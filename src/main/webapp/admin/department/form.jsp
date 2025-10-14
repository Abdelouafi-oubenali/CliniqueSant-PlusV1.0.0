<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.Department" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    Department department = (Department) request.getAttribute("department");
    String contextPath = (String) request.getAttribute("contextPath");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");

    boolean isEdit = (department != null && department.getId() != null);

    if (contextPath == null) {
        contextPath = request.getContextPath();
    }
    if (pageTitle == null) {
        pageTitle = isEdit ? "Modifier Département" : "Nouveau Département";
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
                        <p><%= isEdit ? "Modifiez les informations du département" : "Créez un nouveau département médical" %></p>
                    </div>
                    <a href="<%= contextPath %>/DepartmentServlet?action=list" class="btn btn-secondary">
                        <i class="fas fa-arrow-left"></i> Retour à la liste
                    </a>
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

                <div class="form-container">
                    <form id="departmentForm" action="<%= contextPath %>/DepartmentServlet" method="POST">
                        <% if (isEdit) { %>
                            <input type="hidden" name="id" value="<%= department.getId() %>">
                            <input type="hidden" name="action" value="update">
                        <% } else { %>
                            <input type="hidden" name="action" value="add">
                        <% } %>

                        <div class="form-row">
                            <div class="form-group">
                                <label for="code">Code Département *</label>
                                <input type="text" id="code" name="code" class="form-control" required
                                       placeholder="Ex: CARDIO, PEDIA" maxlength="10"
                                       pattern="[A-Za-z0-9]{2,10}" title="2 à 10 caractères alphanumériques"
                                       value="<%= (department != null && department.getCode() != null) ? department.getCode() : "" %>">
                                <small class="form-text">Code unique (2-10 caractères)</small>
                            </div>
                            <div class="form-group">
                                <label for="name">Nom du Département *</label>
                                <input type="text" id="name" name="name" class="form-control" required
                                       placeholder="Ex: Cardiologie, Pédiatrie" maxlength="100"
                                       value="<%= (department != null && department.getName() != null) ? department.getName() : "" %>">
                                <small class="form-text">Nom complet du département</small>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="description">Description</label>
                            <textarea id="description" name="description" class="form-control" rows="3"
                                      placeholder="Description du département..." maxlength="500"><%= (department != null && department.getDescription() != null) ? department.getDescription() : "" %></textarea>
                            <small class="form-text">Optionnel - 500 caractères maximum</small>
                        </div>

                        <div class="form-actions">
                            <a href="<%= contextPath %>/DepartmentServlet?action=list" class="btn btn-secondary">
                                <i class="fas fa-times"></i> Annuler
                            </a>
                            <button type="submit" class="btn btn-success">
                                <i class="fas fa-save"></i> <%= isEdit ? "Modifier" : "Enregistrer" %>
                            </button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <script>
        console.log("=== FORMULAIRE DÉPARTEMENT ===");
        console.log("Mode: <%= isEdit ? "ÉDITION" : "AJOUT" %>");
        <%
        if (department != null) {
            out.println("console.log('Département ID: " + department.getId() + "');");
            out.println("console.log('Code: " + department.getCode() + "');");
            out.println("console.log('Nom: " + department.getName() + "');");
        }
        %>

        document.getElementById('departmentForm').addEventListener('submit', function(e) {
            console.log("📤 Soumission du formulaire...");

            const code = document.getElementById('code');
            const name = document.getElementById('name');

            if (!code.value.trim() || !name.value.trim()) {
                e.preventDefault();
                alert('Veuillez remplir tous les champs obligatoires (*)');
                return false;
            }

            // Validation format code
            const codeRegex = /^[A-Za-z0-9]{2,10}$/;
            if (!codeRegex.test(code.value.trim())) {
                e.preventDefault();
                alert('Le code doit contenir 2 à 10 caractères alphanumériques');
                code.focus();
                return false;
            }

            console.log("✅ Formulaire valide, envoi...");

            // Afficher un indicateur de chargement
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Enregistrement...';
            submitBtn.disabled = true;

            return true;
        });
    </script>
</body>
</html>