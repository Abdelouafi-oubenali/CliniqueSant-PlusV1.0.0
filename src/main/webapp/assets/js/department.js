// Department.js - Gestion complète des départements
console.log("✅ Department.js chargé - Version 2.0");

// Fonction de confirmation de suppression améliorée
function confirmDelete(event, element) {
    event.preventDefault();
    event.stopPropagation();

    const departmentCard = element.closest('.department-card');
    const departmentName = departmentCard.querySelector('h3').textContent;
    const departmentCode = departmentCard.querySelector('.department-code').textContent.replace('Code: ', '');

    const confirmationMessage =
        `Êtes-vous sûr de vouloir supprimer le département ?\n\n` +
        `📛 Nom: ${departmentName}\n` +
        `🔖 Code: ${departmentCode}\n\n` +
        `⚠️  Cette action est irréversible et supprimera toutes les données associées.`;

    const isConfirmed = confirm(confirmationMessage);

    if (isConfirmed) {
        console.log(`✅ Suppression confirmée pour: ${departmentName}`);
        // Récupérer l'URL originale et naviguer
        const originalHref = element.getAttribute('href');
        window.location.href = originalHref;
        return true;
    } else {
        console.log(`❌ Suppression annulée pour: ${departmentName}`);
        return false;
    }
}

function initializeDepartmentPage() {
    console.log("🚀 Initialisation de la page départements");

    // Vérifier que nous ne sommes pas déjà initialisés
    if (window.departmentPageInitialized) {
        console.log("⚠️ Page déjà initialisée, ignore...");
        return;
    }

    setupFormHandlers();
    setupCardAnimations();
    setupFilterHandlers();
    setupActionButtons();
    setupSearchFunctionality();
    setupDeleteConfirmations();

    window.departmentPageInitialized = true;
    console.log("✅ Page départements entièrement initialisée");
}

function setupFormHandlers() {
    console.log("📝 Configuration des gestionnaires de formulaire");

    const showFormBtn = document.getElementById('showFormBtn');
    const showFormBtnEmpty = document.getElementById('showFormBtnEmpty');
    const departmentForm = document.getElementById('departmentForm');
    const closeFormBtn = document.getElementById('closeFormBtn');
    const cancelFormBtn = document.getElementById('cancelFormBtn');
    const addDepartmentForm = document.getElementById('addDepartmentForm');

    function showForm() {
        console.log("📤 Affichage du formulaire");
        if (departmentForm) {
            departmentForm.style.display = 'block';
            departmentForm.scrollIntoView({ behavior: 'smooth', block: 'start' });

            // Focus sur le premier champ
            const codeInput = document.getElementById('code');
            if (codeInput) {
                codeInput.focus();
                codeInput.select();
            }
        }
        if (showFormBtn) showFormBtn.style.display = 'none';
        if (showFormBtnEmpty) showFormBtnEmpty.style.display = 'none';
    }

    function hideForm() {
        console.log("📥 Masquage du formulaire");
        if (departmentForm) {
            departmentForm.style.display = 'none';
        }
        if (showFormBtn) showFormBtn.style.display = 'inline-flex';
        if (showFormBtnEmpty) showFormBtnEmpty.style.display = 'inline-flex';
        if (addDepartmentForm) addDepartmentForm.reset();
    }

    // Événements pour afficher le formulaire
    if (showFormBtn) {
        showFormBtn.addEventListener('click', showForm);
        console.log("✅ Événement ajouté sur showFormBtn");
    }

    if (showFormBtnEmpty) {
        showFormBtnEmpty.addEventListener('click', showForm);
        console.log("✅ Événement ajouté sur showFormBtnEmpty");
    }

    // Événements pour masquer le formulaire
    if (closeFormBtn) {
        closeFormBtn.addEventListener('click', hideForm);
        console.log("✅ Événement ajouté sur closeFormBtn");
    }

    if (cancelFormBtn) {
        cancelFormBtn.addEventListener('click', hideForm);
        console.log("✅ Événement ajouté sur cancelFormBtn");
    }

    // Gestion de la soumission du formulaire
    if (addDepartmentForm) {
        addDepartmentForm.addEventListener('submit', function(e) {
            e.preventDefault();
            console.log("📤 TENTATIVE DE SOUMISSION");

            const code = document.getElementById('code');
            const name = document.getElementById('name');

            if (!code || !name) {
                alert('Erreur: champs non trouvés');
                return false;
            }

            // Validation côté client
            if (!code.value.trim()) {
                alert('Veuillez saisir un code pour le département');
                code.focus();
                return false;
            }

            if (!name.value.trim()) {
                alert('Veuillez saisir un nom pour le département');
                name.focus();
                return false;
            }

            // Validation format code
            const codeRegex = /^[A-Za-z0-9]{2,10}$/;
            if (!codeRegex.test(code.value.trim())) {
                alert('Le code doit contenir 2 à 10 caractères alphanumériques');
                code.focus();
                return false;
            }

            console.log("✅ FORMULAIRE VALIDE, ENVOI...");

            // Afficher un indicateur de chargement
            const submitBtn = this.querySelector('button[type="submit"]');
            const originalText = submitBtn.innerHTML;
            submitBtn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Enregistrement...';
            submitBtn.disabled = true;

            // Soumission après un petit délai pour voir l'animation
            setTimeout(() => {
                this.submit();
            }, 800);
        });
    }
}

