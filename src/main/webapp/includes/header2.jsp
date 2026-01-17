<div class="top-bar">
    <div class="breadcrumb">
        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">Tableau de bord</a>
        <i class="fas fa-chevron-right"></i>
        <span>Gestion des Patients</span>
    </div>
    <div class="user-info">
        <div style="margin-right: 15px; text-align: right;">
            <p style="font-weight: 600;">
            ${sessionScope.user.name}
        </p>
        
        <p style="font-size: 0.8rem; color: var(--gray);">
            ${sessionScope.user.role}
        </p>
        </div>
        <img src="https://i.pravatar.cc/150?img=32" alt="Profile">
    </div>
</div>