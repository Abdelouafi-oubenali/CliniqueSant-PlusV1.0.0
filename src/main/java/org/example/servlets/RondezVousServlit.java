package org.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.User;
import org.example.entities.Appointment;
import org.example.entities.Doctor;
import org.example.entities.Specialty;
import org.example.dao.AppointmentDAO;

import java.io.IOException;
import java.util.List;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

@WebServlet("/rondezVousServlit")
public class RondezVousServlit extends HttpServlet {

    private AppointmentDAO appointmentDAO;

    @Override
    public void init() throws ServletException {
        appointmentDAO = new AppointmentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Récupérer l'utilisateur connecté depuis la session
            User user = (User) request.getSession().getAttribute("user");

            if (user == null) {
                System.out.println("Utilisateur non connecté - Redirection vers login");
                response.sendRedirect(request.getContextPath() + "/login.jsp");
                return;
            }

            System.out.println("Utilisateur connecté: " + user.getId() + " - " + user.getEmail());

            // Récupérer les rendez-vous depuis la base de données
            List<Appointment> appointments = appointmentDAO.findByPatientUserId(user.getId());

            System.out.println("Rendez-vous récupérés depuis DAO: " + appointments.size());

            // Convertir en DTO pour la JSP
            List<AppointmentDTO> appointmentDTOs = convertToDTO(appointments);

            System.out.println("DTOs créés: " + appointmentDTOs.size());

            // Ajouter les attributs à la request
            request.setAttribute("appointments", appointmentDTOs);
            request.setAttribute("userId", user.getId());

            // Forward vers la JSP
            request.getRequestDispatcher("/patient/rondz-vous.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Erreur dans la servlet: " + e.getMessage());
            request.setAttribute("appointments", List.of());
            request.setAttribute("error", "Erreur lors du chargement des rendez-vous: " + e.getMessage());
            request.getRequestDispatcher("/patient/rondz-vous.jsp").forward(request, response);
        }
    }

    private List<AppointmentDTO> convertToDTO(List<Appointment> appointments) {
        List<AppointmentDTO> dtos = new ArrayList<>();
        for (Appointment appointment : appointments) {
            AppointmentDTO dto = convertToDTO(appointment);
            if (dto != null) {
                dtos.add(dto);
            }
        }
        return dtos;
    }

    private AppointmentDTO convertToDTO(Appointment appointment) {
        try {
            DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
            DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

            String status = convertStatus(appointment.getStatus());
            String doctorName = getDoctorName(appointment.getDoctor());
            String specialty = getSpecialty(appointment.getDoctor());
            String type = getAppointmentType(appointment);
            String notes = getNotesFromAppointment(appointment);
            String date = appointment.getAppointmentDate() != null ?
                    appointment.getAppointmentDate().format(dateFormatter) : "Date non définie";
            String time = appointment.getStartTime() != null ?
                    appointment.getStartTime().format(timeFormatter) : "Heure non définie";

            // DEBUG DÉTAILLÉ
            System.out.println("=== RENDEZ-VOUS " + appointment.getId() + " ===");
            System.out.println("Date: " + date);
            System.out.println("Heure: " + time);
            System.out.println("Type: " + type);
            System.out.println("Statut: " + status);
            System.out.println("Docteur: " + doctorName);
            System.out.println("Spécialité: " + specialty);
            System.out.println("Notes: " + notes);

            return new AppointmentDTO(
                    appointment.getId(),
                    type,
                    doctorName,
                    specialty,
                    status,
                    date,
                    time,
                    "Clinique SantéPlus",
                    notes
            );
        } catch (Exception e) {
            System.out.println(" Erreur conversion rendez-vous " + appointment.getId() + ": " + e.getMessage());
            e.printStackTrace();
            return null;
        }
    }

    private String convertStatus(String status) {
        if (status == null) return "upcoming";

        return switch (status.toUpperCase()) {
            case "DONE", "COMPLETED" -> "completed";
            case "CANCELED", "CANCELLED" -> "cancelled";
            default -> "upcoming";
        };
    }

    private String getDoctorName(Doctor doctor) {
        if (doctor != null && doctor.getUser() != null) {
            return "Dr. " + doctor.getUser().getName();
        }
        return "Médecin non assigné";
    }

    private String getSpecialty(Doctor doctor) {
        if (doctor != null && doctor.getSpecialty() != null) {
            // CORRECTION : Specialty est une entité, utiliser getName()
            return doctor.getSpecialty().getName();
        }
        return "Générale";
    }

    private String getAppointmentType(Appointment appointment) {
        if (appointment.getType() != null && !appointment.getType().isEmpty()) {
            return appointment.getType();
        }
        return "Consultation générale";
    }

    private String getNotesFromAppointment(Appointment appointment) {
        if (appointment.getNotes() != null && !appointment.getNotes().isEmpty()) {
            return appointment.getNotes().get(0).getContent();
        }
        return "";
    }

    @Override
    public void destroy() {
        if (appointmentDAO != null) {
            appointmentDAO.close();
        }
    }

    // Classe DTO pour la JSP
    public static class AppointmentDTO {
        private Long id;
        private String type;
        private String doctorName;
        private String specialty;
        private String status;
        private String date;
        private String time;
        private String location;
        private String notes;

        public AppointmentDTO(Long id, String type, String doctorName, String specialty,
                              String status, String date, String time, String location, String notes) {
            this.id = id;
            this.type = type;
            this.doctorName = doctorName;
            this.specialty = specialty;
            this.status = status;
            this.date = date;
            this.time = time;
            this.location = location;
            this.notes = notes;
        }

        // Getters
        public Long getId() { return id; }
        public String getType() { return type; }
        public String getDoctorName() { return doctorName; }
        public String getSpecialty() { return specialty; }
        public String getStatus() { return status; }
        public String getDate() { return date; }
        public String getTime() { return time; }
        public String getLocation() { return location; }
        public String getNotes() { return notes; }
    }
}