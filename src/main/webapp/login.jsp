<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Connexion - Espace Médical</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #0ea5e9 0%, #06b6d4 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
            overflow: hidden;
        }

        .login-container {
            display: flex;
            background: white;
            border-radius: 20px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            overflow: hidden;
            max-width: 900px;
            width: 100%;
            animation: slideIn 0.6s ease-out;
        }

        @keyframes slideIn {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .image-section {
            flex: 1;
            background: linear-gradient(135deg, #0ea5e9 0%, #06b6d4 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 40px;
            position: relative;
            overflow: hidden;
        }

        .doctor-image {
            width: 280px;
            height: 280px;
            border-radius: 50%;
            background: white;
            padding: 20px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            animation: rotate 20s linear infinite;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }

        @keyframes rotate {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(360deg);
            }
        }

        .doctor-icon {
            font-size: 180px;
            animation: counterRotate 20s linear infinite;
        }

        @keyframes counterRotate {
            from {
                transform: rotate(0deg);
            }
            to {
                transform: rotate(-360deg);
            }
        }

        .welcome-text {
            margin-top: 30px;
            text-align: center;
            color: white;
        }

        .welcome-text h3 {
            font-size: 26px;
            margin-bottom: 10px;
        }

        .welcome-text p {
            font-size: 15px;
            opacity: 0.9;
        }

        .floating-icons {
            position: absolute;
            font-size: 40px;
            opacity: 0.2;
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% {
                transform: translateY(0px);
            }
            50% {
                transform: translateY(-20px);
            }
        }

        .icon1 { top: 10%; left: 10%; animation-delay: 0s; }
        .icon2 { top: 20%; right: 15%; animation-delay: 1s; }
        .icon3 { bottom: 15%; left: 15%; animation-delay: 2s; }
        .icon4 { bottom: 10%; right: 10%; animation-delay: 1.5s; }

        .form-section {
            flex: 1;
            padding: 60px 50px;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .form-header {
            margin-bottom: 40px;
        }

        .form-header h2 {
            font-size: 32px;
            color: #1e293b;
            margin-bottom: 10px;
        }

        .form-header p {
            color: #64748b;
            font-size: 15px;
        }

        .form-group {
            margin-bottom: 25px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            color: #334155;
            font-weight: 600;
            font-size: 14px;
        }

        .input-wrapper {
            position: relative;
        }

        .input-icon {
            position: absolute;
            left: 15px;
            top: 50%;
            transform: translateY(-50%);
            color: #94a3b8;
            font-size: 18px;
        }

        .form-group input {
            width: 100%;
            padding: 14px 15px 14px 45px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 15px;
            transition: all 0.3s ease;
            outline: none;
        }

        .form-group input:focus {
            border-color: #0ea5e9;
            box-shadow: 0 0 0 3px rgba(14, 165, 233, 0.1);
        }

        .remember-forgot {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
            font-size: 14px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            color: #475569;
        }

        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            cursor: pointer;
        }

        .forgot-password {
            color: #0ea5e9;
            text-decoration: none;
            font-weight: 600;
        }

        .forgot-password:hover {
            text-decoration: underline;
        }

        .btn-login {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #0ea5e9 0%, #06b6d4 100%);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(14, 165, 233, 0.3);
        }

        .btn-login:active {
            transform: translateY(0);
        }

        .signup-link {
            text-align: center;
            margin-top: 25px;
            color: #64748b;
            font-size: 14px;
        }

        .signup-link a {
            color: #0ea5e9;
            text-decoration: none;
            font-weight: 600;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }

        @media (max-width: 768px) {
            .login-container {
                flex-direction: column;
            }

            .image-section {
                padding: 30px;
            }

            .doctor-image {
                width: 200px;
                height: 200px;
            }

            .doctor-icon {
                font-size: 120px;
            }

            .form-section {
                padding: 40px 30px;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="image-section">
            <div class="floating-icons icon1"></div>
            <div class="floating-icons icon2"></div>
            <div class="floating-icons icon3"></div>
            <div class="floating-icons icon4"></div>

            <div class="doctor-image">
            </div>

            <div class="welcome-text">
                <h3>Espace Medical</h3>
                <p>Connectez-vous pour acceder à votre compte</p>
            </div>
        </div>

        <div class="form-section">
            <div class="form-header">
                <h2>Connexion</h2>
                <p>Bienvenue ! Veuillez vous connecter</p>
            </div>

            <form action="login" method="post">
                <div class="form-group">
                    <label for="email">Email</label>
                    <div class="input-wrapper">
                        <span class="input-icon"></span>
                        <input type="email" id="email" name="email" placeholder="vous@exemple.com" required>
                    </div>
                </div>

                <div class="form-group">
                    <label for="password">Mot de passe</label>
                    <div class="input-wrapper">
                        <span class="input-icon"></span>
                        <input type="password" id="password" name="password" placeholder="Entrez votre mot de passe" required>
                    </div>
                </div>

                <div class="remember-forgot">
                    <label class="remember-me">
                        <input type="checkbox" name="remember">
                        <span>Se souvenir de moi</span>
                    </label>
                    <a href="#" class="forgot-password">Mot de passe oublié ?</a>
                </div>

                <button type="submit" class="btn-login">Se connecter</button>

                <div class="signup-link">
                    Pas encore de compte ? <a href="register.jsp">S'inscrire</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>