<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.User" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    User user = (User) request.getAttribute("user");
    String contextPath = (String) request.getAttribute("contextPath");

    if (contextPath == null) {
        contextPath = request.getContextPath();
    }
    if (pageTitle == null) pageTitle = "Utilisateur";
    boolean isEditMode = user != null && user.getId() != null;
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
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }

        .page-header h1 {
            font-size: 28px;
            font-weight: 700;
            color: #333;
            margin: 0;
        }

        .page-header p {
            color: #666;
            font-size: 14px;
            margin: 5px 0 0 0;
        }

        .form-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: #333;
            margin-bottom: 8px;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 14px;
            font-family: inherit;
            box-sizing: border-box;
        }

        .form-control:focus {
            outline: none;
            border-color: #2c7fb8;
            box-shadow: 0 0 0 3px rgba(44, 127, 184, 0.1);
        }

        .form-control:disabled {
            background-color: #f5f5f5;
            color: #666;
        }

        .form-check {
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .form-check input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .form-check label {
            margin: 0;
            cursor: pointer;
        }

        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            padding-top: 25px;
            border-top: 2px solid #f0f0f0;
        }

        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s;
            flex: 1;
            justify-content: center;
        }

        .btn-primary {
            background-color: #2c7fb8;
            color: white;
        }

        .btn-primary:hover {
            background-color: #1f5a8d;
        }

        .btn-secondary {
            background-color: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background-color: #5a6268;
        }

        .btn-danger {
            background-color: #e74c3c;
            color: white;
        }

        .btn-danger:hover {
            background-color: #c0392b;
        }

        .info-box {
            background-color: #e7f3ff;
            border: 1px solid #b3d9ff;
            color: #004085;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 25px;
            display: flex;
            gap: 10px;
        }

        .info-box i {
            flex-shrink: 0;
            font-size: 18px;
            margin-top: 2px;
        }

        .small-text {
            font-size: 12px;
            color: #666;
            margin-top: 5px;
        }

        @media (max-width: 768px) {
            .form-container {
                padding: 20px;
            }

            .btn {
                padding: 10px 16px;
                font-size: 14px;
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
                    <h1><%= pageTitle %></h1>
                    <p><%= isEditMode ? "Modifiez les informations de l'utilisateur" : "Ajoutez un nouvel utilisateur" %></p>
                </div>

                <div class="form-container">
                    <% if (isEditMode) { %>
                        <div class="info-box">
                            <i class="fas fa-info-circle"></i>
                            <div>
                                <strong>Utilisateur ID:</strong> <%= user.getId() %>
                            </div>
                        </div>
                    <% } %>

                    <form action="<%= contextPath %>/UserServlet" method="POST">
                        <input type="hidden" name="action" value="<%= isEditMode ? "update" : "add" %>">
                        <% if (isEditMode) { %>
                            <input type="hidden" name="id" value="<%= user.getId() %>">
                        <% } %>

                        <div class="form-group">
                            <label for="name">Nom Complet *</label>
                            <input type="text" id="name" name="name" class="form-control" required
                                   placeholder="Ex: Jean Dupont"
                                   value="<%= isEditMode && user.getName() != null ? user.getName() : "" %>"
                                   maxlength="100">
                        </div>

                        <div class="form-group">
                            <label for="email">Email *</label>
                            <input type="email" id="email" name="email" class="form-control" required
                                   placeholder="Ex: jean.dupont@example.com"
                                   value="<%= isEditMode && user.getEmail() != null ? user.getEmail() : "" %>"
                                   maxlength="100">
                        </div>

                        <% if (!isEditMode) { %>
                            <div class="form-group">
                                <label for="password">Mot de passe *</label>
                                <input type="password" id="password" name="password" class="form-control" required
                                       placeholder="Entrez un mot de passe" minlength="6">
                                <small class="small-text">Minimum 6 caractères</small>
                            </div>
                        <% } %>

                        <div class="form-group">
                            <label for="role">Rôle *</label>
                            <select id="role" name="role" class="form-control" required>
                                <option value="">Sélectionnez un rôle</option>
                                <option value="ADMIN" <%= isEditMode && "ADMIN".equals(user.getRole()) ? "selected" : "" %>>Administrateur</option>
                                <option value="DOCTOR" <%= isEditMode && "DOCTOR".equals(user.getRole()) ? "selected" : "" %>>Médecin</option>
                                <option value="PATIENT" <%= isEditMode && "PATIENT".equals(user.getRole()) ? "selected" : "" %>>Patient</option>
                            </select>
                        </div>

                        <% if (isEditMode) { %>
                            <div class="form-group form-check">
                                <input type="checkbox" id="active" name="active" 
                                       <%= user.isActive() ? "checked" : "" %>>
                                <label for="active">Utilisateur Actif</label>
                            </div>
                        <% } %>

                        <div class="form-actions">
                            <a href="<%= contextPath %>/UserServlet?action=list" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Retour
                            </a>
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-save"></i> <%= isEditMode ? "Mettre à jour" : "Créer" %>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
