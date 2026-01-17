<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Clinique SantePlus - Votre santé, notre priorité</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
    --primary: #2c7fb8;
    --primary-dark: #1a5a8a;
    --primary-light: #4a9bd6;
    --secondary: #7fcdbb;
    --accent: #edf8b1;
    --dark: #253237;
    --light: #f8f9fa;
    --white: #ffffff;
    --gray: #6c757d;
    --light-gray: #e9ecef;
    --border-radius: 12px;
    --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    --transition: all 0.3s ease;
}

        * {
margin: 0;
padding: 0;
box-sizing: border-box;
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

body {
    background-color: var(--light);
    color: var(--dark);
    line-height: 1.6;
}

/* Header */
header {
    background: var(--white);
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
}

        .header-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 80px;
}

        .logo {
    display: flex;
    align-items: center;
    gap: 15px;
}

        .logo-icon {
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.5rem;
}

        .logo-text {
    font-size: 1.8rem;
    font-weight: 700;
    color: var(--primary);
}

        .logo-text span {
color: var(--secondary);
        }

nav ul {
display: flex;
list-style: none;
gap: 30px;
        }

nav a {
text-decoration: none;
color: var(--dark);
font-weight: 600;
font-size: 1rem;
transition: var(--transition);
position: relative;
        }

nav a:hover {
    color: var(--primary);
}

nav a::after {
    content: '';
    position: absolute;
    bottom: -5px;
    left: 0;
    width: 0;
    height: 2px;
    background: var(--primary);
    transition: var(--transition);
}

nav a:hover::after {
    width: 100%;
}

        .header-actions {
    display: flex;
    gap: 15px;
    align-items: center;
}

        .user-info {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 8px 15px;
    background: rgba(44, 127, 184, 0.1);
    border-radius: var(--border-radius);
    color: var(--primary);
    font-weight: 500;
}

        .user-avatar {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    background: var(--primary);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    font-size: 0.9rem;
}

        .btn {
    padding: 10px 20px;
    border: none;
    border-radius: var(--border-radius);
    cursor: pointer;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: var(--transition);
}

        .btn-outline {
    background-color: transparent;
    border: 2px solid var(--primary);
    color: var(--primary);
}

        .btn-outline:hover {
    background-color: var(--primary);
    color: white;
}

        .btn-primary {
    background-color: var(--primary);
    color: white;
}

        .btn-primary:hover {
    background-color: var(--primary-dark);
}

        .btn-secondary {
    background-color: var(--secondary);
    color: var(--dark);
    border: 2px solid var(--secondary);
}

        .btn-secondary:hover {
    background-color: transparent;
    color: var(--dark);
}

        .btn-success {
    background-color: var(--success);
    color: white;
    border: 2px solid var(--success);
}

        .btn-success:hover {
    background-color: transparent;
    color: var(--success);
}

/* Hero Banner */
        .hero {
    height: 80vh;
    background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
            url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1950&q=80');
    background-size: cover;
    background-position: center;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    color: white;
    position: relative;
}

        .hero-content {
    max-width: 800px;
    padding: 0 20px;
    z-index: 2;
}

        .hero h1 {
font-size: 3.5rem;
margin-bottom: 20px;
font-weight: 700;
line-height: 1.2;
        }

        .hero p {
font-size: 1.3rem;
margin-bottom: 30px;
opacity: 0.9;
        }

        .hero-buttons {
    display: flex;
    gap: 15px;
    justify-content: center;
    flex-wrap: wrap;
}

        .hero .btn {
    padding: 12px 30px;
    font-size: 1.1rem;
}

        .hero .btn-primary {
    background-color: var(--secondary);
    border: 2px solid var(--secondary);
    color: var(--dark);
}

        .hero .btn-primary:hover {
    background-color: transparent;
    color: white;
}

        .hero .btn-outline {
    border: 2px solid white;
    color: white;
}

        .hero .btn-outline:hover {
    background-color: white;
    color: var(--dark);
}

/* Appointment Section */
        .appointment {
    padding: 80px 20px;
    background: var(--white);
}

        .section-container {
    max-width: 1200px;
    margin: 0 auto;
}

        .section-title {
    text-align: center;
    margin-bottom: 50px;
}

        .section-title h2 {
font-size: 2.5rem;
color: var(--dark);
margin-bottom: 15px;
        }

                .section-title p {
font-size: 1.2rem;
color: var(--gray);
max-width: 600px;
margin: 0 auto;
        }

                .appointment-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 50px;
    align-items: center;
}

        .appointment-image {
    border-radius: var(--border-radius);
    overflow: hidden;
    box-shadow: var(--shadow);
}

        .appointment-image img {
width: 100%;
height: auto;
display: block;
        }

                .appointment-content {
    padding: 20px;
}

        .appointment-content h3 {
font-size: 1.8rem;
margin-bottom: 20px;
color: var(--dark);
        }

                .appointment-content p {
color: var(--gray);
margin-bottom: 30px;
line-height: 1.7;
        }

        .auth-required {
    background: rgba(44, 127, 184, 0.05);
    border-radius: var(--border-radius);
    padding: 25px;
    margin-bottom: 30px;
    border-left: 4px solid var(--primary);
}

        .appointment-ready {
    background: rgba(46, 204, 113, 0.1);
    border-radius: var(--border-radius);
    padding: 25px;
    margin-bottom: 30px;
    border-left: 4px solid var(--success);
}

        .auth-required h4, .appointment-ready h4 {
font-size: 1.3rem;
margin-bottom: 10px;
color: var(--dark);
display: flex;
align-items: center;
gap: 10px;
        }

                .auth-required h4 i {
    color: var(--primary);
}

        .appointment-ready h4 i {
    color: var(--success);
}

        .auth-required p, .appointment-ready p {
margin-bottom: 0;
color: var(--gray);
        }

                .auth-buttons, .appointment-buttons {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

        .auth-buttons .btn, .appointment-buttons .btn {
    flex: 1;
    min-width: 180px;
    justify-content: center;
    padding: 15px;
}

        .benefits-list {
    margin-top: 30px;
}

        .benefits-list h4 {
font-size: 1.2rem;
margin-bottom: 15px;
color: var(--dark);
        }

                .benefits-list ul {
list-style: none;
        }

                .benefits-list li {
display: flex;
align-items: center;
gap: 12px;
margin-bottom: 12px;
color: var(--gray);
        }

                .benefits-list i {
color: var(--success);
        }

                /* Features Section */
                .features {
    padding: 80px 20px;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

        .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
}

        .feature-card {
    background: var(--white);
    border-radius: var(--border-radius);
    padding: 40px 30px;
    text-align: center;
    box-shadow: var(--shadow);
    transition: var(--transition);
}

        .feature-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
}

        .feature-icon {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: rgba(44, 127, 184, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 25px;
    color: var(--primary);
    font-size: 2rem;
}

        .feature-card h3 {
font-size: 1.5rem;
margin-bottom: 15px;
color: var(--dark);
        }

                .feature-card p {
color: var(--gray);
line-height: 1.7;
        }

        /* Services Section */
        .services {
    padding: 80px 20px;
    background: var(--white);
}

        .services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 25px;
}

        .service-card {
    background: var(--white);
    border-radius: var(--border-radius);
    overflow: hidden;
    box-shadow: var(--shadow);
    transition: var(--transition);
}

        .service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

        .service-image {
    height: 200px;
    background-size: cover;
    background-position: center;
}

        .service-content {
    padding: 25px;
}

        .service-content h3 {
font-size: 1.3rem;
margin-bottom: 10px;
color: var(--dark);
        }

                .service-content p {
color: var(--gray);
margin-bottom: 20px;
font-size: 0.95rem;
        }

                /* CTA Section */
                .cta {
    padding: 80px 20px;
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    color: white;
    text-align: center;
}

        .cta h2 {
font-size: 2.5rem;
margin-bottom: 20px;
        }

                .cta p {
font-size: 1.2rem;
margin-bottom: 30px;
max-width: 700px;
margin-left: auto;
margin-right: auto;
opacity: 0.9;
        }

        .cta .btn {
    padding: 15px 40px;
    font-size: 1.1rem;
    background: var(--secondary);
    color: var(--dark);
    border: 2px solid var(--secondary);
}

        .cta .btn:hover {
    background: transparent;
    color: white;
}

