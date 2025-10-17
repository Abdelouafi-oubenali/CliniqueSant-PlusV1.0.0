package org.example.repositories;

import org.example.entities.Appointment;
import jakarta.persistence.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.List;

public class AppointmentRepository {

    private EntityManagerFactory emf;

    public AppointmentRepository() {
        try {
            this.emf = Persistence.createEntityManagerFactory("cliniquePU");
            System.out.println("AppointmentRepository initialisé avec RESOURCE_LOCAL");
        } catch (Exception e) {
            System.err.println("Erreur initialisation AppointmentRepository: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("Erreur initialisation repository", e);
        }
    }

    public Appointment save(Appointment appointment) {
        EntityManager entityManager = emf.createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();

            Appointment savedAppointment;
            if (appointment.getId() == null) {
                entityManager.persist(appointment);
                savedAppointment = appointment;
            } else {
                savedAppointment = entityManager.merge(appointment);
            }

            transaction.commit();
            return savedAppointment;
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            System.err.println("Erreur save: " + e.getMessage());
            throw new RuntimeException("Erreur sauvegarde rendez-vous", e);
        } finally {
            entityManager.close();
        }
    }

    public List<Appointment> findByDoctorAndDate(Long doctorId, LocalDate date) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId " +
                    "AND a.appointmentDate = :date " +
                    "AND a.status = 'PLANNED' " +
                    "ORDER BY a.startTime";
            TypedQuery<Appointment> query = entityManager.createQuery(jpql, Appointment.class);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findByDoctorAndDate: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public boolean isTimeSlotAvailable(Long doctorId, LocalDate date, LocalTime startTime, LocalTime endTime) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(a) FROM Appointment a WHERE a.doctor.id = :doctorId " +
                    "AND a.appointmentDate = :date " +
                    "AND a.status = 'PLANNED' " +
                    "AND ((a.startTime <= :startTime AND a.endTime > :startTime) " +
                    "OR (a.startTime < :endTime AND a.endTime >= :endTime) " +
                    "OR (a.startTime >= :startTime AND a.endTime <= :endTime))";

            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);
            query.setParameter("startTime", startTime);
            query.setParameter("endTime", endTime);

            Long count = query.getSingleResult();
            return count == 0;
        } catch (Exception e) {
            System.err.println("Erreur isTimeSlotAvailable: " + e.getMessage());
            return false;
        } finally {
            entityManager.close();
        }
    }

    public List<Appointment> findByPatientId(Long patientId) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT a FROM Appointment a WHERE a.patient.id = :patientId " +
                    "ORDER BY a.appointmentDate DESC, a.startTime DESC";
            TypedQuery<Appointment> query = entityManager.createQuery(jpql, Appointment.class);
            query.setParameter("patientId", patientId);
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur findByPatientId: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public List<Appointment> findByDoctorAndFutureDates(Long doctorId) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT a FROM Appointment a WHERE a.doctor.id = :doctorId " +
                    "AND a.appointmentDate >= :today AND a.status = 'PLANNED' " +
                    "ORDER BY a.appointmentDate, a.startTime";
            TypedQuery<Appointment> query = entityManager.createQuery(jpql, Appointment.class);
            query.setParameter("doctorId", doctorId);
            query.setParameter("today", LocalDate.now());
            return query.getResultList();
        } catch (Exception e) {
            System.err.println("Erreur dans findByDoctorAndFutureDates: " + e.getMessage());
            return List.of();
        } finally {
            entityManager.close();
        }
    }

    public boolean hasAppointmentOnSameDay(Long patientId, LocalDate date) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(a) FROM Appointment a WHERE a.patient.id = :patientId " +
                    "AND a.appointmentDate = :date " +
                    "AND a.status = 'PLANNED'";

            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("patientId", patientId);
            query.setParameter("date", date);

            Long count = query.getSingleResult();
            System.out.println("Vérification rendez-vous même jour - Patient ID: " + patientId +
                    ", Date: " + date + ", Count: " + count);

            return count > 0;
        } catch (Exception e) {
            System.err.println("Erreur hasAppointmentOnSameDay: " + e.getMessage());
            e.printStackTrace();
            return false;
        } finally {
            entityManager.close();
        }
    }

    // Version alternative si vous voulez utiliser FUNCTION('DATE') pour extraire la date
    public boolean hasAppointmentWithSameDoctorOnSameDay(Long patientId, Long doctorId, LocalDate date) {
        EntityManager entityManager = emf.createEntityManager();
        try {
            String jpql = "SELECT COUNT(a) FROM Appointment a WHERE a.patient.id = :patientId " +
                    "AND a.doctor.id = :doctorId " +
                    "AND a.appointmentDate = :date " +
                    "AND a.status = 'PLANNED'";

            TypedQuery<Long> query = entityManager.createQuery(jpql, Long.class);
            query.setParameter("patientId", patientId);
            query.setParameter("doctorId", doctorId);
            query.setParameter("date", date);

            Long count = query.getSingleResult();
            System.out.println("Vérification rendez-vous même docteur même jour - Patient ID: " + patientId +
                    ", Doctor ID: " + doctorId + ", Date: " + date + ", Count: " + count);

            return count > 0;
        } catch (Exception e) {
            System.err.println("Erreur hasAppointmentWithSameDoctorOnSameDay: " + e.getMessage());
            e.printStackTrace();
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