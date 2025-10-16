    package org.example.repositories;

    import org.example.entities.Availability;
    import jakarta.persistence.*;
    import java.time.LocalDate;
    import java.util.List;

    public class AvailabilityRepository {

        private EntityManagerFactory emf;

        public AvailabilityRepository() {
            try {
                this.emf = Persistence.createEntityManagerFactory("cliniquePU");
                System.out.println("AvailabilityRepository initialisé avec RESOURCE_LOCAL");
            } catch (Exception e) {
                System.err.println("Erreur initialisation AvailabilityRepository: " + e.getMessage());
                e.printStackTrace();
                throw new RuntimeException("Erreur initialisation repository", e);
            }
        }

        public List<Availability> findByDoctor(Long doctorId) {
            EntityManager entityManager = emf.createEntityManager();
            try {
                String jpql = "SELECT a FROM Availability a WHERE a.doctor.id = :doctorId ORDER BY a.day, a.startTime";
                TypedQuery<Availability> query = entityManager.createQuery(jpql, Availability.class);
                query.setParameter("doctorId", doctorId);
                return query.getResultList();
            } catch (Exception e) {
                System.err.println("Erreur findByDoctor: " + e.getMessage());
                return List.of();
            } finally {
                entityManager.close();
            }
        }

        public List<Availability> findCurrentByDoctor(Long doctorId) {
            EntityManager entityManager = emf.createEntityManager();
            try {
                String jpql = "SELECT a FROM Availability a WHERE a.doctor.id = :doctorId " +
                        "AND (a.validTo IS NULL OR a.validTo >= CURRENT_DATE) " +
                        "ORDER BY a.day, a.startTime";
                TypedQuery<Availability> query = entityManager.createQuery(jpql, Availability.class);
                query.setParameter("doctorId", doctorId);
                return query.getResultList();
            } catch (Exception e) {
                System.err.println("Erreur findCurrentByDoctor: " + e.getMessage());
                return List.of();
            } finally {
                entityManager.close();
            }
        }

        public Availability save(Availability availability) {
            EntityManager entityManager = emf.createEntityManager();
            EntityTransaction transaction = entityManager.getTransaction();
            try {
                transaction.begin();

                Availability savedAvailability;
                if (availability.getId() == null) {
                    entityManager.persist(availability);
                    savedAvailability = availability;
                } else {
                    savedAvailability = entityManager.merge(availability);
                }

                transaction.commit();
                return savedAvailability;
            } catch (Exception e) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
                System.err.println("Erreur save: " + e.getMessage());
                throw new RuntimeException("Erreur sauvegarde disponibilité", e);
            } finally {
                entityManager.close();
            }
        }

        public void delete(Long id) {
            EntityManager entityManager = emf.createEntityManager();
            EntityTransaction transaction = entityManager.getTransaction();
            try {
                transaction.begin();
                Availability availability = entityManager.find(Availability.class, id);
                if (availability != null) {
                    entityManager.remove(availability);
                }
                transaction.commit();
            } catch (Exception e) {
                if (transaction.isActive()) {
                    transaction.rollback();
                }
                System.err.println("Erreur delete: " + e.getMessage());
                throw new RuntimeException("Erreur suppression disponibilité", e);
            } finally {
                entityManager.close();
            }
        }

        public List<Availability> findByDoctorAndDateRange(Long doctorId, LocalDate startDate, LocalDate endDate) {
            EntityManager entityManager = emf.createEntityManager();
            try {
                String jpql = "SELECT a FROM Availability a WHERE a.doctor.id = :doctorId " +
                        "AND a.day BETWEEN :startDate AND :endDate " +
                        "AND a.status = 'AVAILABLE' " +
                        "ORDER BY a.day, a.startTime";

                TypedQuery<Availability> query = entityManager.createQuery(jpql, Availability.class);
                query.setParameter("doctorId", doctorId);
                query.setParameter("startDate", startDate);
                query.setParameter("endDate", endDate);

                return query.getResultList();
            } catch (Exception e) {
                System.err.println("Erreur findByDoctorAndDateRange: " + e.getMessage());
                return List.of();
            } finally {
                entityManager.close();
            }
        }

        public List<Availability> findByDoctorAndFutureDates(Long doctorId) {
            EntityManager entityManager = emf.createEntityManager();
            try {
                LocalDate today = LocalDate.now();

                String jpql = "SELECT a FROM Availability a WHERE a.doctor.id = :doctorId " +
                        "AND a.day >= :today " +
                        "AND a.status = 'AVAILABLE' " +
                        "ORDER BY a.day, a.startTime";

                TypedQuery<Availability> query = entityManager.createQuery(jpql, Availability.class);
                query.setParameter("doctorId", doctorId);
                query.setParameter("today", today);

                return query.getResultList();
            } catch (Exception e) {
                System.err.println("Erreur findByDoctorAndFutureDates: " + e.getMessage());
                return List.of();
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
