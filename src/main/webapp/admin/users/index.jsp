<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.User" %>
<%@ page import="java.util.List" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    List<User> users = (List<User>) request.getAttribute("users");
    Integer usersCount = (Integer) request.getAttribute("usersCount");
    Integer adminCount = (Integer) request.getAttribute("adminCount");
    Integer doctorCount = (Integer) request.getAttribute("doctorCount");
    Integer patientCount = (Integer) request.getAttribute("patientCount");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String currentFilter = (String) request.getAttribute("currentFilter");
    String contextPath = (String) request.getAttribute("contextPath");

    // Valeurs par défaut
    if (contextPath == null) {
        contextPath = request.getContextPath();
    }
    if (pageTitle == null) pageTitle = "Gestion des Utilisateurs";
    if (users == null) users = java.util.Collections.emptyList();
    if (usersCount == null) usersCount = 0;
    if (adminCount == null) adminCount = 0;
    if (doctorCount == null) doctorCount = 0;
    if (patientCount == null) patientCount = 0;
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
    <style>
        .page-header {
            background: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .page-title h1 {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin-bottom: 5px;
        }

        .page-title p {
            color: #666;
            font-size: 14px;
        }

        .btn-primary {
            background-color: #2c7fb8;
            color: white;
            border: none;
            padding: 12px 24px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: background-color 0.3s;
        }

        .btn-primary:hover {
            background-color: #1f5a8d;
        }

        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }

        .stat-info h3 {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin: 0;
        }

        .stat-info p {
            color: #666;
            font-size: 14px;
            margin: 5px 0 0 0;
        }

        .alert {
            padding: 15px 20px;
            border-radius: 5px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .alert-danger {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        .filters-section {
            background: white;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 30px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .filter-buttons {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 8px 16px;
            border: 2px solid #ddd;
            background: white;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            color: #666;
            transition: all 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .filter-btn.active {
            border-color: #2c7fb8;
            background-color: #2c7fb8;
            color: white;
        }

        .filter-btn:hover {
            border-color: #2c7fb8;
            color: #2c7fb8;
        }

        .users-table {
            background: white;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .users-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .users-table th {
            background-color: #f5f5f5;
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: #333;
            border-bottom: 2px solid #ddd;
        }

        .users-table td {
            padding: 15px;
            border-bottom: 1px solid #ddd;
        }

        .users-table tbody tr:hover {
            background-color: #f9f9f9;
        }

        .user-name {
            display: flex;
            align-items: center;
            gap: 10px;
            font-weight: 600;
            color: #333;
        }

        .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2c7fb8, #7fcdbb);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 14px;
        }

        .badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: 600;
        }

        .badge-admin {
            background-color: #e7d4f5;
            color: #6c3fb4;
        }

        .badge-doctor {
            background-color: #d1ecf1;
            color: #0c5460;
        }

        .badge-patient {
            background-color: #d4edda;
            color: #155724;
        }

        .badge-active {
            background-color: #d4edda;
            color: #155724;
        }

        .badge-inactive {
            background-color: #f8d7da;
            color: #721c24;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .action-btn {
            padding: 6px 12px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-size: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .view-btn {
            background-color: #2c7fb8;
            color: white;
        }

        .view-btn:hover {
            background-color: #1f5a8d;
        }

        .edit-btn {
            background-color: #ffc107;
            color: white;
        }

        .edit-btn:hover {
            background-color: #e0a800;
        }

        .delete-btn {
            background-color: #e74c3c;
            color: white;
        }

        .delete-btn:hover {
            background-color: #c0392b;
        }

        .form-container {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            margin-bottom: 30px;
        }

        .form-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
            padding-bottom: 15px;
        }

        .form-header h3 {
            font-size: 20px;
            font-weight: 700;
            color: #333;
            margin: 0;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
        }

        .form-control:focus {
            outline: none;
            border-color: #2c7fb8;
            box-shadow: 0 0 0 3px rgba(44, 127, 184, 0.1);
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .form-actions {
            display: flex;
            gap: 10px;
            justify-content: flex-end;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 2px solid #f0f0f0;
        }

        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-success {
            background-color: #28a745;
            color: white;
        }

        .btn-success:hover {
            background-color: #218838;
        }

        .no-users {
            text-align: center;
            padding: 60px 20px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .no-users i {
            font-size: 64px;
            color: #ddd;
            margin-bottom: 20px;
        }

        .no-users h3 {
            font-size: 24px;
            color: #333;
            margin: 20px 0;
        }

        .no-users p {
            color: #666;
            margin: 10px 0;
        }

        @media (max-width: 768px) {
            .form-row {
                grid-template-columns: 1fr;
            }

            .page-header {
                flex-direction: column;
                align-items: flex-start;
                gap: 15px;
            }

            .users-table {
                overflow-x: auto;
            }
        }
    </style>
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
                        <p>Administrez les utilisateurs du système</p>
                    </div>
                    <button id="showFormBtn" class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouvel Utilisateur
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
                <div id="userForm" class="form-container" style="display: none;">
                    <div class="form-header">
                        <h3><i class="fas fa-user-plus"></i> Nouvel Utilisateur</h3>
                        <button id="closeFormBtn" class="btn" style="background: none; border: none; color: #666; font-size: 24px; padding: 0;">
                            <i class="fas fa-times"></i>
                        </button>
                    </div>

                    <form id="addUserForm" action="<%= contextPath %>/UserServlet" method="POST">
                        <input type="hidden" name="action" value="add">

                        <div class="form-row">
                            <div class="form-group">
                                <label for="name">Nom Complet *</label>
                                <input type="text" id="name" name="name" class="form-control" required
                                       placeholder="Ex: Jean Dupont" maxlength="100">
                            </div>
                            <div class="form-group">
                                <label for="email">Email *</label>
                                <input type="email" id="email" name="email" class="form-control" required
                                       placeholder="Ex: jean.dupont@example.com" maxlength="100">
                            </div>
                        </div>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="password">Mot de passe *</label>
                                <input type="password" id="password" name="password" class="form-control" required
                                       placeholder="Entrez un mot de passe" minlength="6">
                                <small style="color: #666;">Minimum 6 caractères</small>
                            </div>
                            <div class="form-group">
                                <label for="role">Rôle *</label>
                                <select id="role" name="role" class="form-control" required>
                                    <option value="">Sélectionnez un rôle</option>
                                    <option value="ADMIN">Admin</option>
                                    <option value="DOCTOR">Médecin</option>
                                    <option value="PATIENT">Patient</option>
                                </select>
                            </div>
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
                        <div class="stat-icon" style="background-color: #2c7fb8;">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= usersCount %></h3>
                            <p>Utilisateurs Total</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: #6c3fb4;">
                            <i class="fas fa-crown"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= adminCount %></h3>
                            <p>Administrateurs</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: #0c5460;">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= doctorCount %></h3>
                            <p>Médecins</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: #155724;">
                            <i class="fas fa-user-injured"></i>
                        </div>
                        <div class="stat-info">
                            <h3><%= patientCount %></h3>
                            <p>Patients</p>
                        </div>
                    </div>
                </div>

                <%-- Filtres --%>
                <div class="filters-section">
                    <div class="filter-controls">
                        <label style="font-weight: 600; margin-right: 15px;">Filtrer par rôle:</label>
                        <div class="filter-buttons">
                            <a href="<%= contextPath %>/UserServlet?action=list&filter=all"
                               class="filter-btn <%= "all".equals(currentFilter) ? "active" : "" %>">
                                Tous (<%= usersCount %>)
                            </a>
                            <a href="<%= contextPath %>/UserServlet?action=list&filter=admin"
                               class="filter-btn <%= "admin".equals(currentFilter) ? "active" : "" %>">
                                Admins (<%= adminCount %>)
                            </a>
                            <a href="<%= contextPath %>/UserServlet?action=list&filter=doctor"
                               class="filter-btn <%= "doctor".equals(currentFilter) ? "active" : "" %>">
                                Médecins (<%= doctorCount %>)
                            </a>
                            <a href="<%= contextPath %>/UserServlet?action=list&filter=patient"
                               class="filter-btn <%= "patient".equals(currentFilter) ? "active" : "" %>">
                                Patients (<%= patientCount %>)
                            </a>
                        </div>
                    </div>
                </div>

                <%-- Tableau des utilisateurs --%>
                <div class="users-table">
                    <% if (!users.isEmpty()) { %>
                        <table>
                            <thead>
                                <tr>
                                    <th>Utilisateur</th>
                                    <th>Email</th>
                                    <th>Rôle</th>
                                    <th>Statut</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% for (User user : users) { %>
                                    <tr>
                                        <td>
                                            <div class="user-name">
                                                <div class="user-avatar">
                                                    <%= user.getName() != null && user.getName().length() > 0 ? 
                                                        user.getName().substring(0, 1).toUpperCase() : "U" %>
                                                </div>
                                                <%= user.getName() != null ? user.getName() : "N/A" %>
                                            </div>
                                        </td>
                                        <td><%= user.getEmail() != null ? user.getEmail() : "N/A" %></td>
                                        <td>
                                            <span class="badge <%= 
                                                "ADMIN".equals(user.getRole()) ? "badge-admin" :
                                                "DOCTOR".equals(user.getRole()) ? "badge-doctor" :
                                                "badge-patient" %>">
                                                <%= user.getRole() %>
                                            </span>
                                        </td>
                                        <td>
                                            <span class="badge <%= user.isActive() ? "badge-active" : "badge-inactive" %>">
                                                <%= user.isActive() ? "Actif" : "Inactif" %>
                                            </span>
                                        </td>
                                        <td>
                                            <div class="action-buttons">
                                                <a href="<%= contextPath %>/UserServlet?action=view&id=<%= user.getId() %>"
                                                   class="action-btn view-btn" title="Voir détails">
                                                    <i class="fas fa-eye"></i>
                                                </a>
                                                <a href="<%= contextPath %>/UserServlet?action=edit&id=<%= user.getId() %>"
                                                   class="action-btn edit-btn" title="Modifier">
                                                    <i class="fas fa-edit"></i>
                                                </a>
                                                <a href="<%= contextPath %>/UserServlet?action=delete&id=<%= user.getId() %>"
                                                   class="action-btn delete-btn"
                                                   onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur ?')"
                                                   title="Supprimer">
                                                    <i class="fas fa-trash"></i>
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                <% } %>
                            </tbody>
                        </table>
                    <% } else { %>
                        <div class="no-users">
                            <i class="fas fa-users"></i>
                            <h3>Aucun utilisateur trouvé</h3>
                            <p><%= "all".equals(currentFilter)
                                ? "Commencez par créer votre premier utilisateur"
                                : "Aucun utilisateur ne correspond aux critères de filtrage" %></p>
                            <% if ("all".equals(currentFilter)) { %>
                                <button id="showFormBtnEmpty" class="btn btn-primary" style="margin-top: 20px;">
                                    <i class="fas fa-plus"></i> Créer un utilisateur
                                </button>
                            <% } else { %>
                                <a href="<%= contextPath %>/UserServlet?action=list&filter=all" class="btn btn-primary" style="margin-top: 20px;">
                                    <i class="fas fa-list"></i> Voir tous les utilisateurs
                                </a>
                            <% } %>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>

    <script>
        document.getElementById('showFormBtn').addEventListener('click', function() {
            document.getElementById('userForm').style.display = 'block';
            document.getElementById('showFormBtn').style.display = 'none';
        });

        document.getElementById('closeFormBtn').addEventListener('click', function() {
            document.getElementById('userForm').style.display = 'none';
            document.getElementById('showFormBtn').style.display = 'inline-flex';
        });

        document.getElementById('cancelFormBtn').addEventListener('click', function() {
            document.getElementById('userForm').style.display = 'none';
            document.getElementById('showFormBtn').style.display = 'inline-flex';
        });

        if (document.getElementById('showFormBtnEmpty')) {
            document.getElementById('showFormBtnEmpty').addEventListener('click', function() {
                document.getElementById('userForm').style.display = 'block';
                document.getElementById('showFormBtn').style.display = 'none';
            });
        }
    </script>
</body>
</html>
