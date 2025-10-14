package com.clinique.dao;

import org.example.entities.Department;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import java.util.List;

public class DepartmentDAO {

    private EntityManagerFactory emf;

    public DepartmentDAO() {
        emf = Persistence.createEntityManagerFactory("cliniquePU");
    }

    public void save(Department department) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(department);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public Department findById(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            return em.find(Department.class, id);
        } finally {
            em.close();
        }
    }

    public List<Department> findAll() {
        EntityManager em = emf.createEntityManager();
        try {
            return em.createQuery("SELECT d FROM Department d", Department.class).getResultList();
        } finally {
            em.close();
        }
    }

    public void update(Department department) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(department);
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public void delete(Long id) {
        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            Department department = em.find(Department.class, id);
            if (department != null) {
                em.remove(department);
            }
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }
}