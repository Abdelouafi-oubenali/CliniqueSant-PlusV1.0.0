package org.example.dao;

public class DoctorDTO {
    private Long id;
    private String matricule;
    private String title;
    private String doctorName;
    private String email;
    private Long specialtyId;
    private String specialtyName;
    private Long userId;

    // Constructeurs
    public DoctorDTO() {}

    public DoctorDTO(Long id, String matricule, String title, String doctorName, String email) {
        this.id = id;
        this.matricule = matricule;
        this.title = title;
        this.doctorName = doctorName;
        this.email = email;
    }

    // Getters et Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getMatricule() { return matricule; }
    public void setMatricule(String matricule) { this.matricule = matricule; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getDoctorName() { return doctorName; }
    public void setDoctorName(String doctorName) { this.doctorName = doctorName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public Long getSpecialtyId() { return specialtyId; }
    public void setSpecialtyId(Long specialtyId) { this.specialtyId = specialtyId; }

    public String getSpecialtyName() { return specialtyName; }
    public void setSpecialtyName(String specialtyName) { this.specialtyName = specialtyName; }

    public Long getUserId() { return userId; }
    public void setUserId(Long userId) { this.userId = userId; }

    @Override
    public String toString() {
        return "DoctorDTO{" +
                "id=" + id +
                ", matricule='" + matricule + '\'' +
                ", title='" + title + '\'' +
                ", doctorName='" + doctorName + '\'' +
                ", email='" + email + '\'' +
                ", specialtyName='" + specialtyName + '\'' +
                '}';
    }
}