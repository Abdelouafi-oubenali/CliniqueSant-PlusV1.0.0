<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rendez-vous Confirmé - Clinique Médicale</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #e8f4f8 0%, #d4e9f0 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            background: white;
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 600px;
            width: 100%;
            border-top: 5px solid #28a745;
        }

        .success-icon {
            font-size: 4rem;
            color: #28a745;
            margin-bottom: 20px;
        }

        h1 {
            color: #28a745;
            margin-bottom: 15px;
            font-size: 2rem;
        }

        .appointment-details {
            background: #f8f9fa;
            padding: 25px;
            border-radius: 10px;
            margin: 25px 0;
            text-align: left;
            border-left: 4px solid #007bff;
        }

        .detail-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 12px;
            padding-bottom: 12px;
            border-bottom: 1px solid #dee2e6;
        }

        .detail-item:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }

        .detail-label {
            font-weight: 600;
            color: #495057;
        }

        .detail-value {
            font-weight: 600;
            color: #28a745;
        }

        .btn {
            display: inline-block;
            padding: 12px 24px;
            background: #007bff;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            margin: 8px;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 123, 255, 0.3);
        }

        .btn-secondary {
            background: #6c757d;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .confirmation-message {
            color: #555;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .contact-info {
            margin-top: 25px;
            padding-top: 20px;
            border-top: 1px solid #e9ecef;
            color: #6c757d;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 30px 20px;
                margin: 10px;
            }

            .detail-item {
                flex-direction: column;
                gap: 5px;
            }

            .btn {
                display: block;
                margin: 8px 0;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="success-icon">✓</div>
        <h1>Rendez-vous Confirmé !</h1>

        <div class="confirmation-message">
            <p>Votre rendez-vous a été pris avec succès.</p>
            <p>Vous recevrez un email de confirmation avec tous les détails.</p>
        </div>

        <!-- Détails du rendez-vous -->
        <div class="appointment-details">
            <div class="detail-item">
                <span class="detail-label">Numéro de confirmation:</span>
                <span class="detail-value">#${appointmentId}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Médecin:</span>
                <span class="detail-value">${doctorName}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Spécialité:</span>
                <span class="detail-value">${specialty}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Date:</span>
                <span class="detail-value">${appointmentDate}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Heure:</span>
                <span class="detail-value">${appointmentTime}</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Durée:</span>
                <span class="detail-value">30 minutes</span>
            </div>
            <div class="detail-item">
                <span class="detail-label">Lieu:</span>
                <span class="detail-value">Étage A, Bureau 102</span>
            </div>
        </div>

        <!-- Boutons d'action -->
        <div>
            <a href="${pageContext.request.contextPath}/appointment" class="btn">
                Prendre un nouveau rendez-vous
            </a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-secondary">
                Retour à l'accueil
            </a>
        </div>

        <!-- Informations de contact -->
        <div class="contact-info">
            <p><strong>📞 Contact:</strong> 01 23 45 67 89 | <strong>📧 Email:</strong> contact@clinique.com</p>
            <p><small>Présentez-vous 10 minutes avant l'heure du rendez-vous</small></p>
        </div>
    </div>

    <script>
        // Animation au chargement
        document.addEventListener('DOMContentLoaded', function() {
            // Effet de pulse sur l'icône
            const icon = document.querySelector('.success-icon');
            setTimeout(() => {
                icon.style.transform = 'scale(1.2)';
                setTimeout(() => {
                    icon.style.transform = 'scale(1)';
                }, 300);
            }, 500);
        });
    </script>
</body>
</html>