/* Footer */
footer {
    background: var(--dark);
    color: white;
    padding: 60px 20px 30px;
}

        .footer-container {
    max-width: 1200px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
}

        .footer-col h3 {
font-size: 1.3rem;
margin-bottom: 25px;
position: relative;
padding-bottom: 10px;
        }

                .footer-col h3::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 50px;
    height: 2px;
    background: var(--secondary);
}

        .footer-col p {
margin-bottom: 20px;
opacity: 0.8;
line-height: 1.7;
        }

        .footer-links {
    list-style: none;
}

        .footer-links li {
margin-bottom: 12px;
        }

                .footer-links a {
color: rgba(255, 255, 255, 0.8);
text-decoration: none;
transition: var(--transition);
        }

                .footer-links a:hover {
    color: var(--secondary);
    padding-left: 5px;
}

        .footer-contact li {
display: flex;
align-items: flex-start;
gap: 15px;
margin-bottom: 20px;
        }

                .footer-contact i {
color: var(--secondary);
margin-top: 5px;
        }

                .social-links {
    display: flex;
    gap: 15px;
    margin-top: 20px;
}

        .social-links a {
width: 40px;
height: 40px;
border-radius: 50%;
background: rgba(255, 255, 255, 0.1);
display: flex;
align-items: center;
justify-content: center;
color: white;
transition: var(--transition);
        }

                .social-links a:hover {
    background: var(--secondary);
    color: var(--dark);
    transform: translateY(-3px);
}

        .copyright {
    text-align: center;
    margin-top: 50px;
    padding-top: 20px;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    opacity: 0.7;
    font-size: 0.9rem;
}

/* Modal */
        .modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 2000;
    align-items: center;
    justify-content: center;
}

        .modal-content {
    background: white;
    border-radius: var(--border-radius);
    width: 90%;
    max-width: 500px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    animation: modalAppear 0.3s ease;
}

