package org.example;

import jakarta.persistence.*;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.example.entities.*;

@WebListener
public class DataLoader implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("cliniquePU");
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            User admin = new User();
            admin.setName("Admin");
            admin.setEmail("admin@example.com");
            admin.setPassword("admin123");
            admin.setRole("ADMIN");
            admin.setActive(true);
            em.persist(admin);

            em.getTransaction().commit();
            System.out.println("Data inserted successfully!");
        } catch(Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {}
}
