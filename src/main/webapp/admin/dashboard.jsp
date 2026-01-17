<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%
    // Récupérer les données du servlet
    Integer totalPatients = (Integer) request.getAttribute("totalPatients");
    Integer totalDoctors = (Integer) request.getAttribute("totalDoctors");
    Integer totalDepartments = (Integer) request.getAttribute("totalDepartments");
    Integer totalUsers = (Integer) request.getAttribute("totalUsers");
    Integer todayAppointments = (Integer) request.getAttribute("todayAppointments");
    Integer pendingPatients = (Integer) request.getAttribute("pendingPatients");
    Integer newPatientsThisMonth = (Integer) request.getAttribute("newPatientsThisMonth");
    Integer availableBeds = (Integer) request.getAttribute("availableBeds");
    
    Map<String, Integer> monthlyAdmissions = (Map<String, Integer>) request.getAttribute("monthlyAdmissions");
    Map<String, Integer> statusDistribution = (Map<String, Integer>) request.getAttribute("statusDistribution");
    Map<String, Integer> departmentStats = (Map<String, Integer>) request.getAttribute("departmentStats");
    Map<String, Integer> topDepartments = (Map<String, Integer>) request.getAttribute("topDepartments");
    
    // Valeurs par défaut
    if (totalPatients == null) totalPatients = 0;
    if (totalDoctors == null) totalDoctors = 0;
    if (totalDepartments == null) totalDepartments = 0;
    if (totalUsers == null) totalUsers = 0;
    if (todayAppointments == null) todayAppointments = 0;
    if (pendingPatients == null) pendingPatients = 0;
    if (newPatientsThisMonth == null) newPatientsThisMonth = 0;
    if (availableBeds == null) availableBeds = 0;
    
    if (monthlyAdmissions == null) {
        monthlyAdmissions = Map.of("Jan", 120, "Fév", 190, "Mar", 135, "Avr", 210, "Mai", 180, "Juin", 240);
    }
    if (statusDistribution == null) {
        statusDistribution = Map.of("Actifs", 65, "En attente", 20, "Inactifs", 15);
    }
    if (topDepartments == null) {
        topDepartments = Map.of("Urgences", 312, "Cardiologie", 245, "Pédiatrie", 187, "Chirurgie", 156);
    }
    
    String contextPath = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tableau de Bord - Clinique SantePlus</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <link href="${pageContext.request.contextPath}/assets/css/style2.css" rel="stylesheet">
    <style>
        :root {
            --primary: #4361ee;
            --primary-light: #eef2ff;
            --secondary: #3f37c9;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #f72585;
            --info: #7209b7;
            --dark: #212529;
            --light: #f8f9fa;
            --gray: #6c757d;
            --gray-light: #e9ecef;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            background-color: #f5f7fb;
            color: var(--dark);
        }

        .container {
            display: flex;
            min-height: 100vh;
        }

        .main-content {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .content {
            padding: 25px;
            overflow-y: auto;
            background-color: #f5f7fb;
        }

        /* Page Header */
        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            border-left: 5px solid var(--primary);
        }

        .page-title h1 {
            font-size: 28px;
            font-weight: 700;
            color: var(--dark);
            margin-bottom: 8px;
        }

        .page-title p {
            color: var(--gray);
            font-size: 16px;
        }

        .btn-refresh {
            background: var(--primary-light);
            color: var(--primary);
            border: none;
            padding: 12px 24px;
            border-radius: 10px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
        }

        .btn-refresh:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
        }

        /* Stats Cards */
        .stats-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
            gap: 20px;
            margin-bottom: 30px;
        }

        .stat-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            gap: 20px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease;
            cursor: pointer;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }

        .stat-icon {
            width: 60px;
            height: 60px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 24px;
        }

        .stat-info h3 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 5px;
        }

        .stat-info p {
            color: var(--gray);
            font-size: 14px;
        }

        .stat-change {
            font-size: 12px;
            margin-top: 5px;
            display: flex;
            align-items: center;
            gap: 4px;
        }

        .stat-change.positive {
            color: var(--success);
        }

        .stat-change.negative {
            color: var(--danger);
        }

        /* Graphiques Section */
        .charts-section {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
        }

        @media (max-width: 1200px) {
            .charts-section {
                grid-template-columns: 1fr;
            }
        }

        .chart-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .chart-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }

        .chart-header h3 {
            font-size: 18px;
            font-weight: 600;
            color: var(--dark);
        }

        .chart-actions {
            display: flex;
            gap: 10px;
        }

        .chart-btn {
            background: var(--primary-light);
            color: var(--primary);
            border: none;
            padding: 8px 16px;
            border-radius: 8px;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .chart-btn:hover {
            background: var(--primary);
            color: white;
        }

        .chart-container {
            height: 300px;
            position: relative;
        }

        /* Departments Table */
        .departments-table {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            margin-bottom: 30px;
        }

        .departments-table h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--dark);
        }

        .table-responsive {
            overflow-x: auto;
        }

        .departments-table table {
            width: 100%;
            border-collapse: collapse;
        }

        .departments-table th {
            padding: 15px;
            text-align: left;
            font-weight: 600;
            color: var(--gray);
            border-bottom: 2px solid var(--gray-light);
            font-size: 14px;
        }

        .departments-table td {
            padding: 15px;
            border-bottom: 1px solid var(--gray-light);
        }

        .departments-table tbody tr:hover {
            background-color: var(--primary-light);
        }

        .department-name {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .department-icon-small {
            width: 35px;
            height: 35px;
            border-radius: 8px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 16px;
        }

        .progress-bar {
            height: 8px;
            background-color: var(--gray-light);
            border-radius: 4px;
            overflow: hidden;
        }

        .progress-fill {
            height: 100%;
            border-radius: 4px;
        }

        /* Quick Actions */
        .quick-actions {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 20px;
            margin-top: 30px;
        }

        .action-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            color: inherit;
        }

        .action-icon {
            width: 70px;
            height: 70px;
            border-radius: 15px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
            color: white;
            margin-bottom: 15px;
        }

        .action-card h4 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 10px;
        }

        .action-card p {
            color: var(--gray);
            font-size: 14px;
            line-height: 1.5;
        }

        /* Recent Activity */
        .recent-activity {
            background: white;
            border-radius: 15px;
            padding: 25px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        }

        .recent-activity h3 {
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 20px;
            color: var(--dark);
        }

        .activity-list {
            display: flex;
            flex-direction: column;
            gap: 15px;
        }

        .activity-item {
            display: flex;
            align-items: center;
            gap: 15px;
            padding: 15px;
            border-radius: 10px;
            background: var(--light);
            transition: background 0.3s;
        }

        .activity-item:hover {
            background: var(--primary-light);
        }

        .activity-icon {
            width: 40px;
            height: 40px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 18px;
        }

        .activity-content {
            flex: 1;
        }

        .activity-content p {
            margin-bottom: 5px;
            font-size: 14px;
        }

        .activity-time {
            font-size: 12px;
            color: var(--gray);
        }

        /* Dashboard Layout */
        .dashboard-grid {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 25px;
        }

        @media (max-width: 1200px) {
            .dashboard-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <jsp:include page="../includes/sidebar.jsp" />

        <div class="main-content">
            <jsp:include page="../includes/header2.jsp" />

            <div class="content">
                <!-- Page Header -->
                <div class="page-header">
                    <div class="page-title">
                        <h1>Tableau de Bord</h1>
                        <p>Bienvenue dans le système de gestion de la clinique</p>
                    </div>
                    <button class="btn-refresh" onclick="refreshDashboard()">
                        <i class="fas fa-sync-alt"></i> Actualiser
                    </button>
                </div>

                <!-- Stats Cards -->
                <div class="stats-cards">
                    <div class="stat-card" onclick="location.href='<%= contextPath %>/PatientServlet'">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #4361ee, #3f37c9);">
                            <i class="fas fa-user-injured"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="totalPatients"><%= totalPatients %></h3>
                            <p>Patients Totaux</p>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i> <%= newPatientsThisMonth %> ce mois
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card" onclick="location.href='<%= contextPath %>/DoctorServlet'">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #4cc9f0, #4895ef);">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="totalDoctors"><%= totalDoctors %></h3>
                            <p>Médecins</p>
                            <div class="stat-change positive">
                                <i class="fas fa-arrow-up"></i> 12 actifs
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card" onclick="location.href='<%= contextPath %>/DepartmentServlet?action=list'">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #f8961e, #f3722c);">
                            <i class="fas fa-hospital"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="totalDepartments"><%= totalDepartments %></h3>
                            <p>Départements</p>
                            <div class="stat-change positive">
                                <i class="fas fa-check-circle"></i> Tous opérationnels
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card" onclick="location.href='#'">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #7209b7, #560bad);">
                            <i class="fas fa-users"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="totalUsers"><%= totalUsers %></h3>
                            <p>Utilisateurs</p>
                            <div class="stat-change positive">
                                <i class="fas fa-user-plus"></i> 5 nouveaux
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card" onclick="location.href='#'">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #f72585, #b5179e);">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="todayAppointments"><%= todayAppointments %></h3>
                            <p>RDV Aujourd'hui</p>
                            <div class="stat-change positive">
                                <i class="fas fa-clock"></i> <%= pendingPatients %> en attente
                            </div>
                        </div>
                    </div>
                    
                    <div class="stat-card" onclick="location.href='#'">
                        <div class="stat-icon" style="background: linear-gradient(135deg, #2ec4b6, #20a39e);">
                            <i class="fas fa-bed"></i>
                        </div>
                        <div class="stat-info">
                            <h3 id="availableBeds"><%= availableBeds %></h3>
                            <p>Lits Disponibles</p>
                            <div class="stat-change negative">
                                <i class="fas fa-arrow-down"></i> 23% occupation
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Graphiques Section -->
                <div class="charts-section">
                    <div class="chart-card">
                        <div class="chart-header">
                            <h3>Évolution des admissions (6 derniers mois)</h3>
                            <div class="chart-actions">
                                <button class="chart-btn" onclick="changeChartType('line')">Lignes</button>
                                <button class="chart-btn" onclick="changeChartType('bar')">Barres</button>
                            </div>
                        </div>
                        <div class="chart-container">
                            <canvas id="admissionsChart"></canvas>
                        </div>
                    </div>
                    
                    <div class="chart-card">
                        <div class="chart-header">
                            <h3>Répartition par statut</h3>
                        </div>
                        <div class="chart-container">
                            <canvas id="statusChart"></canvas>
                        </div>
                    </div>
                </div>

                <!-- Dashboard Grid -->
                <div class="dashboard-grid">
                    <!-- Departments Table -->
                    <div class="departments-table">
                        <h3>Top Départements par admissions</h3>
                        <div class="table-responsive">
                            <table>
                                <thead>
                                    <tr>
                                        <th>Département</th>
                                        <th>Admissions</th>
                                        <th>Occupation</th>
                                        <th>Taux</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    int count = 0;
                                    for (Map.Entry<String, Integer> entry : topDepartments.entrySet()) {
                                        if (count >= 5) break;
                                        String deptName = entry.getKey();
                                        int admissions = entry.getValue();
                                        int occupancy = 65 + (count * 5);
                                        String iconClass = getDepartmentIconClass(deptName);
                                        String icon = getDepartmentIcon(deptName);
                                    %>
                                    <tr>
                                        <td>
                                            <div class="department-name">
                                                <div class="department-icon-small <%= iconClass %>" 
                                                     style="background: <%= getDepartmentColor(count) %>">
                                                    <i class="<%= icon %>"></i>
                                                </div>
                                                <span><%= deptName %></span>
                                            </div>
                                        </td>
                                        <td><strong><%= admissions %></strong></td>
                                        <td><%= occupancy %>%</td>
                                        <td style="width: 150px;">
                                            <div class="progress-bar">
                                                <div class="progress-fill" 
                                                     style="width: <%= occupancy %>%; background: <%= getDepartmentColor(count) %>"></div>
                                            </div>
                                        </td>
                                    </tr>
                                    <% 
                                        count++;
                                    } 
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>

                    <!-- Recent Activity -->
                    <div class="recent-activity">
                        <h3>Activité Récente</h3>
                        <div class="activity-list">
                            <div class="activity-item">
                                <div class="activity-icon" style="background: linear-gradient(135deg, #4361ee, #3f37c9);">
                                    <i class="fas fa-user-plus"></i>
                                </div>
                                <div class="activity-content">
                                    <p>Nouveau patient enregistré - Jean Dupont</p>
                                    <div class="activity-time">Il y a 5 minutes</div>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon" style="background: linear-gradient(135deg, #4cc9f0, #4895ef);">
                                    <i class="fas fa-calendar-plus"></i>
                                </div>
                                <div class="activity-content">
                                    <p>Rendez-vous confirmé - Dr. Martin</p>
                                    <div class="activity-time">Il y a 15 minutes</div>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon" style="background: linear-gradient(135deg, #f8961e, #f3722c);">
                                    <i class="fas fa-file-medical"></i>
                                </div>
                                <div class="activity-content">
                                    <p>Dossier médical mis à jour - Patient #245</p>
                                    <div class="activity-time">Il y a 30 minutes</div>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon" style="background: linear-gradient(135deg, #7209b7, #560bad);">
                                    <i class="fas fa-chart-line"></i>
                                </div>
                                <div class="activity-content">
                                    <p>Rapport mensuel généré</p>
                                    <div class="activity-time">Il y a 2 heures</div>
                                </div>
                            </div>
                            <div class="activity-item">
                                <div class="activity-icon" style="background: linear-gradient(135deg, #2ec4b6, #20a39e);">
                                    <i class="fas fa-bell"></i>
                                </div>
                                <div class="activity-content">
                                    <p>Alert: Disponibilité des lits faible</p>
                                    <div class="activity-time">Il y a 3 heures</div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="quick-actions">
                    <a href="<%= contextPath %>/PatientServlet" class="action-card">
                        <div class="action-icon" style="background: linear-gradient(135deg, #4361ee, #3f37c9);">
                            <i class="fas fa-user-injured"></i>
                        </div>
                        <h4>Gérer Patients</h4>
                        <p>Ajouter, modifier ou consulter les dossiers des patients</p>
                    </a>
                    
                    <a href="<%= contextPath %>/appointment" class="action-card">
                        <div class="action-icon" style="background: linear-gradient(135deg, #4cc9f0, #4895ef);">
                            <i class="fas fa-calendar-plus"></i>
                        </div>
                        <h4>Prendre RDV</h4>
                        <p>Planifier un nouveau rendez-vous pour un patient</p>
                    </a>
                    
                    <a href="<%= contextPath %>/DepartmentServlet?action=list" class="action-card">
                        <div class="action-icon" style="background: linear-gradient(135deg, #f8961e, #f3722c);">
                            <i class="fas fa-hospital"></i>
                        </div>
                        <h4>Départements</h4>
                        <p>Gérer les départements et spécialités médicales</p>
                    </a>
                    
                    <a href="#" class="action-card">
                        <div class="action-icon" style="background: linear-gradient(135deg, #7209b7, #560bad);">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h4>Rapports</h4>
                        <p>Générer des rapports statistiques et analytiques</p>
                    </a>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Données pour les graphiques (depuis JSP)
        const monthlyData = {
            labels: <%= getMonthlyLabels(monthlyAdmissions) %>,
            values: <%= getMonthlyValues(monthlyAdmissions) %>
        };
        
        const statusData = {
            labels: <%= getStatusLabels(statusDistribution) %>,
            values: <%= getStatusValues(statusDistribution) %>
        };
        
        const departmentColors = [
            '#4361ee', '#4cc9f0', '#f8961e', '#f72585', '#7209b7', '#2ec4b6'
        ];

        // Graphique des admissions
        let admissionsChart;
        function renderAdmissionsChart(type = 'line') {
            const ctx = document.getElementById('admissionsChart').getContext('2d');
            
            if (admissionsChart) {
                admissionsChart.destroy();
            }
            
            admissionsChart = new Chart(ctx, {
                type: type,
                data: {
                    labels: monthlyData.labels,
                    datasets: [{
                        label: 'Admissions',
                        data: monthlyData.values,
                        backgroundColor: type === 'bar' ? 'rgba(67, 97, 238, 0.7)' : 'rgba(67, 97, 238, 0.1)',
                        borderColor: 'rgba(67, 97, 238, 1)',
                        borderWidth: 2,
                        fill: type === 'line',
                        tension: 0.4,
                        pointBackgroundColor: 'rgba(67, 97, 238, 1)',
                        pointBorderColor: '#fff',
                        pointBorderWidth: 2,
                        pointRadius: 5
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    plugins: {
                        legend: {
                            display: false
                        },
                        tooltip: {
                            backgroundColor: 'rgba(0, 0, 0, 0.8)',
                            titleColor: '#fff',
                            bodyColor: '#fff',
                            borderColor: 'rgba(67, 97, 238, 1)',
                            borderWidth: 1
                        }
                    },
                    scales: {
                        y: {
                            beginAtZero: true,
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            },
                            ticks: {
                                stepSize: 50
                            }
                        },
                        x: {
                            grid: {
                                color: 'rgba(0, 0, 0, 0.05)'
                            }
                        }
                    }
                }
            });
        }

        // Graphique des statuts
        let statusChart;
        function renderStatusChart() {
            const ctx = document.getElementById('statusChart').getContext('2d');
            
            statusChart = new Chart(ctx, {
                type: 'doughnut',
                data: {
                    labels: statusData.labels,
                    datasets: [{
                        data: statusData.values,
                        backgroundColor: [
                            'rgba(76, 201, 240, 0.8)',
                            'rgba(248, 150, 30, 0.8)',
                            'rgba(108, 117, 125, 0.8)',
                            'rgba(103, 114, 229, 0.8)',
                            'rgba(231, 76, 60, 0.8)'
                        ],
                        borderWidth: 0,
                        hoverOffset: 15,
                        borderRadius: 10
                    }]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    cutout: '65%',
                    plugins: {
                        legend: {
                            position: 'right',
                            labels: {
                                padding: 20,
                                usePointStyle: true,
                                font: {
                                    size: 12
                                }
                            }
                        },
                        tooltip: {
                            callbacks: {
                                label: function(context) {
                                    const label = context.label || '';
                                    const value = context.raw || 0;
                                    const total = context.dataset.data.reduce((a, b) => a + b, 0);
                                    const percentage = Math.round((value / total) * 100);
                                    return `${label}: ${value} (${percentage}%)`;
                                }
                            }
                        }
                    }
                }
            });
        }

        // Changer le type de graphique
        function changeChartType(type) {
            renderAdmissionsChart(type);
        }

        // Animation des compteurs
        function animateCounter(elementId, targetValue) {
            const element = document.getElementById(elementId);
            if (!element) return;
            
            let current = 0;
            const increment = targetValue / 100;
            const timer = setInterval(() => {
                current += increment;
                if (current >= targetValue) {
                    element.textContent = targetValue.toLocaleString();
                    clearInterval(timer);
                } else {
                    element.textContent = Math.floor(current).toLocaleString();
                }
            }, 20);
        }

        // Rafraîchir le dashboard
        function refreshDashboard() {
            const btn = event.target.closest('.btn-refresh');
            btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Actualisation...';
            btn.disabled = true;
            
            setTimeout(() => {
                window.location.reload();
            }, 1000);
        }

        // Initialisation
        document.addEventListener('DOMContentLoaded', function() {
            // Rendre les graphiques
            renderAdmissionsChart('line');
            renderStatusChart();
            
            // Animer les compteurs
            setTimeout(() => {
                animateCounter('totalPatients', <%= totalPatients %>);
                animateCounter('totalDoctors', <%= totalDoctors %>);
                animateCounter('totalDepartments', <%= totalDepartments %>);
                animateCounter('totalUsers', <%= totalUsers %>);
                animateCounter('todayAppointments', <%= todayAppointments %>);
                animateCounter('availableBeds', <%= availableBeds %>);
            }, 500);
            
            // Ajouter des écouteurs pour les cartes cliquables
            document.querySelectorAll('.stat-card').forEach(card => {
                card.style.cursor = 'pointer';
            });
        });
    </script>
</body>
</html>

<%!
    // Méthodes utilitaires pour les données des graphiques
    
    private String getMonthlyLabels(Map<String, Integer> data) {
        StringBuilder sb = new StringBuilder("[");
        boolean first = true;
        for (String month : data.keySet()) {
            if (!first) sb.append(", ");
            sb.append("'").append(month).append("'");
            first = false;
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String getMonthlyValues(Map<String, Integer> data) {
        StringBuilder sb = new StringBuilder("[");
        boolean first = true;
        for (Integer value : data.values()) {
            if (!first) sb.append(", ");
            sb.append(value);
            first = false;
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String getStatusLabels(Map<String, Integer> data) {
        StringBuilder sb = new StringBuilder("[");
        boolean first = true;
        for (String status : data.keySet()) {
            if (!first) sb.append(", ");
            sb.append("'").append(status).append("'");
            first = false;
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String getStatusValues(Map<String, Integer> data) {
        StringBuilder sb = new StringBuilder("[");
        boolean first = true;
        for (Integer value : data.values()) {
            if (!first) sb.append(", ");
            sb.append(value);
            first = false;
        }
        sb.append("]");
        return sb.toString();
    }
    
    private String getDepartmentIconClass(String departmentName) {
        if (departmentName == null) return "default";
        String name = departmentName.toLowerCase();
        if (name.contains("cardio")) return "cardiology";
        if (name.contains("pédiat") || name.contains("pediat")) return "pediatrics";
        if (name.contains("chirurg")) return "surgery";
        if (name.contains("radio")) return "radiology";
        if (name.contains("urgence")) return "emergency";
        if (name.contains("neuro")) return "neurology";
        return "default";
    }
    
    private String getDepartmentIcon(String departmentName) {
        if (departmentName == null) return "fas fa-hospital";
        String name = departmentName.toLowerCase();
        if (name.contains("cardio")) return "fas fa-heartbeat";
        if (name.contains("pédiat") || name.contains("pediat")) return "fas fa-baby";
        if (name.contains("chirurg")) return "fas fa-scalpel";
        if (name.contains("radio")) return "fas fa-x-ray";
        if (name.contains("urgence")) return "fas fa-ambulance";
        if (name.contains("neuro")) return "fas fa-brain";
        return "fas fa-hospital";
    }
    
    private String getDepartmentColor(int index) {
        String[] colors = {
            "linear-gradient(135deg, #4361ee, #3f37c9)",
            "linear-gradient(135deg, #4cc9f0, #4895ef)",
            "linear-gradient(135deg, #f8961e, #f3722c)",
            "linear-gradient(135deg, #f72585, #b5179e)",
            "linear-gradient(135deg, #7209b7, #560bad)",
            "linear-gradient(135deg, #2ec4b6, #20a39e)"
        };
        return colors[index % colors.length];
    }
%>