@keyframes modalAppear {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

        .modal-header {
    padding: 20px 25px;
    border-bottom: 1px solid var(--light-gray);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

        .modal-header h3 {
font-size: 1.5rem;
color: var(--dark);
        }

                .close-modal {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: var(--gray);
    transition: var(--transition);
}

        .close-modal:hover {
    color: var(--dark);
}

        .modal-body {
    padding: 25px;
}

        .form-group {
    margin-bottom: 20px;
}

        .form-group label {
display: block;
margin-bottom: 8px;
font-weight: 500;
color: var(--dark);
        }

                .form-control {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid var(--light-gray);
    border-radius: var(--border-radius);
    font-size: 1rem;
    transition: var(--transition);
}

        .form-control:focus {
    outline: none;
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(44, 127, 184, 0.1);
}

        .form-footer {
    margin-top: 25px;
    text-align: center;
    font-size: 0.9rem;
    color: var(--gray);
}

        .form-footer a {
color: var(--primary);
text-decoration: none;
font-weight: 500;
        }

        .form-footer a:hover {
    text-decoration: underline;
}

/* Responsive */
@media (max-width: 992px) {
        .hero h1 {
font-size: 2.8rem;
            }

nav ul {
gap: 20px;
            }

                    .appointment-container {
    grid-template-columns: 1fr;
    gap: 30px;
}
        }

@media (max-width: 768px) {
        .header-container {
    flex-direction: column;
    height: auto;
    padding: 20px;
}

            .logo {
    margin-bottom: 15px;
}

nav ul {
flex-wrap: wrap;
justify-content: center;
gap: 15px;
margin-bottom: 15px;
            }

                    .hero {
    height: 70vh;
}

            .hero h1 {
font-size: 2.2rem;
            }

                    .hero p {
font-size: 1.1rem;
            }

                    .hero-buttons {
    flex-direction: column;
    align-items: center;
}

            .hero .btn {
    width: 200px;
}

            .section-title h2 {
font-size: 2rem;
            }

                    .auth-buttons, .appointment-buttons {
    flex-direction: column;
}

            .user-info {
    margin-top: 10px;
}
        }

@media (max-width: 576px) {
        .hero h1 {
font-size: 1.8rem;
            }

                    .hero p {
font-size: 1rem;
            }

                    .features, .services, .appointment, .cta {
    padding: 50px 20px;
}

            .footer-container {
    grid-template-columns: 1fr;
}
        }
    </style>
</head>
<body>
    <!-- Header -->
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
                    <li><a href="#">Rendez-vous</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </nav>

            <div class="header-actions" id="header-actions">
                <!-- État non connecté -->
                <div id="guest-actions">
                    <button class="btn btn-outline" id="login-btn-header">
                        <i class="fas fa-sign-in-alt"></i> Se connecter
                    </button>
                    <button class="btn btn-primary" id="register-btn-header">
                        <i class="fas fa-user-plus"></i> Créer un compte
        </button>
                </div>

                <!-- État connecté -->
                <div id="user-actions" style="display: none;">
                    <div class="user-info">
                        <div class="user-avatar" id="user-avatar">JD</div>
                        <span id="user-name">Jean Dupont</span>
                    </div>
                    <button class="btn btn-outline" id="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Déconnexion
        </button>
                </div>
            </div>
        </div>
    </header>

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
                    <div class="auth-required" id="auth-required">
                        <h4><i class="fas fa-lock"></i> Authentification requise</h4>
<p>Pour prendre un rendez-vous, vous devez avoir un compte patient. Connectez-vous ou créez un compte gratuitement.</p>
                    </div>

                    <!-- État connecté -->
                    <div class="appointment-ready" id="appointment-ready" style="display: none;">
                        <h4><i class="fas fa-check-circle"></i> Prêt à réserver</h4>
<p>Vous êtes connecté en tant que <strong id="user-email">jean.dupont@email.com</strong>. Vous pouvez maintenant prendre un rendez-vous.</p>
                    </div>

                    <div class="auth-buttons" id="auth-buttons">
                        <button class="btn btn-primary" id="login-btn-section">
                            <i class="fas fa-sign-in-alt"></i> Se connecter
                        </button>
                        <button class="btn btn-secondary" id="register-btn-section">
                            <i class="fas fa-user-plus"></i> Créer un compte
        </button>
                    </div>

                    <div class="appointment-buttons" id="appointment-buttons" style="display: none;">
                        <button class="btn btn-success" id="book-appointment-btn">
                            <i class="fas fa-calendar-plus"></i> Prendre un rendez-vous
        </button>
                        <button class="btn btn-outline" id="view-appointments-btn">
                            <i class="fas fa-list"></i> Voir mes rendez-vous
        </button>
                    </div>

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
            <button class="btn" id="cta-register-btn">
                <i class="fas fa-user-plus"></i> Créer un compte
        </button>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-col">
<h3>Clinique Clinique SantePlus </h3>
<p>Votre partenaire santé de confiance, engagé à vous offrir des soins médicaux d'excellence dans un environnement bienveillant et moderne.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>

            <div class="footer-col">
<h3>Liens rapides</h3>
                <ul class="footer-links">
                    <li><a href="#">Accueil</a></li>
                    <li><a href="#">Nos services</a></li>
                    <li><a href="#">Notre équipe</a></li>
                    <li><a href="#">Tarifs</a></li>
                    <li><a href="#">Blog santé</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h3>Services</h3>
                <ul class="footer-links">
                    <li><a href="#">Médecine générale</a></li>
                    <li><a href="#">Spécialités</a></li>
                    <li><a href="#">Analyses médicales</a></li>
                    <li><a href="#">Imagerie</a></li>
                    <li><a href="#">Urgences</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h3>Contact</h3>
                <ul class="footer-contact">
                    <li>
                        <i class="fas fa-map-marker-alt"></i>
                        <div>
                            <strong>Adresse</strong><br>
                            123 Avenue de la Santé<br>
                            75000 Paris, France
        </div>
                    </li>
                    <li>
                        <i class="fas fa-phone-alt"></i>
                        <div>
                            <strong>Téléphone</strong><br>
                            +212 616 12 69 29
                        </div>
                    </li>
                    <li>
                        <i class="fas fa-envelope"></i>
                        <div>
                            <strong>Email</strong><br>
abdelouafioubenali9@gmail.com
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2023 Clinique SantePlus. Tous droits réservés.</p>
        </div>
    </footer>

    <!-- Login Modal -->
    <div class="modal" id="login-modal">
        <div class="modal-content">
            <div class="modal-header">
<h3>Connexion à votre compte</h3>
                <button class="close-modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="login-form" action="login" method="post">
                    <div class="form-group">
                        <label for="login-email">Adresse email</label>
                        <input type="email" id="login-email" name="email" class="form-control" placeholder="votre@email.com" required>
                    </div>
                    <div class="form-group">
                        <label for="login-password">Mot de passe</label>
                        <input type="password" id="login-password" name="password" class="form-control" placeholder="Votre mot de passe" required>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px;">
                        <i class="fas fa-sign-in-alt"></i> Se connecter
                    </button>
                </form>
                <div class="form-footer">
<p>Pas encore de compte ? <a href="#" id="switch-to-register">Créer un compte</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Register Modal -->
    <div class="modal" id="register-modal">
        <div class="modal-content">
            <div class="modal-header">
<h3>Créer un compte patient</h3>
                <button class="close-modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post">
                    <div class="form-group">
                        <label for="register-name">Nom complet</label>
                        <input type="text" id="register-name" name="name" class="form-control" placeholder="Votre nom et prénom" required>
                    </div>
                    <div class="form-group">
                        <label for="register-email">Adresse email</label>
                        <input type="email" id="register-email" name="email" class="form-control" placeholder="votre@email.com" required>
                    </div>
                    <div class="form-group">
                        <label for="register-phone">Téléphone</label>
                        <input type="tel" id="register-phone" name="phone" class="form-control" placeholder="Votre numéro de téléphone" required>
                    </div>
                    <div class="form-group">
                        <label for="register-password">Mot de passe</label>
                        <input type="password" id="register-password" name="password" class="form-control" placeholder="Créez un mot de passe" required>
                    </div>
                    <div class="form-group">
                        <label for="register-confirm">Confirmer le mot de passe</label>
                        <input type="password" id="register-confirm" name="confirmPassword" class="form-control" placeholder="Confirmez votre mot de passe" required>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px;">
                        <i class="fas fa-user-plus"></i> Créer mon compte
        </button>
                </form>
                <div class="form-footer">
<p>Déjà un compte ? <a href="#" id="switch-to-login">Se connecter</a></p>
                </div>
            </div>
        </div>
    </div>

<script>
        // État de connexion (à remplacer par la vérification réelle de session)
        let isLoggedIn = false;
let currentUser = null;

// Fonction pour vérifier l'état de connexion (simulée)
function checkLoginStatus() {
    // En production, vous feriez une requête AJAX vers le serveur
    // pour vérifier si l'utilisateur est connecté
            const userData = localStorage.getItem('currentUser');
    if (userData) {
        currentUser = JSON.parse(userData);
        isLoggedIn = true;
    }
    updateUI();
}

// Fonction pour mettre à jour l'interface en fonction de l'état de connexion
function updateUI() {
            const guestActions = document.getElementById('guest-actions');
            const userActions = document.getElementById('user-actions');
            const authRequired = document.getElementById('auth-required');
            const appointmentReady = document.getElementById('appointment-ready');
            const authButtons = document.getElementById('auth-buttons');
            const appointmentButtons = document.getElementById('appointment-buttons');
            const userAvatar = document.getElementById('user-avatar');
            const userName = document.getElementById('user-name');
            const userEmail = document.getElementById('user-email');

    if (isLoggedIn && currentUser) {
        // Mode connecté
        guestActions.style.display = 'none';
        userActions.style.display = 'flex';
        authRequired.style.display = 'none';
        appointmentReady.style.display = 'block';
        authButtons.style.display = 'none';
        appointmentButtons.style.display = 'flex';

        // Mettre à jour les informations utilisateur
        userAvatar.textContent = currentUser.initials || 'JD';
        userName.textContent = currentUser.name || 'Utilisateur';
        userEmail.textContent = currentUser.email || 'utilisateur@email.com';
    } else {
        // Mode non connecté
        guestActions.style.display = 'flex';
        userActions.style.display = 'none';
        authRequired.style.display = 'block';
        appointmentReady.style.display = 'none';
        authButtons.style.display = 'flex';
        appointmentButtons.style.display = 'none';
    }
}

// Fonction de connexion simulée
function loginUser(userData) {
    currentUser = {
            name: userData.name,
            email: userData.email,
            initials: userData.name.split(' ').map(n => n[0]).join('').toUpperCase()
            };
    isLoggedIn = true;
    localStorage.setItem('currentUser', JSON.stringify(currentUser));
    updateUI();
}

// Fonction de déconnexion
function logoutUser() {
    isLoggedIn = false;
    currentUser = null;
    localStorage.removeItem('currentUser');
    updateUI();
}

// Modal functionality
        const loginModal = document.getElementById('login-modal');
        const registerModal = document.getElementById('register-modal');
        const loginButtons = document.querySelectorAll('#login-btn-header, #login-btn-section');
        const registerButtons = document.querySelectorAll('#register-btn-header, #register-btn-section, #cta-register-btn');
        const appointmentButton = document.getElementById('appointment-btn-hero');
        const bookAppointmentBtn = document.getElementById('book-appointment-btn');
        const viewAppointmentsBtn = document.getElementById('view-appointments-btn');
        const logoutBtn = document.getElementById('logout-btn');
        const closeButtons = document.querySelectorAll('.close-modal');
        const switchToRegister = document.getElementById('switch-to-register');
        const switchToLogin = document.getElementById('switch-to-login');

// Open login modal
        loginButtons.forEach(button => {
    button.addEventListener('click', () => {
            loginModal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
            });
});

        // Open register modal
        registerButtons.forEach(button => {
    button.addEventListener('click', () => {
            registerModal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
            });
});

        // Appointment button behavior
        appointmentButton.addEventListener('click', () => {
        if (isLoggedIn) {
// Rediriger vers la page de prise de rendez-vous
alert('Redirection vers la page de prise de rendez-vous...');
// window.location.href = '/patient/appointment';
            } else {
                    // Faire défiler vers la section rendez-vous
                    document.getElementById('appointment').scrollIntoView({ behavior: 'smooth' });
        }
        });

        // Book appointment button (quand connecté)
        bookAppointmentBtn.addEventListener('click', () => {
alert('Redirection vers la page de prise de rendez-vous...');
// window.location.href = '/patient/appointment';
        });

                // View appointments button (quand connecté)
                viewAppointmentsBtn.addEventListener('click', () => {
alert('Redirection vers la page des rendez-vous...');
// window.location.href = '/patient/appointments';
        });

                // Logout button
                logoutBtn.addEventListener('click', () => {
logoutUser();
        });

                // Close modals
                closeButtons.forEach(button => {
    button.addEventListener('click', () => {
            loginModal.style.display = 'none';
    registerModal.style.display = 'none';
    document.body.style.overflow = 'auto';
            });
});

        // Switch between login and register modals
        switchToRegister.addEventListener('click', (e) => {
        e.preventDefault();
loginModal.style.display = 'none';
registerModal.style.display = 'flex';
        });

        switchToLogin.addEventListener('click', (e) => {
        e.preventDefault();
registerModal.style.display = 'none';
loginModal.style.display = 'flex';
        });

        // Close modal when clicking outside
        window.addEventListener('click', (e) => {
        if (e.target === loginModal) {
loginModal.style.display = 'none';
document.body.style.overflow = 'auto';
        }
        if (e.target === registerModal) {
registerModal.style.display = 'none';
document.body.style.overflow = 'auto';
        }
        });

        // Form submissions
        document.getElementById('login-form').addEventListener('submit', (e) => {
        e.preventDefault();
            const email = document.getElementById('login-email').value;
            const password = document.getElementById('login-password').value;

// Simulation de connexion réussie
loginUser({
    name: 'Jean Dupont',
            email: email,
            initials: 'JD'
});

loginModal.style.display = 'none';
document.body.style.overflow = 'auto';

alert('Connexion réussie ! Bienvenue Jean Dupont.');
        });

                document.getElementById('registerForm').addEventListener('submit', (e) => {
        e.preventDefault();
            const name = document.getElementById('register-name').value;
            const email = document.getElementById('register-email').value;
            const phone = document.getElementById('register-phone').value;
            const password = document.getElementById('register-password').value;

// Simulation de création de compte réussie
loginUser({
    name: name,
            email: email,
            initials: name.split(' ').map(n => n[0]).join('').toUpperCase()
});

registerModal.style.display = 'none';
document.body.style.overflow = 'auto';

alert('Compte créé avec succès ! Bienvenue ' + name + '.');
        });

                // Header background on scroll
                window.addEventListener('scroll', function() {
            const header = document.querySelector('header');
    if(window.scrollY > 100) {
        header.style.background = 'rgba(255, 255, 255, 0.95)';
        header.style.backdropFilter = 'blur(10px)';
    } else {
        header.style.background = 'var(--white)';
        header.style.backdropFilter = 'none';
    }
});

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
    checkLoginStatus();
});
    </script>
