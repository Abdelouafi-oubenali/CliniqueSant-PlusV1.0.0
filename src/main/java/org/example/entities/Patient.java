package org.example.entities;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.List;

@Entity
@Table(name = "patients")
public class Patient {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String cin;
    private LocalDate birthDate;
    private String gender;
    private String address;
    private String phone;
    private String bloodType;

    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;

    @OneToMany(mappedBy = "patient")
    private List<Appointment> appointments;

    public Patient() {}

    // ===== Getters =====
    public Long getId() {
        return id;
    }

    public String getCin() {
        return cin;
    }

    public LocalDate getBirthDate() {
        return birthDate;
    }

    public String getGender() {
        return gender;
    }

    public String getAddress() {
        return address;
    }

    public String getPhone() {
        return phone;
    }

    public String getBloodType() {
        return bloodType;
    }

    public User getUser() {
        return user;
    }

    public List<Appointment> getAppointments() {
        return appointments;
    }

    // ===== Setters =====
    public void setId(Long id) {
        this.id = id;
    }

    public void setCin(String cin) {
        this.cin = cin;
    }

    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setBloodType(String bloodType) {
        this.bloodType = bloodType;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setAppointments(List<Appointment> appointments) {
        this.appointments = appointments;
    }
}
