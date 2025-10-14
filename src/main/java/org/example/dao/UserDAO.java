package org.example.dao;

import jakarta.persistence.EntityManager;
import org.example.entities.User;
import org.example.utils.JpaUtil;

public class UserDAO {

    public void save(User user) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
