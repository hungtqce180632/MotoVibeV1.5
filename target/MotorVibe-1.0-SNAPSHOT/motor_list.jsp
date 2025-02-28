<%--
    Document   : motor_list
    Created on : Feb 21, 2025, 3:01:41 PM
    Author     : tiend - upgrade hưng
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Danh sách Motorbike - MotoVibe</title> <%-- Tiêu đề trang, thân thiện hơn --%>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }

            body {
                background: var(--dark-black);
                color: var(--text-gold);
            }

            .container {
                padding-top: 80px; /* Account for fixed header */
            }

            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                position: relative;
                padding-bottom: 15px;
            }

            h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .table {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                color: var(--text-gold);
                border: 1px solid var(--primary-gold);
                border-radius: 15px;
                overflow: hidden;
            }

            .table thead th {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .form-control, .form-select {
                background: rgba(26, 26, 26, 0.9);
                border: 1px solid var(--primary-gold);
                color: var (--text-gold);
            }

            .btn {
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include> <%-- Include header (menu điều hướng) --%>

        <div class="container mt-4"> <%-- Container chính, thêm margin top để cách header --%>
            <h2 class="text-center mb-4">Danh sách Motorbike</h2> <%-- Tiêu đề trang, canh giữa, margin bottom --%>

            <div class="d-flex justify-content-between mb-3"> <%-- Container cho nút thêm mới và form tìm kiếm, flexbox để căn chỉnh --%>
                <div> <%-- Div chứa các nút chức năng (thêm mới, inventory log), chỉ hiển thị cho admin --%>
                    <c:if test="${sessionScope.user.role eq 'admin'}"> <%-- Kiểm tra vai trò admin để hiển thị nút quản lý --%>
                        <a href="addMotor" class="btn btn-primary">Thêm Motorbike mới</a> <%-- Nút "Thêm Motorbike mới" --%>
                        <a href="inventoryLog" class="btn btn-info ms-2">Lịch sử Kho</a> <%-- Nút "Lịch sử Kho", thêm margin left (ms-2) --%>
                    </c:if>
                </div>
                <form action="searchMotors" method="get" class="d-flex"> <%-- Form tìm kiếm theo tên motor, class d-flex để hiển thị inline --%>
                    <input class="form-control me-2" type="search" placeholder="Tìm kiếm theo Tên" name="searchTerm" aria-label="Search"> <%-- Input tìm kiếm, placeholder tiếng Việt --%>
                    <button class="btn btn-outline-success" type="submit">Tìm kiếm</button> <%-- Nút tìm kiếm --%>
                </form>
            </div>

            <div class="mb-3"> <%-- Container cho form filter --%>
                <form action="filterMotors" method="get" class="row g-3 align-items-center"> <%-- Form filter, dùng Bootstrap Grid (row, g-3) và căn giữa theo chiều dọc (align-items-center) --%>
                    <div class="col-auto"> <%-- Cột cho dropdown chọn Brand --%>
                        <select class="form-select" name="brandId" id="brandId"> <%-- Dropdown chọn Brand --%>
                            <option value="">Tất cả Brands</option> <%-- Option "Tất cả Brands" --%>
                            <c:forEach var="brand" items="${brands}"> <%-- Loop qua danh sách brands từ servlet --%>
                                <option value="${brand.brandId}">${brand.brandName}</option> <%-- Hiển thị từng brand trong dropdown --%>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto"> <%-- Cột cho dropdown chọn Fuel Type --%>
                        <select class="form-select" name="fuelId" id="fuelId"> <%-- Dropdown chọn Fuel Type --%>
                            <option value="">Tất cả Loại nhiên liệu</option> <%-- Option "Tất cả Loại nhiên liệu" --%>
                            <c:forEach var="fuel" items="${fuels}"> <%-- Loop qua danh sách fuels từ servlet --%>
                                <option value="${fuel.fuelId}">${fuel.fuelName}</option> <%-- Hiển thị từng fuel type trong dropdown --%>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto"> <%-- Cột cho dropdown chọn Model --%>
                        <select class="form-select" name="modelId" id="modelId"> <%-- Dropdown chọn Model --%>
                            <option value="">Tất cả Models</option> <%-- Option "Tất cả Models" --%>
                            <c:forEach var="model" items="${models}"> <%-- Loop qua danh sách models từ servlet --%>
                                <option value="${model.modelId}">${model.modelName}</option> <%-- Hiển thị từng model trong dropdown --%>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-auto"> <%-- Cột cho nút "Filter" --%>
                        <button type="submit" class="btn btn-primary">Lọc</button> <%-- Nút "Lọc" --%>
                    </div>
                    <div class="col-auto"> <%-- Cột cho nút "Reset Filter" --%>
                        <a href="motorList" class="btn btn-secondary">Reset Bộ lọc</a> <%-- Nút "Reset Bộ lọc", link tới trang motorList để reset filter --%>
                    </div>
                </form>
            </div>

            <%-- Phần hiển thị danh sách motorbikes --%>
            <c:choose>
                <c:when test="${sessionScope.user.role eq 'admin'}">
                    <%-- Hiển thị dạng bảng cho admin --%>
                    <table class="table table-bordered table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Motor's Name</th>
                                <th>Brand</th>
                                <th>Model</th>
                                <th>Fuel</th>
                                <th>Color</th>
                                <th>Price</th>
                                <th>Date</th>
                                <th>Ammount</th>
                                <th>Picture</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="motor" items="${motors}">
                                <tr>
                                    <td>${motor.motorId}</td>
                                    <td>
                                        <a href="motorDetail?id=${motor.motorId}" class="fw-bold text-decoration-none ${motor.present eq true ? 'text-success' : 'text-danger'}">
                                            ${motor.motorName}
                                        </a>
                                    </td>
                                    <td>${brandMap[motor.brandId]}</td>
                                    <td>${modelMap[motor.modelId]}</td>
                                    <td>${fuelMap[motor.fuelId]}</td>
                                    <td>${motor.color}</td>
                                    <td>${motor.price}</td>
                                    <td>${motor.dateStart}</td>
                                    <td>${motor.quantity}</td>
                                    <td>
                                        <img src="images/${motor.picture}" alt="${motor.motorName}" style="max-width: 100px; height: auto;">
                                    </td>
                                    <td>
                                        <c:if test="${sessionScope.user.role eq 'admin'}">
                                            <a href="changeQuantity?id=${motor.motorId}" class="btn btn-warning btn-sm btn-full-width mt-1">Đổi Số lượng</a>
                                            <a href="toggleMotorStatus?id=${motor.motorId}" class="btn btn-secondary btn-sm btn-full-width mt-1">${motor.present eq true ? 'Ẩn' : 'Hiện'}</a>
                                        </c:if>
                                        <a href="motorDetail?id=${motor.motorId}" class="btn btn-info btn-sm btn-full-width mt-1">Xem Chi tiết</a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <%-- Hiển thị dạng tag/card cho customer, employee, guest --%>
                    <jsp:include page="motor_tags_view.jsp"></jsp:include>
                </c:otherwise>
            </c:choose>

        </div>

        <jsp:include page="footer.jsp"></jsp:include> <%-- Include footer --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script> <%-- Bootstrap JS bundle --%>
    </body>
</html>