package org.example;

import jakarta.persistence.*;
import org.example.entities.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;

public class Main {

    public static void main(String[] args) {
        // Crée l'EntityManagerFactory et l'EntityManager
        EntityManagerFactory emf = Persistence.createEntityManagerFactory("cliniquePU");
        EntityManager em = emf.createEntityManager();

        try {
            em.getTransaction().begin();

            // Création d'un département
            Department cardiology = new Department();
            cardiology.setCode("CARD");
            cardiology.setName("Cardiology");
            cardiology.setDescription("Cardiology Department");
            em.persist(cardiology);

            // Création d'une spécialité
            Specialty cardioSpecialty = new Specialty();
            cardioSpecialty.setCode("CARD-001");
            cardioSpecialty.setName("Heart Surgery");
            cardioSpecialty.setDescription("Heart Surgery Specialty");
            cardioSpecialty.setDepartment(cardiology);
            em.persist(cardioSpecialty);

            // Création d'un utilisateur
            User admin = new User();
            admin.setName("Admin");
            admin.setEmail("admin@example.com");
            admin.setPassword("admin123");
            admin.setRole("ADMIN");
            admin.setActive(true);
            em.persist(admin);

            // Création d'un docteur
            Doctor drSmith = new Doctor();
            drSmith.setMatricule("DOC-001");
            drSmith.setTitle("Dr.");
            drSmith.setSpecialty(cardioSpecialty);
            drSmith.setUser(admin);
            em.persist(drSmith);

            // Création d'un patient
            Patient patient1 = new Patient();
            patient1.setCin("P123456");
            patient1.setBirthDate(LocalDate.of(1990, 5, 15));
            patient1.setGender("Male");
            patient1.setAddress("123 Main St");
            patient1.setPhone("0123456789");
            patient1.setBloodType("O+");
            patient1.setUser(admin);
            em.persist(patient1);

            // Création d'une disponibilité
            Availability avail = new Availability();
            avail.setDoctor(drSmith);
            avail.setDay(LocalDate.of(2025, 10, 10));
            avail.setStartTime(LocalTime.of(9, 0));
            avail.setEndTime(LocalTime.of(12, 0));
            avail.setStatus("AVAILABLE");
            avail.setValidFrom(LocalDate.of(2025, 10, 1));
            avail.setValidTo(LocalDate.of(2025, 12, 31));
            em.persist(avail);

            // Création d'un rendez-vous
            Appointment appointment = new Appointment();
            appointment.setPatient(patient1);
            appointment.setDoctor(drSmith);
            appointment.setAppointmentDate(LocalDate.of(2025, 10, 10));
            appointment.setStartTime(LocalTime.of(9, 30));
            appointment.setEndTime(LocalTime.of(10, 0));
            appointment.setStatus("SCHEDULED");
            appointment.setType("Consultation");
            em.persist(appointment);

            // Création d'une note médicale
            MedicalNote note = new MedicalNote();
            note.setAppointment(appointment);
            note.setAuthor(admin);
            note.setContent("Patient in good health.");
            em.persist(note);

            em.getTransaction().commit();

            System.out.println("Données insérées avec succès !");
        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
            emf.close();
        }
    }
}
