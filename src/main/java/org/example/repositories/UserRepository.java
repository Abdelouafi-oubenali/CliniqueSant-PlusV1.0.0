package org.example.repositories;

import org.example.entities.User;
import jakarta.persistence.*;
import java.util.List;

public class UserRepository {

    private EntityManagerFactory emf;

    public UserRepository() {
        try {
            this.emf = Persistence.createEntityManagerFactory("cliniquePU");
            System.out.println("UserRepository initialisé avec RESOURCE_LOCAL");
        } catch (Exception e) {
            System.err.println("Erreur initialisation UserRepository: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erreur initialisation repository", e);
        }
    }

    public List<User> findAll() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT u FROM User u ORDER BY u.name";
            TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findAll: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public User findById(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            return entityManager.find(User.class, id);
        } catch (Exception e) {
            System.err.println("Erreur findById: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    public User save(User user) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            User savedUser;
            if (user.getId() == null) {
                entityManager.persist(user);
                savedUser = user;
            } else {
                savedUser = entityManager.merge(user);
            }

            transaction.commit();
            return savedUser;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur save: " + e.getMessage());
            throw new RuntimeException("Erreur sauvegarde utilisateur", e);
        } finally {
            entityManager.close();
        }
    }

    public User updateUserRole(Long userId, String newRole) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();

        try {
            transaction.begin();

            User user = entityManager.find(User.class, userId);
            if (user == null) {
                System.err.println("Utilisateur non trouvé avec l'ID : " + userId);
                transaction.rollback();
                return null;
            }

            user.setRole(newRole);
            User updatedUser = entityManager.merge(user);

            transaction.commit();
            System.out.println("Rôle de l'utilisateur ID " + userId + " mis à jour en " + newRole);

            return updatedUser;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur updateUserRole: " + e.getMessage());
            throw new RuntimeException("Erreur lors de la mise à jour du rôle utilisateur", e);
        } finally {
            entityManager.close();
        }
    }

    public List<User> findAllPatients() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.role = 'PATIENT' ORDER BY u.name";
            TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findAllPatients: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public User findByEmail(String email) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            return entityManager.createQuery("SELECT u FROM User u WHERE u.email = :email", User.class)
                    .setParameter("email", email)
                    .getResultStream()
                    .findFirst()
                    .orElse(null);
        } catch (Exception e) {
            System.err.println("Erreur findByEmail: " + e.getMessage());
            return null;
        } finally {
            entityManager.close();
        }
    }

    public boolean existsByEmail(String email) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(u) FROM User u WHERE u.email = :email";
            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("email", email);
            return query.getSingleResult() > 0;
        } catch (Exception e) {
            System.err.println("Erreur existsByEmail: " + e.getMessage());
            return false;
        } finally {
            entityManager.close();
        }
    }

    public List<User> findAllDoctors() {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT u FROM User u WHERE u.role = 'DOCTOR' ORDER BY u.name";
            TypedQuery<User> query = entityManager.createQuery(jpql, User.class);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findAllDoctors: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public void delete(Long id) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            User user = entityManager.find(User.class, id);
            if (user != null) {
                entityManager.remove(user);
                System.out.println("Utilisateur ID " + id + " supprimé avec succès");
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur delete: " + e.getMessage());
            throw new RuntimeException("Erreur suppression utilisateur", e);
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