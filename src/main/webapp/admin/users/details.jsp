<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.User" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    User user = (User) request.getAttribute("user");
    String contextPath = (String) request.getAttribute("contextPath");

    if (contextPath == null) {
        contextPath = request.getContextPath();
    }
    if (pageTitle == null) pageTitle = "Détails Utilisateur";
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
            margin: 0;
        }

        .page-title p {
            color: #666;
            font-size: 14px;
            margin: 5px 0 0 0;
        }

        .details-container {
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            max-width: 600px;
            margin: 0 auto;
        }

        .user-header {
            display: flex;
            align-items: center;
            gap: 20px;
            margin-bottom: 30px;
            padding-bottom: 20px;
            border-bottom: 2px solid #f0f0f0;
        }

        .user-avatar {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            background: linear-gradient(135deg, #2c7fb8, #7fcdbb);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 700;
            font-size: 32px;
        }

        .user-header-info h2 {
            font-size: 24px;
            font-weight: 700;
            color: #333;
            margin: 0 0 10px 0;
        }

        .user-header-info p {
            color: #666;
            margin: 5px 0;
            font-size: 14px;
        }

        .detail-section {
            margin-bottom: 30px;
        }

        .detail-section h3 {
            font-size: 16px;
            font-weight: 700;
            color: #333;
            margin: 0 0 15px 0;
            padding-bottom: 10px;
            border-bottom: 2px solid #f0f0f0;
        }

        .detail-row {
            display: flex;
            gap: 20px;
            margin-bottom: 15px;
        }

        .detail-col {
            flex: 1;
        }

        .detail-label {
            font-size: 12px;
            font-weight: 600;
            color: #999;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 5px;
        }

        .detail-value {
            font-size: 15px;
            color: #333;
            word-break: break-all;
        }

        .badge {
            display: inline-block;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
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
            gap: 10px;
            margin-top: 30px;
            padding-top: 25px;
            border-top: 2px solid #f0f0f0;
        }

        .btn {
            flex: 1;
            padding: 12px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            font-weight: 600;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            transition: all 0.3s;
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

        @media (max-width: 768px) {
            .details-container {
                padding: 20px;
            }

            .user-header {
                flex-direction: column;
                text-align: center;
            }

            .detail-row {
                flex-direction: column;
                gap: 0;
            }

            .action-buttons {
                flex-direction: column;
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
                        <p>Informations détaillées de l'utilisateur</p>
                    </div>
                </div>

                <% if (user != null) { %>
                    <div class="details-container">
                        <div class="user-header">
                            <div class="user-avatar">
                                <%= user.getName() != null && user.getName().length() > 0 ? 
                                    user.getName().substring(0, 1).toUpperCase() : "U" %>
                            </div>
                            <div class="user-header-info">
                                <h2><%= user.getName() != null ? user.getName() : "N/A" %></h2>
                                <p><i class="fas fa-envelope"></i> <%= user.getEmail() != null ? user.getEmail() : "N/A" %></p>
                                <p style="margin-top: 10px;">
                                    <span class="badge <%= 
                                        "ADMIN".equals(user.getRole()) ? "badge-admin" :
                                        "DOCTOR".equals(user.getRole()) ? "badge-doctor" :
                                        "badge-patient" %>">
                                        <%= user.getRole() != null ? user.getRole() : "N/A" %>
                                    </span>
                                </p>
                            </div>
                        </div>

                        <div class="detail-section">
                            <h3>Informations Générales</h3>
                            <div class="detail-row">
                                <div class="detail-col">
                                    <div class="detail-label">ID Utilisateur</div>
                                    <div class="detail-value"><%= user.getId() %></div>
                                </div>
                                <div class="detail-col">
                                    <div class="detail-label">Statut</div>
                                    <div class="detail-value">
                                        <span class="badge <%= user.isActive() ? "badge-active" : "badge-inactive" %>">
                                            <%= user.isActive() ? "Actif" : "Inactif" %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="detail-section">
                            <h3>Contact</h3>
                            <div class="detail-row">
                                <div class="detail-col">
                                    <div class="detail-label">Email</div>
                                    <div class="detail-value">
                                        <a href="mailto:<%= user.getEmail() %>"><%= user.getEmail() != null ? user.getEmail() : "N/A" %></a>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="detail-section">
                            <h3>Rôle</h3>
                            <div class="detail-row">
                                <div class="detail-col">
                                    <div class="detail-label">Rôle Système</div>
                                    <div class="detail-value">
                                        <% if ("ADMIN".equals(user.getRole())) { %>
                                            <i class="fas fa-crown"></i> Administrateur
                                        <% } else if ("DOCTOR".equals(user.getRole())) { %>
                                            <i class="fas fa-user-md"></i> Médecin
                                        <% } else if ("PATIENT".equals(user.getRole())) { %>
                                            <i class="fas fa-user-injured"></i> Patient
                                        <% } %>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="action-buttons">
                            <a href="<%= contextPath %>/UserServlet?action=list" class="btn btn-secondary">
                                <i class="fas fa-arrow-left"></i> Retour à la liste
                            </a>
                            <a href="<%= contextPath %>/UserServlet?action=edit&id=<%= user.getId() %>" class="btn btn-primary">
                                <i class="fas fa-edit"></i> Modifier
                            </a>
                            <a href="<%= contextPath %>/UserServlet?action=delete&id=<%= user.getId() %>" 
                               class="btn btn-danger"
                               onclick="return confirm('Êtes-vous sûr de vouloir supprimer cet utilisateur ?')">
                                <i class="fas fa-trash"></i> Supprimer
                            </a>
                        </div>
                    </div>
                <% } else { %>
                    <div class="details-container" style="text-align: center; padding: 60px 20px;">
                        <i class="fas fa-exclamation-circle" style="font-size: 64px; color: #ddd; margin-bottom: 20px;"></i>
                        <h3>Utilisateur non trouvé</h3>
                        <p>Désolé, cet utilisateur n'existe pas ou a été supprimé.</p>
                        <a href="<%= contextPath %>/UserServlet?action=list" class="btn btn-primary" style="margin-top: 20px; width: auto;">
                            <i class="fas fa-list"></i> Retour à la liste
                        </a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>
