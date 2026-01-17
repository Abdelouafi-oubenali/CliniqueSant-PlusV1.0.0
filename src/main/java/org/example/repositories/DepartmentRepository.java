package org.example.repositories;

import org.example.entities.Department;
import jakarta.persistence.*;
import java.util.List;

public class DepartmentRepository {

    private EntityManagerFactory emf;

    public DepartmentRepository() {
        try {
            this.emf = Persistence.createEntityManagerFactory("cliniquePU");
            System.out.println(" DepartmentRepository initialisé avec RESOURCE_LOCAL");
        } catch (Exception e) {
            System.err.println("Erreur initialisation DepartmentRepository: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erreur initialisation repository", e);
        }
    }

    public List<Department> findAll() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT d FROM Department d LEFT JOIN FETCH d.specialties";
            TypedQuery<Department> query = entityManager.createQuery(jpql, Department.class);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println(" Erreur findAll: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public Department findById(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT d FROM Department d LEFT JOIN FETCH d.specialties WHERE d.id = :id";
            TypedQuery<Department> query = entityManager.createQuery(jpql, Department.class);
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

    public Department save(Department department) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Department savedDepartment;
            if (department.getId() == null) {
                entityManager.persist(department);
                savedDepartment = department;
            } else {
                savedDepartment = entityManager.merge(department);
            }

            transaction.commit();
            return savedDepartment;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println(" Erreur save: " + e.getMessage());
            throw new RuntimeException("Erreur sauvegarde département", e);
        } finally {
            entityManager.close();
        }
    }

    public void delete(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            Department department = entityManager.find(Department.class, id);
            if (department != null) {
                entityManager.remove(department);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur delete: " + e.getMessage());
            throw new RuntimeException("Erreur suppression département", e);
        } finally {
            entityManager.close();
        }
    }

    public long count() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(d) FROM Department d";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            System.err.println("Erreur count: " + e.getMessage());
            return 0;
        } finally {
            entityManager.close();
        }
    }

    public long countActiveDoctors() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(d) FROM Doctor d WHERE d.user.active = true";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            System.err.println(" Erreur countActiveDoctors: " + e.getMessage());
            return 0;
        } finally {
            entityManager.close();
        }
    }

    public long countAvailableBeds() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COALESCE(SUM(r.availableBeds), 0) FROM Room r WHERE r.status = 'AVAILABLE'";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            return query.getSingleResult();
        } catch (Exception e) {
            System.err.println("Erreur countAvailableBeds: " + e.getMessage());
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