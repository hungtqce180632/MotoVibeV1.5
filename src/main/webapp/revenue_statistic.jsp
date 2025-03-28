<%-- 
    Document   : revenue_statistic
    Created on : Feb 23, 2025, 4:11:08 AM
    Author     : hieunmce181623
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Revenue Statistics - MotoVibe</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            /* Styling cơ bản cho trang */
            body {
                background: var(--dark-black);
                color: var(--text-gold);
            }

            /* Styling cho container */
            .list-container {
                padding-top: 100px;
                padding-bottom: 50px;
            }

            /* Styling cho tiêu đề */
            h1 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 2rem;
                text-align: center;
                position: relative;
            }

            /* Margin cho form */
            form {
                margin-bottom: 10px;
            }
            p {
                text-align: center;
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <%-- Chèn header từ file header.jsp --%>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="container list-container">
                <h1><i class="fas fa-chart-line"></i> Revenue Statistics</h1>
                <p class="lead">View monthly revenue statistics, including the number of cars sold and total revenue.</p>

                <!-- Form cho phép người dùng chọn tháng để lọc dữ liệu -->
                <div class="row">
                    <form method="GET" action="revenueStatistic">
                        <div class="mb-3">
                            <label for="monthFilter" class="form-label">Select Month</label>
                            <select id="monthFilter" name="monthFilter" class="form-control">
                                <option value="">-- All Months --</option>
                            <c:forEach var="month" items="${availableMonths}">
                                <option value="${month}" ${month == param.monthFilter ? 'selected' : ''}>${month}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <button type="submit" class="btn btn-primary">Filter</button>
                </form>

                <!-- Hiển thị tổng doanh thu -->
                <div class="col-md-4">
                    <div class="card text-white bg-primary mb-3">
                        <div class="card-header">Total Revenue</div>
                        <div class="card-body">
                            <h4 class="card-title">$${totalRevenue}</h4>
                        </div>
                    </div>
                </div>

                <!-- Hiển thị tổng số đơn hàng -->
                <div class="col-md-4">
                    <div class="card text-white bg-success mb-3">
                        <div class="card-header">Total Orders</div>
                        <div class="card-body">
                            <h4 class="card-title">${totalOrders}</h4>
                        </div>
                    </div>
                </div>

            </div>

            <!-- Chèn biểu đồ cho doanh thu -->
            <canvas id="revenueChart"></canvas>

            <!-- Bảng hiển thị doanh thu và số lượng xe bán ra theo tháng -->
            <table class="table table-bordered mt-4">
                <thead class="table-dark">
                    <tr>
                        <th>Month</th>
                        <th>Cars Sold</th>
                        <th>Revenue ($)</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Duyệt qua danh sách doanh thu và hiển thị thông tin -->
                    <c:forEach var="data" items="${revenueData}">
                        <tr>
                            <td>${data.month}</td>
                            <td>${data.total_sales}</td>
                            <td>${data.total_revenue}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <!-- Liên kết quay lại dashboard -->
            <a href="home" class="btn btn-secondary mt-3"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>
        <%-- Chèn footer từ file footer.jsp --%>
        <jsp:include page="footer.jsp"></jsp:include>

        <%-- Script hiển thị biểu đồ doanh thu bằng Chart.js --%>
        <script>
            var revenueData = [];
            var salesData = [];
            var monthLabels = [];

            <!-- Duyệt qua revenueData và thêm dữ liệu vào các mảng cho biểu đồ -->
            <c:forEach var="data" items="${revenueData}">
            monthLabels.push("${data.month}");
            salesData.push(${data.total_sales});
            revenueData.push(${data.total_revenue});
            </c:forEach>

            var ctx = document.getElementById('revenueChart').getContext('2d');
            var revenueChart = new Chart(ctx, {
                type: 'bar',  <!-- Loại biểu đồ (bar chart) -->
                data: {
                    labels: monthLabels,  <!-- Dữ liệu nhãn (tháng) -->
                    datasets: [
                        {
                            label: 'Cars Sold',  <!-- Dữ liệu cho số lượng xe bán ra -->
                            data: salesData,  <!-- Dữ liệu cho số lượng xe bán ra -->
                            backgroundColor: 'rgba(54, 162, 235, 0.6)',  <!-- Màu nền của các thanh biểu đồ -->
                            borderColor: 'rgba(54, 162, 235, 1)',  <!-- Màu viền của các thanh biểu đồ -->
                            borderWidth: 1  <!-- Độ dày viền của các thanh biểu đồ -->
                        },
                        {
                            label: 'Revenue ($)',  <!-- Dữ liệu cho doanh thu -->
                            data: revenueData,  <!-- Dữ liệu cho doanh thu -->
                            backgroundColor: 'rgba(75, 192, 192, 0.6)',  <!-- Màu nền của các thanh biểu đồ -->
                            borderColor: 'rgba(75, 192, 192, 1)',  <!-- Màu viền của các thanh biểu đồ -->
                            borderWidth: 1  <!-- Độ dày viền của các thanh biểu đồ -->
                        }
                    ]
                },
                options: { 
                    scales: { 
                        y: { 
                            beginAtZero: true  <!-- Đảm bảo trục y bắt đầu từ 0 -->
                        }
                    }
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
