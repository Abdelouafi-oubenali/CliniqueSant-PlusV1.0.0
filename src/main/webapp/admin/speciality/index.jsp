<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.Specialty" %>
<%@ page import="org.example.entities.Department" %>
<%@ page import="org.example.dao.SpecialtyDTO" %>
<%@ page import="java.util.List" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    List<SpecialtyDTO> specialties = (List<SpecialtyDTO>) request.getAttribute("specialties");
    List<Department> departments = (List<Department>) request.getAttribute("departments");
    Integer specialtiesCount = (Integer) request.getAttribute("specialtiesCount");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String contextPath = request.getContextPath();

    // Variables pour l'édition
    Specialty specialtyToEdit = (Specialty) request.getAttribute("specialtyToEdit");
    boolean isEditMode = specialtyToEdit != null;
    String formTitle = isEditMode ? "Modifier la Spécialité" : "Nouvelle Spécialité";
    String buttonText = isEditMode ? "Modifier" : "Enregistrer";
    String formAction = isEditMode ? "edit" : "add";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle != null ? pageTitle : "Gestion des Spécialités" %></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/spesiality.css">
</head>
<body class="<%= isEditMode ? "edit-mode" : "" %>">
    <div class="container">
        <jsp:include page="../../includes/sidebar.jsp" />

        <div class="main-content">
            <jsp:include page="../../includes/header2.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="page-title">
                        <h1><%= pageTitle != null ? pageTitle : "Gestion des Spécialités" %></h1>
                        <p>Administrez les spécialités médicales de la clinique</p>
                    </div>
                    <% if (!isEditMode) { %>
                    <button id="showFormBtn" class="btn btn-primary show-form-btn">
                        <i class="fas fa-plus"></i> Nouvelle Spécialité
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
                <div id="specialtyForm" class="form-container" style="display: <%= isEditMode ? "block" : "none" %>;">
                    <div class="form-header">
                        <h3><i class="fas fa-<%= isEditMode ? "edit" : "plus-circle" %>"></i> <%= formTitle %></h3>
                        <button id="closeFormBtn" class="btn btn-close">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>

                    <%-- CORRECTION : Utiliser SpecialityServlet partout --%>
                    <form id="specialtyFormData" action="<%= contextPath %>/SpecialityServlet" method="POST">
                        <input type="hidden" name="action" value="<%= formAction %>">
                        <% if (isEditMode) { %>
                            <input type="hidden" name="id" value="<%= specialtyToEdit.getId() %>">
                        <% } %>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="code">Code *</label>
                                <input type="text" id="code" name="code" class="form-control" required
                                       value="<%= isEditMode ? specialtyToEdit.getCode() : "" %>"
                                       placeholder="Ex: CARDIO, PEDIA" maxlength="20">
                            </div>
                            <div class="form-group">
                                <label for="name">Nom *</label>
                                <input type="text" id="name" name="name" class="form-control" required
                                       value="<%= isEditMode ? specialtyToEdit.getName() : "" %>"
                                       placeholder="Ex: Cardiologie, Pédiatrie" maxlength="100">
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="departmentId">Département *</label>
                            <select id="departmentId" name="departmentId" class="form-control" required>
                                <option value="">Sélectionnez un département</option>
                                <% for (Department department : departments) { %>
                                    <option value="<%= department.getId() %>"
                                        <%= isEditMode && specialtyToEdit.getDepartment() != null &&
                                            specialtyToEdit.getDepartment().getId().equals(department.getId()) ? "selected" : "" %>>
                                        <%= department.getName() %>
                                    </option>
                                <% } %>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" class="form-control" rows="3"
                                      placeholder="Description de la spécialité..." maxlength="500"><%= isEditMode && specialtyToEdit.getDescription() != null ? specialtyToEdit.getDescription() : "" %></textarea>
                        </div>

                        <div class="form-actions">
                            <%-- CORRECTION : Utiliser SpecialityServlet --%>
                            <a href="<%= contextPath %>/SpecialityServlet" class="btn btn-secondary">
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
                        <div class="stat-icon" style="background-color: #9b59b6;">
                            <i class="fas fa-stethoscope"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= specialtiesCount != null ? specialtiesCount : 0 %></h3>
                            <p>Spécialités</p>
                        </div>
                    </div>
                </div>

                <%-- Grille des spécialités --%>
                <div class="specialties-grid" id="specialtiesGrid">
                    <% if (specialties != null) { %>
                        <% for (SpecialtyDTO specialty : specialties) { %>
                            <div class="specialty-card">
                                <div class="specialty-header">
                                    <div class="specialty-icon">
                                        <i class="fas fa-stethoscope"></i>
                                    </div>
                                    <div class="specialty-info">
                                        <h3><%= specialty.getName() %></h3>
                                        <span class="specialty-code"><%= specialty.getCode() %></span>
                                    </div>
                                </div>

                                <div class="specialty-description">
                                    <%= specialty.getDescription() != null && !specialty.getDescription().isEmpty()
                                        ? specialty.getDescription()
                                        : "<em>Aucune description disponible</em>" %>
                                </div>

                                <div class="specialty-department">
                                    <strong>Département:</strong> <%= specialty.getDepartmentName() != null ? specialty.getDepartmentName() : "Non assigné" %>
                                </div>

                                <div class="action-buttons" style="display: flex; gap: 56px;">
                                    <%-- CORRECTION : Utiliser SpecialityServlet --%>
                                    <a href="<%= contextPath %>/SpecialityServlet?action=edit&id=<%= specialty.getId() %>"
                                       class="action-btn edit-btn" title="Modifier">
                                        <i class="fas fa-edit"></i>
                                        <span>Modifier</span>
                                    </a>
                                    <a href="<%= contextPath %>/SpecialityServlet?action=delete&id=<%= specialty.getId() %>"
                                       class="action-btn delete-btn"
                                       onclick="return confirm('Êtes-vous sûr de vouloir supprimer la spécialité \u00AB <%= specialty.getName() %> \u00BB ?')"
                                       title="Supprimer">
                                        <i class="fas fa-trash"></i>
                                        <span>Supprimer</span>
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    <% } %>

                    <%-- Message si aucune spécialité --%>
                    <% if (specialties == null || specialties.isEmpty()) { %>
                        <div class="no-specialties">
                            <div class="empty-state">
                                <i class="fas fa-stethoscope fa-4x"></i>
                                <h3>Aucune spécialité trouvée</h3>
                                <p>Commencez par créer votre première spécialité</p>
                                <%-- CORRECTION : Utiliser SpecialityServlet --%>
                                <button id="showFormBtnEmpty" class="btn btn-primary show-form-btn">
                                    <i class="fas fa-plus"></i> Créer une spécialité
                                </button>
                            </div>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <script>
        function setupSpecialtyPage() {
            const showFormBtn = document.getElementById('showFormBtn');
            const showFormBtnEmpty = document.getElementById('showFormBtnEmpty');
            const specialtyForm = document.getElementById('specialtyForm');
            const closeFormBtn = document.getElementById('closeFormBtn');
            const specialtyFormData = document.getElementById('specialtyFormData');

            const isEditMode = document.querySelector('input[name="id"]') !== null;

            function showForm() {
                if (specialtyForm) {
                    specialtyForm.style.display = 'block';
                    specialtyForm.scrollIntoView({ behavior: 'smooth' });
                }
                if (!isEditMode) {
                    if (showFormBtn) showFormBtn.style.display = 'none';
                    if (showFormBtnEmpty) showFormBtnEmpty.style.display = 'none';
                }
            }

            function hideForm() {
                if (specialtyForm && !isEditMode) {
                    specialtyForm.style.display = 'none';
                }
                if (showFormBtn && !isEditMode) showFormBtn.style.display = 'inline-flex';
                if (showFormBtnEmpty && !isEditMode) showFormBtnEmpty.style.display = 'inline-flex';

                if (isEditMode) {
                    // CORRECTION : Utiliser SpecialityServlet
                    window.location.href = '<%= contextPath %>/SpecialityServlet';
                    return;
                }

                if (specialtyFormData) specialtyFormData.reset();
            }

            // Événements
            if (showFormBtn) showFormBtn.addEventListener('click', showForm);
            if (showFormBtnEmpty) showFormBtnEmpty.addEventListener('click', showForm);
            if (closeFormBtn) closeFormBtn.addEventListener('click', hideForm);

            if (specialtyFormData) {
                specialtyFormData.addEventListener('submit', function(e) {
                    e.preventDefault();

                    const code = document.getElementById('code');
                    const name = document.getElementById('name');
                    const department = document.getElementById('departmentId');

                    if (!code.value.trim() || !name.value.trim() || !department.value) {
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
            document.addEventListener('DOMContentLoaded', setupSpecialtyPage);
        } else {
            setupSpecialtyPage();
        }
    </script>
</body>
</html>