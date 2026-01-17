<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clinique SantePlus - Votre santé, notre priorité</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>

<jsp:include page="/includes/header.jsp" />

    <!-- Hero Banner -->
    <section class="hero">
        <div class="hero-content">
            <h1>Votre santé, notre priorité</h1>
            <p>Une équipe médicale dévouée et des soins d'excellence pour vous accompagner à chaque étape de votre vie</p>
            <div class="hero-buttons">
                <button class="btn btn-primary" id="appointment-btn-hero">
                    <i class="fas fa-calendar-check"></i> Prendre rendez-vous
                </button>
                <button class="btn btn-outline">
                    <i class="fas fa-info-circle"></i> En savoir plus
                </button>
            </div>
        </div>
    </section>

    <!-- Appointment Section -->
    <section class="appointment" id="appointment">
        <div class="section-container">
            <div class="section-title">
                <h2>Prendre un rendez-vous</h2>
                <p>Réservez votre consultation en ligne simplement et rapidement</p>
            </div>

            <div class="appointment-container">
                <div class="appointment-image">
                    <img src="https://images.unsplash.com/photo-1586773860418-d37222d8fce3?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80" alt="Prise de rendez-vous en ligne">
                </div>

                <div class="appointment-content">
                    <h3>Réservez votre consultation en quelques clics</h3>
                    <p>Notre plateforme vous permet de prendre rendez-vous avec le spécialiste de votre choix, aux horaires qui vous conviennent.</p>

                    <!-- État non connecté -->
                    <c:if test="${empty sessionScope.user}">
                        <div class="auth-required" id="auth-required">
                            <h4><i class="fas fa-lock"></i> Authentification requise</h4>
                            <p>Pour prendre un rendez-vous, vous devez avoir un compte patient. Connectez-vous ou créez un compte gratuitement.</p>
                        </div>
                    </c:if>

                    <!-- État connecté -->
                    <c:if test="${not empty sessionScope.user}">
                        <div class="appointment-ready" id="appointment-ready">
                            <h4><i class="fas fa-check-circle"></i> Prêt à réserver</h4>
                            <p>Vous êtes connecté en tant que <strong id="user-email">${sessionScope.user.email}</strong>. Vous pouvez maintenant prendre un rendez-vous.</p>
                        </div>
                    </c:if>

                    <c:if test="${empty sessionScope.user}">
                        <div class="auth-buttons" id="auth-buttons">
                            <button class="btn btn-primary" id="login-btn-section">
                                <i class="fas fa-sign-in-alt"></i> Se connecter
                            </button>
                            <button class="btn btn-secondary" id="register-btn-section">
                                <i class="fas fa-user-plus"></i> Créer un compte
                            </button>
                        </div>
                    </c:if>

                    <c:if test="${not empty sessionScope.user}">
                        <div class="appointment-buttons" id="appointment-buttons">
                            <a href="${pageContext.request.contextPath}/appointment" class="btn btn-success" id="book-appointment-btn">
                                <i class="fas fa-calendar-plus"></i> Prendre un rendez-vous
                            </a>
                            <a href="${pageContext.request.contextPath}/patient/appointments" class="btn btn-outline" id="view-appointments-btn">
                                <i class="fas fa-list"></i> Voir mes rendez-vous
                            </a>
                        </div>
                    </c:if>

                    <div class="benefits-list">
                        <h4>Avantages de votre compte patient :</h4>
                        <ul>
                            <li><i class="fas fa-check-circle"></i> Prise de rendez-vous en ligne 24h/24</li>
                            <li><i class="fas fa-check-circle"></i> Gestion de vos consultations</li>
                            <li><i class="fas fa-check-circle"></i> Accès à votre dossier médical</li>
                            <li><i class="fas fa-check-circle"></i> Rappels automatiques par email/SMS</li>
                            <li><i class="fas fa-check-circle"></i> Communication sécurisée avec votre médecin</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="section-container">
            <div class="section-title">
                <h2>Pourquoi choisir notre clinique ?</h2>
                <p>Découvrez les avantages qui font de nous votre partenaire santé de confiance</p>
            </div>

            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h3>Experts médicaux</h3>
                    <p>Notre équipe de médecins spécialistes expérimentés vous assure des soins de qualité et un suivi personnalisé.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-clock"></i>
                    </div>
                    <h3>Rendez-vous rapides</h3>
                    <p>Obtenez une consultation dans les plus brefs délais grâce à notre système de rendez-vous optimisé.</p>
                </div>

                <div class="feature-card">
                    <div class="feature-icon">
                        <i class="fas fa-laptop-medical"></i>
                    </div>
                    <h3>Plateforme digitale</h3>
                    <p>Gérez vos rendez-vous, accédez à vos résultats et communiquez avec votre médecin en toute simplicité.</p>
                </div>
            </div>
        </div>
    </section>

    <!-- Services Section -->
    <section class="services">
        <div class="section-container">
            <div class="section-title">
                <h2>Nos services médicaux</h2>
                <p>Des soins complets adaptés à tous vos besoins de santé</p>
            </div>

            <div class="services-grid">
                <div class="service-card">
                    <div class="service-image" style="background-image: url('https://images.unsplash.com/photo-1559757148-5c350d0d3c56?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80');"></div>
                    <div class="service-content">
                        <h3>Consultation générale</h3>
                        <p>Bilan de santé complet et suivi médical personnalisé par nos médecins généralistes.</p>
                        <button class="btn btn-outline">En savoir plus</button>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-image" style="background-image: url('https://images.unsplash.com/photo-1584467735871-8db9ac8dcc13?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80');"></div>
                    <div class="service-content">
                        <h3>Spécialités médicales</h3>
                        <p>Cardiologie, dermatologie, gynécologie, pédiatrie et plus de 15 spécialités.</p>
                        <button class="btn btn-outline">En savoir plus</button>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-image" style="background-image: url('https://images.unsplash.com/photo-1576091160399-112ba8d25d1f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80');"></div>
                    <div class="service-content">
                        <h3>Analyses médicales</h3>
                        <p>Laboratoire d'analyses sur place pour des résultats rapides et fiables.</p>
                        <button class="btn btn-outline">En savoir plus</button>
                    </div>
                </div>

                <div class="service-card">
                    <div class="service-image" style="background-image: url('https://images.unsplash.com/photo-1516549655669-df6654e35e01?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80');"></div>
                    <div class="service-content">
                        <h3>Imagerie médicale</h3>
                        <p>Radiologie, échographie et IRM avec des équipements de dernière génération.</p>
                        <button class="btn btn-outline">En savoir plus</button>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta">
        <div class="section-container">
            <h2>Prêt à prendre soin de votre santé ?</h2>
            <p>Rejoignez les milliers de patients qui nous font confiance pour leurs soins médicaux. Prenez rendez-vous dès aujourd'hui.</p>
            <c:choose>
                <c:when test="${empty sessionScope.user}">
                    <button class="btn" id="cta-register-btn">
                        <i class="fas fa-user-plus"></i> Créer un compte
                    </button>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/patient/appointment" class="btn">
                        <i class="fas fa-calendar-plus"></i> Prendre rendez-vous
                    </a>
                </c:otherwise>
            </c:choose>
        </div>
    </section>
    <script>
        console.log('Test JS depuis index.jsp');
    </script>

<jsp:include page="/includes/footer.jsp" />

</body>
</html>