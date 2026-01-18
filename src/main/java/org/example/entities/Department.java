package org.example.entities;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "departments")
public class Department {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false, unique = true)
    private String code;

    @Column(nullable = false)
    private String name;

    private String description;

    @OneToMany(mappedBy = "department", cascade = CascadeType.ALL)
    private List<Specialty> specialties;
    
    // Champs temporaires pour affichage (non persistés)
    @Transient
    private Integer doctorsCount;
    
    @Transient
    private Integer occupancyRate;

    public Department() {}

    // ===== Getters & Setters =====
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public List<Specialty> getSpecialties() {
        return specialties;
    }

    public void setSpecialties(List<Specialty> specialties) {
        this.specialties = specialties;
    }
    
    public Integer getDoctorsCount() {
        return doctorsCount;
    }
    
    public void setDoctorsCount(Integer doctorsCount) {
        this.doctorsCount = doctorsCount;
    }
    
    public Integer getOccupancyRate() {
        return occupancyRate;
    }
    
    public void setOccupancyRate(Integer occupancyRate) {
        this.occupancyRate = occupancyRate;
    }
}
