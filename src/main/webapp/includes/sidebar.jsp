<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String currentUri = request.getRequestURI();
    boolean isDashboardActive = currentUri.contains("dashboard.jsp");
    boolean isDepartmentsActive = currentUri.contains("DepartmentServlet");
    boolean isSpecialitiesActive = currentUri.contains("SpecialityServlet");
    boolean isPatientsActive = currentUri.contains("PatientServlet");
    boolean isDoctorsActive = currentUri.contains("DoctorServlet");
    boolean isAppointmentsActive = currentUri.contains("appointment");
    boolean isAvailabilitiesActive = currentUri.contains("availabilities");
    boolean isUsersActive = currentUri.contains("UserServlet");
%>

<div class="sidebar">
    <div class="sidebar-header">
        <h2>Clinique SantePlus</h2>
        <p>Gestion des Patients</p>
    </div>
    <div class="sidebar-menu">
        <ul>
            <li class="<%= isDashboardActive ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/DashboardServlet">
                    <i class="fas fa-home"></i>
                    <span>Tableau de Bord</span>
                </a>
            </li>
            <li class="<%= isDepartmentsActive ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/DepartmentServlet?action=list">
                    <i class="fas fa-hospital"></i>
                    <span>Départements</span>
                </a>
            </li>
            <li class="<%= isSpecialitiesActive ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/SpecialityServlet?action=list">
                    <i class="fas fa-stethoscope"></i>
                    <span>Spécialités</span>
                </a>
            </li>
            <li class="<%= isPatientsActive ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/PatientServlet">
                    <i class="fas fa-user-injured"></i>
                    <span>Patients</span>
                </a>
            </li>
            <li class="<%= isDoctorsActive ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/DoctorServlet">
                    <i class="fas fa-user-md"></i>
                    <span>Médecins</span>
                </a>
            </li>
            <li class="<%= isAppointmentsActive ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/appointment">
                    <i class="fas fa-calendar-check"></i>
                    <span>Rendez-vous</span>
                </a>
            </li>
            <li class="<%= isAvailabilitiesActive ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/availabilities">
                    <i class="fas fa-pills"></i>
                    <span>Disponibilité du docteur</span>
                </a>
            </li>
            <li class="<%= isUsersActive ? "active" : "" %>">
                <a href="${pageContext.request.contextPath}/UserServlet?action=list">
                    <i class="fas fa-users"></i>
                    <span>Gestion des Utilisateurs</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-file-medical"></i>
                    <span>Dossiers Médicaux</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-cog"></i>
                    <span>Paramètres</span>
                </a>
            </li>
        </ul>
    </div>
</div>

<style>
:root {
    --primary: #2c7fb8;
    --secondary: #7fcdbb;
    --accent: #edf8b1;
    --dark: #253237;
    --light: #f8f9fa;
    --danger: #e74c3c;
    --success: #2ecc71;
    --warning: #f39c12;
    --gray: #6c757d;
    --light-gray: #e9ecef;
}

* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

body {
    background-color: #f5f7fa;
    color: var(--dark);
}

.container {
    display: flex;
    min-height: 100vh;
}

