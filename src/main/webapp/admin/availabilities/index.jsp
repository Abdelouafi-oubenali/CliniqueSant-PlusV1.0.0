<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.entities.Availability" %>
<%@ page import="org.example.entities.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%
    String pageTitle = (String) request.getAttribute("pageTitle");
    List<Doctor> doctors = (List<Doctor>) request.getAttribute("doctors");
    Doctor selectedDoctor = (Doctor) request.getAttribute("selectedDoctor");
    List<Availability> availabilities = (List<Availability>) request.getAttribute("availabilities");
    Availability availabilityToEdit = (Availability) request.getAttribute("availabilityToEdit");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    String contextPath = request.getContextPath();

    boolean isEditMode = availabilityToEdit != null;
    DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
    DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= pageTitle != null ? pageTitle : "Disponibilités Médecins" %></title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style2.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/availability.css">
</head>
<body>
    <div class="container">
        <jsp:include page="../../includes/sidebar.jsp" />

        <div class="main-content">
            <jsp:include page="../../includes/header2.jsp" />

            <div class="content">
                <div class="page-header">
                    <div class="page-title">
                        <h1><%= pageTitle != null ? pageTitle : "Disponibilités des Médecins" %></h1>
                        <p>Gédez les emplois du temps des médecins</p>
                    </div>
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

                <%-- Sélection du médecin --%>
                <div class="doctor-selection card">
                    <div class="card-header">
                        <h3><i class="fas fa-user-md"></i> Sélection du Médecin</h3>
                    </div>
                    <div class="card-body">
                        <form method="GET" action="<%= contextPath %>/availabilities" class="doctor-select-form">
                            <div class="form-row">
                                <div class="form-group">
                                    <label for="doctorSelect">Choisir un médecin</label>
                                    <select id="doctorSelect" name="doctorId" class="form-control" onchange="this.form.submit()">
                                        <option value="">Sélectionnez un médecin</option>
                                        <% for (Doctor doctor : doctors) { %>
                                            <option value="<%= doctor.getId() %>"
                                                <%= selectedDoctor != null && selectedDoctor.getId().equals(doctor.getId()) ? "selected" : "" %>>
                                                Dr. <%= doctor.getFullName() %> - <%= doctor.getSpecialization() %>
                                            </option>
                                        <% } %>
                                    </select>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>

                <% if (selectedDoctor != null) { %>
                    <%-- Formulaire d'ajout/modification --%>
                    <div class="form-container card">
                        <div class="card-header">
                            <h3>
                                <i class="fas fa-<%= isEditMode ? "edit" : "plus-circle" %>"></i>
                                <%= isEditMode ? "Modifier la Disponibilité" : "Nouvelle Disponibilité" %>
                            </h3>
                        </div>
                        <div class="card-body">
                            <form method="POST" action="<%= contextPath %>/availabilities">
                                <input type="hidden" name="action" value="<%= isEditMode ? "edit" : "add" %>">
                                <input type="hidden" name="doctorId" value="<%= selectedDoctor.getId() %>">
                                <% if (isEditMode) { %>
                                    <input type="hidden" name="id" value="<%= availabilityToEdit.getId() %>">
                                <% } %>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="day">Jour *</label>
                                        <input type="date" id="day" name="day" class="form-control" required
                                               value="<%= isEditMode ? availabilityToEdit.getDay().toString() : "" %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="startTime">Heure de début *</label>
                                        <input type="time" id="startTime" name="startTime" class="form-control" required
                                               value="<%= isEditMode ? availabilityToEdit.getStartTime().toString() : "" %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="endTime">Heure de fin *</label>
                                        <input type="time" id="endTime" name="endTime" class="form-control" required
                                               value="<%= isEditMode ? availabilityToEdit.getEndTime().toString() : "" %>">
                                    </div>
                                </div>

                                <div class="form-row">
                                    <div class="form-group">
                                        <label for="status">Statut</label>
                                        <select id="status" name="status" class="form-control">
                                            <option value="AVAILABLE" <%= isEditMode && "AVAILABLE".equals(availabilityToEdit.getStatus()) ? "selected" : "" %>>Disponible</option>
                                            <option value="UNAVAILABLE" <%= isEditMode && "UNAVAILABLE".equals(availabilityToEdit.getStatus()) ? "selected" : "" %>>Indisponible</option>
                                            <option value="ON_LEAVE" <%= isEditMode && "ON_LEAVE".equals(availabilityToEdit.getStatus()) ? "selected" : "" %>>En congé</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="validFrom">Valide du</label>
                                        <input type="date" id="validFrom" name="validFrom" class="form-control"
                                               value="<%= isEditMode && availabilityToEdit.getValidFrom() != null ? availabilityToEdit.getValidFrom().toString() : "" %>">
                                    </div>
                                    <div class="form-group">
                                        <label for="validTo">Valide jusqu'au</label>
                                        <input type="date" id="validTo" name="validTo" class="form-control"
                                               value="<%= isEditMode && availabilityToEdit.getValidTo() != null ? availabilityToEdit.getValidTo().toString() : "" %>">
                                    </div>
                                </div>

                                <div class="form-actions">
                                    <% if (isEditMode) { %>
                                        <a href="<%= contextPath %>/availabilities?doctorId=<%= selectedDoctor.getId() %>" class="btn btn-secondary">
                                            <i class="fas fa-times"></i> Annuler
                                        </a>
                                    <% } %>
                                    <button type="submit" class="btn btn-success">
                                        <i class="fas fa-<%= isEditMode ? "edit" : "save" %>"></i>
                                        <%= isEditMode ? "Modifier" : "Enregistrer" %>
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>

                    <%-- Liste des disponibilités --%>
                    <div class="availabilities-list card">
                        <div class="card-header">
                            <h3>
                                <i class="fas fa-calendar-alt"></i>
                                Emploi du temps - Dr. <%= selectedDoctor.getFullName() %>
                            </h3>
                        </div>
                        <div class="card-body">
                            <% if (availabilities != null && !availabilities.isEmpty()) { %>
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th>Jour</th>
                                                <th>Heure début</th>
                                                <th>Heure fin</th>
                                                <th>Statut</th>
                                                <th>Période validité</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <% for (Availability availability : availabilities) { %>
                                                <tr>
                                                    <td><%= availability.getDay().format(dateFormatter) %></td>
                                                    <td><%= availability.getStartTime().format(timeFormatter) %></td>
                                                    <td><%= availability.getEndTime().format(timeFormatter) %></td>
                                                    <td>
                                                        <span class="status-badge status-<%= availability.getStatus().toLowerCase() %>">
                                                            <%= availability.getStatus() %>
                                                        </span>
                                                    </td>
                                                    <td>
                                                        <% if (availability.getValidFrom() != null && availability.getValidTo() != null) { %>
                                                            <%= availability.getValidFrom().format(dateFormatter) %> -
                                                            <%= availability.getValidTo().format(dateFormatter) %>
                                                        <% } else { %>
                                                            Permanent
                                                        <% } %>
                                                    </td>
                                                    <td>
                                                        <a href="<%= contextPath %>/availabilities?action=edit&doctorId=<%= selectedDoctor.getId() %>&id=<%= availability.getId() %>"
                                                           class="btn btn-sm btn-primary">
                                                            <i class="fas fa-edit"></i>
                                                        </a>
                                                        <a href="<%= contextPath %>/availabilities?action=delete&doctorId=<%= selectedDoctor.getId() %>&id=<%= availability.getId() %>"
                                                           class="btn btn-sm btn-danger"
                                                           onclick="return confirm('Êtes-vous sûr de vouloir supprimer cette disponibilité ?')">
                                                            <i class="fas fa-trash"></i>
                                                        </a>
                                                    </td>
                                                </tr>
                                            <% } %>
                                        </tbody>
                                    </table>
                                </div>
                            <% } else { %>
                                <div class="empty-state">
                                    <i class="fas fa-calendar-times fa-3x"></i>
                                    <h4>Aucune disponibilité programmée</h4>
                                    <p>Ajoutez des créneaux de disponibilité pour ce médecin</p>
                                </div>
                            <% } %>
                        </div>
                    </div>
                <% } else if (doctors != null && !doctors.isEmpty()) { %>
                    <div class="empty-state">
                        <i class="fas fa-user-md fa-3x"></i>
                        <h4>Sélectionnez un médecin</h4>
                        <p>Choisissez un médecin dans la liste pour gérer ses disponibilités</p>
                    </div>
                <% } else { %>
                    <div class="empty-state">
                        <i class="fas fa-user-md fa-3x"></i>
                        <h4>Aucun médecin trouvé</h4>
                        <p>Ajoutez d'abord des médecins dans le système</p>
                        <a href="#" class="btn btn-primary">
                            <i class="fas fa-plus"></i> Ajouter un médecin
                        </a>
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        // Validation du formulaire
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form[method="POST"]');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const startTime = document.getElementById('startTime').value;
                    const endTime = document.getElementById('endTime').value;

                    if (startTime && endTime && startTime >= endTime) {
                        e.preventDefault();
                        alert('L\'heure de fin doit être après l\'heure de début');
                        return false;
                    }
                });
            }
        });
    </script>
</body>
</html>