package org.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        try {
            // Simuler des données de la base de données
            // En production, vous devriez appeler vos services DAO
            
            // Statistiques principales
            int totalPatients = 1248;
            int totalDoctors = 87;
            int totalDepartments = 12;
            int totalUsers = 56;
            int todayAppointments = 89;
            int pendingPatients = 7;
            int newPatientsThisMonth = 42;
            int availableBeds = 156;
            
            // Données pour les graphiques
            Map<String, Integer> monthlyAdmissions = new HashMap<>();
            monthlyAdmissions.put("Jan", 120);
            monthlyAdmissions.put("Fév", 190);
            monthlyAdmissions.put("Mar", 135);
            monthlyAdmissions.put("Avr", 210);
            monthlyAdmissions.put("Mai", 180);
            monthlyAdmissions.put("Juin", 240);
            
            Map<String, Integer> statusDistribution = new HashMap<>();
            statusDistribution.put("Actifs", 65);
            statusDistribution.put("En attente", 20);
            statusDistribution.put("Inactifs", 15);
            
            Map<String, Integer> departmentStats = new HashMap<>();
            departmentStats.put("Cardiologie", 245);
            departmentStats.put("Pédiatrie", 187);
            departmentStats.put("Chirurgie", 156);
            departmentStats.put("Urgences", 312);
            departmentStats.put("Radiologie", 98);
            departmentStats.put("Neurologie", 76);
            
            // Départements avec plus d'admissions
            Map<String, Integer> topDepartments = new HashMap<>();
            topDepartments.put("Urgences", 312);
            topDepartments.put("Cardiologie", 245);
            topDepartments.put("Pédiatrie", 187);
            topDepartments.put("Chirurgie", 156);
            
            // Set des attributs pour la JSP
            request.setAttribute("totalPatients", totalPatients);
            request.setAttribute("totalDoctors", totalDoctors);
            request.setAttribute("totalDepartments", totalDepartments);
            request.setAttribute("totalUsers", totalUsers);
            request.setAttribute("todayAppointments", todayAppointments);
            request.setAttribute("pendingPatients", pendingPatients);
            request.setAttribute("newPatientsThisMonth", newPatientsThisMonth);
            request.setAttribute("availableBeds", availableBeds);
            
            // Données pour les graphiques
            request.setAttribute("monthlyAdmissions", monthlyAdmissions);
            request.setAttribute("statusDistribution", statusDistribution);
            request.setAttribute("departmentStats", departmentStats);
            request.setAttribute("topDepartments", topDepartments);
            
            // Transférer vers la page JSP
            request.getRequestDispatcher("/admin/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, 
                "Erreur lors du chargement du tableau de bord: " + e.getMessage());
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}