<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.Doctor" %>
<%@ page import="org.example.entities.User" %>
<%@ page import="org.example.entities.Specialty" %>
<%@ page import="org.example.dao.DoctorDTO" %>
<%@ page import="java.util.List" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    List<DoctorDTO> doctors = (List<DoctorDTO>) request.getAttribute("doctors");
    List<User> users = (List<User>) request.getAttribute("users");
    List<Specialty> specialties = (List<Specialty>) request.getAttribute("specialties");
    Integer doctorsCount = (Integer) request.getAttribute("doctorsCount");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String contextPath = request.getContextPath();

    // Variables pour l'édition
    Doctor doctorToEdit = (Doctor) request.getAttribute("doctorToEdit");
    boolean isEditMode = doctorToEdit != null;
    String formTitle = isEditMode ? "Modifier le Docteur" : "Nouveau Docteur";
    String buttonText = isEditMode ? "Modifier" : "Enregistrer";
    String formAction = isEditMode ? "edit" : "add";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle != null ? pageTitle : "Gestion des Docteurs" %></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/doctor.css">
</head>
<body class="<%= isEditMode ? "edit-mode" : "" %>">
    <div class="container">
        <jsp:include page="../../includes/sidebar.jsp" />

        <div class="main-content">
            <jsp:include page="../../includes/header2.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="page-title">
                        <h1><%= pageTitle != null ? pageTitle : "Gestion des Docteurs" %></h1>
                        <p>Administrez les docteurs de la clinique</p>
                    </div>
                    <% if (!isEditMode) { %>
                    <button id="showFormBtn" class="btn btn-primary show-form-btn">
                        <i class="fas fa-plus"></i> Nouveau Docteur
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
                <div id="doctorForm" class="form-container" style="display: <%= isEditMode ? "block" : "none" %>;">
                    <div class="form-header">
                        <h3><i class="fas fa-<%= isEditMode ? "edit" : "plus-circle" %>"></i> <%= formTitle %></h3>
                        <button id="closeFormBtn" class="btn btn-close">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>

                    <form id="doctorFormData" action="<%= contextPath %>/DoctorServlet" method="POST">
                        <input type="hidden" name="action" value="<%= formAction %>">
                        <% if (isEditMode) { %>
                            <input type="hidden" name="id" value="<%= doctorToEdit.getId() %>">
                        <% } %>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="matricule">Matricule *</label>
                                <input type="text" id="matricule" name="matricule" class="form-control" required
                                       value="<%= isEditMode ? doctorToEdit.getMatricule() : "" %>"
                                       placeholder="Ex: DOC001, DOC002" maxlength="20">
                            </div>
                            <div class="form-group">
                                <label for="title">Titre *</label>
                                <input type="text" id="title" name="title" class="form-control" required
                                       value="<%= isEditMode ? doctorToEdit.getTitle() : "" %>"
                                       placeholder="Ex: Dr, Pr, Médecin" maxlength="50">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="userId">Utilisateur *</label>
                                <select id="userId" name="userId" class="form-control" required>
                                    <option value="">Sélectionnez un utilisateur</option>
                                    <% for (User user : users) { %>
                                        <option value="<%= user.getId() %>"
                                            <%= isEditMode && doctorToEdit.getUser() != null &&
                                                doctorToEdit.getUser().getId().equals(user.getId()) ? "selected" : "" %>>
                                            <%= user.getName() %> (<%= user.getEmail() %>)
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-group">
                                <label for="specialtyId">Spécialité</label>
                                <select id="specialtyId" name="specialtyId" class="form-control">
                                    <option value="">Sélectionnez une spécialité</option>
                                    <% for (Specialty specialty : specialties) { %>
                                        <option value="<%= specialty.getId() %>"
                                            <%= isEditMode && doctorToEdit.getSpecialty() != null &&
                                                doctorToEdit.getSpecialty().getId().equals(specialty.getId()) ? "selected" : "" %>>
                                            <%= specialty.getName() %>
                                        </option>
                                    <% } %>
                                </select>
                            </div>
                        </div>

                        <div class="form-actions">
                            <a href="<%= contextPath %>/DoctorServlet" class="btn btn-secondary">
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
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= doctorsCount != null ? doctorsCount : 0 %></h3>
                            <p>Docteurs</p>
                        </div>
                    </div>
                </div>

                <%-- Grille des docteurs --%>
                <div class="doctors-grid" id="doctorsGrid">
                    <% if (doctors != null) { %>
                        <% for (DoctorDTO doctor : doctors) { %>
                            <div class="doctor-card">
                                <div class="doctor-header">
                                    <div class="doctor-icon">
                                        <i class="fas fa-user-md"></i>
                                    </div>
                                    <div class="doctor-info">
                                        <h3><%= doctor.getDoctorName() %></h3>
                                        <span class="doctor-title"><%= doctor.getTitle() %></span>
                                    </div>
                                </div>

                                <div class="doctor-details">
                                    <div class="doctor-detail">
                                        <strong>Matricule:</strong> <%= doctor.getMatricule() %>
                                    </div>
                                    <div class="doctor-detail">
                                        <strong>Email:</strong> <%= doctor.getEmail() %>
                                    </div>
                                    <div class="doctor-detail">
                                        <strong>Spécialité:</strong>
                                        <%= doctor.getSpecialtyName() != null ? doctor.getSpecialtyName() : "<em>Non assigné</em>" %>
                                    </div>
                                </div>

                                <div class="action-buttons" style="display: flex; gap: 50px;">
                                    <a href="<%= contextPath %>/DoctorServlet?action=edit&id=<%= doctor.getId() %>"
                                       class="action-btn edit-btn" title="Modifier">
                                        <i class="fas fa-edit"></i>
                                        <span>Modifier</span>
                                    </a>
                                    <a href="<%= contextPath %>/DoctorServlet?action=delete&id=<%= doctor.getId() %>"
                                       class="action-btn delete-btn"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer le docteur \u00AB <%= doctor.getDoctorName() %> \u00BB ?')"
                                       title="Supprimer">
                                        <i class="fas fa-trash"></i>
                                        <span>Supprimer</span>
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    <% } %>

                    <%-- Message si aucun docteur --%>
                    <% if (doctors == null || doctors.isEmpty()) { %>
                        <div class="no-doctors">
                            <div class="empty-state">
                                <i class="fas fa-user-md fa-4x"></i>
                                <h3>Aucun docteur trouvé</h3>
                                <p>Commencez par créer votre premier docteur</p>
                                <button id="showFormBtnEmpty" class="btn btn-primary show-form-btn">
                                    <i class="fas fa-plus"></i> Créer un docteur
                                </button>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <script>
        function setupDoctorPage() {
            const showFormBtn = document.getElementById('showFormBtn');
            const showFormBtnEmpty = document.getElementById('showFormBtnEmpty');
            const doctorForm = document.getElementById('doctorForm');
            const closeFormBtn = document.getElementById('closeFormBtn');
            const doctorFormData = document.getElementById('doctorFormData');

            const isEditMode = document.querySelector('input[name="id"]') !== null;

            function showForm() {
                if (doctorForm) {
                    doctorForm.style.display = 'block';
                    doctorForm.scrollIntoView({ behavior: 'smooth' });
                }
                if (!isEditMode) {
                    if (showFormBtn) showFormBtn.style.display = 'none';
                    if (showFormBtnEmpty) showFormBtnEmpty.style.display = 'none';
                }
            }

            function hideForm() {
                if (doctorForm && !isEditMode) {
                    doctorForm.style.display = 'none';
                }
                if (showFormBtn && !isEditMode) showFormBtn.style.display = 'inline-flex';
                if (showFormBtnEmpty && !isEditMode) showFormBtnEmpty.style.display = 'inline-flex';

                if (isEditMode) {
                    window.location.href = '<%= contextPath %>/DoctorServlet';
                    return;
                }

                if (doctorFormData) doctorFormData.reset();
            }

            // Événements
            if (showFormBtn) showFormBtn.addEventListener('click', showForm);
            if (showFormBtnEmpty) showFormBtnEmpty.addEventListener('click', showForm);
            if (closeFormBtn) closeFormBtn.addEventListener('click', hideForm);

            if (doctorFormData) {
                doctorFormData.addEventListener('submit', function(e) {
                    e.preventDefault();

                    const matricule = document.getElementById('matricule');
                    const title = document.getElementById('title');
                    const user = document.getElementById('userId');

                    if (!matricule.value.trim() || !title.value.trim() || !user.value) {
                        alert('Veuillez remplir tous les champs obligatoires');
                        return false;
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
            document.addEventListener('DOMContentLoaded', setupDoctorPage);
        } else {
            setupDoctorPage();
        }
    </script>
</body>
</html>