</body>
</html><!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Clinique Clinique SantePlus - Votre santé, notre priorité</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
    --primary: #2c7fb8;
    --primary-dark: #1a5a8a;
    --primary-light: #4a9bd6;
    --secondary: #7fcdbb;
    --accent: #edf8b1;
    --dark: #253237;
    --light: #f8f9fa;
    --white: #ffffff;
    --gray: #6c757d;
    --light-gray: #e9ecef;
    --border-radius: 12px;
    --shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
    --transition: all 0.3s ease;
}

        * {
margin: 0;
padding: 0;
box-sizing: border-box;
font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

body {
    background-color: var(--light);
    color: var(--dark);
    line-height: 1.6;
}

/* Header */
header {
    background: var(--white);
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    position: sticky;
    top: 0;
    z-index: 1000;
}

        .header-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 0 20px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 80px;
}

        .logo {
    display: flex;
    align-items: center;
    gap: 15px;
}

        .logo-icon {
    width: 50px;
    height: 50px;
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    border-radius: 50%;
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-size: 1.5rem;
}

        .logo-text {
    font-size: 1.8rem;
    font-weight: 700;
    color: var(--primary);
}

        .logo-text span {
color: var(--secondary);
        }

nav ul {
display: flex;
list-style: none;
gap: 30px;
        }

nav a {
text-decoration: none;
color: var(--dark);
font-weight: 600;
font-size: 1rem;
transition: var(--transition);
position: relative;
        }

nav a:hover {
    color: var(--primary);
}

