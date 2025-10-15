package org.example.repositories;

import org.example.entities.Doctor;
import jakarta.persistence.*;
import java.util.List;

public class DoctorRepository {

    private EntityManagerFactory emf;

    public DoctorRepository() {
        try {
            this.emf = Persistence.createEntityManagerFactory("cliniquePU");
            System.out.println("DoctorRepository initialisé avec RESOURCE_LOCAL");
        } catch (Exception e) {
            System.err.println("Erreur initialisation DoctorRepository: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erreur initialisation repository", e);
        }
    }

    public List<Doctor> findAll() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT d FROM Doctor d LEFT JOIN FETCH d.user LEFT JOIN FETCH d.specialty ORDER BY d.user.name";
            TypedQuery<Doctor> query = entityManager.createQuery(jpql, Doctor.class);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findAll: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public Doctor findById(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT d FROM Doctor d LEFT JOIN FETCH d.user LEFT JOIN FETCH d.specialty WHERE d.id = :id";
            TypedQuery<Doctor> query = entityManager.createQuery(jpql, Doctor.class);
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

    public Doctor findByUserId(Long userId) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT d FROM Doctor d LEFT JOIN FETCH d.user WHERE d.user.id = :userId";
            TypedQuery<Doctor> query = entityManager.createQuery(jpql, Doctor.class);
            query.setParameter("userId", userId);
            return query.getSingleResult();
        } catch (NoResultException e) {
            return null;
        } catch (Exception e) {
            System.err.println("Erreur findByUserId: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    public Doctor save(Doctor doctor) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Doctor savedDoctor;
            if (doctor.getId() == null) {
                entityManager.persist(doctor);
                savedDoctor = doctor;
            } else {
                savedDoctor = entityManager.merge(doctor);
            }

            transaction.commit();
            return savedDoctor;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur save: " + e.getMessage());
            throw new RuntimeException("Erreur sauvegarde docteur", e);
        } finally {
            entityManager.close();
        }
    }

    public void delete(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Doctor doctor = entityManager.find(Doctor.class, id);
            if (doctor != null) {
                entityManager.remove(doctor);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur delete: " + e.getMessage());
            throw new RuntimeException("Erreur suppression docteur", e);
        } finally {
            entityManager.close();
        }
    }

    public boolean existsByMatricule(String matricule) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(d) FROM Doctor d WHERE d.matricule = :matricule";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("matricule", matricule);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            System.err.println("Erreur existsByMatricule: " + e.getMessage());
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