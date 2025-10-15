package org.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.Availability;
import org.example.entities.Doctor;
import org.example.entities.User;
import org.example.repositories.AvailabilityRepository;
import org.example.repositories.DoctorRepository;
import java.io.IOException;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;
import java.util.Arrays;
import java.util.ArrayList;

@WebServlet("/availabilities")
public class AvailabilityServlet extends HttpServlet {

    private AvailabilityRepository availabilityRepository;
    private DoctorRepository doctorRepository;

    @Override
    public void init() {
        System.out.println("Initialisation de AvailabilityServlet...");
        try {
            availabilityRepository = new AvailabilityRepository();
            doctorRepository = new DoctorRepository();
            System.out.println(" Repositories initialisés avec succès");
        } catch (Exception e) {
            System.err.println("Erreur initialisation repositories: " + e.getMessage());
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n=== AVAILABILITY SERVLET DOGET ===");
        String action = request.getParameter("action");
        String doctorIdParam = request.getParameter("doctorId");

        try {
            // Vérifier si un médecin est connecté
            HttpSession session = request.getSession(false);
            User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;
            Doctor loggedInDoctor = null;

            if (loggedInUser != null && "DOCTOR".equals(loggedInUser.getRole())) {
                loggedInDoctor = findDoctorByUserId(loggedInUser.getId());
                if (loggedInDoctor != null) {
                    // Forcer la sélection du médecin connecté
                    doctorIdParam = loggedInDoctor.getId().toString();
                    request.setAttribute("isDoctorLoggedIn", true);
                }
            }

            // Charger la liste des médecins selon le rôle
            if (loggedInUser == null) {
                // Utilisateur non connecté
                List<Doctor> doctors = doctorRepository.findAll();
                request.setAttribute("doctors", doctors);
                request.setAttribute("isDoctorLoggedIn", false);
            } else if ("DOCTOR".equals(loggedInUser.getRole())) {
                // Cas DOCTOR connecté
                if (loggedInDoctor != null) {
                    List<Doctor> doctors = Arrays.asList(loggedInDoctor);
                    request.setAttribute("doctors", doctors);
                    request.setAttribute("isDoctorLoggedIn", true);
                    request.setAttribute("selectedDoctor", loggedInDoctor);

                    // Charger aussi les disponibilités du doctor connecté
                    List<Availability> availabilities = availabilityRepository.findCurrentByDoctor(loggedInDoctor.getId());
                    request.setAttribute("availabilities", availabilities);
                } else {
                    request.setAttribute("doctors", new ArrayList<Doctor>());
                    request.setAttribute("isDoctorLoggedIn", true);
                    request.setAttribute("errorMessage", "Votre profil médecin n'a pas été trouvé. Contactez l'administrateur.");
                }
            } else {
                // Cas ADMIN ou autre rôle
                List<Doctor> doctors = doctorRepository.findAll();
                request.setAttribute("doctors", doctors);
                request.setAttribute("isDoctorLoggedIn", false);
            }

            // Gestion de la sélection du médecin pour les admins
            if (doctorIdParam != null && !doctorIdParam.trim().isEmpty()) {
                Long doctorId = Long.parseLong(doctorIdParam);
                Doctor doctor = doctorRepository.findById(doctorId);

                if (doctor != null) {
                    request.setAttribute("selectedDoctor", doctor);

                    // Charger les disponibilités du médecin (seulement si pas déjà chargé pour le doctor connecté)
                    if (loggedInDoctor == null || !loggedInDoctor.getId().equals(doctorId)) {
                        List<Availability> availabilities = availabilityRepository.findCurrentByDoctor(doctorId);
                        request.setAttribute("availabilities", availabilities);
                    }
                }
            }

            if ("edit".equals(action)) {
                handleEditAction(request);
            } else if ("delete".equals(action)) {
                handleDeleteAction(request);
            }

            request.setAttribute("pageTitle", "Gestion des Disponibilités des Médecins");

            // Forward vers la JSP
            String jspPath = "/admin/availabilities/index.jsp";
            System.out.println("Forward vers: " + jspPath);
            request.getRequestDispatcher(jspPath).forward(request, response);

        } catch (Exception e) {
            System.err.println(" Erreur dans doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Erreur: " + e.getMessage());
        }
    }

    private Doctor findDoctorByUserId(Long userId) {
        List<Doctor> doctors = doctorRepository.findAll();
        return doctors.stream()
                .filter(doctor -> doctor.getUser() != null && doctor.getUser().getId().equals(userId))
                .findFirst()
                .orElse(null);
    }

    private void handleEditAction(HttpServletRequest request) {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                request.setAttribute("errorMessage", "ID manquant pour la modification");
                return;
            }

            Long id = Long.parseLong(idParam);
            String doctorIdParam = request.getParameter("doctorId");

            if (doctorIdParam != null) {
                Long doctorId = Long.parseLong(doctorIdParam);
                Availability availability = availabilityRepository.findByDoctor(doctorId).stream()
                        .filter(a -> a.getId().equals(id))
                        .findFirst()
                        .orElse(null);

                if (availability != null) {
                    request.setAttribute("availabilityToEdit", availability);
                }
            }
        } catch (Exception e) {
            System.err.println(" Erreur lors de l'édition: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
        }
    }

