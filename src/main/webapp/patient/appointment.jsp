<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Prendre rendez-vous - Clinique Médicale</title>
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
            padding: 20px;
        }

        .container {
            max-width: 1000px;
            margin: 0 auto;
            background: white;
            border-radius: 15px;
            box-shadow: 0 10px 40px rgba(0, 102, 153, 0.15);
            overflow: hidden;
            border-top: 5px solid #0077b6;
        }

        .header {
            background: linear-gradient(135deg, #0077b6 0%, #00b4d8 100%);
            color: white;
            padding: 40px 30px;
            text-align: center;
            position: relative;
        }

        .header::before {
            content: "⚕️";
            font-size: 3em;
            position: absolute;
            top: 50%;
            left: 30px;
            transform: translateY(-50%);
            opacity: 0.3;
        }

        .header::after {
            content: "⚕️";
            font-size: 3em;
            position: absolute;
            top: 50%;
            right: 30px;
            transform: translateY(-50%);
            opacity: 0.3;
        }

        h1 {
            font-size: 2.2em;
            font-weight: 600;
            margin-bottom: 5px;
        }

        .subtitle {
            font-size: 1em;
            opacity: 0.95;
            font-weight: 300;
        }

        .content {
            padding: 40px 30px;
        }

        .section-title {
            color: #0077b6;
            font-size: 1.3em;
            font-weight: 600;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e8f4f8;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        .calendar {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(110px, 1fr));
            gap: 15px;
            margin-bottom: 40px;
        }

        .day-card {
            background: white;
            border: 2px solid #caf0f8;
            border-radius: 10px;
            padding: 18px 12px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            position: relative;
            box-shadow: 0 2px 8px rgba(0, 119, 182, 0.08);
        }

        .day-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 119, 182, 0.2);
            border-color: #0077b6;
        }

        .day-card.selected {
            background: linear-gradient(135deg, #0077b6 0%, #00b4d8 100%);
            color: white;
            border-color: #0077b6;
            box-shadow: 0 8px 25px rgba(0, 119, 182, 0.3);
        }

        .day-card::before {
            content: "✓";
            position: absolute;
            top: 5px;
            right: 8px;
            font-size: 0.9em;
            opacity: 0;
            transition: opacity 0.3s ease;
            color: white;
            font-weight: bold;
        }

        .day-card.selected::before {
            opacity: 1;
        }

        .day-name {
            font-size: 0.8em;
            font-weight: 600;
            text-transform: uppercase;
            margin-bottom: 8px;
            opacity: 0.7;
            letter-spacing: 0.5px;
        }

        .day-number {
            font-size: 2em;
            font-weight: 700;
            margin: 8px 0;
            color: #0077b6;
        }

        .day-card.selected .day-number {
            color: white;
        }

        .day-month {
            font-size: 0.75em;
            opacity: 0.7;
            text-transform: uppercase;
        }

        .form-section {
            background: #f8fcfd;
            padding: 30px;
            border-radius: 10px;
            display: none;
            border: 2px solid #caf0f8;
        }

        .form-section.active {
            display: block;
            animation: fadeIn 0.5s ease;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            font-weight: 600;
            margin-bottom: 8px;
            color: #023e8a;
            font-size: 0.95em;
        }

        input[type="text"],
        input[type="date"] {
            width: 100%;
            padding: 14px;
            border: 2px solid #caf0f8;
            border-radius: 8px;
            font-size: 1em;
            transition: all 0.3s ease;
            background: white;
        }

        input[type="text"]:focus,
        input[type="date"]:focus {
            outline: none;
            border-color: #0077b6;
            box-shadow: 0 0 0 3px rgba(0, 119, 182, 0.1);
        }

        .selected-date-info {
            background: linear-gradient(135deg, #0077b6 0%, #00b4d8 100%);
            color: white;
            padding: 20px;
            border-radius: 8px;
            margin-bottom: 25px;
            text-align: center;
            font-weight: 600;
            font-size: 1.05em;
            box-shadow: 0 4px 15px rgba(0, 119, 182, 0.2);
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
        }

        .selected-date-info::before {
            content: "📅";
            font-size: 1.3em;
        }

        button {
            width: 100%;
            padding: 16px;
            background: linear-gradient(135deg, #0077b6 0%, #00b4d8 100%);
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(0, 119, 182, 0.2);
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0, 119, 182, 0.3);
        }

        button:active {
            transform: translateY(0);
        }

        .info-box {
            background: #e8f4f8;
            border-left: 4px solid #0077b6;
            padding: 15px 20px;
            margin-bottom: 25px;
            border-radius: 5px;
            color: #023e8a;
            font-size: 0.9em;
        }

        .info-box strong {
            display: block;
            margin-bottom: 5px;
            color: #0077b6;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>Clinique Médicale</h1>
            <div class="subtitle">Système de prise de rendez-vous en ligne</div>
        </div>
        <div class="content">
            <div class="info-box">
                <strong>📋 Instructions</strong>
                Sélectionnez une date disponible dans le calendrier ci-dessous pour prendre rendez-vous avec nos spécialistes.
            </div>

            <div class="section-title">
                <span>🗓️</span> Dates disponibles
            </div>
            <div class="calendar" id="calendar"></div>

            <div class="form-section" id="formSection">
                <div class="section-title">
                    <span>👤</span> Informations du patient
                </div>
                <div class="selected-date-info" id="selectedDateInfo"></div>
                <form action="saveAppointment" method="post">
                    <div class="form-group">
                        <label for="nom">Nom complet du patient *</label>
                        <input type="text" id="nom" name="nom" placeholder="Entrez votre nom complet" required>
                    </div>
                    <input type="hidden" id="dateInput" name="date">
                    <button type="submit">✓ Confirmer le rendez-vous</button>
                </form>
            </div>
        </div>
    </div>

    <script>
        const calendar = document.getElementById('calendar');
        const formSection = document.getElementById('formSection');
        const selectedDateInfo = document.getElementById('selectedDateInfo');
        const dateInput = document.getElementById('dateInput');
        let selectedCard = null;

        const joursSemaine = ['Dim', 'Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam'];
        const mois = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Juin', 'Juil', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'];

        function genererCalendrier() {
            const aujourdhui = new Date();

            for (let i = 0; i < 30; i++) {
                const date = new Date(aujourdhui);
                date.setDate(aujourdhui.getDate() + i);

                const dayCard = document.createElement('div');
                dayCard.className = 'day-card';

                const dayName = document.createElement('div');
                dayName.className = 'day-name';
                dayName.textContent = joursSemaine[date.getDay()];

                const dayNumber = document.createElement('div');
                dayNumber.className = 'day-number';
                dayNumber.textContent = date.getDate();

                const dayMonth = document.createElement('div');
                dayMonth.className = 'day-month';
                dayMonth.textContent = mois[date.getMonth()];

                dayCard.appendChild(dayName);
                dayCard.appendChild(dayNumber);
                dayCard.appendChild(dayMonth);

                dayCard.addEventListener('click', () => selectionnerDate(dayCard, date));

                calendar.appendChild(dayCard);
            }
        }

        function selectionnerDate(card, date) {
            if (selectedCard) {
                selectedCard.classList.remove('selected');
            }

            card.classList.add('selected');
            selectedCard = card;

            const dateFormatee = date.toLocaleDateString('fr-FR', {
                weekday: 'long',
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            });

            selectedDateInfo.textContent = dateFormatee.charAt(0).toUpperCase() + dateFormatee.slice(1);

            const dateISO = date.toISOString().split('T')[0];
            dateInput.value = dateISO;

            formSection.classList.add('active');
            formSection.scrollIntoView({ behavior: 'smooth', block: 'nearest' });
        }

        genererCalendrier();
    </script>
</body>
</html>