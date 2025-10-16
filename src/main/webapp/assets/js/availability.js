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