package org.example.repositories;

import org.example.entities.Patient;
import jakarta.persistence.*;
import java.util.List;

public class PatientRepository {

    private EntityManagerFactory emf;

    public PatientRepository() {
        try {
            this.emf = Persistence.createEntityManagerFactory("cliniquePU");
            System.out.println("PatientRepository initialisé avec RESOURCE_LOCAL");
        } catch (Exception e) {
            System.err.println("Erreur initialisation PatientRepository: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erreur initialisation repository", e);
        }
    }

    public List<Patient> findAll() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT p FROM Patient p LEFT JOIN FETCH p.user ORDER BY p.user.name";
            TypedQuery<Patient> query = entityManager.createQuery(jpql, Patient.class);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findAll: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public Patient findById(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT p FROM Patient p LEFT JOIN FETCH p.user WHERE p.id = :id";
            TypedQuery<Patient> query = entityManager.createQuery(jpql, Patient.class);
            query.setParameter("id", id);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            System.err.println("Erreur findById: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

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

    public boolean existsByCin(String cin) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(p) FROM Patient p WHERE p.cin = :cin";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("cin", cin);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            System.err.println("Erreur existsByCin: " + e.getMessage());
            return false;
        } finally {
            entityManager.close();
        }
    }

    public long count() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(p) FROM Patient p";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            System.err.println("Erreur count: " + e.getMessage());
            return 0;
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