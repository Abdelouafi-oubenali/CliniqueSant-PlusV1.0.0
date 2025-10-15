<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.Patient" %>
<%@ page import="org.example.entities.User" %>
<%@ page import="org.example.dao.PatientDTO" %>
<%@ page import="java.util.List" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    List<PatientDTO> patients = (List<PatientDTO>) request.getAttribute("patients");
    List<User> users = (List<User>) request.getAttribute("users");
    Integer patientsCount = (Integer) request.getAttribute("patientsCount");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String contextPath = request.getContextPath();

    // Variables pour l'édition
    Patient patientToEdit = (Patient) request.getAttribute("patientToEdit");
    boolean isEditMode = patientToEdit != null;
    String formTitle = isEditMode ? "Modifier le Patient" : "Nouveau Patient";
    String buttonText = isEditMode ? "Modifier" : "Enregistrer";
    String formAction = isEditMode ? "edit" : "add";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle != null ? pageTitle : "Gestion des Patients" %></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/patient.css">
</head>
<body class="<%= isEditMode ? "edit-mode" : "" %>">
    <div class="container">
        <jsp:include page="../../includes/sidebar.jsp" />

        <div class="main-content">
            <jsp:include page="../../includes/header2.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="page-title">
                        <h1><%= pageTitle != null ? pageTitle : "Gestion des Patients" %></h1>
                        <p>Administrez les patients de la clinique</p>
                    </div>
                    <% if (!isEditMode) { %>
                    <button id="showFormBtn" class="btn btn-primary show-form-btn">
                        <i class="fas fa-plus"></i> Nouveau Patient
                    </button>
                    <% } %>
                </div>

                <%-- Messages d'alerte --%>
                <% if (successMessage != null) { %>
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle"></i> <%= successMessage %>
                    </div>
                <% } %>

                <% if (errorMessage != null) { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i> <%= errorMessage %>
                    </div>
                <% } %>

                <%-- Formulaire d'ajout/modification --%>
                <div id="patientForm" class="form-container" style="display: <%= isEditMode ? "block" : "none" %>;">
                    <div class="form-header">
                        <h3><i class="fas fa-<%= isEditMode ? "edit" : "plus-circle" %>"></i> <%= formTitle %></h3>
                        <button id="closeFormBtn" class="btn btn-close">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>

                    <form id="patientFormData" action="<%= contextPath %>/PatientServlet" method="POST">
                        <input type="hidden" name="action" value="<%= formAction %>">
                        <% if (isEditMode) { %>
                            <input type="hidden" name="id" value="<%= patientToEdit.getId() %>">
                            <input type="hidden" name="userId" value="<%= patientToEdit.getUser().getId() %>">
                        <% } %>

                        <!-- Informations utilisateur (seulement en mode ajout) -->
                        <% if (!isEditMode) { %>
                        <div class="form-section">
                            <h4><i class="fas fa-user"></i> Informations de connexion</h4>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="name">Nom complet *</label>
                                    <input type="text" id="name" name="name" class="form-control" required
                                           placeholder="Ex: Jean Dupont" maxlength="100">
                                </div>
                                <div class="form-group">
                                    <label for="email">Email *</label>
                                    <input type="email" id="email" name="email" class="form-control" required
                                           placeholder="Ex: jean.dupont@email.com" maxlength="100">
                                </div>
                            </div>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="password">Mot de passe *</label>
                                    <input type="password" id="password" name="password" class="form-control" required
                                           placeholder="Mot de passe sécurisé" minlength="6">
                                </div>
                                <div class="form-group">
                                    <label for="confirmPassword">Confirmer le mot de passe *</label>
                                    <input type="password" id="confirmPassword" name="confirmPassword" class="form-control" required
                                           placeholder="Répétez le mot de passe">
                                </div>
                            </div>
                        </div>
                        <% } else { %>
                        <!-- En mode édition : afficher les infos utilisateur en lecture seule -->
                        <div class="form-section">
                            <h4><i class="fas fa-user"></i> Informations de connexion</h4>
                            <div class="form-row">
                                <div class="form-group">
                                    <label>Nom complet</label>
                                    <input type="text" class="form-control" readonly
                                           value="<%= patientToEdit.getUser().getName() %>">
                                </div>
                                <div class="form-group">
                                    <label>Email</label>
                                    <input type="text" class="form-control" readonly
                                           value="<%= patientToEdit.getUser().getEmail() %>">
                                </div>
                            </div>
                        </div>
                        <% } %>

                        <div class="form-section">
                            <h4><i class="fas fa-file-medical"></i> Informations médicales</h4>
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="cin">CIN *</label>
                                    <input type="text" id="cin" name="cin" class="form-control" required
                                           value="<%= isEditMode ? patientToEdit.getCin() : "" %>"
                                           placeholder="Ex: AB123456" maxlength="20">
                                </div>
                                <div class="form-group">
                                    <label for="birthDate">Date de Naissance *</label>
                                    <input type="date" id="birthDate" name="birthDate" class="form-control" required
                                           value="<%= isEditMode && patientToEdit.getBirthDate() != null ? patientToEdit.getBirthDate().toString() : "" %>">
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="gender">Sexe *</label>
                                    <select id="gender" name="gender" class="form-control" required>
                                        <option value="">Sélectionnez le sexe</option>
                                        <option value="M" <%= isEditMode && "M".equals(patientToEdit.getGender()) ? "selected" : "" %>>Masculin</option>
                                        <option value="F" <%= isEditMode && "F".equals(patientToEdit.getGender()) ? "selected" : "" %>>Féminin</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <label for="bloodType">Groupe Sanguin</label>
                                    <select id="bloodType" name="bloodType" class="form-control">
                                        <option value="">Sélectionnez le groupe</option>
                                        <option value="A+" <%= isEditMode && "A+".equals(patientToEdit.getBloodType()) ? "selected" : "" %>>A+</option>
                                        <option value="A-" <%= isEditMode && "A-".equals(patientToEdit.getBloodType()) ? "selected" : "" %>>A-</option>
                                        <option value="B+" <%= isEditMode && "B+".equals(patientToEdit.getBloodType()) ? "selected" : "" %>>B+</option>
                                        <option value="B-" <%= isEditMode && "B-".equals(patientToEdit.getBloodType()) ? "selected" : "" %>>B-</option>
                                        <option value="AB+" <%= isEditMode && "AB+".equals(patientToEdit.getBloodType()) ? "selected" : "" %>>AB+</option>
                                        <option value="AB-" <%= isEditMode && "AB-".equals(patientToEdit.getBloodType()) ? "selected" : "" %>>AB-</option>
                                        <option value="O+" <%= isEditMode && "O+".equals(patientToEdit.getBloodType()) ? "selected" : "" %>>O+</option>
                                        <option value="O-" <%= isEditMode && "O-".equals(patientToEdit.getBloodType()) ? "selected" : "" %>>O-</option>
                                    </select>
                                </div>
                            </div>

                            <div class="form-row">
                                <div class="form-group">
                                    <label for="phone">Téléphone</label>
                                    <input type="tel" id="phone" name="phone" class="form-control"
                                           value="<%= isEditMode ? patientToEdit.getPhone() : "" %>"
                                           placeholder="Ex: 06 12 34 56 78" maxlength="15">
                                </div>
                            </div>

                            <div class="form-group">
                                <label for="address">Adresse</label>
                                <textarea id="address" name="address" class="form-control" rows="3"
                                          placeholder="Adresse complète du patient..." maxlength="255"><%= isEditMode ? patientToEdit.getAddress() : "" %></textarea>
                            </div>
                        </div>

                        <div class="form-actions">
                            <a href="<%= contextPath %>/PatientServlet" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-<%= isEditMode ? "edit" : "save" %>"></i> <%= buttonText %>
                            </button>
                        </div>
                    </form>
                </div>

                <%-- Carte de statistique --%>
                <div class="stats-cards">
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: #007bff;">
                            <i class="fas fa-user-injured"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= patientsCount != null ? patientsCount : 0 %></h3>
                            <p>Patients</p>
                        </div>
                    </div>
                </div>

                <%-- Grille des patients --%>
                <div class="patients-grid" id="patientsGrid">
                    <% if (patients != null) { %>
                        <% for (PatientDTO patient : patients) { %>
                            <div class="patient-card">
                                <div class="patient-header">
                                    <div class="patient-icon">
                                        <i class="fas fa-user-injured"></i>
                                    </div>
                                    <div class="patient-info">
                                        <h3><%= patient.getPatientName() %></h3>
                                        <span class="patient-cin"><%= patient.getCin() %></span>
                                    </div>
                                </div>

                                <div class="patient-details">
                                    <div class="patient-detail">
                                        <strong>Âge:</strong> <%= patient.getAge() %> ans
                                    </div>
                                    <div class="patient-detail">
                                        <strong>Sexe:</strong> <%= patient.getGenderText() %>
                                    </div>
                                    <div class="patient-detail">
                                        <strong>Téléphone:</strong> <%= patient.getPhone() != null ? patient.getPhone() : "<em>Non renseigné</em>" %>
                                    </div>
                                    <div class="patient-detail">
                                        <strong>Email:</strong> <%= patient.getEmail() %>
                                    </div>
                                    <div class="patient-detail">
                                        <strong>Groupe sanguin:</strong> <%= patient.getBloodType() != null ? patient.getBloodType() : "<em>Non renseigné</em>" %>
                                    </div>
                                    <% if (patient.getAddress() != null && !patient.getAddress().isEmpty()) { %>
                                    <div class="patient-detail">
                                        <strong>Adresse:</strong> <%= patient.getAddress() %>
                                    </div>
                                    <% } %>
                                </div>

                                <div class="action-buttons">
                                    <a href="<%= contextPath %>/PatientServlet?action=edit&id=<%= patient.getId() %>"
                                       class="action-btn edit-btn" title="Modifier">
                                        <i class="fas fa-edit"></i>
                                        <span>Modifier</span>
                                    </a>
                                    <a href="<%= contextPath %>/PatientServlet?action=delete&id=<%= patient.getId() %>"
                                       class="action-btn delete-btn"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer le patient \u00AB <%= patient.getPatientName() %> \u00BB ?')"
                                       title="Supprimer">
                                        <i class="fas fa-trash"></i>
                                        <span>Supprimer</span>
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    <% } %>

                    <%-- Message si aucun patient --%>
                    <% if (patients == null || patients.isEmpty()) { %>
                        <div class="no-patients">
                            <div class="empty-state">
                                <i class="fas fa-user-injured fa-4x"></i>
                                <h3>Aucun patient trouvé</h3>
                                <p>Commencez par créer votre premier patient</p>
                                <button id="showFormBtnEmpty" class="btn btn-primary show-form-btn">
                                    <i class="fas fa-plus"></i> Créer un patient
                                </button>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <script>
        function setupPatientPage() {
            const showFormBtn = document.getElementById('showFormBtn');
            const showFormBtnEmpty = document.getElementById('showFormBtnEmpty');
            const patientForm = document.getElementById('patientForm');
            const closeFormBtn = document.getElementById('closeFormBtn');
            const patientFormData = document.getElementById('patientFormData');

            const isEditMode = document.querySelector('input[name="id"]') !== null;

            function showForm() {
                if (patientForm) {
                    patientForm.style.display = 'block';
                    patientForm.scrollIntoView({ behavior: 'smooth' });
                }
                if (!isEditMode) {
                    if (showFormBtn) showFormBtn.style.display = 'none';
                    if (showFormBtnEmpty) showFormBtnEmpty.style.display = 'none';
                }
            }

            function hideForm() {
                if (patientForm && !isEditMode) {
                    patientForm.style.display = 'none';
                }
                if (showFormBtn && !isEditMode) showFormBtn.style.display = 'inline-flex';
                if (showFormBtnEmpty && !isEditMode) showFormBtnEmpty.style.display = 'inline-flex';

                if (isEditMode) {
                    window.location.href = '<%= contextPath %>/PatientServlet';
                    return;
                }

                if (patientFormData) patientFormData.reset();
            }

            // Événements
            if (showFormBtn) showFormBtn.addEventListener('click', showForm);
            if (showFormBtnEmpty) showFormBtnEmpty.addEventListener('click', showForm);
            if (closeFormBtn) closeFormBtn.addEventListener('click', hideForm);

            if (patientFormData) {
                patientFormData.addEventListener('submit', function(e) {
                    e.preventDefault();

                    // Validation des champs communs
                    const cin = document.getElementById('cin');
                    const birthDate = document.getElementById('birthDate');
                    const gender = document.getElementById('gender');

                    if (!cin.value.trim() || !birthDate.value || !gender.value) {
                        alert('Veuillez remplir tous les champs obligatoires des informations médicales');
                        return false;
                    }

                    // Validation des champs utilisateur (seulement en mode ajout)
                    if (!isEditMode) {
                        const name = document.getElementById('name');
                        const email = document.getElementById('email');
                        const password = document.getElementById('password');
                        const confirmPassword = document.getElementById('confirmPassword');

                        if (!name.value.trim() || !email.value.trim() || !password.value || !confirmPassword.value) {
                            alert('Veuillez remplir tous les champs des informations de connexion');
                            return false;
                        }

                        if (password.value.length < 6) {
                            alert('Le mot de passe doit contenir au moins 6 caractères');
                            return false;
                        }

                        if (password.value !== confirmPassword.value) {
                            alert('Les mots de passe ne correspondent pas');
                            return false;
                        }

                        // Validation email basique
                        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (!emailRegex.test(email.value)) {
                            alert('Veuillez entrer une adresse email valide');
                            return false;
                        }
                    }

                    const submitBtn = this.querySelector('button[type="submit"]');
                    const originalText = submitBtn.innerHTML;
                    submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Enregistrement...';
                    submitBtn.disabled = true;

                    setTimeout(() => {
                        this.submit();
                    }, 500);
                });
            }

            // Afficher automatiquement le formulaire en mode édition
            if (isEditMode) {
                showForm();
            }
        }

        // Démarrage
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', setupPatientPage);
        } else {
            setupPatientPage();
        }
    </script>
</body>
</html>