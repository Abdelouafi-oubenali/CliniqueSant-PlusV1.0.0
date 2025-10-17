    <%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

    <!-- Header seulement -->
    <header>
        <div class="header-container">
            <div class="logo">
                <div class="logo-icon">
                    <i class="fas fa-heartbeat"></i>
                </div>
                <div class="logo-text">Santé<span>Plus</span></div>
            </div>

            <nav>
                <ul>
                    <li><a href="#">Accueil</a></li>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">Médecins</a></li>
                    <li><a href="${pageContext.request.contextPath}/rondezVousServlit">Rendez-vous</a></li>
                    <li><a href="${pageContext.request.contextPath}/contact">Contact</a></li>
                </ul>
            </nav>

            <div class="header-actions" id="header-actions">
                <!-- État non connecté -->
                <c:if test="${empty sessionScope.user}">
                    <div id="guest-actions">
                        <button class="btn btn-outline" id="login-btn-header">
                            <i class="fas fa-sign-in-alt"></i> Se connecter
                        </button>
                        <button class="btn btn-primary" id="register-btn-header">
                            <i class="fas fa-user-plus"></i> Créer un compte
                        </button>
                    </div>
                </c:if>

                <!-- État connecté -->
            <c:if test="${not empty sessionScope.user}">
                <div id="user-actions">
                    <div class="user-info">
                        <div class="user-avatar" id="user-avatar">
                            <!-- Première lettre du nom -->
                            <c:if test="${not empty sessionScope.user.name}">
                                ${sessionScope.user.name.substring(0, 1)}
                            </c:if>
                        </div>
                        <span id="user-name">${sessionScope.user.name}</span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline logout-btn">
                            <i class="fas fa-sign-out-alt"></i> Déconnexion
                        </a>
                    </div>
                </div>
            </c:if>
            </div>
        </div>
    </header>