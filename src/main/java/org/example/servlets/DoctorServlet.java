package org.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.Doctor;
import org.example.entities.User;
import org.example.entities.Specialty;
import org.example.repositories.DoctorRepository;
import org.example.repositories.UserRepository;
import org.example.repositories.SpecialtyRepository;
import org.example.dao.DoctorDTO;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

// CORRECTION : Changez le mapping pour correspondre à votre sidebar
@WebServlet("/DoctorServlet")
public class DoctorServlet extends HttpServlet {

    private DoctorRepository doctorRepository;
    private UserRepository userRepository;
    private SpecialtyRepository specialtyRepository;

    @Override
    public void init() {
        System.out.println("Initialisation de DoctorServlet...");
        try {
            doctorRepository = new DoctorRepository();
            userRepository = new UserRepository();
            specialtyRepository = new SpecialtyRepository();
            System.out.println(" Repositories initialisés avec succès");
        } catch (Exception e) {
            System.err.println(" Erreur initialisation repositories: " + e.getMessage());
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n===  DOCTOR SERVLET DOGET ===");
        System.out.println(" URL: " + request.getRequestURL());
        System.out.println(" Query String: " + request.getQueryString());

        String action = request.getParameter("action");
        System.out.println("Action: " + action);

        try {
            if ("edit".equals(action)) {
                handleEditAction(request);
            } else if ("delete".equals(action)) {
                handleDeleteAction(request);
            } else {
                System.out.println(" Mode liste par défaut");
            }

            // Charger les données pour la vue
            loadViewData(request);

            // Forward vers la JSP
            String jspPath = "/admin/doctors/index.jsp";
            System.out.println("➡ Forward vers: " + jspPath);
            request.getRequestDispatcher(jspPath).forward(request, response);

        } catch (Exception e) {
            System.err.println(" Erreur dans doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Erreur: " + e.getMessage());
        }
    }

    private void handleEditAction(HttpServletRequest request) {
        try {
            String idParam = request.getParameter("id");
            System.out.println(" Mode édition - ID param: " + idParam);

            if (idParam == null || idParam.trim().isEmpty()) {
                System.err.println(" ID manquant pour l'édition");
                request.setAttribute("errorMessage", "ID manquant pour la modification");
                return;
            }

            Long id = Long.parseLong(idParam);
            System.out.println("🔍 Recherche docteur ID: " + id);

            Doctor doctor = doctorRepository.findById(id);

            if (doctor != null) {
                request.setAttribute("doctorToEdit", doctor);
                request.setAttribute("pageTitle", "Modifier le Docteur");
                System.out.println("Docteur trouvé: " + doctor.getUser().getName());
            } else {
                System.err.println(" Docteur non trouvé pour ID: " + id);
                request.setAttribute("errorMessage", "Docteur non trouvé");
            }
        } catch (Exception e) {
            System.err.println(" Erreur lors de l'édition: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
        }
    }

    private void handleDeleteAction(HttpServletRequest request) {
        try {
            String idParam = request.getParameter("id");
            System.out.println(" Mode suppression - ID param: " + idParam);

            if (idParam == null || idParam.trim().isEmpty()) {
                System.err.println(" ID manquant pour la suppression");
                request.setAttribute("errorMessage", "ID manquant pour la suppression");
                return;
            }

            Long id = Long.parseLong(idParam);
            Doctor doctor = doctorRepository.findById(id);
            if (doctor != null) {
                String doctorName = doctor.getUser().getName();
                doctorRepository.delete(id);
                request.setAttribute("successMessage", "Docteur '" + doctorName + "' supprimé avec succès");
                System.out.println(" Docteur supprimé: " + doctorName);
            } else {
                request.setAttribute("errorMessage", "Docteur non trouvé");
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur suppression: " + e.getMessage());
        }
    }

    private void loadViewData(HttpServletRequest request) {
        try {
            System.out.println("📥 Chargement des données...");

            // Charger les utilisateurs (doctors) pour le formulaire
            List<User> users = userRepository.findAll();
            request.setAttribute("users", users);
            System.out.println(" Utilisateurs chargés: " + users.size());

            // Charger les spécialités pour le formulaire
            List<Specialty> specialties = specialtyRepository.findAll();
            request.setAttribute("specialties", specialties);
            System.out.println(" Spécialités chargées: " + specialties.size());

            // Charger la liste des docteurs
            List<Doctor> doctors = doctorRepository.findAll();
            System.out.println("🔍 Docteurs trouvés en base: " + doctors.size());

            List<DoctorDTO> doctorDTOs = doctors.stream()
                    .map(doctor -> {
                        DoctorDTO dto = new DoctorDTO();
                        dto.setId(doctor.getId());
                        dto.setMatricule(doctor.getMatricule());
                        dto.setTitle(doctor.getTitle());

                        if (doctor.getUser() != null) {
                            dto.setDoctorName(doctor.getUser().getName());
                            dto.setEmail(doctor.getUser().getEmail());
                            dto.setUserId(doctor.getUser().getId());
                        }

                        if (doctor.getSpecialty() != null) {
                            dto.setSpecialtyId(doctor.getSpecialty().getId());
                            dto.setSpecialtyName(doctor.getSpecialty().getName());
                        }

                        return dto;
                    })
                    .collect(Collectors.toList());

            request.setAttribute("doctors", doctorDTOs);
            request.setAttribute("doctorsCount", doctorDTOs.size());
            System.out.println(" Docteurs DTO créés: " + doctorDTOs.size());

        } catch (Exception e) {
            System.err.println("Erreur lors du chargement des données: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur chargement données: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n=== DOCTOR SERVLET DOPOST ===");

        String action = request.getParameter("action");
        String matricule = request.getParameter("matricule");
        String title = request.getParameter("title");
        String userIdParam = request.getParameter("userId");
        String specialtyIdParam = request.getParameter("specialtyId");

        System.out.println("Action: " + action);
        System.out.println(" Matricule: " + matricule + ", Title: " + title);

        try {
            // Validation
            if (matricule == null || matricule.trim().isEmpty() ||
                    title == null || title.trim().isEmpty() ||
                    userIdParam == null || userIdParam.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tous les champs obligatoires doivent être remplis");
                doGet(request, response);
                return;
            }

            Long userId = Long.parseLong(userIdParam);
            Long specialtyId = specialtyIdParam != null && !specialtyIdParam.trim().isEmpty() ?
                    Long.parseLong(specialtyIdParam) : null;

            if ("edit".equals(action)) {
                // Modification
                Long id = Long.parseLong(request.getParameter("id"));
                Doctor doctor = doctorRepository.findById(id);

                if (doctor != null) {
                    doctor.setMatricule(matricule.trim());
                    doctor.setTitle(title.trim());

                    User user = userRepository.findById(userId);
                    if (user != null) {
                        doctor.setUser(user);
                    }

                    if (specialtyId != null) {
                        Specialty specialty = specialtyRepository.findById(specialtyId);
                        if (specialty != null) {
                            doctor.setSpecialty(specialty);
                        }
                    }

                    doctorRepository.save(doctor);
                    request.setAttribute("successMessage", "Docteur modifié avec succès");
                    System.out.println("Docteur modifié: " + matricule);
                }
            } else {
                // Ajout
                User user = userRepository.findById(userId);
                if (user != null) {
                    Doctor doctor = new Doctor();
                    doctor.setMatricule(matricule.trim());
                    doctor.setTitle(title.trim());
                    doctor.setUser(user);

                    if (specialtyId != null) {
                        Specialty specialty = specialtyRepository.findById(specialtyId);
                        if (specialty != null) {
                            doctor.setSpecialty(specialty);
                        }
                    }

                    doctorRepository.save(doctor);
                    request.setAttribute("successMessage", "Docteur ajouté avec succès");
                    System.out.println("Nouveau docteur ajouté: " + matricule);
                } else {
                    request.setAttribute("errorMessage", "Utilisateur non trouvé");
                }
            }

            userRepository.updateUserRole(userId , "DOCTOR") ;

            // CORRECTION : Redirection vers DoctorServlet
            String redirectUrl = request.getContextPath() + "/DoctorServlet";
            System.out.println("Redirection vers: " + redirectUrl);
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
        System.out.println(" Destruction de DoctorServlet");
        if (doctorRepository != null) {
            doctorRepository.close();
        }
        if (userRepository != null) {
            userRepository.close();
        }
        if (specialtyRepository != null) {
            specialtyRepository.close();
        }
    }
}