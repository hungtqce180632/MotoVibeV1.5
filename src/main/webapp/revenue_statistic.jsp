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
        <title>Revenue Statistics</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="container mt-4">
                <h2><i class="fas fa-chart-line"></i> Revenue Statistics</h2>
                <p class="lead">View monthly revenue generated from appointments.</p>

                <canvas id="revenueChart"></canvas>

                <table class="table table-bordered mt-4">
                    <thead class="table-dark">
                        <tr>
                            <th>Month</th>
                            <th>Revenue ($)</th>
                        </tr>
                    </thead>
                    <tbody>
                    <c:forEach var="data" items="${revenueData}">
                        <tr>
                            <td>${data.month}</td>
                            <td>${data.revenue}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <a href="index.jsp" class="btn btn-secondary mt-3"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>

        <script>
            var revenueData = [];
            var monthLabels = [];

            <c:forEach var="data" items="${revenueData}">
        monthLabels.push("${data.month}");
        revenueData.push(${data.revenue});
            </c:forEach>

            var ctx = document.getElementById('revenueChart').getContext('2d');
            var revenueChart = new Chart(ctx, {
                type: 'line',
                data: {
                    labels: monthLabels,
                    datasets: [{
                            label: 'Revenue ($)',
                            data: revenueData,
                            borderColor: 'rgb(75, 192, 192)',
                            tension: 0.1
                        }]
                }
            });
        </script>
    </body>
</html>
