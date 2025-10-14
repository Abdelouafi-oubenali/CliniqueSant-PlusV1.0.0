package org.example.entities;

import jakarta.persistence.*;

@Entity
@Table(name = "doctors")
public class Doctor {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String matricule;
    private String title;

    @ManyToOne
    @JoinColumn(name = "specialty_id")
    private Specialty specialty;

    @OneToOne
    @JoinColumn(name = "user_id")
    private User user;

    public Doctor() {}

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getMatricule() { return matricule; }
    public void setMatricule(String matricule) { this.matricule = matricule; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Specialty getSpecialty() { return specialty; }
    public void setSpecialty(Specialty specialty) { this.specialty = specialty; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}
