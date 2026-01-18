package org.example.servlets;

import java.io.IOException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.Department;
import org.example.entities.Specialty;
import org.example.entities.Doctor;
import org.example.repositories.DepartmentRepository;
import org.example.repositories.DoctorRepository;

@WebServlet("/DepartmentServlet")
public class DepartmentServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private DepartmentRepository departmentRepository;
    private DoctorRepository doctorRepository;

    @Override
    public void init() throws ServletException {
        try {
            this.departmentRepository = new DepartmentRepository();
            this.doctorRepository = new DoctorRepository();
            System.out.println("DepartmentServlet initialisé avec Repository");
        } catch (Exception e) {
            System.err.println("Erreur initialisation DepartmentRepository: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Erreur initialisation repository", e);
        }
    }

    @Override
    public void destroy() {
        if (departmentRepository != null) {
            departmentRepository.close();
        }
        System.out.println("DepartmentServlet détruit");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Action: " + request.getParameter("action"));

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch(action) {
                case "list":
                    listDepartments(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteDepartment(request, response);
                    break;
                case "view":
                    viewDepartment(request, response);
                    break;
                default:
                    listDepartments(request, response);
            }
        } catch (Exception e) {
            System.err.println("Erreur dans doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Erreur interne: " + e.getMessage());
        }
    }

    private void listDepartments(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("Chargement de la liste des départements depuis PostgreSQL...");

            // Test de connexion d'abord
            testDatabaseConnection();

            // Récupération des données RÉELLES depuis la base
            List<Department> departments = departmentRepository.findAll();
            long departmentsCount = departmentRepository.count();
            long activeDoctors = departmentRepository.countActiveDoctors();
            long availableBeds = departmentRepository.countAvailableBeds();

            System.out.println("📋 " + departments.size() + " départements trouvés dans PostgreSQL");

            // Enrichir chaque département avec les données réelles
            enrichDepartmentsWithRealData(departments);

            // Debug des données
            debugDatabaseState(departments);

            String contextPath = request.getContextPath();

            // Attribution des données RÉELLES
            request.setAttribute("contextPath", contextPath);
            request.setAttribute("pageTitle", "Gestion des Départements");
            request.setAttribute("departments", departments);
            request.setAttribute("departmentsCount", (int) departmentsCount);
            request.setAttribute("activeDepartments", (int) departmentsCount);
            request.setAttribute("totalDoctors", (int) activeDoctors);
            request.setAttribute("availableBeds", (int) availableBeds);

            String filter = request.getParameter("filter");
            request.setAttribute("currentFilter", filter != null ? filter : "all");

            String success = request.getParameter("success");
            if (success != null) {
                request.setAttribute("successMessage", getSuccessMessage(success));
            }

            String error = request.getParameter("error");
            if (error != null) {
                request.setAttribute("errorMessage", getErrorMessage(error));
            }
            System.out.println("resust test " +  request.getAttribute("totalDoctors"));

            System.out.println("Forward vers /admin/department/index.jsp");
            request.getRequestDispatcher("/admin/department/index.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Erreur dans listDepartments: " + e.getMessage());
            e.printStackTrace();

            // Fallback: données simulées en cas d'erreur
            setupFallbackData(request, e.getMessage());
            request.getRequestDispatcher("/admin/department/index.jsp").forward(request, response);
        }
    }

    private void debugDatabaseState(List<Department> departments) {
        System.out.println("=== DEBUG DATABASE STATE ===");
        System.out.println("Départements trouvés: " + departments.size());
        for (Department dept : departments) {
            System.out.println(" " + dept.getId() + " | " + dept.getCode() + " | " + dept.getName());
            System.out.println("   - Spécialités: " + (dept.getSpecialties() != null ? dept.getSpecialties().size() : 0));
            System.out.println("   - Médecins: " + (dept.getDoctorsCount() != null ? dept.getDoctorsCount() : 0));
            System.out.println("   - Occupation: " + (dept.getOccupancyRate() != null ? dept.getOccupancyRate() + "%" : "N/A"));
        }
        System.out.println("=============================");
    }

    private void enrichDepartmentsWithRealData(List<Department> departments) {
        // Récupérer tous les docteurs
        List<Doctor> allDoctors = doctorRepository.findAll();
        
        for (Department dept : departments) {
            // 1. Calculer le nombre de médecins par département
            int doctorsCount = 0;
            if (dept.getSpecialties() != null) {
                for (Specialty specialty : dept.getSpecialties()) {
                    // Compter les docteurs qui ont cette spécialité
                    long doctorsBySpecialty = allDoctors.stream()
                            .filter(d -> d.getSpecialty() != null && 
                                   d.getSpecialty().getId().equals(specialty.getId()))
                            .count();
                    doctorsCount += doctorsBySpecialty;
                }
            }
            
            // Stocker le nombre de médecins pour utilisation dans JSP
            dept.setDoctorsCount(doctorsCount);
            
            // 2. Calculer le taux d'occupation (basé sur le nombre de médecins et spécialités)
            int occupancyRate = calculateOccupancyRate(dept, doctorsCount);
            dept.setOccupancyRate(occupancyRate);
            
            System.out.println("Department enriched: " + dept.getName() + 
                             " - Doctors: " + doctorsCount + 
                             " - Occupancy: " + occupancyRate + "%");
        }
    }

    private int calculateOccupancyRate(Department department, int doctorsCount) {
        // Logique de calcul du taux d'occupation basée sur les données réelles
        if (doctorsCount == 0) return 0;
        
        // Calcul simplifié : basé sur le nombre de spécialités et médecins
        int specialtiesCount = department.getSpecialties() != null ? 
                               department.getSpecialties().size() : 0;
        
        // Formule : (nombre de médecins * 15) + (nombre de spécialités * 10)
        int baseRate = (doctorsCount * 15) + (specialtiesCount * 10);
        
        // Limiter le taux entre 0 et 100%
        return Math.min(Math.max(baseRate, 0), 100);
    }

    private void testDatabaseConnection() {
        try {
            long count = departmentRepository.count();
            System.out.println(" Test connexion PostgreSQL réussi - " + count + " départements");
        } catch (Exception e) {
            System.err.println(" Test connexion PostgreSQL échoué: " + e.getMessage());
            throw new RuntimeException("Connexion base de données échouée", e);
        }
    }

    private void setupFallbackData(HttpServletRequest request, String errorMessage) {
        System.out.println("Utilisation des données de fallback: " + errorMessage);

        List<Department> departments = List.of();

        request.setAttribute("contextPath", request.getContextPath());
        request.setAttribute("pageTitle", "Gestion des Départements - Erreur BD");
        request.setAttribute("departments", departments);
        request.setAttribute("departmentsCount", 0);
        request.setAttribute("activeDepartments", 0);
        request.setAttribute("totalDoctors", 0);
        request.setAttribute("availableBeds", 0);
        request.setAttribute("currentFilter", "all");
        request.setAttribute("errorMessage", "Erreur base de données: " + errorMessage);
    }

    // MÉTHODES MANQUANTES AJOUTÉES
    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("contextPath", request.getContextPath());
            request.setAttribute("pageTitle", "Nouveau Département");
            request.setAttribute("department", null);
            request.getRequestDispatcher("/admin/department/form.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println(" Erreur showAddForm: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=loadform");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=idmanquant");
                return;
            }

            Department department = departmentRepository.findById(Long.parseLong(id));
            if (department != null) {
                request.setAttribute("contextPath", request.getContextPath());
                request.setAttribute("department", department);
                request.setAttribute("pageTitle", "Modifier Département - " + department.getName());
                request.getRequestDispatcher("/admin/department/form.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=notfound");
            }
        } catch (Exception e) {
            System.err.println(" Erreur showEditForm: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=load");
        }
    }

    private void viewDepartment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=idmanquant");
                return;
            }

            Department department = departmentRepository.findById(Long.parseLong(id));
            if (department != null) {
                request.setAttribute("contextPath", request.getContextPath());
                request.setAttribute("department", department);
                request.setAttribute("pageTitle", "Détails Département - " + department.getName());
                request.getRequestDispatcher("/admin/department/details.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=notfound");
            }
        } catch (Exception e) {
            System.err.println(" Erreur viewDepartment: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=load");
        }
    }

    private void deleteDepartment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=idmanquant");
                return;
            }

            // Vérifier si le département existe avant suppression
            Department department = departmentRepository.findById(Long.parseLong(id));
            if (department == null) {
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=notfound");
                return;
            }

            departmentRepository.delete(Long.parseLong(id));
            System.out.println(" Suppression département ID: " + id);
            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&success=deleted");

        } catch (Exception e) {
            System.err.println(" Erreur deleteDepartment: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=delete");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            System.out.println("DepartmentServlet doPost - Action: " + action);
            System.out.println(" Paramètres reçus:");
            request.getParameterMap().forEach((key, values) -> {
                System.out.println("   " + key + ": " + String.join(", ", values));
            });

            if ("add".equals(action)) {
                addDepartment(request, response);
            } else if ("update".equals(action)) {
                updateDepartment(request, response);
            } else {
                System.err.println(" Action POST non reconnue: " + action);
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=actioninconnue");
            }
        } catch (Exception e) {
            System.err.println("Erreur dans doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=" + e.getMessage());
        }
    }

    private void addDepartment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String code = request.getParameter("code");
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            System.out.println("➕ Ajout département - Code: " + code + ", Name: " + name);

            // Validation
            if (code == null || code.trim().isEmpty() || name == null || name.trim().isEmpty()) {
                System.err.println(" Champs obligatoires manquants pour l'ajout");
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=champsmanquants");
                return;
            }

            Department department = new Department();
            department.setCode(code.toUpperCase().trim());
            department.setName(name.trim());
            department.setDescription(description != null ? description.trim() : null);

            Department savedDepartment = departmentRepository.save(department);
            System.out.println(" Département ajouté avec succès - ID: " + savedDepartment.getId());

            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&success=added");

        } catch (Exception e) {
            System.err.println(" Erreur addDepartment: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=add");
        }
    }

    private void updateDepartment(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            String code = request.getParameter("code");
            String name = request.getParameter("name");
            String description = request.getParameter("description");

            System.out.println(" Mise à jour département - ID: " + id + ", Code: " + code + ", Name: " + name);

            if (id == null || id.trim().isEmpty()) {
                System.err.println(" ID manquant pour la mise à jour");
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=idmanquant");
                return;
            }

            // Validation
            if (code == null || code.trim().isEmpty() || name == null || name.trim().isEmpty()) {
                System.err.println(" Champs obligatoires manquants");
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=champsmanquants");
                return;
            }

            Department department = departmentRepository.findById(Long.parseLong(id));
            if (department != null) {
                System.out.println(" Département trouvé: " + department.getName());

                // Sauvegarder les anciennes valeurs pour le log
                String oldCode = department.getCode();
                String oldName = department.getName();

                department.setCode(code.toUpperCase().trim());
                department.setName(name.trim());
                department.setDescription(description != null ? description.trim() : null);

                Department updatedDepartment = departmentRepository.save(department);
                System.out.println(" Département mis à jour avec succès:");
                System.out.println("   Ancien code: " + oldCode + " → Nouveau code: " + updatedDepartment.getCode());
                System.out.println("   Ancien nom: " + oldName + " → Nouveau nom: " + updatedDepartment.getName());
                System.out.println("   ID: " + updatedDepartment.getId());

                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&success=updated");
            } else {
                System.err.println(" Département non trouvé pour l'ID: " + id);
                response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=notfound");
            }
        } catch (Exception e) {
            System.err.println(" Erreur updateDepartment: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/DepartmentServlet?action=list&error=update");
        }
    }

    private String getSuccessMessage(String action) {
        switch(action) {
            case "added": return "Département ajouté avec succès!";
            case "updated": return "Département modifié avec succès!";
            case "deleted": return "Département supprimé avec succès!";
            default: return "Action réalisée avec succès!";
        }
    }

    private String getErrorMessage(String error) {
        switch(error) {
            case "champsmanquants": return "Veuillez remplir tous les champs obligatoires";
            case "idmanquant": return "ID du département manquant";
            case "notfound": return "Département non trouvé";
            case "add": return "Erreur lors de l'ajout du département";
            case "update": return "Erreur lors de la modification du département";
            case "delete": return "Erreur lors de la suppression du département";
            case "load": return "Erreur lors du chargement du département";
            default: return "Une erreur est survenue: " + error;
        }
    }
}