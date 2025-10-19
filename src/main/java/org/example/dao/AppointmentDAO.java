package org.example.dao;

import org.example.entities.Appointment;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.persistence.TypedQuery;
import java.util.List;
import java.util.logging.Logger;

public class AppointmentDAO {

    private static final Logger logger = Logger.getLogger(AppointmentDAO.class.getName());
    private EntityManagerFactory emf;

    public AppointmentDAO() {
        try {
            this.emf = Persistence.createEntityManagerFactory("cliniquePU");
            logger.info(" EntityManagerFactory créé avec succès pour: cliniquePU");

            // Tester la connexion
            testConnection();

        } catch (Exception e) {
            logger.severe("Erreur création EntityManagerFactory: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Impossible d'initialiser l'EntityManagerFactory", e);
        }
    }

    private void testConnection() {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            // Tester une requête simple
            Long count = em.createQuery("SELECT COUNT(a) FROM Appointment a", Long.class).getSingleResult();
            logger.info("Test connexion réussi. Nombre total de rendez-vous: " + count);
        } catch (Exception e) {
            logger.warning("⚠ Test connexion échoué: " + e.getMessage());
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }

    public List<Appointment> findByPatientUserId(Long userId) {
        EntityManager em = null;
        try {
            em = emf.createEntityManager();
            String jpql = "SELECT a FROM Appointment a " +
                    "LEFT JOIN FETCH a.doctor d " +
                    "LEFT JOIN FETCH d.user " +
                    "LEFT JOIN FETCH d.specialty " +
                    "LEFT JOIN FETCH a.patient p " +
                    "LEFT JOIN FETCH p.user u " +
                    "LEFT JOIN FETCH a.notes " +
                    "WHERE u.id = :userId " +
                    "ORDER BY a.appointmentDate DESC, a.startTime DESC";

            TypedQuery<Appointment> query = em.createQuery(jpql, Appointment.class);
            query.setParameter("userId", userId);

            List<Appointment> result = query.getResultList();
            System.out.println(" Rendez-vous récupérés: " + result.size());

            // Debug des relations
            for (Appointment app : result) {
                System.out.println("Appointment " + app.getId() +
                        " - Doctor: " + (app.getDoctor() != null ? app.getDoctor().getId() : "null") +
                        " - Specialty: " + (app.getDoctor() != null && app.getDoctor().getSpecialty() != null ?
                        app.getDoctor().getSpecialty().getName() : "null"));
            }

            return result;

        } catch (Exception e) {
            e.printStackTrace();
            return List.of();
        } finally {
            if (em != null && em.isOpen()) {
                em.close();
            }
        }
    }
    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            logger.info(" EntityManagerFactory fermé");
        }
    }



}