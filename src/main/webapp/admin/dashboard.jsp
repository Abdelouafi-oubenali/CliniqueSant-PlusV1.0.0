<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestion des Patients - Clinique</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <!-- CORRECTION : ../ pour remonter d'un niveau -->
    <link href="../assets/css/style2.css" rel="stylesheet">
</head>
<body>
    <div class="container">
        <!-- CORRECTION : ../ pour remonter d'un niveau -->
        <%@ include file="../includes/sidebar.jsp" %>

        <div class="main-content">
            <!-- CORRECTION : ../ pour remonter d'un niveau -->
            <%@ include file="../includes/header2.jsp" %>

            <!-- Content -->
            <div class="content">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="page-title">
                        <h1>Gestion des Patients</h1>
                        <p>Consultez et gérez les dossiers des patients</p>
                    </div>
                    <button class="btn btn-primary">
                        <i class="fas fa-plus"></i> Nouveau Patient
                    </button>
                </div>

                <!-- Stats Cards -->
                <div class="stats-cards">
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: var(--primary);">
                            <i class="fas fa-user-injured"></i>
                        </div>
                        <div class="stat-info">
                            <h3>1,248</h3>
                            <p>Patients Totaux</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: var(--success);">
                            <i class="fas fa-user-plus"></i>
                        </div>
                        <div class="stat-info">
                            <h3>42</h3>
                            <p>Nouveaux ce Mois</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: var(--warning);">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-info">
                            <h3>89</h3>
                            <p>RDV Aujourd'hui</p>
                        </div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-icon" style="background-color: var(--danger);">
                            <i class="fas fa-exclamation-circle"></i>
                        </div>
                        <div class="stat-info">
                            <h3>7</h3>
                            <p>Patients en Attente</p>
                        </div>
                    </div>
                </div>

                <!-- Message de test -->
                <div style="background: white; padding: 30px; border-radius: 10px; text-align: center; margin-top: 20px;">
                    <h2 style="color: var(--success);">
                        <i class="fas fa-check-circle"></i> Dashboard chargé depuis admin/
                    </h2>
                    <p>Les chemins sont maintenant corrigés avec ../</p>
                </div>
            </div>

            <!-- CORRECTION : ../ pour remonter d'un niveau -->
        </div>
    </div>

    <!-- CORRECTION : ../ pour remonter d'un niveau -->
    <script src="../assets/js/script.js"></script>
</body>
</html>