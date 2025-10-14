<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription Patient</title>
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { font-family: 'Inter', sans-serif; background: #f0f4f8; padding: 40px 20px; }
        .container { max-width: 900px; margin: 0 auto; background: white; border-radius: 16px; box-shadow: 0 4px 6px rgba(0,0,0,0.07); overflow: hidden; }
        .header { background: linear-gradient(135deg, #0066cc 0%, #004999 100%); padding: 50px 60px; color: white; display: flex; align-items: center; gap: 30px; }
        .header-content h1 { font-size: 32px; font-weight: 700; margin-bottom: 8px; letter-spacing: -0.5px; }
        .form-container { padding: 50px 60px 60px; }
        .section-title { font-size: 18px; font-weight: 700; color: #1a202c; margin-bottom: 25px; padding-bottom: 12px; border-bottom: 2px solid #e2e8f0; display: flex; align-items: center; gap: 10px; }
        .form-row { display: grid; grid-template-columns: 1fr 1fr; gap: 25px; margin-bottom: 25px; }
        .form-group { display: flex; flex-direction: column; }
        .form-group.full-width { grid-column: 1 / -1; }
        .form-group label { font-size: 14px; font-weight: 600; color: #2d3748; margin-bottom: 8px; }
        .form-group input, .form-group select { width: 100%; padding: 13px 16px; border: 1.5px solid #cbd5e0; border-radius: 8px; font-size: 15px; outline: none; }
        .btn-submit { width: 100%; padding: 16px; background: linear-gradient(135deg, #0066cc 0%, #004999 100%); color: white; border: none; border-radius: 10px; font-size: 16px; font-weight: 600; cursor: pointer; margin-top: 30px; }
        .footer-section { margin-top: 35px; padding-top: 30px; border-top: 1px solid #e2e8f0; text-align: center; font-size: 13px; color: #718096; }
        @media (max-width: 768px) { .form-row { grid-template-columns: 1fr; gap: 20px; } }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <div class="header-content">
                <h1>Inscription Patient</h1>
                <p>Completez le formulaire pour creer votre dossier medical</p>
            </div>
        </div>

        <div class="form-container">
            <form id="registerForm" action="${pageContext.request.contextPath}/register" method="post">
                <div class="section-title">Informations personnelles</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="name">Nom complet *</label>
                        <input type="text" id="name" name="name" placeholder="Ex: Jean Dupont" required>
                    </div>
                    <div class="form-group">
                        <label for="cin">Numero CIN *</label>
                        <input type="text" id="cin" name="cin" placeholder="Ex: AB123456" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="birthDate">Date de naissance *</label>
                        <input type="date" id="birthDate" name="birthDate" required>
                    </div>
                    <div class="form-group">
                        <label for="gender">Sexe *</label>
                        <select id="gender" name="gender" required>
                            <option value="">Sélectionnez votre sexe</option>
                            <option value="Homme">Homme</option>
                            <option value="Femme">Femme</option>
                        </select>
                    </div>
                </div>

                <div class="section-title" style="margin-top: 40px;">Coordonnees</div>
                <div class="form-row">
                    <div class="form-group full-width">
                        <label for="address">Adresse complète *</label>
                        <input type="text" id="address" name="address" placeholder="Ex: 123 Rue de la République, Casablanca" required>
                    </div>
                </div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="phone">Numero de téléphone *</label>
                        <input type="tel" id="phone" name="phone" placeholder="Ex: +212 6 12 34 56 78" required>
                    </div>
                    <div class="form-group">
                        <label for="email">Adresse email *</label>
                        <input type="email" id="email" name="email" placeholder="Ex: vous@exemple.com" required>
                    </div>
                </div>

                <div class="section-title" style="margin-top: 40px;">Informations medicales</div>
                <div class="form-row">
                    <div class="form-group">
                        <label for="bloodType">Groupe sanguin *</label>
                        <select id="bloodType" name="bloodType" required>
                            <option value="">Sélectionnez votre groupe</option>
                            <option value="A+">A+</option>
                            <option value="A-">A-</option>
                            <option value="B+">B+</option>
                            <option value="B-">B-</option>
                            <option value="AB+">AB+</option>
                            <option value="AB-">AB-</option>
                            <option value="O+">O+</option>
                            <option value="O-">O-</option>
                        </select>
                    </div>
                </div>

                <div class="section-title" style="margin-top: 40px;">Securite du compte</div>
                <div class="form-row">
                    <div class="form-group full-width">
                        <label for="password">Mot de passe *</label>
                        <input type="password" id="password" name="password" placeholder="Créez un mot de passe sécurisé" required minlength="8">
                    </div>
                </div>

                <button type="submit" class="btn-submit">Creer mon compte</button>

                <div class="footer-section">
                    Vous avez déjà un compte ? <a href="login.html">Se connecter</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
