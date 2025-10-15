package org.example.dao;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeFormatter;

public class PatientDTO {
    private Long id;
    private String cin;
    private LocalDate birthDate;
    private String birthDateFormatted;
    private String gender;
    private String address;
    private String phone;
    private String bloodType;
    private String patientName;
    private String email;
    private Long userId;
    private int age;

    // Constructeurs
    public PatientDTO() {}

    public PatientDTO(Long id, String cin, LocalDate birthDate, String gender, String address, String phone, String bloodType, String patientName, String email) {
        this.id = id;
        this.cin = cin;
        this.birthDate = birthDate;
        this.gender = gender;
        this.address = address;
        this.phone = phone;
        this.bloodType = bloodType;
        this.patientName = patientName;
        this.email = email;
        calculateAge();
        formatDate();
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getCin() { return cin; }
    public void setCin(String cin) { this.cin = cin; }

    public LocalDate getBirthDate() { return birthDate; }
    public void setBirthDate(LocalDate birthDate) {
        this.birthDate = birthDate;
        calculateAge();
        formatDate();
    }

    public String getBirthDateFormatted() { return birthDateFormatted; }
    public void setBirthDateFormatted(String birthDateFormatted) { this.birthDateFormatted = birthDateFormatted; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getBloodType() { return bloodType; }
    public void setBloodType(String bloodType) { this.bloodType = bloodType; }

    public String getPatientName() { return patientName; }
    public void setPatientName(String patientName) { this.patientName = patientName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    public int getAge() { return age; }
    public void setAge(int age) { this.age = age; }

    // Méthodes utilitaires
    private void calculateAge() {
        if (birthDate != null) {
            this.age = Period.between(birthDate, LocalDate.now()).getYears();
        }
    }

    private void formatDate() {
        if (birthDate != null) {
            this.birthDateFormatted = birthDate.format(DateTimeFormatter.ofPattern("dd/MM/yyyy"));
        }
    }

    public String getGenderText() {
        if ("M".equals(gender)) return "Masculin";
        if ("F".equals(gender)) return "Féminin";
        return gender;
    }

    @Override
    public String toString() {
        return "PatientDTO{" +
                "id=" + id +
                ", cin='" + cin + '\'' +
                ", patientName='" + patientName + '\'' +
                ", age=" + age +
                ", gender='" + gender + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}