    private void handleDeleteAction(HttpServletRequest request) {
        try {
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.trim().isEmpty()) {
                request.setAttribute("errorMessage", "ID manquant pour la suppression");
                return;
            }

            Long id = Long.parseLong(idParam);
            availabilityRepository.delete(id);
            request.setAttribute("successMessage", "Disponibilité supprimée avec succès");

        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur suppression: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n=== AVAILABILITY SERVLET DOPOST ===");

        String action = request.getParameter("action");
        String doctorIdParam = request.getParameter("doctorId");
        String dayParam = request.getParameter("day");
        String startTimeParam = request.getParameter("startTime");
        String endTimeParam = request.getParameter("endTime");
        String status = request.getParameter("status");
        String validFromParam = request.getParameter("validFrom");
        String validToParam = request.getParameter("validTo");

        try {
            // Vérifier les permissions
            HttpSession session = request.getSession(false);
            User loggedInUser = (session != null) ? (User) session.getAttribute("user") : null;

            if (loggedInUser != null && "DOCTOR".equals(loggedInUser.getRole())) {
                // Si un médecin est connecté, s'assurer qu'il ne modifie que ses propres disponibilités
                Doctor loggedInDoctor = findDoctorByUserId(loggedInUser.getId());
                if (loggedInDoctor != null && !loggedInDoctor.getId().toString().equals(doctorIdParam)) {
                    request.setAttribute("errorMessage", "Vous ne pouvez modifier que vos propres disponibilités");
                    doGet(request, response);
                    return;
                }
            }

            // Validation
            if (doctorIdParam == null || doctorIdParam.trim().isEmpty() ||
                    dayParam == null || dayParam.trim().isEmpty() ||
                    startTimeParam == null || startTimeParam.trim().isEmpty() ||
                    endTimeParam == null || endTimeParam.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tous les champs obligatoires doivent être remplis");
                doGet(request, response);
                return;
            }

            Long doctorId = Long.parseLong(doctorIdParam);
            LocalDate day = LocalDate.parse(dayParam);
            LocalTime startTime = LocalTime.parse(startTimeParam);
            LocalTime endTime = LocalTime.parse(endTimeParam);
            LocalDate validFrom = validFromParam != null && !validFromParam.trim().isEmpty() ?
                    LocalDate.parse(validFromParam) : null;
            LocalDate validTo = validToParam != null && !validToParam.trim().isEmpty() ?
                    LocalDate.parse(validToParam) : null;

            Doctor doctor = doctorRepository.findById(doctorId);
            if (doctor == null) {
                request.setAttribute("errorMessage", "Médecin non trouvé");
                doGet(request, response);
                return;
            }

            if ("edit".equals(action)) {
                // Modification
                Long id = Long.parseLong(request.getParameter("id"));
                // Recherche de la disponibilité à modifier
                Availability availability = availabilityRepository.findByDoctor(doctorId).stream()
                        .filter(a -> a.getId().equals(id))
                        .findFirst()
                        .orElse(null);

                if (availability != null) {
                    availability.setDay(day);
                    availability.setStartTime(startTime);
                    availability.setEndTime(endTime);
                    availability.setStatus(status != null ? status : "AVAILABLE");
                    availability.setValidFrom(validFrom);
                    availability.setValidTo(validTo);

                    availabilityRepository.save(availability);
                    request.setAttribute("successMessage", "Disponibilité modifiée avec succès");
                }
            } else {
                // Ajout
                Availability availability = new Availability();
                availability.setDoctor(doctor);
                availability.setDay(day);
                availability.setStartTime(startTime);
                availability.setEndTime(endTime);
                availability.setStatus(status != null ? status : "AVAILABLE");
                availability.setValidFrom(validFrom);
                availability.setValidTo(validTo);

                availabilityRepository.save(availability);
                request.setAttribute("successMessage", "Disponibilité ajoutée avec succès");
            }

            // Redirection
            String redirectUrl = request.getContextPath() + "/availabilities?doctorId=" + doctorId;
            response.sendRedirect(redirectUrl);

        } catch (Exception e) {
            System.err.println(" Erreur dans doPost: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
            doGet(request, response);
        }
    }

    @Override
    public void destroy() {
        System.out.println(" Destruction de AvailabilityServlet");
        if (availabilityRepository != null) {
            availabilityRepository.close();
        }
        if (doctorRepository != null) {
            doctorRepository.close();
        }
    }
}