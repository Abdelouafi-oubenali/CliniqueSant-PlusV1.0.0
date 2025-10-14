package org.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.Specialty;
import org.example.entities.Department;
import org.example.repositories.SpecialtyRepository;
import org.example.repositories.DepartmentRepository;
import org.example.dao.SpecialtyDTO;
import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet("/specialties")
public class SpecialityServlet extends HttpServlet {
    
    private SpecialtyRepository specialtyRepository;
    private DepartmentRepository departmentRepository;

    @Override
    public void init() {
        System.out.println("🔄 Initialisation de SpecialityServlet...");
        try {
            specialtyRepository = new SpecialtyRepository();
            departmentRepository = new DepartmentRepository();
            System.out.println("✅ Repositories initialisés avec succès");
        } catch (Exception e) {
            System.err.println("❌ Erreur initialisation repositories: " + e.getMessage());
            e.printStackTrace();
        }
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("\n=== 🚀 SPECIALITY SERVLET DOGET ===");
        System.out.println("📧 URL: " + request.getRequestURL());
        System.out.println("🔍 Query String: " + request.getQueryString());
        
        String action = request.getParameter("action");
        System.out.println("🎯 Action: " + action);
        
        try {
            if ("edit".equals(action)) {
                handleEditAction(request);
            } else if ("delete".equals(action)) {
                handleDeleteAction(request);
            } else if ("view".equals(action)) {
                handleViewAction(request);
            } else {
                System.out.println("📋 Mode liste par défaut");
            }
            
            // Charger les données pour la vue
            loadViewData(request);
            
            // Forward vers la JSP
            forwardToJSP(request, response);
            
        } catch (Exception e) {
            System.err.println("❌ Erreur dans doGet: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
            forwardToJSP(request, response);
        }
    }
    
    private void handleEditAction(HttpServletRequest request) {
        try {
            String idParam = request.getParameter("id");
            System.out.println("✏️ Mode édition - ID param: " + idParam);
            
            if (idParam == null || idParam.trim().isEmpty()) {
                System.err.println("❌ ID manquant pour l'édition");
                request.setAttribute("errorMessage", "ID manquant pour la modification");
                return;
            }
            
            Long id = Long.parseLong(idParam);
            System.out.println("🔍 Recherche spécialité ID: " + id);
            
            Specialty specialty = specialtyRepository.findById(id);
            
            if (specialty != null) {
                request.setAttribute("specialtyToEdit", specialty);
                request.setAttribute("pageTitle", "Modifier la Spécialité");
                System.out.println("✅ Spécialité trouvée: " + specialty.getName());
                
                // Debug department
                if (specialty.getDepartment() != null) {
                    System.out.println("🏥 Département: " + specialty.getDepartment().getName());
                } else {
                    System.out.println("⚠️ Aucun département associé");
                }
            } else {
                System.err.println("❌ Spécialité non trouvée pour ID: " + id);
                request.setAttribute("errorMessage", "Spécialité non trouvée");
            }
        } catch (NumberFormatException e) {
            System.err.println("❌ Format ID invalide");
            request.setAttribute("errorMessage", "ID invalide");
        } catch (Exception e) {
            System.err.println("❌ Erreur lors de l'édition: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
        }
    }
    
    private void handleDeleteAction(HttpServletRequest request) {
        try {
            String idParam = request.getParameter("id");
            System.out.println("🗑️ Mode suppression - ID param: " + idParam);
            
            if (idParam == null || idParam.trim().isEmpty()) {
                System.err.println("❌ ID manquant pour la suppression");
                request.setAttribute("errorMessage", "ID manquant pour la suppression");
                return;
            }
            
            Long id = Long.parseLong(idParam);
            System.out.println("🔍 Suppression spécialité ID: " + id);
            
            // Vérifier si la spécialité existe avant suppression
            Specialty specialty = specialtyRepository.findById(id);
            if (specialty != null) {
                specialtyRepository.delete(id);
                request.setAttribute("successMessage", "Spécialité '" + specialty.getName() + "' supprimée avec succès");
                System.out.println("✅ Spécialité supprimée: " + specialty.getName());
            } else {
                System.err.println("❌ Spécialité non trouvée pour suppression ID: " + id);
                request.setAttribute("errorMessage", "Spécialité non trouvée");
            }
        } catch (NumberFormatException e) {
            System.err.println("❌ Format ID invalide pour suppression");
            request.setAttribute("errorMessage", "ID invalide");
        } catch (Exception e) {
            System.err.println("❌ Erreur lors de la suppression: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur lors de la suppression: " + e.getMessage());
        }
    }
    
    private void handleViewAction(HttpServletRequest request) {
        System.out.println("👁️ Mode visualisation");
        // Implémentez la visualisation si nécessaire
    }
    
    private void loadViewData(HttpServletRequest request) {
        try {
            System.out.println("📥 Chargement des données...");
            
            // Charger les départements pour le formulaire
            List<Department> departments = departmentRepository.findAll();
            request.setAttribute("departments", departments);
            System.out.println("✅ Départements chargés: " + departments.size());
            
            // Charger la liste des spécialités
            List<Specialty> specialties = specialtyRepository.findAll();
            System.out.println("🔍 Spécialités trouvées en base: " + specialties.size());
            
            List<SpecialtyDTO> specialtyDTOs = specialties.stream()
                .map(specialty -> {
                    SpecialtyDTO dto = new SpecialtyDTO();
                    dto.setId(specialty.getId());
                    dto.setCode(specialty.getCode());
                    dto.setName(specialty.getName());
                    dto.setDescription(specialty.getDescription());
                    
                    if (specialty.getDepartment() != null) {
                        dto.setDepartmentId(specialty.getDepartment().getId());
                        dto.setDepartmentName(specialty.getDepartment().getName());
                        System.out.println("🏥 " + specialty.getName() + " -> Département: " + specialty.getDepartment().getName());
                    } else {
                        dto.setDepartmentName("Non assigné");
                        System.out.println("⚠️ " + specialty.getName() + " -> Aucun département");
                    }
                    
                    return dto;
                })
                .collect(Collectors.toList());
                
            request.setAttribute("specialties", specialtyDTOs);
            request.setAttribute("specialtiesCount", specialtyDTOs.size());
            System.out.println("✅ Spécialités DTO créées: " + specialtyDTOs.size());
            
        } catch (Exception e) {
            System.err.println("❌ Erreur lors du chargement des données: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur chargement données: " + e.getMessage());
        }
    }
    
    private void forwardToJSP(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String jspPath = "/WEB-INF/admin/specialties/index.jsp";
        System.out.println("➡️ Forward vers: " + jspPath);
        
        try {
            request.getRequestDispatcher(jspPath).forward(request, response);
            System.out.println("✅ Forward réussi");
        } catch (Exception e) {
            System.err.println("❌ Erreur lors du forward: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Erreur JSP: " + e.getMessage());
        }
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("\n=== 🚀 SPECIALITY SERVLET DOPOST ===");
        System.out.println("📧 URL: " + request.getRequestURL());
        
        String action = request.getParameter("action");
        System.out.println("🎯 Action POST: " + action);
        
        try {
            // Récupérer les paramètres
            String code = request.getParameter("code");
            String name = request.getParameter("name");
            String description = request.getParameter("description");
            String departmentIdParam = request.getParameter("departmentId");
            
            System.out.println("📋 Paramètres reçus:");
            System.out.println("   - Code: " + code);
            System.out.println("   - Name: " + name);
            System.out.println("   - Description: " + description);
            System.out.println("   - DepartmentId: " + departmentIdParam);
            
            // Validation
            if (!validateFormData(code, name, departmentIdParam, request)) {
                System.err.println("❌ Validation échouée");
                doGet(request, response);
                return;
            }
            
            Long departmentId = Long.parseLong(departmentIdParam);
            
            if ("edit".equals(action)) {
                handleEditPost(request, code, name, description, departmentId);
            } else {
                handleAddPost(request, code, name, description, departmentId);
            }
            
            // Redirection vers la liste
            String redirectUrl = request.getContextPath() + "/specialties";
            System.out.println("🔄 Redirection vers: " + redirectUrl);
            response.sendRedirect(redirectUrl);
            
        } catch (Exception e) {
            System.err.println("❌ Erreur dans doPost: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Erreur: " + e.getMessage());
            doGet(request, response);
        }
    }
    
    private boolean validateFormData(String code, String name, String departmentId, HttpServletRequest request) {
        if (code == null || code.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Le code est obligatoire");
            return false;
        }
        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Le nom est obligatoire");
            return false;
        }
        if (departmentId == null || departmentId.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Le département est obligatoire");
            return false;
        }
        return true;
    }
    
    private void handleEditPost(HttpServletRequest request, String code, String name, 
                               String description, Long departmentId) {
        try {
            String idParam = request.getParameter("id");
            System.out.println("✏️ Modification spécialité ID: " + idParam);
            
            if (idParam == null || idParam.trim().isEmpty()) {
                throw new IllegalArgumentException("ID manquant pour la modification");
            }
            
            Long id = Long.parseLong(idParam);
            Specialty specialty = specialtyRepository.findById(id);
            
            if (specialty != null) {
                specialty.setCode(code.trim());
                specialty.setName(name.trim());
                specialty.setDescription(description != null ? description.trim() : null);
                
                Department department = departmentRepository.findById(departmentId);
                if (department != null) {
                    specialty.setDepartment(department);
                    specialtyRepository.save(specialty);
                    request.setAttribute("successMessage", "Spécialité modifiée avec succès");
                    System.out.println("✅ Spécialité modifiée: " + name);
                } else {
                    throw new IllegalArgumentException("Département non trouvé ID: " + departmentId);
                }
            } else {
                throw new IllegalArgumentException("Spécialité non trouvée ID: " + id);
            }
        } catch (Exception e) {
            System.err.println("❌ Erreur modification: " + e.getMessage());
            throw new RuntimeException("Erreur modification: " + e.getMessage(), e);
        }
    }
    
    private void handleAddPost(HttpServletRequest request, String code, String name, 
                              String description, Long departmentId) {
        try {
            System.out.println("➕ Ajout nouvelle spécialité");
            
            Department department = departmentRepository.findById(departmentId);
            if (department != null) {
                Specialty specialty = new Specialty(code.trim(), name.trim(), 
                                                   description != null ? description.trim() : null, 
                                                   department);
                specialtyRepository.save(specialty);
                request.setAttribute("successMessage", "Spécialité ajoutée avec succès");
                System.out.println("✅ Nouvelle spécialité ajoutée: " + name);
            } else {
                throw new IllegalArgumentException("Département non trouvé ID: " + departmentId);
            }
        } catch (Exception e) {
            System.err.println("❌ Erreur ajout: " + e.getMessage());
            throw new RuntimeException("Erreur ajout: " + e.getMessage(), e);
        }
    }
    
    @Override
    public void destroy() {
        System.out.println("🔚 Destruction de SpecialityServlet");
        if (specialtyRepository != null) {
            specialtyRepository.close();
        }
        if (departmentRepository != null) {
            departmentRepository.close();
        }
    }
}