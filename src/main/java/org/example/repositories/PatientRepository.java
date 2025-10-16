package org.example.repositories;

import org.example.entities.Patient;
import jakarta.persistence.*;
import java.util.List;
import java.util.Optional;

public class PatientRepository {

    private EntityManagerFactory emf;

    public PatientRepository() {
        try {
            this.emf = Persistence.createEntityManagerFactory("cliniquePU");
        } catch (Exception e) {
            System.err.println("Erreur initialisation PatientRepository: " + e.getMessage());
            throw new RuntimeException("Erreur initialisation repository", e);
        }
    }

    // Méthode pour trouver un patient par ID
    public Patient findById(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            return entityManager.find(Patient.class, id);
        } catch (Exception e) {
            System.err.println("Erreur findById: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    // Méthode pour trouver un patient par ID utilisateur
    public Patient findByUserId(Long userId) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT p FROM Patient p WHERE p.user.id = :userId";
            TypedQuery<Patient> query = entityManager.createQuery(jpql, Patient.class);
            query.setParameter("userId", userId);
            return query.getResultStream().findFirst().orElse(null);
        } catch (Exception e) {
            System.err.println("Erreur findByUserId: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    // Méthode pour récupérer tous les patients
    public List<Patient> findAll() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT p FROM Patient p ORDER BY p.user.name";
            TypedQuery<Patient> query = entityManager.createQuery(jpql, Patient.class);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findAll: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    // Méthode pour sauvegarder un patient (création ou mise à jour)
    public Patient save(Patient patient) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Patient savedPatient;
            if (patient.getId() == null) {
                entityManager.persist(patient);
                savedPatient = patient;
            } else {
                savedPatient = entityManager.merge(patient);
            }

            transaction.commit();
            return savedPatient;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur save: " + e.getMessage());
            throw new RuntimeException("Erreur sauvegarde patient", e);
        } finally {
            entityManager.close();
        }
    }

    // Méthode pour supprimer un patient
    public void delete(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Patient patient = entityManager.find(Patient.class, id);
            if (patient != null) {
                entityManager.remove(patient);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur delete: " + e.getMessage());
            throw new RuntimeException("Erreur suppression patient", e);
        } finally {
            entityManager.close();
        }
    }

    // Méthode pour trouver un patient par email
    public Patient findByEmail(String email) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT p FROM Patient p WHERE p.user.email = :email";
            TypedQuery<Patient> query = entityManager.createQuery(jpql, Patient.class);
            query.setParameter("email", email);
            return query.getResultStream().findFirst().orElse(null);
        } catch (Exception e) {
            System.err.println("Erreur findByEmail: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    // Méthode pour compter le nombre total de patients
    public Long count() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(p) FROM Patient p";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            System.err.println("Erreur count: " + e.getMessage());
            return 0L;
        } finally {
            entityManager.close();
        }
    }

    // Méthode pour vérifier si un patient existe par ID utilisateur
    public boolean existsByUserId(Long userId) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(p) FROM Patient p WHERE p.user.id = :userId";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("userId", userId);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            System.err.println("Erreur existsByUserId: " + e.getMessage());
            return false;
        } finally {
            entityManager.close();
        }
    }

    public void close() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }
}