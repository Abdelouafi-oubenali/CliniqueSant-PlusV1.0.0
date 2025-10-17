<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Disponibilités - ${doctor.title} ${doctor.user.name}</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/assets/css/availability.css" rel="stylesheet">
    <style>
        .availability-container {
            padding: 60px 0;
            background: #f8f9fa;
            min-height: 80vh;
        }

        .doctor-header {
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .doctor-avatar {
            width: 100px;
            height: 100px;
            border-radius: 50%;
            background-size: cover;
            background-position: center;
            border: 4px solid #007bff;
        }

        .doctor-info h1 {
            margin: 0 0 10px 0;
            color: #2c3e50;
        }

        .doctor-info p {
            margin: 5px 0;
            color: #6c757d;
        }

        .back-btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: #6c757d;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }

        .back-btn:hover {
            background: #5a6268;
            transform: translateY(-2px);
        }

        .calendar-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
            margin-bottom: 30px;
        }

        .days-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .day-card {
            background: #f8f9fa;
            border-radius: 10px;
            padding: 20px;
            border-left: 4px solid #28a745;
        }

        .day-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
        }

        .day-date {
            font-weight: 600;
            color: #2c3e50;
            font-size: 1.1rem;
        }

        .day-name {
            background: #007bff;
            color: white;
            padding: 4px 8px;
            border-radius: 4px;
            font-size: 0.8rem;
            font-weight: 600;
        }

        .time-slots-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(120px, 1fr));
            gap: 10px;
        }

        .time-slot {
            padding: 10px;
            text-align: center;
            border-radius: 6px;
            transition: all 0.3s ease;
            font-size: 0.9rem;
            border: 1px solid #e9ecef;
        }

        .time-slot.available {
            background: #e8f5e8;
            color: #2e7d32;
            border-color: #c8e6c9;
            cursor: pointer;
        }

        .time-slot.available:hover {
            background: #c8e6c9;
            transform: translateY(-2px);
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }

        .time-slot.past {
            background: #f8f9fa !important;
            color: #6c757d !important;
            cursor: not-allowed !important;
            border: 1px solid #dee2e6 !important;
            opacity: 0.6;
        }

        .time-slot.booked {
            background: #ffe6e6 !important;
            color: #dc3545 !important;
            border-color: #f5c6cb !important;
            cursor: not-allowed !important;
            opacity: 0.7;
        }

        .time-slot.selected {
            background: #007bff !important;
            color: white !important;
            border-color: #0056b3 !important;
            transform: scale(1.05);
        }

        .no-availability {
            text-align: center;
            padding: 40px;
            color: #6c757d;
        }

        .no-availability i {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        .confirmation-section {
            display: none;
            background: white;
            border-radius: 15px;
            padding: 30px;
            margin-top: 30px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.08);
        }

        .appointment-summary {
            margin-bottom: 20px;
        }

        .summary-item {
            display: flex;
            justify-content: space-between;
            margin-bottom: 15px;
            padding-bottom: 15px;
            border-bottom: 1px solid #f8f9fa;
        }

        .summary-label {
            color: #6c757d;
        }

        .summary-value {
            font-weight: 600;
            color: #2c3e50;
        }

        .action-buttons {
            display: flex;
            gap: 15px;
            justify-content: center;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 0.95rem;
            font-weight: 600;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: #007bff;
            color: white;
        }

        .btn-primary:hover {
            background: #0056b3;
        }

        .btn-success {
            background: #28a745;
            color: white;
        }

        .btn-success:hover {
            background: #218838;
        }

        .btn-outline {
            background: transparent;
            color: #007bff;
            border: 2px solid #007bff;
        }

        .btn-outline:hover {
            background: #007bff;
            color: white;
        }

        @media (max-width: 768px) {
            .time-slots-grid {
                grid-template-columns: repeat(auto-fit, minmax(100px, 1fr));
            }

            .doctor-header {
                flex-direction: column;
                text-align: center;
            }

            .action-buttons {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>

<jsp:include page="/includes/header.jsp" />

<section class="availability-container">

    <!-- Message d'erreur pour rendez-vous avec le même médecin le même jour -->
    <c:if test="${param.error == 'already_has_appointment_same_doctor'}">
        <div class="alert alert-danger text-center fw-bold fs-5 border-3 shadow-sm"
             style="background-color: #f8d7da; border-color: #dc3545;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            Impossible de réserver un rendez-vous. Vous avez déjà un rendez-vous programmé avec ce médecin pour cette date.
        </div>
    </c:if>

    <!-- Message d'erreur pour rendez-vous le même jour (tous médecins) -->
    <c:if test="${param.error == 'already_has_appointment_today'}">
        <div class="alert alert-danger text-center fw-bold fs-5 border-3 shadow-sm"
             style="background-color: #f8d7da; border-color: #dc3545; color: red ;">
            <i class="bi bi-exclamation-triangle-fill me-2"></i>
            Impossible de réserver un rendez-vous. Vous avez déjà un rendez-vous programmé pour cette date.
        </div>
    </c:if>

    <!-- === CSS POUR CENTRER LES MESSAGES D'ERREUR === -->
    <style>
    .alert {
      display: flex;
      justify-content: center; /* Centre horizontalement le contenu */
      align-items: center;
      margin: 20px auto;
      max-width: 900px;
      border-radius: 12px;
      padding: 16px 20px;
      font-weight: bold;
      font-size: 1.1rem;
      box-shadow: 0 2px 8px rgba(0,0,0,0.1);
    }
    </style>

    <div class="section-container">
        <!-- Bouton retour -->
        <a href="${pageContext.request.contextPath}/appointment" class="back-btn">
            <i class="fas fa-arrow-left"></i> Retour aux médecins
        </a>

        <!-- En-tête du médecin -->
        <div class="doctor-header">
            <div class="doctor-avatar" style="background-image: url('https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=800&q=80')"></div>
            <div class="doctor-info">
                <h1>${doctor.title} ${doctor.user.name}</h1>
                <p><strong>Spécialité:</strong> ${doctor.specialty.name}</p>
                <p><strong>Matricule:</strong> ${doctor.matricule}</p>
                <p><strong>Localisation:</strong> Étage A, Bureau 102</p>
            </div>
        </div>

        <!-- Section calendrier -->
        <div class="calendar-section">
            <h3 style="margin-bottom: 20px; color: #2c3e50;">
                <i class="fas fa-calendar-alt"></i> Créneaux disponibles
            </h3>

            <c:choose>
                <c:when test="${not empty availabilities}">
                    <div class="days-list">
                        <c:forEach var="availability" items="${availabilities}">
                            <div class="day-card">
                                <div class="day-header">
                                    <span class="day-date">
                                        <!-- Formatage manuel pour LocalDate -->
                                        <c:set var="dayOfWeek" value="${availability.day.dayOfWeek.value}" />
                                        <c:set var="dayOfMonth" value="${availability.day.dayOfMonth}" />
                                        <c:set var="month" value="${availability.day.monthValue}" />
                                        <c:set var="year" value="${availability.day.year}" />

                                        <c:choose>
                                            <c:when test="${dayOfWeek == 1}">Lundi</c:when>
                                            <c:when test="${dayOfWeek == 2}">Mardi</c:when>
                                            <c:when test="${dayOfWeek == 3}">Mercredi</c:when>
                                            <c:when test="${dayOfWeek == 4}">Jeudi</c:when>
                                            <c:when test="${dayOfWeek == 5}">Vendredi</c:when>
                                            <c:when test="${dayOfWeek == 6}">Samedi</c:when>
                                            <c:when test="${dayOfWeek == 7}">Dimanche</c:when>
                                        </c:choose>
                                        ${dayOfMonth}
                                        <c:choose>
                                            <c:when test="${month == 1}">janvier</c:when>
                                            <c:when test="${month == 2}">février</c:when>
                                            <c:when test="${month == 3}">mars</c:when>
                                            <c:when test="${month == 4}">avril</c:when>
                                            <c:when test="${month == 5}">mai</c:when>
                                            <c:when test="${month == 6}">juin</c:when>
                                            <c:when test="${month == 7}">juillet</c:when>
                                            <c:when test="${month == 8}">août</c:when>
                                            <c:when test="${month == 9}">septembre</c:when>
                                            <c:when test="${month == 10}">octobre</c:when>
                                            <c:when test="${month == 11}">novembre</c:when>
                                            <c:when test="${month == 12}">décembre</c:when>
                                        </c:choose>
                                        ${year}
                                    </span>
                                    <span class="day-name">
                                        <c:choose>
                                            <c:when test="${dayOfWeek == 1}">LUNDI</c:when>
                                            <c:when test="${dayOfWeek == 2}">MARDI</c:when>
                                            <c:when test="${dayOfWeek == 3}">MERCREDI</c:when>
                                            <c:when test="${dayOfWeek == 4}">JEUDI</c:when>
                                            <c:when test="${dayOfWeek == 5}">VENDREDI</c:when>
                                            <c:when test="${dayOfWeek == 6}">SAMEDI</c:when>
                                            <c:when test="${dayOfWeek == 7}">DIMANCHE</c:when>
                                        </c:choose>
                                    </span>
                                </div>

                                <!-- Afficher directement les créneaux horaires -->
                                <div class="time-slots-grid">
                                    <c:forEach var="hour" begin="${availability.startTime.hour}" end="${availability.endTime.hour - 1}">
                                        <c:set var="timeSlot1" value="${hour}:00" />
                                        <c:set var="timeSlot2" value="${hour}:30" />

                                        <!-- Vérifier si le créneau est déjà réservé -->
                                        <c:set var="isBooked1" value="false" />
                                        <c:set var="isBooked2" value="false" />

                                        <c:forEach var="appointment" items="${existingAppointments}">
                                            <c:if test="${appointment.appointmentDate eq availability.day}">
                                                <c:if test="${appointment.startTime.toString() eq timeSlot1}">
                                                    <c:set var="isBooked1" value="true" />
                                                </c:if>
                                                <c:if test="${hour < availability.endTime.hour - 1 and appointment.startTime.toString() eq timeSlot2}">
                                                    <c:set var="isBooked2" value="true" />
                                                </c:if>
                                            </c:if>
                                        </c:forEach>

                                        <!-- Créneau à l'heure pile -->
                                        <div class="time-slot ${isBooked1 ? 'booked' : 'available'}"
                                             data-date="${availability.day}"
                                             data-time="${timeSlot1}"
                                             <c:if test="${not isBooked1}">
                                                 onclick="selectTimeSlot(this, '${availability.day}', '${timeSlot1}')"
                                             </c:if>>
                                            ${timeSlot1}
                                            <c:if test="${isBooked1}"> (Réservé)</c:if>
                                        </div>

                                        <!-- Créneau à la demi-heure (sauf dernière heure) -->
                                        <c:if test="${hour < availability.endTime.hour - 1}">
                                            <div class="time-slot ${isBooked2 ? 'booked' : 'available'}"
                                                 data-date="${availability.day}"
                                                 data-time="${timeSlot2}"
                                                 <c:if test="${not isBooked2}">
                                                     onclick="selectTimeSlot(this, '${availability.day}', '${timeSlot2}')"
                                                 </c:if>>
                                                ${timeSlot2}
                                                <c:if test="${isBooked2}"> (Réservé)</c:if>
                                            </div>
                                        </c:if>
                                    </c:forEach>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-availability">
                        <i class="fas fa-calendar-times"></i>
                        <h3>Aucune disponibilité programmée</h3>
                        <p>Ce médecin n'a pas de créneaux disponibles pour le moment.</p>
                        <p style="font-size: 0.9rem; margin-top: 10px;">
                            Veuillez contacter la clinique pour plus d'informations.
                        </p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <!-- Section confirmation (cachée par défaut) -->
        <div class="confirmation-section" id="confirmationSection">
            <h3>Confirmer votre rendez-vous</h3>
            <div class="appointment-summary" id="appointmentSummary">
                <!-- Résumé du rendez-vous -->
            </div>
            <div class="action-buttons">
                <button class="btn btn-outline" id="backToCalendar">
                    <i class="fas fa-arrow-left"></i> Modifier
                </button>
                <button class="btn btn-success" id="confirmAppointment">
                    <i class="fas fa-calendar-check"></i> Confirmer le rendez-vous
                </button>
            </div>
        </div>

        <!-- Formulaire caché pour la confirmation -->
        <form id="hiddenAppointmentForm" action="${pageContext.request.contextPath}/appointment/create" method="post" style="display: none;">
            <input type="hidden" name="doctorId" value="${doctor.id}">
            <input type="hidden" name="date" id="hiddenDate">
            <input type="hidden" name="time" id="hiddenTime">
        </form>
    </div>
</section>

<jsp:include page="/includes/footer.jsp" />

<script>
    let selectedDate = null;
    let selectedTime = null;

    document.addEventListener('DOMContentLoaded', function() {
        initializeNavigation();
        checkPastTimeSlots();
    });

    function checkPastTimeSlots() {
        const now = new Date();
        const timeSlots = document.querySelectorAll('.time-slot.available');

        timeSlots.forEach(slot => {
            const dateStr = slot.getAttribute('data-date');
            const timeStr = slot.getAttribute('data-time') || slot.textContent.trim().replace(' (Passé)', '').replace(' (Réservé)', '');

            if (dateStr && timeStr) {
                // Créer la date complète avec l'heure
                const [hours, minutes] = timeStr.split(':');
                const slotDateTime = new Date(dateStr + 'T' + timeStr + ':00');

                console.log('Vérification créneau:', timeStr, 'Date:', slotDateTime, 'Maintenant:', now);

                if (slotDateTime < now) {
                    console.log('Créneau passé:', timeStr);
                    slot.classList.remove('available');
                    slot.classList.add('past');
                    slot.style.cursor = 'not-allowed';
                    slot.onclick = null;

                    // Mettre à jour le texte seulement si nécessaire
                    if (!slot.textContent.includes('(Passé)')) {
                        slot.textContent = timeStr + ' (Passé)';
                    }
                }
            }
        });
    }

    function selectTimeSlot(element, date, time) {
        console.log('Tentative de sélection:', date, time);
        console.log('Élément classes:', element.classList);

        // Vérifier si l'élément est marqué comme passé ou réservé
        if (element.classList.contains('past') || element.classList.contains('booked')) {
            console.log('Créneau non disponible - annulation');
            return;
        }

        // Vérifier si le créneau n'est pas dans le passé
        const slotDateTime = new Date(date + 'T' + time + ':00');
        const now = new Date();

        if (slotDateTime < now) {
            alert('Ce créneau est déjà passé. Veuillez choisir un autre créneau.');
            return;
        }

        // Retirer la sélection précédente
        document.querySelectorAll('.time-slot.selected').forEach(slot => {
            slot.classList.remove('selected');
        });

        // Ajouter la sélection
        element.classList.add('selected');

        // Stocker la sélection
        selectedDate = date;
        selectedTime = time;

        // Afficher la section de confirmation
        showConfirmationSection();
    }

    function showConfirmationSection() {
        const confirmationSection = document.getElementById('confirmationSection');
        const appointmentSummary = document.getElementById('appointmentSummary');

        // Formater la date en français
        const date = new Date(selectedDate);
        const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
        const formattedDate = date.toLocaleDateString('fr-FR', options);

        // Formater l'heure (remplacer : par h)
        const formattedTime = selectedTime.replace(':', 'h');

        appointmentSummary.innerHTML = `
            <div class="summary-item">
                <span class="summary-label">Médecin:</span>
                <span class="summary-value">${doctor.title} ${doctor.user.name}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Spécialité:</span>
                <span class="summary-value">${doctor.specialty.name}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Date:</span>
                <span class="summary-value">${formattedDate}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Heure:</span>
                <span class="summary-value">${formattedTime}</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Durée:</span>
                <span class="summary-value">30 minutes</span>
            </div>
            <div class="summary-item">
                <span class="summary-label">Lieu:</span>
                <span class="summary-value">Étage A, Bureau 102</span>
            </div>
        `;

        confirmationSection.style.display = 'block';
        confirmationSection.scrollIntoView({ behavior: 'smooth' });
    }

    function initializeNavigation() {
        document.getElementById('backToCalendar').addEventListener('click', function() {
            document.getElementById('confirmationSection').style.display = 'none';
            document.querySelectorAll('.time-slot.selected').forEach(slot => {
                slot.classList.remove('selected');
            });
        });

        document.getElementById('confirmAppointment').addEventListener('click', function() {
            confirmAppointment();
        });
    }

    function confirmAppointment() {
        if (!selectedDate || !selectedTime) {
            alert('Veuillez sélectionner un créneau horaire.');
            return;
        }

        console.log('Tentative de création de rendez-vous:', {
            doctorId: ${doctor.id},
            date: selectedDate,
            time: selectedTime
        });

        // Vérifier une dernière fois que le créneau n'est pas passé
        const slotDateTime = new Date(selectedDate + 'T' + selectedTime + ':00');
        const now = new Date();

        if (slotDateTime < now) {
            alert('Ce créneau est maintenant passé. Veuillez choisir un autre créneau.');
            return;
        }

        // Méthode SIMPLE avec formulaire HTML (plus fiable)
        document.getElementById('hiddenDate').value = selectedDate;
        document.getElementById('hiddenTime').value = selectedTime;
        document.getElementById('hiddenAppointmentForm').submit();
    }
</script>

</body>
</html>