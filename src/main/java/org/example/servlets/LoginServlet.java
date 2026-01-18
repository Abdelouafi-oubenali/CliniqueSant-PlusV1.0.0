package org.example.servlets;

import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.example.entities.User;

import java.io.IOException;
import java.util.List;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        try {
            emf = Persistence.createEntityManagerFactory("cliniquePU");
        } catch (Exception e) {
            throw new ServletException("Erreur lors de l'initialisation de l'EntityManagerFactory", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");

        System.out.println("Tentative de connexion: " + email); // Debug

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            resp.sendRedirect("index.jsp?error=missing_fields");
            return;
        }

        EntityManager em = null;
        try {
            em = emf.createEntityManager();

            List<User> users = em.createQuery(
                            "SELECT u FROM User u WHERE u.email = :email AND u.password = :password", User.class)
                    .setParameter("email", email)
                    .setParameter("password", password)
                    .getResultList();

            if (!users.isEmpty()) {
                User user = users.get(0);
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                session.setAttribute("userId", user.getId());
                session.setAttribute("userRole", user.getRole());

                System.out.println("Connexion réussie - Rôle: " + user.getRole()); // Debug

                // Redirection selon le rôle
                if ("ADMIN".equalsIgnoreCase(user.getRole()) || "DOCTOR".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/DashboardServlet");
                } else if ("PATIENT".equalsIgnoreCase(user.getRole())) {
                    resp.sendRedirect(req.getContextPath() + "/patient/index.jsp");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/index.jsp?error=invalid_role");
                }
            } else {
                System.out.println("Aucun utilisateur trouvé"); // Debug
                resp.sendRedirect(req.getContextPath() + "/index.jsp?error=invalid_credentials");
            }

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/index.jsp?error=server_error");
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}