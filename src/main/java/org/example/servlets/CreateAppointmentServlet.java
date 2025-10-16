package org.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.example.entities.Appointment;
import org.example.entities.Doctor;
import org.example.entities.Patient;
import org.example.entities.User;
import org.example.repositories.AppointmentRepository;
import org.example.repositories.DoctorRepository;
import org.example.repositories.PatientRepository;

import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;

@WebServlet("/appointment/create")
public class CreateAppointmentServlet extends HttpServlet {

    private AppointmentRepository appointmentRepository;
    private DoctorRepository doctorRepository;
    private PatientRepository patientRepository;

    @Override
    public void init() {
        appointmentRepository = new AppointmentRepository();
        doctorRepository = new DoctorRepository();
        patientRepository = new PatientRepository();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("=== DÉBUT CREATE APPOINTMENT SERVLET ===");

        String doctorIdParam = request.getParameter("doctorId");
        String dateParam = request.getParameter("date");
        String timeParam = request.getParameter("time");

        System.out.println("Paramètres reçus - doctorId: " + doctorIdParam + ", date: " + dateParam + ", time: " + timeParam);

        try {
            // Récupérer l'utilisateur connecté
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");

            if (user == null) {
                System.out.println("Utilisateur non connecté - redirection vers login");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            System.out.println("=== DEBUG USER INFO ===");
            System.out.println("User ID: " + user.getId());
            System.out.println("User Email: " + user.getEmail());
            System.out.println("User Name: " + user.getName());
            System.out.println("User Role: " + user.getRole());
            System.out.println("======================");

            // Validation des paramètres
            if (doctorIdParam == null || dateParam == null || timeParam == null) {
                System.out.println("Paramètres manquants");
                response.sendRedirect(request.getContextPath() + "/appointment?error=missing_params");
                return;
            }

            Long doctorId = Long.parseLong(doctorIdParam);
            LocalDate date = LocalDate.parse(dateParam);
            LocalTime startTime = LocalTime.parse(timeParam);
            LocalTime endTime = startTime.plusMinutes(30);

            System.out.println("Données parsées - doctorId: " + doctorId + ", date: " + date + ", startTime: " + startTime);

            // Vérifier si le créneau est disponible
            boolean isAvailable = appointmentRepository.isTimeSlotAvailable(doctorId, date, startTime, endTime);
            System.out.println("Créneau disponible: " + isAvailable);

            if (!isAvailable) {
                response.sendRedirect(request.getContextPath() + "/appointment/availability?doctorId=" + doctorId + "&error=slot_taken");
                return;
            }

            // Récupérer le médecin
            Doctor doctor = doctorRepository.findById(doctorId);
            System.out.println("Médecin trouvé: " + (doctor != null));

            if (doctor == null) {
                response.sendRedirect(request.getContextPath() + "/appointment?error=doctor_not_found");
                return;
            }

            // Récupérer ou CRÉER le patient
            Patient patient = patientRepository.findByUserId(user.getId());
            System.out.println("Patient initial trouvé: " + (patient != null));

            // Si le patient n'existe pas, le créer automatiquement avec la bonne structure
            if (patient == null) {
                System.out.println("Création automatique du patient pour l'utilisateur: " + user.getEmail());

                patient = new Patient();
                patient.setUser(user);
                patient.setCin("À compléter");
                patient.setBirthDate(LocalDate.now().minusYears(30)); // Date par défaut
                patient.setGender("Non spécifié");
                patient.setAddress("À compléter");
                patient.setPhone("À compléter");
                patient.setBloodType("Non spécifié");

                // Sauvegarder le nouveau patient
                patient = patientRepository.save(patient);
                System.out.println("Nouveau patient créé avec ID: " + (patient != null ? patient.getId() : "null"));

                if (patient == null) {
                    System.err.println("ÉCHEC de la création du patient");
                    response.sendRedirect(request.getContextPath() + "/appointment?error=patient_creation_failed");
                    return;
                }

                System.out.println("SUCCÈS - Patient créé avec ID: " + patient.getId());
            }

            // Créer le rendez-vous
            Appointment appointment = new Appointment();
            appointment.setAppointmentDate(date);
            appointment.setStartTime(startTime);
            appointment.setEndTime(endTime);
            appointment.setStatus("PLANNED");
            appointment.setType("CONSULTATION");
            appointment.setDoctor(doctor);
            appointment.setPatient(patient);

            // Sauvegarder le rendez-vous
            Appointment savedAppointment = appointmentRepository.save(appointment);
            System.out.println("Rendez-vous sauvegardé avec ID: " + (savedAppointment != null ? savedAppointment.getId() : "null"));

            if (savedAppointment != null) {
                // SUCCÈS - Forward vers la page de confirmation avec les attributs
                System.out.println("Rendez-vous créé avec succès! Forward vers appointment-success.jsp");

                // Passer les attributs à la JSP
                request.setAttribute("appointmentId", savedAppointment.getId());
                request.setAttribute("appointmentDate", date);
                request.setAttribute("appointmentTime", startTime);
                request.setAttribute("doctorName", doctor.getTitle() + " " + doctor.getUser().getName());
                request.setAttribute("specialty", doctor.getSpecialty().getName());

                RequestDispatcher dispatcher = request.getRequestDispatcher("/patient/appointment-success.jsp");
                dispatcher.forward(request, response);
            } else {
                System.err.println("Échec de la sauvegarde du rendez-vous");
                response.sendRedirect(request.getContextPath() + "/appointment?error=appointment_save_failed");
            }

        } catch (NumberFormatException e) {
            System.err.println("Erreur de format des paramètres: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/appointment?error=invalid_params");
        } catch (Exception e) {
            System.err.println("ERREUR dans CreateAppointmentServlet: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/appointment?error=server_error&message=" + e.getMessage());
        }

        System.out.println("=== FIN CREATE APPOINTMENT SERVLET ===");
    }

    @Override
    public void destroy() {
        if (appointmentRepository != null) {
            appointmentRepository.close();
        }
        if (doctorRepository != null) {
            doctorRepository.close();
        }
        if (patientRepository != null) {
            patientRepository.close();
        }
    }
}