/* Sidebar */
.sidebar {
    width: 250px;
    background: linear-gradient(to bottom, var(--primary), #1a5a8a);
    color: white;
    transition: all 0.3s;
    box-shadow: 3px 0 10px rgba(0, 0, 0, 0.1);
}

.sidebar-header {
    padding: 20px;
    text-align: center;
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.sidebar-header h2 {
    font-size: 1.5rem;
    margin-bottom: 5px;
}

.sidebar-header p {
    font-size: 0.8rem;
    opacity: 0.8;
}

.sidebar-menu {
    padding: 15px 0;
}

.sidebar-menu ul {
    list-style: none;
}

.sidebar-menu li {
    padding: 12px 20px;
    transition: all 0.3s;
}

.sidebar-menu li:hover {
    background-color: rgba(255, 255, 255, 0.1);
    border-left: 4px solid var(--secondary);
}

/* Style pour les liens actifs - AMÉLIORÉ */
.sidebar-menu li.active {
    background: linear-gradient(90deg, rgba(255,255,255,0.15) 0%, rgba(255,255,255,0.05) 100%);
    border-left: 4px solid var(--secondary);
    position: relative;
}

.sidebar-menu li.active::before {
    content: '';
    position: absolute;
    right: 0;
    top: 50%;
    transform: translateY(-50%);
    width: 3px;
    height: 70%;
    background-color: var(--secondary);
    border-radius: 2px 0 0 2px;
}

.sidebar-menu li.active a {
    font-weight: 600;
    color: white;
}

.sidebar-menu li.active i {
    color: var(--secondary);
}

/* Effet de glow sur le lien actif */
.sidebar-menu li.active:hover {
    background: linear-gradient(90deg, rgba(255,255,255,0.2) 0%, rgba(255,255,255,0.1) 100%);
}

/* Animation pour le changement d'état */
.sidebar-menu li {
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.sidebar-menu a {
    color: white;
    text-decoration: none;
    display: flex;
    align-items: center;
}

.sidebar-menu i {
    margin-right: 10px;
    font-size: 1.2rem;
    width: 25px;
    text-align: center;
}

/* Main Content */
.main-content {
    flex: 1;
    display: flex;
    flex-direction: column;
    overflow-x: hidden;
}

/* Top Bar */
.top-bar {
    background-color: white;
    padding: 15px 30px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
}

.breadcrumb {
    display: flex;
    align-items: center;
    font-size: 0.9rem;
    color: var(--gray);
}

.breadcrumb a {
    color: var(--primary);
    text-decoration: none;
}

.breadcrumb i {
    margin: 0 8px;
}

.user-info {
    display: flex;
    align-items: center;
}

.user-info img {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    margin-right: 10px;
    object-fit: cover;
}

/* Content */
.content {
    padding: 30px;
    flex: 1;
}

.page-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 25px;
}

.page-title h1 {
    font-size: 1.8rem;
    color: var(--dark);
    margin-bottom: 5px;
}

.page-title p {
    color: var(--gray);
}

.btn {
    padding: 10px 20px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: all 0.3s;
}

.btn-primary {
    background-color: var(--primary);
    color: white;
}

.btn-primary:hover {
    background-color: #1a5a8a;
}

.btn-success {
    background-color: var(--success);
    color: white;
}

.btn-success:hover {
    background-color: #27ae60;
}

/* Stats Cards */
.stats-cards {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
    gap: 20px;
    margin-bottom: 30px;
}

.stat-card {
    background-color: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
    display: flex;
    align-items: center;
    transition: transform 0.3s;
}

.stat-card:hover {
    transform: translateY(-5px);
}

.stat-icon {
    width: 60px;
    height: 60px;
    border-radius: 10px;
    display: flex;
    align-items: center;
    justify-content: center;
    margin-right: 15px;
    font-size: 1.5rem;
    color: white;
}

.stat-info h3 {
    font-size: 1.8rem;
    margin-bottom: 5px;
}

.stat-info p {
    color: var(--gray);
    font-size: 0.9rem;
}

/* Filters and Search */
.filters-section {
    background-color: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
    margin-bottom: 25px;
}

.filters-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 15px;
}

.filters-title {
    font-size: 1.2rem;
    font-weight: 600;
}

.filter-controls {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
    gap: 15px;
}

.filter-group {
    display: flex;
    flex-direction: column;
}

.filter-group label {
    margin-bottom: 5px;
    font-weight: 500;
    font-size: 0.9rem;
}

.filter-control {
    padding: 10px;
    border: 1px solid var(--light-gray);
    border-radius: 6px;
    font-size: 0.9rem;
}

.search-box {
    position: relative;
}

.search-box input {
    padding-left: 40px;
    width: 100%;
}

.search-box i {
    position: absolute;
    left: 12px;
    top: 50%;
    transform: translateY(-50%);
    color: var(--gray);
}

/* Patients Table */
.table-container {
    background-color: white;
    border-radius: 10px;
    padding: 20px;
    box-shadow: 0 3px 10px rgba(0, 0, 0, 0.08);
    overflow-x: auto;
}

.table-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
}