nav a::after {
    content: '';
    position: absolute;
    bottom: -5px;
    left: 0;
    width: 0;
    height: 2px;
    background: var(--primary);
    transition: var(--transition);
}

nav a:hover::after {
    width: 100%;
}

        .header-actions {
    display: flex;
    gap: 15px;
    align-items: center;
}

        .user-info {
    display: flex;
    align-items: center;
    gap: 10px;
    padding: 8px 15px;
    background: rgba(44, 127, 184, 0.1);
    border-radius: var(--border-radius);
    color: var(--primary);
    font-weight: 500;
}

        .user-avatar {
    width: 35px;
    height: 35px;
    border-radius: 50%;
    background: var(--primary);
    display: flex;
    align-items: center;
    justify-content: center;
    color: white;
    font-weight: bold;
    font-size: 0.9rem;
}

        .btn {
    padding: 10px 20px;
    border: none;
    border-radius: var(--border-radius);
    cursor: pointer;
    font-weight: 600;
    display: inline-flex;
    align-items: center;
    gap: 8px;
    transition: var(--transition);
}

        .btn-outline {
    background-color: transparent;
    border: 2px solid var(--primary);
    color: var(--primary);
}

        .btn-outline:hover {
    background-color: var(--primary);
    color: white;
}

        .btn-primary {
    background-color: var(--primary);
    color: white;
}

        .btn-primary:hover {
    background-color: var(--primary-dark);
}

        .btn-secondary {
    background-color: var(--secondary);
    color: var(--dark);
    border: 2px solid var(--secondary);
}

        .btn-secondary:hover {
    background-color: transparent;
    color: var(--dark);
}

        .btn-success {
    background-color: var(--success);
    color: white;
    border: 2px solid var(--success);
}

        .btn-success:hover {
    background-color: transparent;
    color: var(--success);
}

/* Hero Banner */
        .hero {
    height: 80vh;
    background: linear-gradient(rgba(0, 0, 0, 0.6), rgba(0, 0, 0, 0.6)),
            url('https://images.unsplash.com/photo-1519494026892-80bbd2d6fd0d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1950&q=80');
    background-size: cover;
    background-position: center;
    display: flex;
    align-items: center;
    justify-content: center;
    text-align: center;
    color: white;
    position: relative;
}

        .hero-content {
    max-width: 800px;
    padding: 0 20px;
    z-index: 2;
}

        .hero h1 {
font-size: 3.5rem;
margin-bottom: 20px;
font-weight: 700;
line-height: 1.2;
        }

        .hero p {
font-size: 1.3rem;
margin-bottom: 30px;
opacity: 0.9;
        }

        .hero-buttons {
    display: flex;
    gap: 15px;
    justify-content: center;
    flex-wrap: wrap;
}

        .hero .btn {
    padding: 12px 30px;
    font-size: 1.1rem;
}

        .hero .btn-primary {
    background-color: var(--secondary);
    border: 2px solid var(--secondary);
    color: var(--dark);
}

        .hero .btn-primary:hover {
    background-color: transparent;
    color: white;
}

        .hero .btn-outline {
    border: 2px solid white;
    color: white;
}

        .hero .btn-outline:hover {
    background-color: white;
    color: var(--dark);
}

/* Appointment Section */
        .appointment {
    padding: 80px 20px;
    background: var(--white);
}

        .section-container {
    max-width: 1200px;
    margin: 0 auto;
}

        .section-title {
    text-align: center;
    margin-bottom: 50px;
}

        .section-title h2 {
font-size: 2.5rem;
color: var(--dark);
margin-bottom: 15px;
        }

                .section-title p {
font-size: 1.2rem;
color: var(--gray);
max-width: 600px;
margin: 0 auto;
        }

                .appointment-container {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 50px;
    align-items: center;
}

        .appointment-image {
    border-radius: var(--border-radius);
    overflow: hidden;
    box-shadow: var(--shadow);
}

        .appointment-image img {
width: 100%;
height: auto;
display: block;
        }

                .appointment-content {
    padding: 20px;
}

        .appointment-content h3 {
font-size: 1.8rem;
margin-bottom: 20px;
color: var(--dark);
        }

                .appointment-content p {
color: var(--gray);
margin-bottom: 30px;
line-height: 1.7;
        }

        .auth-required {
    background: rgba(44, 127, 184, 0.05);
    border-radius: var(--border-radius);
    padding: 25px;
    margin-bottom: 30px;
    border-left: 4px solid var(--primary);
}

        .appointment-ready {
    background: rgba(46, 204, 113, 0.1);
    border-radius: var(--border-radius);
    padding: 25px;
    margin-bottom: 30px;
    border-left: 4px solid var(--success);
}

        .auth-required h4, .appointment-ready h4 {
font-size: 1.3rem;
margin-bottom: 10px;
color: var(--dark);
display: flex;
align-items: center;
gap: 10px;
        }

                .auth-required h4 i {
    color: var(--primary);
}

        .appointment-ready h4 i {
    color: var(--success);
}

        .auth-required p, .appointment-ready p {
margin-bottom: 0;
color: var(--gray);
        }

                .auth-buttons, .appointment-buttons {
    display: flex;
    gap: 15px;
    flex-wrap: wrap;
}

        .auth-buttons .btn, .appointment-buttons .btn {
    flex: 1;
    min-width: 180px;
    justify-content: center;
    padding: 15px;
}

        .benefits-list {
    margin-top: 30px;
}

        .benefits-list h4 {
font-size: 1.2rem;
margin-bottom: 15px;
color: var(--dark);
        }

                .benefits-list ul {
list-style: none;
        }

                .benefits-list li {
display: flex;
align-items: center;
gap: 12px;
margin-bottom: 12px;
color: var(--gray);
        }

                .benefits-list i {
color: var(--success);
        }

                /* Features Section */
                .features {
    padding: 80px 20px;
    background: linear-gradient(135deg, #f8f9fa 0%, #e9ecef 100%);
}

        .features-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 30px;
}

        .feature-card {
    background: var(--white);
    border-radius: var(--border-radius);
    padding: 40px 30px;
    text-align: center;
    box-shadow: var(--shadow);
    transition: var(--transition);
}

        .feature-card:hover {
    transform: translateY(-10px);
    box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
}

        .feature-icon {
    width: 80px;
    height: 80px;
    border-radius: 50%;
    background: rgba(44, 127, 184, 0.1);
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 25px;
    color: var(--primary);
    font-size: 2rem;
}

        .feature-card h3 {
font-size: 1.5rem;
margin-bottom: 15px;
color: var(--dark);
        }

                .feature-card p {
color: var(--gray);
line-height: 1.7;
        }

        /* Services Section */
        .services {
    padding: 80px 20px;
    background: var(--white);
}

        .services-grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 25px;
}

        .service-card {
    background: var(--white);
    border-radius: var(--border-radius);
    overflow: hidden;
    box-shadow: var(--shadow);
    transition: var(--transition);
}

        .service-card:hover {
    transform: translateY(-5px);
    box-shadow: 0 10px 25px rgba(0, 0, 0, 0.15);
}

        .service-image {
    height: 200px;
    background-size: cover;
    background-position: center;
}

        .service-content {
    padding: 25px;
}

        .service-content h3 {
font-size: 1.3rem;
margin-bottom: 10px;
color: var(--dark);
        }

                .service-content p {
color: var(--gray);
margin-bottom: 20px;
font-size: 0.95rem;
        }

                /* CTA Section */
                .cta {
    padding: 80px 20px;
    background: linear-gradient(135deg, var(--primary), var(--primary-dark));
    color: white;
    text-align: center;
}

        .cta h2 {
font-size: 2.5rem;
margin-bottom: 20px;
        }

                .cta p {
font-size: 1.2rem;
margin-bottom: 30px;
max-width: 700px;
margin-left: auto;
margin-right: auto;
opacity: 0.9;
        }

        .cta .btn {
    padding: 15px 40px;
    font-size: 1.1rem;
    background: var(--secondary);
    color: var(--dark);
    border: 2px solid var(--secondary);
}

        .cta .btn:hover {
    background: transparent;
    color: white;
}