function setupCardAnimations() {
    const cards = document.querySelectorAll('.department-card');
    console.log(`${cards.length} cartes départements trouvées`);

    cards.forEach((card, index) => {
        // Initial state for animation
        card.style.opacity = '0';
        card.style.transform = 'translateY(20px)';
        card.style.transition = 'all 0.5s ease';

        // Animation d'entrée avec délai
        setTimeout(() => {
            card.style.opacity = '1';
            card.style.transform = 'translateY(0)';
        }, 150 * index);

        // Hover effects
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-8px) scale(1.02)';
            this.style.boxShadow = '0 12px 35px rgba(0,0,0,0.15)';
            this.style.zIndex = '10';
        });

        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0) scale(1)';
            this.style.boxShadow = '';
            this.style.zIndex = '1';
        });

        // Clic sur la carte (sauf boutons) - redirige vers la vue détail
        card.addEventListener('click', function(e) {
            if (!e.target.closest('.btn') && !e.target.closest('.action-btn')) {
                const viewBtn = this.querySelector('.action-btn.view-btn');
                if (viewBtn) {
                    console.log(`👁️ Navigation vers détails: ${this.querySelector('h3').textContent}`);
                    viewBtn.click();
                }
            }
        });
    });
}

function setupFilterHandlers() {
    const filterBtns = document.querySelectorAll('.filter-btn');
    console.log(`🔘 ${filterBtns.length} boutons filtre trouvés`);

    filterBtns.forEach(btn => {
        btn.addEventListener('click', function(e) {
            const filterType = this.textContent.trim();
            console.log(`🔍 Application filtre: ${filterType}`);
            // La navigation est déjà gérée par le href naturellement
        });
    });
}

function setupActionButtons() {
    const actionBtns = document.querySelectorAll('.action-btn');
    console.log(`⚡ ${actionBtns.length} boutons action trouvés`);

    actionBtns.forEach(btn => {
        // Effets visuels supplémentaires
        btn.addEventListener('mouseenter', function() {
            this.style.transform = 'scale(1.05)';
        });

        btn.addEventListener('mouseleave', function() {
            this.style.transform = 'scale(1)';
        });

        btn.addEventListener('click', function(e) {
            const action = this.classList.contains('view-btn') ? 'view' :
                          this.classList.contains('edit-btn') ? 'edit' :
                          this.classList.contains('delete-btn') ? 'delete' : 'unknown';

            const departmentName = this.closest('.department-card')?.querySelector('h3')?.textContent || 'Inconnu';
            console.log(`🔧 Action ${action} sur: ${departmentName}`);

            if (action === 'delete') {
                e.preventDefault();
                confirmDelete(e, this);
            }
        });
    });
}

function setupSearchFunctionality() {
    const searchInput = document.getElementById('searchInput');
    const departmentsGrid = document.getElementById('departmentsGrid');

    if (searchInput && departmentsGrid) {
        console.log("🔍 Configuration de la recherche en temps réel");

        searchInput.addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase().trim();
            const departmentCards = departmentsGrid.querySelectorAll('.department-card');
            let visibleCount = 0;

            departmentCards.forEach(card => {
                const name = card.getAttribute('data-name');
                const code = card.getAttribute('data-code');

                if (name.includes(searchTerm) || code.includes(searchTerm)) {
                    card.style.display = 'block';
                    visibleCount++;

                    // Highlight des termes recherchés
                    if (searchTerm.length > 2) {
                        highlightSearchTerms(card, searchTerm);
                    }
                } else {
                    card.style.display = 'none';
                }
            });

            // Gérer l'affichage "aucun résultat"
            handleNoResults(visibleCount, searchTerm, departmentsGrid);

            console.log(`🔍 Recherche: "${searchTerm}" - ${visibleCount} résultats`);
        });

        // Ajouter un bouton de reset à la recherche
        addSearchResetButton(searchInput);
    }
}

function highlightSearchTerms(card, searchTerm) {
    const title = card.querySelector('h3');
    const code = card.querySelector('.department-code');
    const description = card.querySelector('.department-description');

    if (title) {
        const originalText = title.textContent;
        const highlighted = originalText.replace(
            new RegExp(searchTerm, 'gi'),
            match => `<mark class="search-highlight">${match}</mark>`
        );
        title.innerHTML = highlighted;
    }

    if (code) {
        const originalText = code.textContent;
        const highlighted = originalText.replace(
            new RegExp(searchTerm, 'gi'),
            match => `<mark class="search-highlight">${match}</mark>`
        );
        code.innerHTML = highlighted;
    }
}

