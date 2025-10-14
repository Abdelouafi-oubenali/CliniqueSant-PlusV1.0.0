<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.Department" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    Department department = (Department) request.getAttribute("department");
    String contextPath = (String) request.getAttribute("contextPath");

    if (contextPath == null) {
        contextPath = request.getContextPath();
    }
    if (pageTitle == null) {
        pageTitle = "Détails Département";
    }
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
                        <p>Informations détaillées du département</p>
                    </div>
                    <a href="<%= contextPath %>/DepartmentServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à la liste
                    </a>
                </div>

                <% if (department != null) { %>
                    <div class="department-details">
                        <div class="detail-card">
                            <div class="detail-header">
                                <div class="department-icon <%= getDepartmentIconClass(department.getName()) %>">
                                    <i class="<%= getDepartmentIcon(department.getName()) %>"></i>
                                </div>
                                <div class="detail-info">
                                    <h2><%= department.getName() %></h2>
                                    <p class="detail-code">Code: <strong><%= department.getCode() %></strong></p>
                                    <span class="badge badge-success">Actif</span>
                                </div>
                            </div>

                            <div class="detail-content">
                                <div class="detail-section">
                                    <h3>Description</h3>
                                    <p><%= (department.getDescription() != null && !department.getDescription().isEmpty())
                                        ? department.getDescription()
                                        : "Aucune description disponible" %></p>
                                </div>

                                <div class="detail-section">
                                    <h3>Informations générales</h3>
                                    <div class="info-grid">
                                        <div class="info-item">
                                            <label>ID du département:</label>
                                            <span><%= department.getId() %></span>
                                        </div>
                                        <div class="info-item">
                                            <label>Code:</label>
                                            <span><%= department.getCode() %></span>
                                        </div>
                                        <div class="info-item">
                                            <label>Nom:</label>
                                            <span><%= department.getName() %></span>
                                        </div>
                                        <div class="info-item">
                                            <label>Statut:</label>
                                            <span class="badge badge-success">Actif</span>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="detail-actions">
                                <a href="<%= contextPath %>/DepartmentServlet?action=edit&id=<%= department.getId() %>"
                                   class="btn btn-warning">
                                    <i class="fas fa-edit"></i> Modifier
                                </a>
                                <a href="<%= contextPath %>/DepartmentServlet?action=list"
                                   class="btn btn-secondary">
                                    <i class="fas fa-list"></i> Retour à la liste
                                </a>
                            </div>
                        </div>
                    </div>
                <% } else { %>
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-circle"></i> Département non trouvé
                    </div>
                <% } %>
            </div>
        </div>
    </div>
</body>
</html>

<%!
    // Méthodes helper pour les icônes
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
%>