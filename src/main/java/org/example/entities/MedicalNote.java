package org.example.entities;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "medical_notes")
public class MedicalNote {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String content;

    @ManyToOne
    @JoinColumn(name = "author_id")
    private User author;

    @ManyToOne
    @JoinColumn(name = "appointment_id")
    private Appointment appointment;

    private LocalDateTime createdAt = LocalDateTime.now();

    public MedicalNote() {}

    // ===== Getters =====
    public Long getId() {
        return id;
    }

    public String getContent() {
        return content;
    }

    public User getAuthor() {
        return author;
    }

    public Appointment getAppointment() {
        return appointment;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    // ===== Setters =====
    public void setId(Long id) {
        this.id = id;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setAuthor(User author) {
        this.author = author;
    }

    public void setAppointment(Appointment appointment) {
        this.appointment = appointment;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }
}
