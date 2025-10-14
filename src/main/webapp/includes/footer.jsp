<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Footer seulement -->
<footer>
    <div class="footer-container">
        <div class="footer-col">
            <h3>Clinique SantéPlus</h3>
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
                <li><a href="${pageContext.request.contextPath}/">Accueil</a></li>
                <li><a href="${pageContext.request.contextPath}/services">Nos services</a></li>
                <li><a href="${pageContext.request.contextPath}/doctors">Notre équipe</a></li>
                <li><a href="${pageContext.request.contextPath}/pricing">Tarifs</a></li>
                <li><a href="${pageContext.request.contextPath}/blog">Blog santé</a></li>
            </ul>
        </div>

        <div class="footer-col">
            <h3>Services</h3>
            <ul class="footer-links">
                <li><a href="${pageContext.request.contextPath}/service/general-medicine">Médecine générale</a></li>
                <li><a href="${pageContext.request.contextPath}/service/specialties">Spécialités</a></li>
                <li><a href="${pageContext.request.contextPath}/service/medical-tests">Analyses médicales</a></li>
                <li><a href="${pageContext.request.contextPath}/service/medical-imaging">Imagerie</a></li>
                <li><a href="${pageContext.request.contextPath}/service/emergency">Urgences</a></li>
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
        <p>&copy; 2023 Clinique SantéPlus. Tous droits réservés.</p>
    </div>
</footer>

<!-- Modals -->
<div class="modal" id="login-modal">
    <div class="modal-content">
        <div class="modal-header">
            <h3>Connexion à votre compte</h3>
            <button class="close-modal">&times;</button>
        </div>
        <div class="modal-body">
            <form id="login-form" action="${pageContext.request.contextPath}/login" method="post">
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

<!-- CHARGEMENT DU JAVASCRIPT -->
<script src="${pageContext.request.contextPath}/assets/js/main.js"></script>