.table-title {
    font-size: 1.3rem;
    font-weight: 600;
}

table {
    width: 100%;
    border-collapse: collapse;
    min-width: 800px;
}

th, td {
    padding: 15px;
    text-align: left;
    border-bottom: 1px solid #eee;
}

th {
    color: var(--gray);
    font-weight: 600;
    font-size: 0.9rem;
}

tr:hover {
    background-color: rgba(44, 127, 184, 0.03);
}

.patient-info {
    display: flex;
    align-items: center;
}

.patient-avatar {
    width: 40px;
    height: 40px;
    border-radius: 50%;
    background-color: var(--primary);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    margin-right: 12px;
}

.patient-name {
    font-weight: 600;
}

.patient-details {
    font-size: 0.8rem;
    color: var(--gray);
}

.badge {
    padding: 5px 10px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
}

.badge-success {
    background-color: rgba(46, 204, 113, 0.2);
    color: var(--success);
}

.badge-warning {
    background-color: rgba(243, 156, 18, 0.2);
    color: var(--warning);
}

.badge-danger {
    background-color: rgba(231, 76, 60, 0.2);
    color: var(--danger);
}

.badge-info {
    background-color: rgba(52, 152, 219, 0.2);
    color: #3498db;
}

.action-buttons {
    display: flex;
    gap: 8px;
}

.action-btn {
    width: 35px;
    height: 35px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    transition: all 0.3s;
}

.action-btn.view {
    background-color: rgba(52, 152, 219, 0.1);
    color: #3498db;
}

.action-btn.edit {
    background-color: rgba(46, 204, 113, 0.1);
    color: var(--success);
}

.action-btn.delete {
    background-color: rgba(231, 76, 60, 0.1);
    color: var(--danger);
}

.action-btn:hover {
    transform: translateY(-2px);
}

/* Pagination */
.pagination {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 20px;
}

.pagination-info {
    color: var(--gray);
    font-size: 0.9rem;
}

.pagination-controls {
    display: flex;
    gap: 5px;
}

.pagination-btn {
    width: 35px;
    height: 35px;
    border: 1px solid var(--light-gray);
    background-color: white;
    border-radius: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    cursor: pointer;
    transition: all 0.3s;
}

.pagination-btn.active {
    background-color: var(--primary);
    color: white;
    border-color: var(--primary);
}

.pagination-btn:hover:not(.active) {
    background-color: var(--light-gray);
}

/* Footer */
.footer {
    background-color: white;
    padding: 15px 30px;
    text-align: center;
    border-top: 1px solid var(--light-gray);
    color: var(--gray);
    font-size: 0.9rem;
}

/* Responsive */
@media (max-width: 992px) {
    .container {
        flex-direction: column;
    }

    .sidebar {
        width: 100%;
        height: auto;
    }

    .sidebar-menu ul {
        display: flex;
        overflow-x: auto;
    }

    .sidebar-menu li {
        flex-shrink: 0;
    }

    .stats-cards {
        grid-template-columns: repeat(2, 1fr);
    }
}

@media (max-width: 768px) {
    .stats-cards {
        grid-template-columns: 1fr;
    }

    .filter-controls {
        grid-template-columns: 1fr;
    }

    .page-header {
        flex-direction: column;
        align-items: flex-start;
        gap: 15px;
    }

    .pagination {
        flex-direction: column;
        gap: 15px;
    }
}
</style>