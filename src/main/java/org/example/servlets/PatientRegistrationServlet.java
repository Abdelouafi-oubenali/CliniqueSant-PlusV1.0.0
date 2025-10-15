package org.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.Patient;
import org.example.entities.User;
import org.example.repositories.PatientRepository;
import org.example.repositories.UserRepository;
import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/PatientRegistrationServlet")
public class PatientRegistrationServlet extends HttpServlet {

    private UserRepository userRepository;
    private PatientRepository patientRepository;

    @Override
    public void init() {
        this.userRepository = new UserRepository();
        this.patientRepository = new PatientRepository();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/patient/registration.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String cin = request.getParameter("cin");
        String birthDateParam = request.getParameter("birthDate");
        String gender = request.getParameter("gender");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String bloodType = request.getParameter("bloodType");

        try {
            // Validation
            if (!password.equals(confirmPassword)) {
                request.setAttribute("errorMessage", "Les mots de passe ne correspondent pas");
                doGet(request, response);
                return;
            }

            // Vérifier si l'email existe déjà
            if (userRepository.existsByEmail(email)) {
                request.setAttribute("errorMessage", "Cet email est déjà utilisé");
                doGet(request, response);
                return;
            }

            // 1. Créer l'utilisateur
            User user = User.createPatientUser(name, email, password);
            User savedUser = userRepository.save(user);

            // 2. Créer le profil patient
            Patient patient = new Patient();
            patient.setCin(cin);
            patient.setBirthDate(LocalDate.parse(birthDateParam));
            patient.setGender(gender);
            patient.setPhone(phone);
            patient.setAddress(address);
            patient.setBloodType(bloodType);
            patient.setUser(savedUser);

            patientRepository.save(patient);

            request.setAttribute("successMessage", "Votre compte patient a été créé avec succès!");
            request.getRequestDispatcher("/patient/registration-success.jsp").forward(request, response);

        } catch (Exception e) {
            request.setAttribute("errorMessage", "Erreur lors de l'inscription: " + e.getMessage());
            doGet(request, response);
        }
    }

    @Override
    public void destroy() {
        if (userRepository != null) userRepository.close();
        if (patientRepository != null) patientRepository.close();
    }
}