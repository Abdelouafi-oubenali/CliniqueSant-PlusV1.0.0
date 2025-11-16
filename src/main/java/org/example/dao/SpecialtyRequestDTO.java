package org.example.dao;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.Size;

public class SpecialtyRequestDTO {

    private Long id;

    @NotBlank(message = "Le nom de la spécialité est obligatoire")
    @Size(min = 2, max = 100, message = "Le nom doit contenir entre 2 et 100 caractères")
    private String name;

    @Size(max = 500, message = "La description ne peut pas dépasser 500 caractères")
    private String description;

    // Constructeurs
    public SpecialtyRequestDTO() {}

    public SpecialtyRequestDTO(String name, String description) {
        this.name = name;
        this.description = description;
    }

    // Getters et Setters
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
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

    // Méthodes de validation
    public boolean isValid() {
        return name != null && !name.trim().isEmpty() && name.length() >= 2 && name.length() <= 100;
    }

    public String getValidationErrors() {
        if (name == null || name.trim().isEmpty()) {
            return "Le nom de la spécialité est obligatoire";
        }
        if (name.length() < 2 || name.length() > 100) {
            return "Le nom doit contenir entre 2 et 100 caractères";
        }
        if (description != null && description.length() > 500) {
            return "La description ne peut pas dépasser 500 caractères";
        }
        return null;
    }
}