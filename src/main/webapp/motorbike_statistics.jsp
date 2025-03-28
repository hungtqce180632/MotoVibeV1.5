<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- 
    Document   : motobike_statistic
    Created on : Feb 23, 2025, 4:11:08 AM
    Author     : hieunmce181623
--%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>MotoBike Sales Statistics</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <style>
            /* Styling cơ bản cho trang */
            body {
                background: #1a1a1a;
                color: #f8f9fa;
            }

            /* Styling cho container */
            .container {
                margin-top: 100px;
            }

            /* Styling cho tiêu đề */
            h2 {
                color: #D4AF37;
                text-transform: uppercase;
                text-align: center;
                margin-bottom: 20px;
            }

            /* Styling cho bảng */
            .table {
                width: 100%;
                margin-top: 20px;
                background: #222;
                border-radius: 10px;
                overflow: hidden;
            }

            /* Styling cho header của bảng */
            .table th {
                background: #D4AF37;
                color: black;
                text-align: center;
            }

            /* Styling cho các ô trong bảng */
            .table td {
                text-align: center;
                vertical-align: middle;
            }

            /* Styling cho container chứa biểu đồ */
            .chart-container {
                width: 100%;
                height: 450px;
                padding: 20px;
                background: #2c2c2c;
                border-radius: 10px;
                margin-bottom: 30px;
            }

            /* Styling cho nút quay lại */
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

            /* Styling cho nút quay lại khi hover */
            .btn-secondary:hover {
                background: #c5a028;
            }
        </style>
    </head>
    <body>

        <%-- Chèn header từ file header.jsp --%>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="container">
            <h2><i class="fas fa-motorcycle"></i> Motorbike Sales Statistics</h2>
            <p class="text-center">View total sales, revenue, and average revenue per unit.</p>

            <!-- Form lọc theo mẫu xe -->
            <form method="GET" action="motorbikeStatistics">
                <div class="mb-3">
                    <label for="modelFilter" class="form-label">Filter by Model</label>
                    <select id="modelFilter" name="modelFilter" class="form-control">
                        <option value="">-- All Models --</option>
                        <!-- Duyệt qua danh sách các mẫu xe và tạo các lựa chọn trong dropdown -->
                        <c:forEach var="model" items="${motorbikeModels}">
                            <option value="${model}" ${model == param.modelFilter ? 'selected' : ''}>${model}</option>
                        </c:forEach>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary">Filter</button>
            </form>

            <!-- Kiểm tra nếu motorbikeData không rỗng -->
            <c:if test="${not empty motorbikeData}">
                <!-- Chart Container -->
                <div class="chart-container">
                    <canvas id="motorbikeChart"></canvas>
                </div>

                <!-- Bảng hiển thị doanh thu và số lượng xe bán ra -->
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
                            <!-- Tính tổng doanh thu -->
                            <c:set var="totalRevenue" value="0"/>
                            <c:forEach var="data" items="${motorbikeData}">
                                <c:set var="totalRevenue" value="${totalRevenue + data.total_revenue}"/>
                            </c:forEach>

                            <!-- Duyệt qua danh sách dữ liệu xe bán ra và hiển thị thông tin -->
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

            <!-- Nếu không có dữ liệu, hiển thị thông báo -->
            <c:if test="${empty motorbikeData}">
                <p class="text-center text-warning">No motorbike models have been sold.</p>
            </c:if>

            <!-- Nút quay lại trang dashboard -->
            <a href="home" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
        </div>

        <%-- Chèn footer từ file footer.jsp --%>
        <jsp:include page="footer.jsp"></jsp:include>

        <!-- Script cho biểu đồ doanh thu -->
        <script>
            var modelNames = [];
            var salesData = [];
            var revenueData = [];
            var avgRevenueData = [];

            <!-- Duyệt qua dữ liệu xe bán ra và thêm thông tin vào biểu đồ -->
            <c:forEach var="data" items="${motorbikeData}">
                modelNames.push("${data.model_name}");
                salesData.push(${data.total_sold});
                revenueData.push(${data.total_revenue});
                avgRevenueData.push(${data.total_sold > 0 ? (data.total_revenue / data.total_sold) : 0});
            </c:forEach>

            var ctx = document.getElementById('motorbikeChart').getContext('2d');
            var motorbikeChart = new Chart(ctx, {
                type: 'bar',  <!-- Loại biểu đồ là cột -->
                data: {
                    labels: modelNames,  <!-- Nhãn cho các mẫu xe -->
                    datasets: [
                        {
                            label: 'Units Sold',  <!-- Dữ liệu cho số lượng xe bán ra -->
                            data: salesData,  <!-- Dữ liệu số lượng xe bán ra -->
                            backgroundColor: 'rgba(54, 162, 235, 0.8)',  <!-- Màu nền của cột -->
                            borderColor: 'rgba(54, 162, 235, 1)',  <!-- Màu viền của cột -->
                            borderWidth: 1,
                            yAxisID: 'y'  <!-- Sử dụng trục Y chính -->
                        },
                        {
                            label: 'Revenue ($)',  <!-- Dữ liệu cho doanh thu -->
                            data: revenueData,  <!-- Dữ liệu doanh thu -->
                            backgroundColor: 'rgba(75, 192, 192, 0.8)',  <!-- Màu nền của cột -->
                            borderColor: 'rgba(75, 192, 192, 1)',  <!-- Màu viền của cột -->
                            borderWidth: 1,
                            yAxisID: 'y'  <!-- Sử dụng trục Y chính -->
                        },
                        {
                            label: 'Avg Revenue per Unit ($)',  <!-- Dữ liệu cho doanh thu trung bình mỗi đơn vị -->
                            data: avgRevenueData,  <!-- Dữ liệu doanh thu trung bình -->
                            type: 'line',  <!-- Kiểu đồ thị là đường -->
                            borderColor: 'rgba(255, 99, 132, 1)',  <!-- Màu đường -->
                            backgroundColor: 'rgba(255, 99, 132, 0.2)',  <!-- Màu nền đường -->
                            borderWidth: 2,
                            fill: false,
                            tension: 0.4,
                            yAxisID: 'y2'  <!-- Trục y phụ cho đường -->
                        }
                    ]
                },
                options: {
                    responsive: true,  <!-- Đảm bảo biểu đồ có thể thay đổi kích thước -->
                    maintainAspectRatio: false,  <!-- Không duy trì tỷ lệ khung hình cố định -->
                    scales: {
                        y: {
                            beginAtZero: true,  <!-- Trục y bắt đầu từ 0 -->
                            position: 'left',
                            title: {
                                display: true,
                                text: 'Units Sold & Revenue ($)',  <!-- Tiêu đề trục y -->
                                color: '#f8f9fa'
                            },
                            grid: {
                                color: 'rgba(255, 255, 255, 0.1)'  <!-- Màu lưới của trục y -->
                            },
                            ticks: {
                                color: '#f8f9fa'  <!-- Màu chữ trên trục y -->
                            }
                        },
                        y2: {
                            beginAtZero: true,  <!-- Trục y phụ bắt đầu từ 0 -->
                            position: 'right',
                            title: {
                                display: true,
                                text: 'Avg Revenue per Unit ($)',  <!-- Tiêu đề trục y phụ -->
                                color: '#ff6384'
                            },
                            grid: {
                                drawOnChartArea: false  <!-- Không vẽ lưới trên trục y phụ -->
                            },
                            ticks: {
                                color: '#ff6384'  <!-- Màu chữ trên trục y phụ -->
                            }
                        }
                    },
                    plugins: {
                        legend: {
                            labels: {
                                color: '#f8f9fa'  <!-- Màu chữ trong phần legend -->
                            }
                        },
                        tooltip: {
                            backgroundColor: 'rgba(26, 26, 26, 0.9)',  <!-- Màu nền của tooltip -->
                            titleColor: '#D4AF37',  <!-- Màu chữ tiêu đề của tooltip -->
                            bodyColor: '#f8f9fa'  <!-- Màu chữ nội dung của tooltip -->
                        }
                    }
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
