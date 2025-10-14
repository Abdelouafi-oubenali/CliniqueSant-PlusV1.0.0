<div class="sidebar">
    <div class="sidebar-header">
        <h2>Clinique SantéPlus</h2>
        <p>Gestion des Patients</p>
    </div>
    <div class="sidebar-menu">
        <ul>
            <li>
                <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
                    <i class="fas fa-home"></i>
                    <span>Tableau de Bord</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/DepartmentServlet?action=list">
                    <i class="fas fa-hospital"></i>
                    <span>Départements</span>
                </a>
            </li>
          <li>
                <a href="${pageContext.request.contextPath}/SpecialityServlet?action=list">
                <i class="fas fa-hospital"></i>
                <span>spesiality</span>
            </a>
        </li>
            <li class="active">
                <a href="#">
                    <i class="fas fa-user-injured"></i>
                    <span>Patients</span>
                </a>
            </li>
            <li>
                <a href="${pageContext.request.contextPath}/SpecialityServlet?action=list">
                    <i class="fas fa-user-md"></i>
                    <span>Médecins</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-calendar-check"></i>
                    <span>Rendez-vous</span>
                </a>
            </li>
            <li>
                <a href="#">
                    <i class="fas fa-pills"></i>
                    <span>Médicaments</span>
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