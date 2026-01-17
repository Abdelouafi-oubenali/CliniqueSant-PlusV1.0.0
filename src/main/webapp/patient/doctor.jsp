<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choisir un médecin - Clinique SantePlus</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        /* Tous les styles précédents restent identiques */
        .appointment-steps {
            background: white;
            padding: 40px 0;
            border-bottom: 1px solid #e9ecef;
        }

        .steps-container {
            display: flex;
            justify-content: center;
            margin-bottom: 40px;
            position: relative;
        }

        .steps-container::before {
            content: '';
            position: absolute;
            top: 25px;
            left: 50%;
            transform: translateX(-50%);
            width: 80%;
            height: 2px;
            background-color: #e9ecef;
            z-index: 1;
        }

        .step {
            display: flex;
            flex-direction: column;
            align-items: center;
            position: relative;
            z-index: 2;
            width: 150px;
        }

        .step-number {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            background-color: #e9ecef;
            color: #6c757d;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: bold;
            font-size: 1.2rem;
            margin-bottom: 10px;
            border: 3px solid white;
            transition: all 0.3s ease;
        }

        .step.active .step-number {
            background-color: #007bff;
            color: white;
        }

        .step.completed .step-number {
            background-color: #28a745;
            color: white;
        }

        .step-label {
            font-size: 0.9rem;
            color: #6c757d;
            text-align: center;
            font-weight: 500;
        }

        .step.active .step-label {
            color: #007bff;
            font-weight: 600;
        }

        .step.completed .step-label {
            color: #28a745;
        }

        .doctor-selection {
            padding: 60px 0;
            background: #f8f9fa;
        }

        .specialty-filter {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-bottom: 30px;
            flex-wrap: wrap;
        }

        .filter-btn {
            padding: 10px 20px;
            border: 2px solid #e9ecef;
            background: white;
            border-radius: 25px;
            cursor: pointer;
            transition: all 0.3s ease;
            font-weight: 500;
        }

        .filter-btn:hover,
        .filter-btn.active {
            background: #007bff;
            color: white;
            border-color: #007bff;
        }

        .doctors-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 30px;
            margin-bottom: 40px;
        }

        .doctor-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            transition: all 0.3s ease;
        }

        .doctor-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.12);
        }

        .doctor-image {
            height: 200px;
            background-size: cover;
            background-position: center;
            position: relative;
        }

        .doctor-info {
            padding: 25px;
        }

        .doctor-name {
            font-size: 1.3rem;
            color: #2c3e50;
            margin-bottom: 5px;
        }

        .doctor-specialty {
            color: #007bff;
            font-weight: 600;
            margin-bottom: 10px;
            display: block;
        }

        .doctor-rating {
            display: flex;
            align-items: center;
            gap: 5px;
            margin-bottom: 15px;
        }

        .stars {
            color: #ffc107;
        }

        .rating-value {
            font-weight: 600;
            color: #6c757d;
        }

        .doctor-details {
            margin-bottom: 20px;
        }

        .detail {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 8px;
            font-size: 0.9rem;
            color: #6c757d;
        }

        .detail i {
            width: 16px;
            color: #007bff;
        }

        /* Styles pour les disponibilités */
        .availability-section {
            margin: 20px 0;
            padding: 15px;
            background: #f8f9fa;
            border-radius: 10px;
            border-left: 4px solid #28a745;
        }

        .availability-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 10px;
        }

        .availability-header h4 {
            margin: 0;
            color: #2c3e50;
            font-size: 1rem;
        }

        .availability-header i {
            color: #28a745;
        }

        .availability-dates {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-bottom: 10px;
        }

        .date-range {
            background: white;
            padding: 8px 12px;
            border-radius: 6px;
            border: 1px solid #e9ecef;
            font-size: 0.85rem;
        }

        .date-range .label {
            font-weight: 600;
            color: #495057;
            margin-right: 5px;
        }

        .date-range .value {
            color: #28a745;
            font-weight: 500;
        }

        .no-availability {
            text-align: center;
            padding: 15px;
            color: #6c757d;
            background: #fff3cd;
            border-radius: 6px;
            border: 1px solid #ffeaa7;
        }

        .no-availability i {
            margin-right: 8px;
            color: #f39c12;
        }

        .select-doctor-btn {
            width: 100%;
            padding: 12px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
            text-decoration: none;
        }

        .select-doctor-btn:hover {
            background: #0056b3;
            transform: translateY(-2px);
        }

        .select-doctor-btn:disabled {
            background: #6c757d;
            cursor: not-allowed;
            transform: none;
        }

        @media (max-width: 768px) {
            .steps-container::before {
                width: 90%;
            }

            .step {
                width: 120px;
            }

            .doctors-grid {
                grid-template-columns: 1fr;
            }

            .availability-dates {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/includes/header.jsp" />

<!-- Étapes du rendez-vous -->
<section class="appointment-steps">
    <div class="section-container">
        <div class="steps-container">
            <div class="step active" id="step1">
                <div class="step-number">1</div>
                <div class="step-label">Choisir un médecin</div>
            </div>
            <div class="step" id="step2">
                <div class="step-number">2</div>
                <div class="step-label">Sélectionner une date</div>
            </div>
            <div class="step" id="step3">
                <div class="step-number">3</div>
                <div class="step-label">Confirmer le rendez-vous</div>
            </div>
        </div>
    </div>
</section>

<!-- Section de sélection du médecin -->
<section class="doctor-selection" id="doctorSelection">
    <div class="section-container">
        <div class="section-title">
            <h2>Choisissez votre médecin</h2>
            <p>Sélectionnez un professionnel de santé selon votre besoin</p>
        </div>

        <!-- Filtres par spécialité -->
        <div class="specialty-filter">
            <button class="filter-btn active" data-specialty="all">Toutes les spécialités</button>
            <c:forEach var="specialty" items="${specialties}">
                <button class="filter-btn" data-specialty="${specialty.name}">${specialty.name}</button>
            </c:forEach>
        </div>

        <!-- Grille des médecins -->
        <div class="doctors-grid">
            <c:forEach var="doctor" items="${doctors}">
                <div class="doctor-card" data-specialty="${doctor.specialty.name}">
                    <div class="doctor-image" style="background-image: url('https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80')"></div>
                    <div class="doctor-info">
                        <h3 class="doctor-name">${doctor.title} ${doctor.user.name}</h3>
                        <span class="doctor-specialty">${doctor.specialty.name}</span>
                        <div class="doctor-rating">
                            <div class="stars">
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star"></i>
                                <i class="fas fa-star-half-alt"></i>
                            </div>
                            <span class="rating-value">4.5</span>
                        </div>
                        <div class="doctor-details">
                            <div class="detail">
                                <i class="fas fa-graduation-cap"></i>
                                <span>Matricule: ${doctor.matricule}</span>
                            </div>
                            <div class="detail">
                                <i class="fas fa-map-marker-alt"></i>
                                <span>Étage A, Bureau 102</span>
                            </div>
                            <div class="detail">
                                <i class="fas fa-clock"></i>
                                <span>Consultation: 30 min</span>
                            </div>
                        </div>

                        <!-- Section des disponibilités -->
                        <div class="availability-section">
                            <div class="availability-header">
                                <i class="fas fa-calendar-check"></i>
                                <h4>Disponibilités</h4>
                            </div>

                            <c:set var="doctorAvails" value="${doctorAvailabilities[doctor.id]}" />
                            <c:choose>
                                <c:when test="${not empty doctorAvails}">
                                    <div class="availability-dates">
                                        <c:forEach var="availability" items="${doctorAvails}">
                                            <div class="date-range">
                                                <span class="label">Période:</span>
                                                <span class="value">
                                                    ${availability.validFrom} - ${availability.validTo}
                                                </span>
                                            </div>
                                            <div class="date-range">
                                                <span class="label">Horaires:</span>
                                                <span class="value">
                                                    ${availability.startTime} - ${availability.endTime}
                                                </span>
                                            </div>
                                        </c:forEach>
                                    </div>
                                    <div style="font-size: 0.85rem; color: #28a745;">
                                        <i class="fas fa-check-circle"></i>
                                        Ce médecin a des créneaux disponibles
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="no-availability">
                                        <i class="fas fa-calendar-times"></i>
                                        Aucune disponibilité programmée pour le moment
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <!-- Bouton pour voir les disponibilités détaillées -->
                        <c:choose>
                            <c:when test="${not empty doctorAvailabilities[doctor.id]}">
                                <a href="${pageContext.request.contextPath}/appointment/availability?doctorId=${doctor.id}"
                                   class="select-doctor-btn">
                                    <i class="fas fa-calendar-check"></i> Voir les créneaux disponibles
                                </a>
                            </c:when>
                            <c:otherwise>
                                <button class="select-doctor-btn" disabled>
                                    <i class="fas fa-calendar-times"></i> Aucune disponibilité
                                </button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</section>

<jsp:include page="/includes/footer.jsp" />

<script>
    // Filtrage des médecins par spécialité
    document.addEventListener('DOMContentLoaded', function() {
        const filterButtons = document.querySelectorAll('.filter-btn');
        const doctorCards = document.querySelectorAll('.doctor-card');

        filterButtons.forEach(button => {
            button.addEventListener('click', function() {
                // Retirer la classe active de tous les boutons
                filterButtons.forEach(btn => btn.classList.remove('active'));

                // Ajouter la classe active au bouton cliqué
                this.classList.add('active');

                const specialty = this.getAttribute('data-specialty');

                // Filtrer les médecins
                doctorCards.forEach(card => {
                    if (specialty === 'all' || card.getAttribute('data-specialty') === specialty) {
                        card.style.display = 'block';
                    } else {
                        card.style.display = 'none';
                    }
                });
            });
        });
    });
</script>

</body>
</html>