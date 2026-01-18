package org.example.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entities.User;
import org.example.repositories.UserRepository;
import java.io.IOException;
import java.util.List;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private UserRepository userRepository;

    @Override
    public void init() throws ServletException {
        try {
            this.userRepository = new UserRepository();
            System.out.println("UserServlet initialisé avec Repository");
        } catch (Exception e) {
            System.err.println("Erreur initialisation UserRepository: " + e.getMessage());
            e.printStackTrace();
            throw new ServletException("Erreur initialisation repository", e);
        }
    }

    @Override
    public void destroy() {
        if (userRepository != null) {
            userRepository.close();
        }
        System.out.println("UserServlet détruit");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("Action: " + request.getParameter("action"));

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch(action) {
                case "list":
                    listUsers(request, response);
                    break;
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteUser(request, response);
                    break;
                case "view":
                    viewUser(request, response);
                    break;
                default:
                    listUsers(request, response);
            }
        } catch (Exception e) {
            System.err.println("Erreur dans doGet: " + e.getMessage());
            e.printStackTrace();
            response.sendError(500, "Erreur interne: " + e.getMessage());
        }
    }

    private void listUsers(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            System.out.println("Chargement de la liste des utilisateurs depuis PostgreSQL...");

            // Récupération des données RÉELLES depuis la base
            List<User> users = userRepository.findAll();
            long usersCount = users.size();
            long adminCount = users.stream().filter(u -> "ADMIN".equals(u.getRole())).count();
            long doctorCount = users.stream().filter(u -> "DOCTOR".equals(u.getRole())).count();
            long patientCount = users.stream().filter(u -> "PATIENT".equals(u.getRole())).count();

            System.out.println("📋 " + users.size() + " utilisateurs trouvés dans PostgreSQL");

            String contextPath = request.getContextPath();

            // Attribution des données RÉELLES
            request.setAttribute("contextPath", contextPath);
            request.setAttribute("pageTitle", "Gestion des Utilisateurs");
            request.setAttribute("users", users);
            request.setAttribute("usersCount", (int) usersCount);
            request.setAttribute("adminCount", (int) adminCount);
            request.setAttribute("doctorCount", (int) doctorCount);
            request.setAttribute("patientCount", (int) patientCount);

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

            System.out.println("Forward vers /admin/users/index.jsp");
            request.getRequestDispatcher("/admin/users/index.jsp").forward(request, response);

        } catch (Exception e) {
            System.err.println("Erreur dans listUsers: " + e.getMessage());
            e.printStackTrace();

            // Fallback: données simulées en cas d'erreur
            setupFallbackData(request, e.getMessage());
            request.getRequestDispatcher("/admin/users/index.jsp").forward(request, response);
        }
    }

    private void setupFallbackData(HttpServletRequest request, String errorMessage) {
        System.out.println("Utilisation des données de fallback: " + errorMessage);

        request.setAttribute("contextPath", request.getContextPath());
        request.setAttribute("pageTitle", "Gestion des Utilisateurs - Erreur BD");
        request.setAttribute("users", List.of());
        request.setAttribute("usersCount", 0);
        request.setAttribute("adminCount", 0);
        request.setAttribute("doctorCount", 0);
        request.setAttribute("patientCount", 0);
        request.setAttribute("currentFilter", "all");
        request.setAttribute("errorMessage", "Erreur base de données: " + errorMessage);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("contextPath", request.getContextPath());
            request.setAttribute("pageTitle", "Nouvel Utilisateur");
            request.setAttribute("user", null);
            request.getRequestDispatcher("/admin/users/form.jsp").forward(request, response);
        } catch (Exception e) {
            System.err.println("Erreur showAddForm: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=loadform");
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=idmanquant");
                return;
            }

            User user = userRepository.findById(Long.parseLong(id));
            if (user != null) {
                request.setAttribute("contextPath", request.getContextPath());
                request.setAttribute("user", user);
                request.setAttribute("pageTitle", "Modifier Utilisateur - " + user.getName());
                request.getRequestDispatcher("/admin/users/form.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=notfound");
            }
        } catch (Exception e) {
            System.err.println("Erreur showEditForm: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=load");
        }
    }

    private void viewUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=idmanquant");
                return;
            }

            User user = userRepository.findById(Long.parseLong(id));
            if (user != null) {
                request.setAttribute("contextPath", request.getContextPath());
                request.setAttribute("user", user);
                request.setAttribute("pageTitle", "Détails Utilisateur - " + user.getName());
                request.getRequestDispatcher("/admin/users/details.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=notfound");
            }
        } catch (Exception e) {
            System.err.println("Erreur viewUser: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=load");
        }
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            if (id == null || id.trim().isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=idmanquant");
                return;
            }

            User user = userRepository.findById(Long.parseLong(id));
            if (user == null) {
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=notfound");
                return;
            }

            userRepository.delete(Long.parseLong(id));
            System.out.println("Suppression utilisateur ID: " + id);
            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&success=deleted");

        } catch (Exception e) {
            System.err.println("Erreur deleteUser: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=delete");
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String action = request.getParameter("action");
            System.out.println("UserServlet doPost - Action: " + action);

            if ("add".equals(action)) {
                addUser(request, response);
            } else if ("update".equals(action)) {
                updateUser(request, response);
            } else {
                System.err.println("Action POST non reconnue: " + action);
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=actioninconnue");
            }
        } catch (Exception e) {
            System.err.println("Erreur dans doPost: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=" + e.getMessage());
        }
    }

    private void addUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("password");
            String role = request.getParameter("role");

            System.out.println("➕ Ajout utilisateur - Name: " + name + ", Email: " + email + ", Role: " + role);

            if (name == null || name.trim().isEmpty() || 
                email == null || email.trim().isEmpty() || 
                password == null || password.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {
                System.err.println("Champs obligatoires manquants pour l'ajout");
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=champsmanquants");
                return;
            }

            User user = new User();
            user.setName(name.trim());
            user.setEmail(email.trim());
            user.setPassword(password.trim());
            user.setRole(role.trim());
            user.setActive(true);

            User savedUser = userRepository.save(user);
            System.out.println("Utilisateur ajouté avec succès - ID: " + savedUser.getId());

            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&success=added");

        } catch (Exception e) {
            System.err.println("Erreur addUser: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=add");
        }
    }

    private void updateUser(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String role = request.getParameter("role");
            String activeStr = request.getParameter("active");

            System.out.println("Mise à jour utilisateur - ID: " + id + ", Name: " + name);

            if (id == null || id.trim().isEmpty()) {
                System.err.println("ID manquant pour la mise à jour");
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=idmanquant");
                return;
            }

            if (name == null || name.trim().isEmpty() || 
                email == null || email.trim().isEmpty() ||
                role == null || role.trim().isEmpty()) {
                System.err.println("Champs obligatoires manquants");
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=champsmanquants");
                return;
            }

            User user = userRepository.findById(Long.parseLong(id));
            if (user != null) {
                System.out.println("Utilisateur trouvé: " + user.getName());

                user.setName(name.trim());
                user.setEmail(email.trim());
                user.setRole(role.trim());
                user.setActive("on".equals(activeStr));

                User updatedUser = userRepository.save(user);
                System.out.println("Utilisateur mis à jour avec succès - ID: " + updatedUser.getId());

                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&success=updated");
            } else {
                System.err.println("Utilisateur non trouvé pour l'ID: " + id);
                response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=notfound");
            }
        } catch (Exception e) {
            System.err.println("Erreur updateUser: " + e.getMessage());
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/UserServlet?action=list&error=update");
        }
    }

    private String getSuccessMessage(String action) {
        switch(action) {
            case "added": return "Utilisateur ajouté avec succès!";
            case "updated": return "Utilisateur modifié avec succès!";
            case "deleted": return "Utilisateur supprimé avec succès!";
            default: return "Action réalisée avec succès!";
        }
    }

    private String getErrorMessage(String error) {
        switch(error) {
            case "champsmanquants": return "Veuillez remplir tous les champs obligatoires";
            case "idmanquant": return "ID de l'utilisateur manquant";
            case "notfound": return "Utilisateur non trouvé";
            case "add": return "Erreur lors de l'ajout de l'utilisateur";
            case "update": return "Erreur lors de la modification de l'utilisateur";
            case "delete": return "Erreur lors de la suppression de l'utilisateur";
            case "load": return "Erreur lors du chargement de l'utilisateur";
            default: return "Une erreur est survenue: " + error;
        }
    }
}
