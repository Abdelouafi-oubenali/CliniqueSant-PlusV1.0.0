package org.example.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import org.example.entities.Doctor;
import org.example.entities.Specialty;
import org.example.entities.Availability;
import org.example.repositories.DoctorRepository;
import org.example.repositories.SpecialtyRepository;
import org.example.repositories.AvailabilityRepository;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/appointment")
public class AppointmentServlet extends HttpServlet {

    private DoctorRepository doctorRepository;
    private SpecialtyRepository specialtyRepository;
    private AvailabilityRepository availabilityRepository;

    @Override
    public void init() {
        doctorRepository = new DoctorRepository();
        specialtyRepository = new SpecialtyRepository();
        availabilityRepository = new AvailabilityRepository();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Récupérer tous les médecins depuis la base de données
            List<Doctor> doctors = doctorRepository.findAll();

            // Récupérer toutes les spécialités pour les filtres
            List<Specialty> specialties = specialtyRepository.findAll();

            // Récupérer les disponibilités pour chaque médecin
            Map<Long, List<Availability>> doctorAvailabilities = new HashMap<>();
            for (Doctor doctor : doctors) {
                List<Availability> availabilities = availabilityRepository.findCurrentByDoctor(doctor.getId());
                doctorAvailabilities.put(doctor.getId(), availabilities);
            }

            // Passer les données à la JSP
            request.setAttribute("doctors", doctors);
            request.setAttribute("specialties", specialties);
            request.setAttribute("doctorAvailabilities", doctorAvailabilities);
            request.setAttribute("today", LocalDate.now());

            // Forward vers la page de rendez-vous
            String jspPath = "/patient/doctor.jsp";
            RequestDispatcher dispatcher = request.getRequestDispatcher(jspPath);
            dispatcher.forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Erreur lors du chargement des données: " + e.getMessage());
        }
    }

    public void setDoctorRepository(DoctorRepository doctorRepository) {
        this.doctorRepository = doctorRepository;
    }

    public void setSpecialtyRepository(SpecialtyRepository specialtyRepository) {
        this.specialtyRepository = specialtyRepository;
    }

    public void setAvailabilityRepository(AvailabilityRepository availabilityRepository) {
        this.availabilityRepository = availabilityRepository;
    }


    @Override
    public void destroy() {
        if (doctorRepository != null) {
            doctorRepository.close();
        }
        if (specialtyRepository != null) {
            specialtyRepository.close();
        }
        if (availabilityRepository != null) {
            availabilityRepository.close();
        }
    }
}