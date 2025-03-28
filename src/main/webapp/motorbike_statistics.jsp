<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>MotoBike Sales Statistics</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            body {
                background: #1a1a1a;
                color: #f8f9fa;
            }

            .container {
                margin-top: 100px;
            }

            h2 {
                color: #D4AF37;
                text-transform: uppercase;
                text-align: center;
                margin-bottom: 20px;
            }

            .table {
                width: 100%;
                margin-top: 20px;
                background: #222;
                border-radius: 10px;
                overflow: hidden;
            }

            .table th {
                background: #D4AF37;
                color: black;
                text-align: center;
            }

            .table td {
                text-align: center;
                vertical-align: middle;
            }

            .chart-container {
                width: 100%;
                height: 450px;
                padding: 20px;
                background: #2c2c2c;
                border-radius: 10px;
                margin-bottom: 30px;
            }

            .btn-secondary {
                display: block;
                width: 200px;
                margin: 30px auto;
                background: #D4AF37;
                color: black;
                font-weight: bold;
                text-transform: uppercase;
                border: none;
            }

            .btn-secondary:hover {
                background: #c5a028;
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="container">
                <h2><i class="fas fa-motorcycle"></i> Motorbike Sales Statistics</h2>
                <p class="text-center">View total sales, revenue, and average revenue per unit.</p>


                <!-- Filter Form -->
                <form method="GET" action="motorbikeStatistics">
                    <div class="mb-3">
                        <label for="modelFilter" class="form-label">Filter by Model</label>
                        <select id="modelFilter" name="modelFilter" class="form-control">
                            <option value="">-- All Models --</option>
                        <c:forEach var="model" items="${motorbikeModels}">
                            <option value="${model}" ${model == param.modelFilter ? 'selected' : ''}>${model}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Filter</button>
            </form>

            <!-- Check if motorbikeData is null or empty -->
            <c:if test="${not empty motorbikeData}">
                <!-- Chart Container -->
                <div class="chart-container">
                    <canvas id="motorbikeChart"></canvas>
                </div>

                <!-- Table displaying data -->
                <div class="table-responsive">
                    <table class="table table-bordered table-striped">
                        <thead>
                            <tr>
                                <th>Model Name</th>
                                <th>Units Sold</th>
                                <th>Revenue ($)</th>
                                <th>Avg Revenue per Unit ($)</th>
                                <th>% Contribution to Total Revenue</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:set var="totalRevenue" value="0"/>
                            <c:forEach var="data" items="${motorbikeData}">
                                <c:set var="totalRevenue" value="${totalRevenue + data.total_revenue}"/>
                            </c:forEach>

                            <c:forEach var="data" items="${motorbikeData}">
                                <tr>
                                    <td>${data.model_name}</td>
                                    <td>${data.total_sold}</td>
                                    <td>$${data.total_revenue}</td>
                                    <td>$${data.total_sold > 0 ? (data.total_revenue / data.total_sold) : 0}</td>
                                    <td>${(data.total_revenue / totalRevenue) * 100}%</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <!-- If no motorbike data, display "No models sold" message -->
            <c:if test="${empty motorbikeData}">
                <p class="text-center text-warning">No motorbike models have been sold.</p>
            </c:if>

            <a href="home" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>

    <jsp:include page="footer.jsp"></jsp:include>
        <script>
            var modelNames = [];
            var salesData = [];
            var revenueData = [];
            var avgRevenueData = [];

        <c:forEach var="data" items="${motorbikeData}">
            modelNames.push("${data.model_name}");
            salesData.push(${data.total_sold});
            revenueData.push(${data.total_revenue});
            avgRevenueData.push(${data.total_sold > 0 ? (data.total_revenue / data.total_sold) : 0});
        </c:forEach>

            var ctx = document.getElementById('motorbikeChart').getContext('2d');
            var motorbikeChart = new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: modelNames,
                    datasets: [
                        {
                            label: 'Units Sold',
                            data: salesData,
                            backgroundColor: 'rgba(54, 162, 235, 0.8)',
                            borderColor: 'rgba(54, 162, 235, 1)',
                            borderWidth: 1,
                            yAxisID: 'y'
                        },
                        {
                            label: 'Revenue ($)',
                            data: revenueData,
                            backgroundColor: 'rgba(75, 192, 192, 0.8)',
                            borderColor: 'rgba(75, 192, 192, 1)',
                            borderWidth: 1,
                            yAxisID: 'y'
                        },
                        {
                            label: 'Avg Revenue per Unit ($)',
                            data: avgRevenueData,
                            type: 'line',
                            borderColor: 'rgba(255, 99, 132, 1)',
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',
                            borderWidth: 2,
                            fill: false,
                            tension: 0.4,
                            yAxisID: 'y2'
                        }
                    ]
                },
                options: {
                    responsive: true,
                    maintainAspectRatio: false,
                    scales: {
                        y: {
                            beginAtZero: true,
                            position: 'left',
                            title: {
                                display: true,
                                text: 'Units Sold & Revenue ($)',
                                color: '#f8f9fa'
                            },
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'
                            },
                            ticks: {
                                color: '#f8f9fa'
                            }
                        },
                        y2: {
                            beginAtZero: true,
                            position: 'right',
                            title: {
                                display: true,
                                text: 'Avg Revenue per Unit ($)',
                                color: '#ff6384'
                            },
                            grid: {
                                drawOnChartArea: false
                            },
                            ticks: {
                                color: '#ff6384'
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: '#f8f9fa'
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(26, 26, 26, 0.9)',
                            titleColor: '#D4AF37',
                            bodyColor: '#f8f9fa'
                        }
                    }
                }
            });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
