<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.Department" %>
<%@ page import="java.util.List" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    List<Department> departments = (List<Department>) request.getAttribute("departments");
    Integer departmentsCount = (Integer) request.getAttribute("departmentsCount");
    Integer activeDepartments = (Integer) request.getAttribute("activeDepartments");
    Integer totalDoctors = (Integer) request.getAttribute("totalDoctors");
    Integer availableBeds = (Integer) request.getAttribute("availableBeds");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String currentFilter = (String) request.getAttribute("currentFilter");
    String contextPath = (String) request.getAttribute("contextPath");

    // Valeurs par défaut
    if (contextPath == null) {
        contextPath = request.getContextPath();
    }
    if (pageTitle == null) pageTitle = "Gestion des Départements";
    if (departments == null) departments = java.util.Collections.emptyList();
    if (departmentsCount == null) departmentsCount = 0;
    if (activeDepartments == null) activeDepartments = 0;
    if (totalDoctors == null) totalDoctors = 0;
    if (availableBeds == null) availableBeds = 0;
    if (currentFilter == null) currentFilter = "all";
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle %></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/department.css">
</head>
<body>
    <div class="container">
        <jsp:include page="../../includes/sidebar.jsp" />

        <div class="main-content">
            <jsp:include page="../../includes/header2.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="page-title">
                        <h1><%= pageTitle %></h1>
                        <p>Administrez les départements médicaux de la clinique</p>
                    </div>
                    <button id="showFormBtn" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouveau Département
                    </button>
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

                <%-- Formulaire d'ajout --%>
                <div id="departmentForm" class="form-container" style="display: none;">
                    <div class="form-header">
                        <h3><i class="fas fa-plus-circle"></i> Nouveau Département</h3>
                        <button id="closeFormBtn" class="btn btn-close">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>

                    <form id="addDepartmentForm" action="<%= contextPath %>/DepartmentServlet" method="POST">
                        <input type="hidden" name="action" value="add">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="code">Code Département *</label>
                                <input type="text" id="code" name="code" class="form-control" required
                                       placeholder="Ex: CARDIO, PEDIA" maxlength="10"
                                       pattern="[A-Za-z0-9]{2,10}" title="2 à 10 caractères alphanumériques">
                                <small class="form-text">Code unique (2-10 caractères)</small>
                            </div>
                            <div class="form-group">
                                <label for="name">Nom du Département *</label>
                                <input type="text" id="name" name="name" class="form-control" required
                                       placeholder="Ex: Cardiologie, Pédiatrie" maxlength="100">
                                <small class="form-text">Nom complet du département</small>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" class="form-control" rows="3"
                                      placeholder="Description du département..." maxlength="500"></textarea>
                            <small class="form-text">Optionnel - 500 caractères maximum</small>
                        </div>

                        <div class="form-actions">
                            <button type="button" id="cancelFormBtn" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Annuler
                            </button>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> Enregistrer
                            </button>
                        </div>
                    </form>
                </div>

                <%-- Cartes de statistiques --%>
                <div class="stats-cards">
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: var(--primary);">
                            <i class="fas fa-hospital"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= departmentsCount %></h3>
                            <p>Départements</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: var(--success);">
                            <i class="fas fa-check-circle"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= activeDepartments %></h3>
                            <p>Départements Actifs</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: var(--warning);">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= totalDoctors %></h3>
                            <p>Médecins</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: var(--info);">
                            <i class="fas fa-bed"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= availableBeds %></h3>
                            <p>Lits Disponibles</p>
                        </div>
                    </div>
                </div>

                <%-- Filtres --%>
                <div class="filters-section">
                    <div class="filter-controls">
                        <div class="filter-group">
                            <label>Filtrer par statut:</label>
                            <div class="filter-buttons">
                                <a href="<%= contextPath %>/DepartmentServlet?action=list&filter=all"
                                   class="btn filter-btn <%= "all".equals(currentFilter) ? "active" : "" %>">
                                    Tous (<%= departmentsCount %>)
                                </a>
                                <a href="<%= contextPath %>/DepartmentServlet?action=list&filter=active"
                                   class="btn filter-btn <%= "active".equals(currentFilter) ? "active" : "" %>">
                                    Actifs (<%= activeDepartments %>)
                                </a>
                                <a href="<%= contextPath %>/DepartmentServlet?action=list&filter=inactive"
                                   class="btn filter-btn <%= "inactive".equals(currentFilter) ? "active" : "" %>">
                                    Inactifs (0)
                                </a>
                            </div>
                        </div>

                        <div class="search-group">
                            <div class="search-box">
                            <input type="text" id="searchInput" placeholder="Rechercher un département..." 
                                style="padding: 12px 20px 12px 45px; border: 2px solid #e0e0e0; border-radius: 25px; width: 100%; font-size: 14px;">
                            <i class="fas fa-search" style="position: absolute; left: 18px; top: 50%; transform: translateY(-50%); color: #999;"></i>
                        </div>
                                                </div>
                    </div>
                </div>

                <%-- Grille des départements --%>
                <div class="departments-grid" id="departmentsGrid">
                    <% for (Department department : departments) { %>
                        <div class="department-card" data-name="<%= department.getName().toLowerCase() %>" data-code="<%= department.getCode().toLowerCase() %>">
                            <div class="department-header">
                                <div class="department-icon <%= getDepartmentIconClass(department.getName()) %>">
                                    <i class="<%= getDepartmentIcon(department.getName()) %>"></i>
                                </div>
                                <div class="department-info">
                                    <h3><%= department.getName() %></h3>
                                    <p class="department-code">Code: <%= department.getCode() %></p>
                                </div>
                                <span class="badge badge-success">Actif</span>
                            </div>

                            <div class="department-description">
                                <%= department.getDescription() != null && !department.getDescription().isEmpty()
                                    ? department.getDescription()
                                    : "<em>Aucune description disponible</em>" %>
                            </div>

                            <div class="department-stats">
                                <div class="stat-item">
                                    <div class="stat-number">
                                        <%= department.getSpecialties() != null ? department.getSpecialties().size() : 0 %>
                                    </div>
                                    <div class="stat-label">Spécialités</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">
                                        <%= calculateDoctorsCount(department) %>
                                    </div>
                                    <div class="stat-label">Médecins</div>
                                </div>
                                <div class="stat-item">
                                    <div class="stat-number">
                                        <%= calculateOccupancy(department) %>%
                                    </div>
                                    <div class="stat-label">Occupation</div>
                                </div>
                            </div>

                            <div class="action-buttons">
                                <a href="<%= contextPath %>/DepartmentServlet?action=view&id=<%= department.getId() %>"
                                   class="action-btn view-btn" title="Voir détails">
                                    <i class="fas fa-eye"></i>
                                    <span>Détails</span>
                                </a>
                                <a href="<%= contextPath %>/DepartmentServlet?action=edit&id=<%= department.getId() %>"
                                   class="action-btn edit-btn" title="Modifier">
                                    <i class="fas fa-edit"></i>
                                    <span>Modifier</span>
                                </a>
                                <a href="<%= contextPath %>/DepartmentServlet?action=delete&id=<%= department.getId() %>"
                                   class="action-btn delete-btn"
                                   onclick="return confirmDelete(event, this)"
                                   title="Supprimer">
                                    <i class="fas fa-trash"></i>
                                    <span>Supprimer</span>
                                </a>
                            </div>
                        </div>
                    <% } %>

                    <%-- Message si aucun département --%>
                    <% if (departments.isEmpty()) { %>
                        <div class="no-departments">
                            <div class="empty-state">
                                <i class="fas fa-hospital fa-4x"></i>
                                <h3>Aucun département trouvé</h3>
                                <p><%= "all".equals(currentFilter)
                                    ? "Commencez par créer votre premier département"
                                    : "Aucun département ne correspond aux critères de filtrage" %></p>
                                <% if ("all".equals(currentFilter)) { %>
                                    <button id="showFormBtnEmpty" class="btn btn-primary">
                                        <i class="fas fa-plus"></i> Créer un département
                                    </button>
                                <% } else { %>
                                    <a href="<%= contextPath %>/DepartmentServlet?action=list&filter=all" class="btn btn-secondary">
                                        <i class="fas fa-list"></i> Voir tous les départements
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    <% } %>
                </div>

                <%-- Pagination (optionnelle) --%>
                <% if (departmentsCount > 6) { %>
                    <div class="pagination">
                        <button class="btn btn-outline"><i class="fas fa-chevron-left"></i> Précédent</button>
                        <span class="page-info">Page 1 sur <%= (int) Math.ceil(departmentsCount / 6.0) %></span>
                        <button class="btn btn-outline">Suivant <i class="fas fa-chevron-right"></i></button>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <!-- Script externe uniquement -->
    <script src="<%= contextPath %>/assets/js/department.js"></script>
</body>
</html>

<%!
    // Méthode pour obtenir l'icône du département
    private String getDepartmentIcon(String departmentName) {
        if (departmentName == null) return "fas fa-hospital";
        String name = departmentName.toLowerCase();
        if (name.contains("cardio")) return "fas fa-heartbeat";
        if (name.contains("pédiat") || name.contains("pediat")) return "fas fa-baby";
        if (name.contains("chirurg")) return "fas fa-scalpel";
        if (name.contains("radio")) return "fas fa-x-ray";
        if (name.contains("urgence")) return "fas fa-ambulance";
        if (name.contains("neuro")) return "fas fa-brain";
        if (name.contains("ortho")) return "fas fa-bone";
        if (name.contains("dermat")) return "fas fa-allergies";
        if (name.contains("ophta")) return "fas fa-eye";
        if (name.contains("psych")) return "fas fa-brain";
        if (name.contains("gynéco")) return "fas fa-female";
        if (name.contains("matern")) return "fas fa-baby-carriage";
        return "fas fa-hospital";
    }

    // Méthode pour obtenir la classe CSS de l'icône
    private String getDepartmentIconClass(String departmentName) {
        if (departmentName == null) return "default";
        String name = departmentName.toLowerCase();
        if (name.contains("cardio")) return "cardiology";
        if (name.contains("pédiat") || name.contains("pediat")) return "pediatrics";
        if (name.contains("chirurg")) return "surgery";
        if (name.contains("radio")) return "radiology";
        if (name.contains("urgence")) return "emergency";
        if (name.contains("neuro")) return "neurology";
        if (name.contains("ortho")) return "orthopedics";
        return "default";
    }

    // Méthode pour calculer le nombre de médecins (logique temporaire)
    private int calculateDoctorsCount(Department department) {
        if (department.getSpecialties() == null) return 0;
        return department.getSpecialties().size() * 2 + 3; // Exemple: 2 médecins par spécialité + 3 de base
    }

    // Méthode pour calculer le taux d'occupation (logique temporaire)
    private int calculateOccupancy(Department department) {
        // Logique temporaire - à remplacer par la vraie logique métier
        String name = department.getName().toLowerCase();
        if (name.contains("urgence")) return 92;
        if (name.contains("cardio")) return 85;
        if (name.contains("chirurg")) return 78;
        if (name.contains("pédiat")) return 65;
        return 75; // Valeur par défaut
    }
%>