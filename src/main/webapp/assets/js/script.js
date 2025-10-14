// Fonctionnalités JavaScript pour l'interactivité
document.addEventListener('DOMContentLoaded', function() {
    console.log("Dashboard loaded successfully");

    // Recherche en temps réel
    const searchInput = document.getElementById('search');
    if (searchInput) {
        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll('table tbody tr');

            rows.forEach(row => {
                const patientName = row.querySelector('.patient-name').textContent.toLowerCase();
                const patientEmail = row.querySelector('.patient-details').textContent.toLowerCase();
                const dossier = row.querySelector('td:nth-child(3)').textContent.toLowerCase();

                if (patientName.includes(searchTerm) || patientEmail.includes(searchTerm) || dossier.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }

    // Filtrage par statut
    const statusFilter = document.getElementById('status');
    if (statusFilter) {
        statusFilter.addEventListener('change', function() {
            const selectedStatus = this.value;
            const rows = document.querySelectorAll('table tbody tr');

            rows.forEach(row => {
                const statusBadge = row.querySelector('.badge');
                let statusValue = '';

                if (statusBadge.classList.contains('badge-success')) {
                    statusValue = 'active';
                } else if (statusBadge.classList.contains('badge-warning')) {
                    statusValue = 'pending';
                } else if (statusBadge.classList.contains('badge-info')) {
                    statusValue = 'archived';
                }

                if (selectedStatus === '' || statusValue === selectedStatus) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    }

    // Animation des cartes de statistiques
    const statCards = document.querySelectorAll('.stat-card');
    statCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-5px)';
        });
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
    });

    // Gestion des actions (boutons)
    document.addEventListener('click', function(e) {
        if (e.target.closest('.action-btn')) {
            const button = e.target.closest('.action-btn');
            const action = button.classList[1]; // view, edit ou delete
            const row = button.closest('tr');
            const patientName = row.querySelector('.patient-name').textContent;

            switch(action) {
                case 'view':
                    alert(`Voir le dossier de: ${patientName}`);
                    break;
                case 'edit':
                    alert(`Modifier: ${patientName}`);
                    break;
                case 'delete':
                    if (confirm(`Êtes-vous sûr de vouloir supprimer ${patientName} ?`)) {
                        row.style.opacity = '0.5';
                        setTimeout(() => {
                            row.remove();
                            updatePatientCount();
                        }, 500);
                    }
                    break;
            }
        }
    });

    // Mettre à jour le compteur de patients
    function updatePatientCount() {
        const patientRows = document.querySelectorAll('table tbody tr');
        const totalCount = document.querySelector('.stat-card:nth-child(1) h3');
        if (totalCount) {
            totalCount.textContent = patientRows.length;
        }
    }

    // Pagination
    const paginationButtons = document.querySelectorAll('.pagination-btn');
    paginationButtons.forEach(button => {
        button.addEventListener('click', function() {
            if (!this.classList.contains('active') && !this.querySelector('i')) {
                paginationButtons.forEach(btn => btn.classList.remove('active'));
                this.classList.add('active');
            }
        });
    });
});