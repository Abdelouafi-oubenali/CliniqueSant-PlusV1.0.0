package org.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.example.entities.Appointment;
import org.example.entities.Doctor;
import org.example.entities.Availability;
import org.example.repositories.DoctorRepository;
import org.example.repositories.AvailabilityRepository;
import org.example.repositories.AppointmentRepository;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@WebServlet("/appointment/availability")
public class AppointmentAvailabilityServlet extends HttpServlet {

    private DoctorRepository doctorRepository;
    private AvailabilityRepository availabilityRepository;
    private AppointmentRepository appointmentRepository; // Ajout de cette ligne

    @Override
    public void init() {
        doctorRepository = new DoctorRepository();
        availabilityRepository = new AvailabilityRepository();
        appointmentRepository = new AppointmentRepository(); // Initialisation
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String doctorIdParam = request.getParameter("doctorId");

        try {
            if (doctorIdParam == null || doctorIdParam.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/appointment");
                return;
            }

            Long doctorId = Long.parseLong(doctorIdParam);
            Doctor doctor = doctorRepository.findById(doctorId);

            if (doctor == null) {
                response.sendRedirect(request.getContextPath() + "/appointment");
                return;
            }

            // Récupérer les disponibilités spécifiques par jour du médecin
            List<Availability> availabilities = availabilityRepository.findByDoctorAndFutureDates(doctorId);

            // Récupérer les rendez-vous déjà pris pour ce médecin
            List<Appointment> existingAppointments = appointmentRepository.findByDoctorAndFutureDates(doctorId);

            // Passer les données à la JSP
            request.setAttribute("doctor", doctor);
            request.setAttribute("availabilities", availabilities);
            request.setAttribute("existingAppointments", existingAppointments);

            String jspPath = "/patient/availability.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erreur lors du chargement des disponibilités: " + e.getMessage());
        }
    }

    @Override
    public void destroy() {
        if (doctorRepository != null) {
            doctorRepository.close();
        }
        if (availabilityRepository != null) {
            availabilityRepository.close();
        }
        if (appointmentRepository != null) {
            appointmentRepository.close();
        }
    }
}