<%-- 
    Document   : revenue_statistic
    Created on : Feb 28, 2025, 4:52:12 PM
    Author     : Jackt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Revenue Statistics - MotoVibe</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }

            .stats-container {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 15px;
                padding: 2rem;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
                margin: 2rem auto;
            }
            
            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 0.5rem;
                position: relative;
                display: inline-block;
            }
            
            h2::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 0;
                width: 100%;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            
            .lead {
                color: var(--text-gold);
                margin-bottom: 2rem;
                opacity: 0.9;
            }
            
            .chart-container {
                background: rgba(0, 0, 0, 0.2);
                padding: 1.5rem;
                border-radius: 10px;
                margin-bottom: 2rem;
                border: 1px solid rgba(212, 175, 55, 0.3);
                position: relative;
            }
            
            canvas {
                max-width: 100%;
                height: auto !important;
            }
            
            .table {
                color: var(--text-gold) !important;
                border: 1px solid var(--secondary-gold);
                border-radius: 10px;
                overflow: hidden;
                margin-top: 2rem;
            }
            
            .table thead th {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black) !important;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                border: none;
                padding: 1rem;
            }
            
            .table tbody td {
                color: var (--text-gold) !important;
                border-color: rgba(212, 175, 55, 0.2);
                padding: 1rem;
            }
            
            .table tbody tr {
                transition: all 0.3s ease;
            }
            
            .table tbody tr:hover {
                background: rgba(212, 175, 55, 0.05);
            }
            
            .btn-secondary {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                margin-top: 1rem;
            }
            
            .btn-secondary:hover {
                background: rgba(212, 175, 55, 0.1);
                color: var(--primary-gold);
                transform: translateY(-2px);
                box-shadow: 0 0 15px rgba(212, 175, 55, 0.2);
            }
            
            .btn i {
                margin-right: 5px;
            }
            
            .stats-summary {
                display: flex;
                justify-content: space-between;
                margin-bottom: 2rem;
            }
            
            .stat-card {
                background: linear-gradient(145deg, var(--rich-black), var(--dark-black));
                border: 1px solid var(--secondary-gold);
                border-radius: 10px;
                padding: 1.5rem;
                text-align: center;
                flex: 1;
                margin: 0 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                transition: all 0.3s ease;
            }
            
            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 8px 20px rgba(212, 175, 55, 0.2);
            }
            
            .stat-number {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--primary-gold);
                margin-bottom: 0.5rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            }
            
            .stat-title {
                font-size: 1rem;
                color: var(--text-gold);
                text-transform: uppercase;
                letter-spacing: 1px;
                opacity: 0.8;
            }
            
            .stat-icon {
                font-size: 2rem;
                color: var(--primary-gold);
                margin-bottom: 1rem;
                opacity: 0.8;
            }
            
            .chart-tabs {
                display: flex;
                margin-bottom: 1.5rem;
                border-bottom: 1px solid rgba(212, 175, 55, 0.3);
                padding-bottom: 0.5rem;
            }
            
            .chart-tab {
                padding: 0.75rem 1.5rem;
                background: transparent;
                border: 1px solid var(--secondary-gold);
                color: var(--text-gold);
                margin-right: 0.5rem;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s ease;
            }
            
            .chart-tab.active {
                background: var(--primary-gold);
                color: var(--dark-black);
                font-weight: 600;
            }
            
            .chart-tab:hover:not(.active) {
                background: rgba(212, 175, 55, 0.1);
            }
            
            .container {
                padding-top: 80px;
            }
            
            @media (max-width: 768px) {
                .stats-summary {
                    flex-direction: column;
                }
                
                .stat-card {
                    margin: 0 0 1rem 0;
                }
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="container">
            <div class="stats-container">
                <h2><i class="fas fa-chart-line me-2"></i>Revenue Statistics</h2>
                <p class="lead">Comprehensive overview of our business performance and revenue trends.</p>
                
                <!-- Summary statistics cards -->
                <div class="stats-summary">
                    <div class="stat-card">
                        <i class="fas fa-dollar-sign stat-icon"></i>
                        <div class="stat-number">
                            <c:set var="totalRevenue" value="0" />
                            <c:forEach var="data" items="${revenueData}">
                                <c:set var="totalRevenue" value="${totalRevenue + data.revenue}" />
                            </c:forEach>
                            $${totalRevenue}
                        </div>
                        <div class="stat-title">Total Revenue</div>
                    </div>
                    
                    <div class="stat-card">
                        <i class="fas fa-chart-bar stat-icon"></i>
                        <div class="stat-number">
                            <c:set var="avgRevenue" value="${totalRevenue / revenueData.size()}" />
                            $${Math.round(avgRevenue)}
                        </div>
                        <div class="stat-title">Average Monthly</div>
                    </div>
                    
                    <div class="stat-card">
                        <i class="fas fa-chart-line stat-icon"></i>
                        <div class="stat-number">
                            <c:set var="maxRevenue" value="0" />
                            <c:forEach var="data" items="${revenueData}">
                                <c:if test="${data.revenue > maxRevenue}">
                                    <c:set var="maxRevenue" value="${data.revenue}" />
                                </c:if>
                            </c:forEach>
                            $${maxRevenue}
                        </div>
                        <div class="stat-title">Best Month</div>
                    </div>
                </div>
                
                <!-- Chart tabs -->
                <div class="chart-tabs">
                    <button class="chart-tab active" data-type="line">Line Chart</button>
                    <button class="chart-tab" data-type="bar">Bar Chart</button>
                </div>
                
                <!-- Chart container -->
                <div class="chart-container">
                    <canvas id="revenueChart"></canvas>
                </div>

                <!-- Data table -->
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Month</th>
                                <th>Revenue ($)</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="data" items="${revenueData}">
                                <tr>
                                    <td>${data.month}</td>
                                    <td>$${data.revenue}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>

                <a href="index.jsp" class="btn btn-secondary mt-3"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        
        <script>
            var revenueData = [];
            var monthLabels = [];

            <c:forEach var="data" items="${revenueData}">
                monthLabels.push("${data.month}");
                revenueData.push(${data.revenue});
            </c:forEach>

            // Initialize variables
            var ctx = document.getElementById('revenueChart').getContext('2d');
            var currentChart;
            var chartType = 'line';
            
            // Colors for the chart
            var goldGradient = ctx.createLinearGradient(0, 0, 0, 400);
            goldGradient.addColorStop(0, 'rgba(212, 175, 55, 0.8)');
            goldGradient.addColorStop(1, 'rgba(197, 160, 40, 0.2)');
            
            // Create chart function
            function createChart(type) {
                // Destroy previous chart if it exists
                if (currentChart) {
                    currentChart.destroy();
                }
                
                // Chart configuration
                var config = {
                    type: type,
                    data: {
                        labels: monthLabels,
                        datasets: [{
                            label: 'Revenue ($)',
                            data: revenueData,
                            backgroundColor: goldGradient,
                            borderColor: '#D4AF37',
                            borderWidth: 2,
                            pointBackgroundColor: '#D4AF37',
                            pointBorderColor: '#111111',
                            pointRadius: 6,
                            pointHoverRadius: 8,
                            tension: 0.4
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        scales: {
                            y: {
                                beginAtZero: true,
                                grid: {
                                    color: 'rgba(212, 175, 55, 0.1)',
                                    borderColor: '#D4AF37'
                                },
                                ticks: {
                                    color: '#F5E6CC'
                                }
                            },
                            x: {
                                grid: {
                                    color: 'rgba(212, 175, 55, 0.1)',
                                    borderColor: '#D4AF37'
                                },
                                ticks: {
                                    color: '#F5E6CC'
                                }
                            }
                        },
                        plugins: {
                            legend: {
                                labels: {
                                    color: '#F5E6CC',
                                    font: {
                                        size: 14
                                    }
                                }
                            },
                            tooltip: {
                                backgroundColor: 'rgba(26, 26, 26, 0.9)',
                                titleColor: '#D4AF37',
                                bodyColor: '#F5E6CC',
                                borderColor: '#D4AF37',
                                borderWidth: 1,
                                displayColors: false,
                                callbacks: {
                                    title: function(tooltipItems) {
                                        return tooltipItems[0].label;
                                    },
                                    label: function(context) {
                                        return 'Revenue: $' + context.parsed.y;
                                    }
                                }
                            }
                        }
                    }
                };
                
                // Create chart
                currentChart = new Chart(ctx, config);
            }
            
            // Initialize chart on page load
            document.addEventListener('DOMContentLoaded', function() {
                createChart('line');
                
                // Add event listeners to chart tabs
                document.querySelectorAll('.chart-tab').forEach(function(tab) {
                    tab.addEventListener('click', function() {
                        // Remove active class from all tabs
                        document.querySelectorAll('.chart-tab').forEach(function(t) {
                            t.classList.remove('active');
                        });
                        
                        // Add active class to clicked tab
                        this.classList.add('active');
                        
                        // Get chart type from data attribute
                        chartType = this.getAttribute('data-type');
                        
                        // Create new chart with selected type
                        createChart(chartType);
                    });
                });
            });
        </script>
    </body>
</html>
