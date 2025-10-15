package org.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.Patient;
import org.example.entities.User;
import org.example.repositories.PatientRepository;
import org.example.repositories.UserRepository;
import org.example.dao.PatientDTO;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/PatientServlet")
public class PatientServlet extends HttpServlet {

    private PatientRepository patientRepository;
    private UserRepository userRepository;

    @Override
    public void init() {
        System.out.println("Initialisation de PatientServlet...");
        try {
            patientRepository = new PatientRepository();
            userRepository = new UserRepository();
            System.out.println(" Repositories initialisés avec succès");
        } catch (Exception e) {
            System.err.println("Erreur initialisation repositories: " + e.getMessage());
            e.printStackTrace();
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n=== PATIENT SERVLET DOGET ===");
        System.out.println("URL: " + request.getRequestURL());
        System.out.println("🔍 Query String: " + request.getQueryString());

        String action = request.getParameter("action");
        System.out.println(" Action: " + action);

        try {
            if ("edit".equals(action)) {
                handleEditAction(request);
            } else if ("delete".equals(action)) {
                handleDeleteAction(request);
            } else {
                System.out.println("Mode liste par défaut");
            }

            // Charger les données pour la vue
            loadViewData(request);

            // Forward vers la JSP
            String jspPath = "/admin/patients/index.jsp";
            System.out.println("Forward vers: " + jspPath);
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
            System.out.println("🔍 Recherche patient ID: " + id);

            Patient patient = patientRepository.findById(id);

            if (patient != null) {
                request.setAttribute("patientToEdit", patient);
                request.setAttribute("pageTitle", "Modifier le Patient");
                System.out.println(" Patient trouvé: " + patient.getUser().getName());
            } else {
                System.err.println(" Patient non trouvé pour ID: " + id);
                request.setAttribute("errorMessage", "Patient non trouvé");
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
            Patient patient = patientRepository.findById(id);
            if (patient != null) {
                String patientName = patient.getUser().getName();
                patientRepository.delete(id);
                request.setAttribute("successMessage", "Patient '" + patientName + "' supprimé avec succès");
                System.out.println(" Patient supprimé: " + patientName);
            } else {
                request.setAttribute("errorMessage", "Patient non trouvé");
            }
        } catch (Exception e) {
            System.err.println("Erreur lors de la suppression: " + e.getMessage());
            request.setAttribute("errorMessage", "Erreur suppression: " + e.getMessage());
        }
    }

    private void loadViewData(HttpServletRequest request) {
        try {
            System.out.println("📥 Chargement des données...");

            // Charger les utilisateurs (patients) pour le formulaire
            List<User> users = userRepository.findAllPatients();
            request.setAttribute("users", users);
            System.out.println("Utilisateurs patients chargés: " + users.size());

            // Charger la liste des patients
            List<Patient> patients = patientRepository.findAll();
            System.out.println("🔍 Patients trouvés en base: " + patients.size());

            List<PatientDTO> patientDTOs = patients.stream()
                    .map(patient -> {
                        PatientDTO dto = new PatientDTO();
                        dto.setId(patient.getId());
                        dto.setCin(patient.getCin());
                        dto.setBirthDate(patient.getBirthDate());
                        dto.setGender(patient.getGender());
                        dto.setAddress(patient.getAddress());
                        dto.setPhone(patient.getPhone());
                        dto.setBloodType(patient.getBloodType());

                        if (patient.getUser() != null) {
                            dto.setPatientName(patient.getUser().getName());
                            dto.setEmail(patient.getUser().getEmail());
                            dto.setUserId(patient.getUser().getId());
                        }

                        return dto;
                    })
                    .collect(Collectors.toList());

            request.setAttribute("patients", patientDTOs);
            request.setAttribute("patientsCount", patientDTOs.size());
            System.out.println(" Patients DTO créés: " + patientDTOs.size());

        } catch (Exception e) {
            System.err.println(" Erreur lors du chargement des données: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur chargement données: " + e.getMessage());
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("\n=== PATIENT SERVLET DOPOST ===");

        String action = request.getParameter("action");
        String cin = request.getParameter("cin");
        String birthDateParam = request.getParameter("birthDate");
        String gender = request.getParameter("gender");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String bloodType = request.getParameter("bloodType");

        System.out.println(" Action: " + action);
        System.out.println("📋 CIN: " + cin + ", Gender: " + gender);

        try {
            // Validation des champs communs
            if (cin == null || cin.trim().isEmpty() ||
                    birthDateParam == null || birthDateParam.trim().isEmpty() ||
                    gender == null || gender.trim().isEmpty()) {
                request.setAttribute("errorMessage", "Tous les champs obligatoires doivent être remplis");
                doGet(request, response);
                return;
            }

            LocalDate birthDate = LocalDate.parse(birthDateParam);

            if ("edit".equals(action)) {
                // MODIFICATION (logique existante)
                Long id = Long.parseLong(request.getParameter("id"));
                Long userId = Long.parseLong(request.getParameter("userId"));
                Patient patient = patientRepository.findById(id);

                if (patient != null) {
                    patient.setCin(cin.trim());
                    patient.setBirthDate(birthDate);
                    patient.setGender(gender);
                    patient.setAddress(address != null ? address.trim() : null);
                    patient.setPhone(phone != null ? phone.trim() : null);
                    patient.setBloodType(bloodType != null ? bloodType.trim() : null);

                    patientRepository.save(patient);
                    request.setAttribute("successMessage", "Patient modifié avec succès");
                    System.out.println(" Patient modifié: " + cin);
                }
            } else {
                // AJOUT - Création d'un nouvel utilisateur + patient
                String name = request.getParameter("name");
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String confirmPassword = request.getParameter("confirmPassword");

                // Validation des champs utilisateur
                if (name == null || name.trim().isEmpty() ||
                        email == null || email.trim().isEmpty() ||
                        password == null || password.trim().isEmpty()) {
                    request.setAttribute("errorMessage", "Tous les champs utilisateur doivent être remplis");
                    doGet(request, response);
                    return;
                }

                if (!password.equals(confirmPassword)) {
                    request.setAttribute("errorMessage", "Les mots de passe ne correspondent pas");
                    doGet(request, response);
                    return;
                }

                if (password.length() < 6) {
                    request.setAttribute("errorMessage", "Le mot de passe doit contenir au moins 6 caractères");
                    doGet(request, response);
                    return;
                }

                // Vérifier si l'email existe déjà
                User existingUser = userRepository.findByEmail(email);
                if (existingUser != null) {
                    request.setAttribute("errorMessage", "Un utilisateur avec cet email existe déjà");
                    doGet(request, response);
                    return;
                }

                // Créer le nouvel utilisateur
                User user = User.createPatientUser(name.trim(), email.trim(), password.trim());
                userRepository.save(user);

                // Créer le patient associé
                Patient patient = new Patient();
                patient.setCin(cin.trim());
                patient.setBirthDate(birthDate);
                patient.setGender(gender);
                patient.setAddress(address != null ? address.trim() : null);
                patient.setPhone(phone != null ? phone.trim() : null);
                patient.setBloodType(bloodType != null ? bloodType.trim() : null);
                patient.setUser(user);

                patientRepository.save(patient);
                request.setAttribute("successMessage", "Patient et compte utilisateur créés avec succès");
                System.out.println(" Nouveau patient et utilisateur créés: " + name);
            }

            // Redirection vers la liste
            String redirectUrl = request.getContextPath() + "/PatientServlet";
            System.out.println(" Redirection vers: " + redirectUrl);
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
        System.out.println(" Destruction de PatientServlet");
        if (patientRepository != null) {
            patientRepository.close();
        }
        if (userRepository != null) {
            userRepository.close();
        }
    }
}