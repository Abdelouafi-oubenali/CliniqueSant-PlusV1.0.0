<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mes Rendez-vous - Clinique SantéPlus</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
        .appointments-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
        }

        .page-title {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title h1 {
            color: #2c3e50;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
        }

        .page-title p {
            color: #7f8c8d;
            font-size: 1.1rem;
        }

        .appointments-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 2px solid #ecf0f1;
        }

        .appointments-actions .btn {
            margin-left: 0.5rem;
        }

        .appointments-grid {
            display: grid;
            gap: 1.5rem;
            margin-bottom: 3rem;
        }

        .appointment-card {
            background: white;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
            border-left: 4px solid #3498db;
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .appointment-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 15px rgba(0,0,0,0.15);
        }

        .appointment-card.cancelled {
            border-left-color: #e74c3c;
            opacity: 0.7;
        }

        .appointment-card.completed {
            border-left-color: #27ae60;
        }

        .appointment-card.upcoming {
            border-left-color: #f39c12;
        }

        .appointment-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .appointment-info h3 {
            color: #2c3e50;
            margin-bottom: 0.5rem;
            font-size: 1.3rem;
        }

        .appointment-doctor {
            color: #7f8c8d;
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .appointment-specialty {
            color: #95a5a6;
            font-size: 0.9rem;
        }

        .appointment-status {
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 600;
            text-transform: uppercase;
        }

        .status-upcoming {
            background-color: #fff3cd;
            color: #856404;
        }

        .status-completed {
            background-color: #d1edff;
            color: #0c5460;
        }

        .status-cancelled {
            background-color: #f8d7da;
            color: #721c24;
        }

        .appointment-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
            padding: 1rem;
            background-color: #f8f9fa;
            border-radius: 8px;
        }

        .detail-item {
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .detail-item i {
            color: #3498db;
            width: 16px;
        }

        .appointment-actions {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.85rem;
        }

        .no-appointments {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0,0,0,0.1);
        }

        .no-appointments i {
            font-size: 4rem;
            color: #bdc3c7;
            margin-bottom: 1rem;
        }

        .no-appointments h3 {
            color: #7f8c8d;
            margin-bottom: 1rem;
        }

        .appointment-notes {
            margin-top: 1rem;
            padding: 1rem;
            background-color: #fff3cd;
            border-left: 4px solid #ffc107;
            border-radius: 4px;
        }

        .appointment-notes h4 {
            color: #856404;
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .appointment-notes p {
            color: #856404;
            font-size: 0.85rem;
            margin: 0;
        }

        @media (max-width: 768px) {
            .appointments-container {
                padding: 1rem;
            }

            .appointments-header {
                flex-direction: column;
                gap: 1rem;
                align-items: stretch;
            }

            .appointments-actions {
                display: flex;
                flex-direction: column;
                gap: 0.5rem;
            }

            .appointments-actions .btn {
                margin-left: 0;
                text-align: center;
            }

            .appointment-header {
                flex-direction: column;
                gap: 1rem;
            }

            .appointment-details {
                grid-template-columns: 1fr;
            }

            .appointment-actions {
                justify-content: stretch;
            }

            .appointment-actions .btn {
                flex: 1;
                text-align: center;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/includes/header.jsp" />

<div class="appointments-container">
    <!-- Section Debug -->
    <div style="background: #e3f2fd; padding: 15px; margin-bottom: 20px; border-radius: 5px;">
        <h4> Informations de débogage:</h4>
        <p><strong>ID utilisateur :</strong> ${userId}</p>
        <p><strong>Liste des rendez-vous :</strong> ${not empty appointments}</p>
        <p><strong>Nombre de rendez-vous :</strong> ${appointments.size()}</p>

        <c:if test="${not empty error}">
            <p style="color: red;"><strong>Erreur :</strong> ${error}</p>
        </c:if>
    </div>

    <!-- En-tête de la page -->
    <div class="page-title">
        <h1><i class="fas fa-calendar-alt"></i> Mes Rendez-vous</h1>
        <p>Gérez et consultez l'ensemble de vos rendez-vous médicaux</p>
    </div>

    <!-- En-tête des actions -->
    <div class="appointments-header">
        <div class="appointments-info">
            <h2>Vos consultations</h2>
            <p class="text-muted">${not empty appointments ? appointments.size() : 0} rendez-vous trouvés</p>
        </div>
        <div class="appointments-actions">
            <a href="${pageContext.request.contextPath}/patient/appointment" class="btn btn-primary">
                <i class="fas fa-calendar-plus"></i> Nouveau rendez-vous
            </a>
            <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-outline">
                <i class="fas fa-arrow-left"></i> Retour au tableau de bord
            </a>
        </div>
    </div>

    <!-- Liste des rendez-vous -->
    <c:choose>
        <c:when test="${not empty appointments}">
            <div class="appointments-grid">
                <c:forEach var="appointment" items="${appointments}">
                    <div class="appointment-card ${appointment.status}">
                        <div class="appointment-header">
                            <div class="appointment-info">
                                <h3>Consultation ${appointment.type}</h3>
                                <div class="appointment-doctor">
                                    <i class="fas fa-user-md"></i> ${appointment.doctorName}
                                </div>
                                <div class="appointment-specialty">
                                    ${appointment.specialty}
                                </div>
                            </div>
                            <div class="appointment-status status-${appointment.status}">
                                <c:choose>
                                    <c:when test="${appointment.status == 'upcoming'}">À VENIR</c:when>
                                    <c:when test="${appointment.status == 'completed'}">TERMINÉ</c:when>
                                    <c:when test="${appointment.status == 'cancelled'}">ANNULÉ</c:when>
                                    <c:otherwise>${appointment.status}</c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <div class="appointment-details">
                            <div class="detail-item">
                                <i class="fas fa-calendar-day"></i>
                                <span><strong>Date :</strong> ${appointment.date}</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-clock"></i>
                                <span><strong>Heure :</strong> ${appointment.time}</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-map-marker-alt"></i>
                                <span><strong>Lieu :</strong> ${appointment.location}</span>
                            </div>
                            <div class="detail-item">
                                <i class="fas fa-stethoscope"></i>
                                <span><strong>Type :</strong> ${appointment.type}</span>
                            </div>
                        </div>

                        <c:if test="${not empty appointment.notes}">
                            <div class="appointment-notes">
                                <h4><i class="fas fa-sticky-note"></i> Notes du médecin :</h4>
                                <p>${appointment.notes}</p>
                            </div>
                        </c:if>

                        <div class="appointment-actions">
                            <c:if test="${appointment.status == 'upcoming'}">
                                <button class="btn btn-warning btn-sm" onclick="modifyAppointment(${appointment.id})">
                                    <i class="fas fa-edit"></i> Modifier
                                </button>
                                <button class="btn btn-danger btn-sm" onclick="cancelAppointment(${appointment.id})">
                                    <i class="fas fa-times"></i> Annuler
                                </button>
                            </c:if>
                            <button class="btn btn-info btn-sm" onclick="viewDetails(${appointment.id})">
                                <i class="fas fa-eye"></i> Détails
                            </button>
                            <c:if test="${appointment.status == 'completed'}">
                                <button class="btn btn-success btn-sm" onclick="downloadReport(${appointment.id})">
                                    <i class="fas fa-download"></i> Compte-rendu
                                </button>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:when>
        <c:otherwise>
            <!-- Aucun rendez-vous -->
            <div class="no-appointments">
                <i class="fas fa-calendar-times"></i>
                <h3>Aucun rendez-vous trouvé</h3>
                <p>Vous n'avez pas encore de rendez-vous programmé.</p>
                <p class="text-muted">Prenez votre premier rendez-vous dès maintenant !</p>
                <a href="${pageContext.request.contextPath}/patient/appointment" class="btn btn-primary">
                    <i class="fas fa-calendar-plus"></i> Prendre un rendez-vous
                </a>
            </div>
        </c:otherwise>
    </c:choose>
</div>

<jsp:include page="/includes/footer.jsp" />

<script>
    // Fonctions pour gérer les actions sur les rendez-vous
    function viewDetails(appointmentId) {
        console.log('Voir détails du rendez-vous:', appointmentId);
        alert('Détails du rendez-vous ' + appointmentId);
    }

    function modifyAppointment(appointmentId) {
        console.log('Modifier le rendez-vous:', appointmentId);
        if(confirm('Voulez-vous modifier ce rendez-vous ?')) {
            window.location.href = '${pageContext.request.contextPath}/patient/appointment/edit?id=' + appointmentId;
        }
    }

    function cancelAppointment(appointmentId) {
        console.log('Annuler le rendez-vous:', appointmentId);
        if(confirm('Êtes-vous sûr de vouloir annuler ce rendez-vous ?')) {
            fetch('${pageContext.request.contextPath}/api/appointments/' + appointmentId + '/cancel', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                }
            })
            .then(response => response.json())
            .then(data => {
                if(data.success) {
                    alert('Rendez-vous annulé avec succès');
                    location.reload();
                } else {
                    alert('Erreur lors de l\'annulation: ' + data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('Erreur lors de l\'annulation');
            });
        }
    }

    function downloadReport(appointmentId) {
        console.log('Télécharger compte-rendu:', appointmentId);
        window.location.href = '${pageContext.request.contextPath}/patient/appointments/' + appointmentId + '/report';
    }
</script>

</body>
</html>