/* Footer */
footer {
    background: var(--dark);
    color: white;
    padding: 60px 20px 30px;
}

        .footer-container {
    max-width: 1200px;
    margin: 0 auto;
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
    gap: 40px;
}

        .footer-col h3 {
font-size: 1.3rem;
margin-bottom: 25px;
position: relative;
padding-bottom: 10px;
        }

                .footer-col h3::after {
    content: '';
    position: absolute;
    bottom: 0;
    left: 0;
    width: 50px;
    height: 2px;
    background: var(--secondary);
}

        .footer-col p {
margin-bottom: 20px;
opacity: 0.8;
line-height: 1.7;
        }

        .footer-links {
    list-style: none;
}

        .footer-links li {
margin-bottom: 12px;
        }

                .footer-links a {
color: rgba(255, 255, 255, 0.8);
text-decoration: none;
transition: var(--transition);
        }

                .footer-links a:hover {
    color: var(--secondary);
    padding-left: 5px;
}

        .footer-contact li {
display: flex;
align-items: flex-start;
gap: 15px;
margin-bottom: 20px;
        }

                .footer-contact i {
color: var(--secondary);
margin-top: 5px;
        }

                .social-links {
    display: flex;
    gap: 15px;
    margin-top: 20px;
}

        .social-links a {
width: 40px;
height: 40px;
border-radius: 50%;
background: rgba(255, 255, 255, 0.1);
display: flex;
align-items: center;
justify-content: center;
color: white;
transition: var(--transition);
        }

                .social-links a:hover {
    background: var(--secondary);
    color: var(--dark);
    transform: translateY(-3px);
}

        .copyright {
    text-align: center;
    margin-top: 50px;
    padding-top: 20px;
    border-top: 1px solid rgba(255, 255, 255, 0.1);
    opacity: 0.7;
    font-size: 0.9rem;
}

/* Modal */
        .modal {
    display: none;
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 2000;
    align-items: center;
    justify-content: center;
}

        .modal-content {
    background: white;
    border-radius: var(--border-radius);
    width: 90%;
    max-width: 500px;
    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
    animation: modalAppear 0.3s ease;
}

