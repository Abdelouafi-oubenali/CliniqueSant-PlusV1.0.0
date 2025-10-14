package org.example.repositories;

import org.example.entities.Specialty;
import jakarta.persistence.*;
import java.util.List;

public class SpecialtyRepository {

    private EntityManagerFactory emf;

    public SpecialtyRepository() {
        try {
            this.emf = Persistence.createEntityManagerFactory("cliniquePU");
            System.out.println("SpecialtyRepository initialisé avec RESOURCE_LOCAL");
        } catch (Exception e) {
            System.err.println("Erreur initialisation SpecialtyRepository: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erreur initialisation repository", e);
        }
    }

    public List<Specialty> findAll() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT s FROM Specialty s LEFT JOIN FETCH s.department ORDER BY s.name";
            TypedQuery<Specialty> query = entityManager.createQuery(jpql, Specialty.class);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findAll: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    // CORRECTION : Retourne directement Specialty (comme DepartmentRepository)
    public Specialty findById(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT s FROM Specialty s LEFT JOIN FETCH s.department WHERE s.id = :id";
            TypedQuery<Specialty> query = entityManager.createQuery(jpql, Specialty.class);
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

    public Specialty save(Specialty specialty) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Specialty savedSpecialty;
            if (specialty.getId() == null) {
                entityManager.persist(specialty);
                savedSpecialty = specialty;
            } else {
                savedSpecialty = entityManager.merge(specialty);
            }

            transaction.commit();
            return savedSpecialty;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur save: " + e.getMessage());
            throw new RuntimeException("Erreur sauvegarde spécialité", e);
        } finally {
            entityManager.close();
        }
    }

    public void delete(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Specialty specialty = entityManager.find(Specialty.class, id);
            if (specialty != null) {
                entityManager.remove(specialty);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur delete: " + e.getMessage());
            throw new RuntimeException("Erreur suppression spécialité", e);
        } finally {
            entityManager.close();
        }
    }

    public List<Specialty> findByDepartmentId(Long departmentId) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT s FROM Specialty s WHERE s.department.id = :departmentId ORDER BY s.name";
            TypedQuery<Specialty> query = entityManager.createQuery(jpql, Specialty.class);
            query.setParameter("departmentId", departmentId);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findByDepartmentId: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public boolean existsByCode(String code) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(s) FROM Specialty s WHERE s.code = :code";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("code", code);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            System.err.println("Erreur existsByCode: " + e.getMessage());
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