function handleNoResults(visibleCount, searchTerm, departmentsGrid) {
    const noDepartments = departmentsGrid.querySelector('.no-departments');
    if (noDepartments) {
        if (visibleCount === 0 && searchTerm !== '') {
            noDepartments.innerHTML = `
                <div class="empty-state">
                    <i class="fas fa-search fa-4x"></i>
                    <h3>Aucun résultat trouvé</h3>
                    <p>Aucun département ne correspond à "<strong>${searchTerm}</strong>"</p>
                    <button onclick="window.department.clearSearch()" class="btn btn-secondary">
                        <i class="fas fa-times"></i> Effacer la recherche
                    </button>
                </div>
            `;
            noDepartments.style.display = 'block';
        } else {
            noDepartments.style.display = 'none';
            // Réinitialiser les highlights
            resetSearchHighlights(departmentsGrid);
        }
    }
}

function resetSearchHighlights(departmentsGrid) {
    const highlights = departmentsGrid.querySelectorAll('mark.search-highlight');
    highlights.forEach(highlight => {
        const parent = highlight.parentNode;
        parent.textContent = parent.textContent;
    });
}

function addSearchResetButton(searchInput) {
    const searchBox = searchInput.parentElement;
    const resetBtn = document.createElement('button');
    resetBtn.type = 'button';
    resetBtn.className = 'search-reset';
    resetBtn.innerHTML = '<i class="fas fa-times"></i>';
    resetBtn.title = 'Effacer la recherche';
    resetBtn.style.display = 'none';

    resetBtn.addEventListener('click', function() {
        searchInput.value = '';
        searchInput.focus();
        searchInput.dispatchEvent(new Event('input'));
        this.style.display = 'none';
    });

    searchInput.addEventListener('input', function() {
        resetBtn.style.display = this.value ? 'block' : 'none';
    });

    searchBox.appendChild(resetBtn);
}

function setupDeleteConfirmations() {
    const deleteButtons = document.querySelectorAll('.action-btn.delete-btn');
    console.log(`🗑️ ${deleteButtons.length} boutons suppression trouvés`);

    deleteButtons.forEach(btn => {
        // S'assurer que l'événement onclick original est préservé
        const originalOnClick = btn.onclick;

        btn.addEventListener('click', function(e) {
            // Notre fonction confirmDelete gère déjà tout
            console.log("✅ Gestion suppression via confirmDelete");
        });
    });
}

// Fonction utilitaire pour effacer la recherche
function clearSearch() {
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.value = '';
        searchInput.dispatchEvent(new Event('input'));
        searchInput.focus();
    }
}

// Gestion des erreurs globales
window.addEventListener('error', function(e) {
    console.error('❌ Erreur globale:', e.error);
});

// Initialisation sécurisée
function safeInitialize() {
    try {
        if (!window.departmentPageInitialized) {
            initializeDepartmentPage();
        }
    } catch (error) {
        console.error('❌ Erreur lors de l\'initialisation:', error);
    }
}

// Initialisation multiple pour garantir le fonctionnement
document.addEventListener('DOMContentLoaded', function() {
    console.log("📄 DOM Content Loaded - Department");
    setTimeout(safeInitialize, 100);
});

// Si le DOM est déjà chargé
if (document.readyState !== 'loading') {
    console.log("⚡ DOM déjà chargé - Department");
    setTimeout(safeInitialize, 200);
}

// Fallback final
setTimeout(function() {
    console.log("⏰ Fallback initialization - Department");
    safeInitialize();
}, 500);

// Exposer les fonctions globalement
window.department = {
    init: safeInitialize,
    showForm: function() {
        const form = document.getElementById('departmentForm');
        const showFormBtn = document.getElementById('showFormBtn');
        const showFormBtnEmpty = document.getElementById('showFormBtnEmpty');

        if (form) {
            form.style.display = 'block';
            form.scrollIntoView({ behavior: 'smooth' });
        }
        if (showFormBtn) showFormBtn.style.display = 'none';
        if (showFormBtnEmpty) showFormBtnEmpty.style.display = 'none';
    },
    hideForm: function() {
        const form = document.getElementById('departmentForm');
        const showFormBtn = document.getElementById('showFormBtn');
        const showFormBtnEmpty = document.getElementById('showFormBtnEmpty');

        if (form) form.style.display = 'none';
        if (showFormBtn) showFormBtn.style.display = 'inline-flex';
        if (showFormBtnEmpty) showFormBtnEmpty.style.display = 'inline-flex';

        const addDepartmentForm = document.getElementById('addDepartmentForm');
        if (addDepartmentForm) addDepartmentForm.reset();
    },
    clearSearch: clearSearch,
    confirmDelete: confirmDelete
};

console.log("🎯 Department.js 2.0 prêt - Attente initialisation...");