@keyframes modalAppear {
    from {
        opacity: 0;
        transform: translateY(-20px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

        .modal-header {
    padding: 20px 25px;
    border-bottom: 1px solid var(--light-gray);
    display: flex;
    justify-content: space-between;
    align-items: center;
}

        .modal-header h3 {
font-size: 1.5rem;
color: var(--dark);
        }

                .close-modal {
    background: none;
    border: none;
    font-size: 1.5rem;
    cursor: pointer;
    color: var(--gray);
    transition: var(--transition);
}

        .close-modal:hover {
    color: var(--dark);
}

        .modal-body {
    padding: 25px;
}

        .form-group {
    margin-bottom: 20px;
}

        .form-group label {
display: block;
margin-bottom: 8px;
font-weight: 500;
color: var(--dark);
        }

                .form-control {
    width: 100%;
    padding: 12px 15px;
    border: 1px solid var(--light-gray);
    border-radius: var(--border-radius);
    font-size: 1rem;
    transition: var(--transition);
}

        .form-control:focus {
    outline: none;
    border-color: var(--primary);
    box-shadow: 0 0 0 3px rgba(44, 127, 184, 0.1);
}

        .form-footer {
    margin-top: 25px;
    text-align: center;
    font-size: 0.9rem;
    color: var(--gray);
}

        .form-footer a {
color: var(--primary);
text-decoration: none;
font-weight: 500;
        }

        .form-footer a:hover {
    text-decoration: underline;
}

/* Responsive */
@media (max-width: 992px) {
        .hero h1 {
font-size: 2.8rem;
            }

nav ul {
gap: 20px;
            }

                    .appointment-container {
    grid-template-columns: 1fr;
    gap: 30px;
}
        }

@media (max-width: 768px) {
        .header-container {
    flex-direction: column;
    height: auto;
    padding: 20px;
}

            .logo {
    margin-bottom: 15px;
}

nav ul {
flex-wrap: wrap;
justify-content: center;
gap: 15px;
margin-bottom: 15px;
            }

                    .hero {
    height: 70vh;
}

            .hero h1 {
font-size: 2.2rem;
            }

                    .hero p {
font-size: 1.1rem;
            }

                    .hero-buttons {
    flex-direction: column;
    align-items: center;
}

            .hero .btn {
    width: 200px;
}

            .section-title h2 {
font-size: 2rem;
            }

                    .auth-buttons, .appointment-buttons {
    flex-direction: column;
}

            .user-info {
    margin-top: 10px;
}
        }

@media (max-width: 576px) {
        .hero h1 {
font-size: 1.8rem;
            }

                    .hero p {
font-size: 1rem;
            }

                    .features, .services, .appointment, .cta {
    padding: 50px 20px;
}

            .footer-container {
    grid-template-columns: 1fr;
}
        }
    </style>
</head>
<body>
    <!-- Header -->
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
                    <li><a href="#">Rendez-vous</a></li>
                    <li><a href="#">Contact</a></li>
                </ul>
            </nav>

            <div class="header-actions" id="header-actions">
                <!-- État non connecté -->
                <div id="guest-actions">
                    <button class="btn btn-outline" id="login-btn-header">
                        <i class="fas fa-sign-in-alt"></i> Se connecter
                    </button>
                    <button class="btn btn-primary" id="register-btn-header">
                        <i class="fas fa-user-plus"></i> Créer un compte
        </button>
                </div>

                <!-- État connecté -->
                <div id="user-actions" style="display: none;">
                    <div class="user-info">
                        <div class="user-avatar" id="user-avatar">JD</div>
                        <span id="user-name">Jean Dupont</span>
                    </div>
                    <button class="btn btn-outline" id="logout-btn">
                        <i class="fas fa-sign-out-alt"></i> Déconnexion
        </button>
                </div>
            </div>
        </div>
    </header>

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
                    <div class="auth-required" id="auth-required">
                        <h4><i class="fas fa-lock"></i> Authentification requise</h4>
<p>Pour prendre un rendez-vous, vous devez avoir un compte patient. Connectez-vous ou créez un compte gratuitement.</p>
                    </div>

                    <!-- État connecté -->
                    <div class="appointment-ready" id="appointment-ready" style="display: none;">
                        <h4><i class="fas fa-check-circle"></i> Prêt à réserver</h4>
<p>Vous êtes connecté en tant que <strong id="user-email">jean.dupont@email.com</strong>. Vous pouvez maintenant prendre un rendez-vous.</p>
                    </div>

                    <div class="auth-buttons" id="auth-buttons">
                        <button class="btn btn-primary" id="login-btn-section">
                            <i class="fas fa-sign-in-alt"></i> Se connecter
                        </button>
                        <button class="btn btn-secondary" id="register-btn-section">
                            <i class="fas fa-user-plus"></i> Créer un compte
        </button>
                    </div>

                    <div class="appointment-buttons" id="appointment-buttons" style="display: none;">
                        <button class="btn btn-success" id="book-appointment-btn">
                            <i class="fas fa-calendar-plus"></i> Prendre un rendez-vous
        </button>
                        <button class="btn btn-outline" id="view-appointments-btn">
                            <i class="fas fa-list"></i> Voir mes rendez-vous
        </button>
                    </div>

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
            <button class="btn" id="cta-register-btn">
                <i class="fas fa-user-plus"></i> Créer un compte
        </button>
        </div>
    </section>

    <!-- Footer -->
    <footer>
        <div class="footer-container">
            <div class="footer-col">
<h3>Clinique SantePlus</h3>
<p>Votre partenaire santé de confiance, engagé à vous offrir des soins médicaux d'excellence dans un environnement bienveillant et moderne.</p>
                <div class="social-links">
                    <a href="#"><i class="fab fa-facebook-f"></i></a>
                    <a href="#"><i class="fab fa-twitter"></i></a>
                    <a href="#"><i class="fab fa-instagram"></i></a>
                    <a href="#"><i class="fab fa-linkedin-in"></i></a>
                </div>
            </div>

            <div class="footer-col">
<h3>Liens rapides</h3>
                <ul class="footer-links">
                    <li><a href="#">Accueil</a></li>
                    <li><a href="#">Nos services</a></li>
                    <li><a href="#">Notre équipe</a></li>
                    <li><a href="#">Tarifs</a></li>
                    <li><a href="#">Blog santé</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h3>Services</h3>
                <ul class="footer-links">
                    <li><a href="#">Médecine générale</a></li>
                    <li><a href="#">Spécialités</a></li>
                    <li><a href="#">Analyses médicales</a></li>
                    <li><a href="#">Imagerie</a></li>
                    <li><a href="#">Urgences</a></li>
                </ul>
            </div>

            <div class="footer-col">
                <h3>Contact</h3>
                <ul class="footer-contact">
                    <li>
                        <i class="fas fa-map-marker-alt"></i>
                        <div>
                            <strong>Adresse</strong><br>
                            sidi taibi <br>
                            75000 kentra, Maroc
        </div>
                    </li>
                    <li>
                        <i class="fas fa-phone-alt"></i>
                        <div>
                            <strong>Téléphone</strong><br>
                            +33 1 45 67 89 10
                        </div>
                    </li>
                    <li>
                        <i class="fas fa-envelope"></i>
                        <div>
                            <strong>Email</strong><br>
contact@santeplus.fr
                        </div>
                    </li>
                </ul>
            </div>
        </div>

        <div class="copyright">
            <p>&copy; 2023 Clinique SantezPlus. Tous droits réservés.</p>
        </div>
    </footer>

    <!-- Login Modal --e
    <div class="modal" id="login-modal">
        <div class="modal-content">
            <div class="modal-header">
<h3>Connexion à votre compte</h3>
                <button class="close-modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="login-form" action="login" method="post">
                    <div class="form-group">
                        <label for="login-email">Adresse email</label>
                        <input type="email" id="login-email" name="email" class="form-control" placeholder="votre@email.com" required>
                    </div>
                    <div class="form-group">
                        <label for="login-password">Mot de passe</label>
                        <input type="password" id="login-password" name="password" class="form-control" placeholder="Votre mot de passe" required>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px;">
                        <i class="fas fa-sign-in-alt"></i> Se connecter
                    </button>
                </form>
                <div class="form-footer">
<p>Pas encore de compte ? <a href="#" id="switch-to-register">Créer un compte</a></p>
                </div>
            </div>
        </div>
    </div>

    <!-- Register Modal -->
    <div class="modal" id="register-modal">
        <div class="modal-content">
            <div class="modal-header">
<h3>Créer un compte patient</h3>
                <button class="close-modal">&times;</button>
            </div>
            <div class="modal-body">
                <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post">
                    <div class="form-group">
                        <label for="register-name">Nom complet</label>
                        <input type="text" id="register-name" name="name" class="form-control" placeholder="Votre nom et prénom" required>
                    </div>
                    <div class="form-group">
                        <label for="register-email">Adresse email</label>
                        <input type="email" id="register-email" name="email" class="form-control" placeholder="votre@email.com" required>
                    </div>
                    <div class="form-group">
                        <label for="register-phone">Téléphone</label>
                        <input type="tel" id="register-phone" name="phone" class="form-control" placeholder="Votre numéro de téléphone" required>
                    </div>
                    <div class="form-group">
                        <label for="register-password">Mot de passe</label>
                        <input type="password" id="register-password" name="password" class="form-control" placeholder="Créez un mot de passe" required>
                    </div>
                    <div class="form-group">
                        <label for="register-confirm">Confirmer le mot de passe</label>
                        <input type="password" id="register-confirm" name="confirmPassword" class="form-control" placeholder="Confirmez votre mot de passe" required>
                    </div>
                    <button type="submit" class="btn btn-primary" style="width: 100%; padding: 15px;">
                        <i class="fas fa-user-plus"></i> Créer mon compte
        </button>
                </form>
                <div class="form-footer">
<p>Déjà un compte ? <a href="#" id="switch-to-login">Se connecter</a></p>
                </div>
            </div>
        </div>
    </div>

<script>
        // État de connexion (à remplacer par la vérification réelle de session)
        let isLoggedIn = false;
let currentUser = null;

// Fonction pour vérifier l'état de connexion (simulée)
function checkLoginStatus() {
    // En production, vous feriez une requête AJAX vers le serveur
    // pour vérifier si l'utilisateur est connecté
            const userData = localStorage.getItem('currentUser');
    if (userData) {
        currentUser = JSON.parse(userData);
        isLoggedIn = true;
    }
    updateUI();
}

// Fonction pour mettre à jour l'interface en fonction de l'état de connexion
function updateUI() {
            const guestActions = document.getElementById('guest-actions');
            const userActions = document.getElementById('user-actions');
            const authRequired = document.getElementById('auth-required');
            const appointmentReady = document.getElementById('appointment-ready');
            const authButtons = document.getElementById('auth-buttons');
            const appointmentButtons = document.getElementById('appointment-buttons');
            const userAvatar = document.getElementById('user-avatar');
            const userName = document.getElementById('user-name');
            const userEmail = document.getElementById('user-email');

    if (isLoggedIn && currentUser) {
        // Mode connecté
        guestActions.style.display = 'none';
        userActions.style.display = 'flex';
        authRequired.style.display = 'none';
        appointmentReady.style.display = 'block';
        authButtons.style.display = 'none';
        appointmentButtons.style.display = 'flex';

        // Mettre à jour les informations utilisateur
        userAvatar.textContent = currentUser.initials || 'JD';
        userName.textContent = currentUser.name || 'Utilisateur';
        userEmail.textContent = currentUser.email || 'utilisateur@email.com';
    } else {
        // Mode non connecté
        guestActions.style.display = 'flex';
        userActions.style.display = 'none';
        authRequired.style.display = 'block';
        appointmentReady.style.display = 'none';
        authButtons.style.display = 'flex';
        appointmentButtons.style.display = 'none';
    }
}

// Fonction de connexion simulée
function loginUser(userData) {
    currentUser = {
            name: userData.name,
            email: userData.email,
            initials: userData.name.split(' ').map(n => n[0]).join('').toUpperCase()
            };
    isLoggedIn = true;
    localStorage.setItem('currentUser', JSON.stringify(currentUser));
    updateUI();
}

// Fonction de déconnexion
function logoutUser() {
    isLoggedIn = false;
    currentUser = null;
    localStorage.removeItem('currentUser');
    updateUI();
}

// Modal functionality
        const loginModal = document.getElementById('login-modal');
        const registerModal = document.getElementById('register-modal');
        const loginButtons = document.querySelectorAll('#login-btn-header, #login-btn-section');
        const registerButtons = document.querySelectorAll('#register-btn-header, #register-btn-section, #cta-register-btn');
        const appointmentButton = document.getElementById('appointment-btn-hero');
        const bookAppointmentBtn = document.getElementById('book-appointment-btn');
        const viewAppointmentsBtn = document.getElementById('view-appointments-btn');
        const logoutBtn = document.getElementById('logout-btn');
        const closeButtons = document.querySelectorAll('.close-modal');
        const switchToRegister = document.getElementById('switch-to-register');
        const switchToLogin = document.getElementById('switch-to-login');

// Open login modal
        loginButtons.forEach(button => {
    button.addEventListener('click', () => {
            loginModal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
            });
});

        // Open register modal
        registerButtons.forEach(button => {
    button.addEventListener('click', () => {
            registerModal.style.display = 'flex';
    document.body.style.overflow = 'hidden';
            });
});

        // Appointment button behavior
        appointmentButton.addEventListener('click', () => {
        if (isLoggedIn) {
// Rediriger vers la page de prise de rendez-vous
alert('Redirection vers la page de prise de rendez-vous...');
// window.location.href = '/patient/appointment';
            } else {
                    // Faire défiler vers la section rendez-vous
                    document.getElementById('appointment').scrollIntoView({ behavior: 'smooth' });
        }
        });

        // Book appointment button (quand connecté)
        bookAppointmentBtn.addEventListener('click', () => {
alert('Redirection vers la page de prise de rendez-vous...');
// window.location.href = '/patient/appointment';
        });

                // View appointments button (quand connecté)
                viewAppointmentsBtn.addEventListener('click', () => {
alert('Redirection vers la page des rendez-vous...');
// window.location.href = '/patient/appointments';
        });

                // Logout button
                logoutBtn.addEventListener('click', () => {
logoutUser();
        });

                // Close modals
                closeButtons.forEach(button => {
    button.addEventListener('click', () => {
            loginModal.style.display = 'none';
    registerModal.style.display = 'none';
    document.body.style.overflow = 'auto';
            });
});

        // Switch between login and register modals
        switchToRegister.addEventListener('click', (e) => {
        e.preventDefault();
loginModal.style.display = 'none';
registerModal.style.display = 'flex';
        });

        switchToLogin.addEventListener('click', (e) => {
        e.preventDefault();
registerModal.style.display = 'none';
loginModal.style.display = 'flex';
        });

        // Close modal when clicking outside
        window.addEventListener('click', (e) => {
        if (e.target === loginModal) {
loginModal.style.display = 'none';
document.body.style.overflow = 'auto';
        }
        if (e.target === registerModal) {
registerModal.style.display = 'none';
document.body.style.overflow = 'auto';
        }
        });

        // Form submissions
        document.getElementById('login-form').addEventListener('submit', (e) => {
        e.preventDefault();
            const email = document.getElementById('login-email').value;
            const password = document.getElementById('login-password').value;

// Simulation de connexion réussie
loginUser({
    name: 'Jean Dupont',
            email: email,
            initials: 'JD'
});

loginModal.style.display = 'none';
document.body.style.overflow = 'auto';

alert('Connexion réussie ! Bienvenue Jean Dupont.');
        });

                document.getElementById('registerForm').addEventListener('submit', (e) => {
        e.preventDefault();
            const name = document.getElementById('register-name').value;
            const email = document.getElementById('register-email').value;
            const phone = document.getElementById('register-phone').value;
            const password = document.getElementById('register-password').value;

// Simulation de création de compte réussie
loginUser({
    name: name,
            email: email,
            initials: name.split(' ').map(n => n[0]).join('').toUpperCase()
});

registerModal.style.display = 'none';
document.body.style.overflow = 'auto';

alert('Compte créé avec succès ! Bienvenue ' + name + '.');
        });

                // Header background on scroll
                window.addEventListener('scroll', function() {
            const header = document.querySelector('header');
    if(window.scrollY > 100) {
        header.style.background = 'rgba(255, 255, 255, 0.95)';
        header.style.backdropFilter = 'blur(10px)';
    } else {
        header.style.background = 'var(--white)';
        header.style.backdropFilter = 'none';
    }
});

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
    checkLoginStatus();
});
    </script>
</body>
</html>