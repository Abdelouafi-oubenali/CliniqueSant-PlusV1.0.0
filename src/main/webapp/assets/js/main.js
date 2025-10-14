// script.js - Version corrigée
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM chargé - Initialisation des événements');

    // Sélection des éléments
    const loginModal = document.getElementById('login-modal');
    const registerModal = document.getElementById('register-modal');

    // Debug des éléments
    console.log('Login modal trouvé:', loginModal);
    console.log('Register modal trouvé:', registerModal);

    // Fonction pour ouvrir modal
    function openModal(modal) {
        if (modal) {
            modal.style.display = 'flex';
            document.body.style.overflow = 'hidden';
            console.log('Modal ouvert:', modal.id);
        } else {
            console.error('Modal non trouvé');
        }
    }

    // Fonction pour fermer modal
    function closeModal(modal) {
        if (modal) {
            modal.style.display = 'none';
            document.body.style.overflow = 'auto';
        }
    }

    // Événements pour les boutons de connexion
    document.querySelectorAll('#login-btn-header, #login-btn-section').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            console.log('Bouton login cliqué');
            openModal(loginModal);
        });
    });

    // Événements pour les boutons d'inscription
    document.querySelectorAll('#register-btn-header, #register-btn-section, #cta-register-btn').forEach(button => {
        button.addEventListener('click', (e) => {
            e.preventDefault();
            console.log('Bouton register cliqué');
            openModal(registerModal);
        });
    });

    // Fermeture des modals
    document.querySelectorAll('.close-modal').forEach(button => {
        button.addEventListener('click', () => {
            closeModal(loginModal);
            closeModal(registerModal);
        });
    });

    // Navigation entre modals
    document.getElementById('switch-to-register')?.addEventListener('click', (e) => {
        e.preventDefault();
        closeModal(loginModal);
        openModal(registerModal);
    });

    document.getElementById('switch-to-login')?.addEventListener('click', (e) => {
        e.preventDefault();
        closeModal(registerModal);
        openModal(loginModal);
    });

    // Fermer en cliquant à l'extérieur
    window.addEventListener('click', (e) => {
        if (e.target === loginModal) closeModal(loginModal);
        if (e.target === registerModal) closeModal(registerModal);
    });

    // Bouton de rendez-vous hero
    document.getElementById('appointment-btn-hero')?.addEventListener('click', () => {
        const appointmentSection = document.getElementById('appointment');
        if (appointmentSection) {
            appointmentSection.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }
    });

    // Header scroll effect
    window.addEventListener('scroll', function() {
        const header = document.querySelector('header');
        if (header) {
            if (window.scrollY > 100) {
                header.style.background = 'rgba(255, 255, 255, 0.95)';
                header.style.backdropFilter = 'blur(10px)';
            } else {
                header.style.background = 'var(--white)';
                header.style.backdropFilter = 'none';
            }
        }
    });

    console.log('Tous les événements initialisés');
});