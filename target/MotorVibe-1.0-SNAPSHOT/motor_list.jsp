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
        <title>Motorbike Collection - MotoVibe</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
                margin-bottom: 30px;
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

            .filter-container {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                padding: 20px;
                margin-bottom: 30px;
            }
            
            .form-control, .form-select {
                background: rgba(26, 26, 26, 0.9);
                border: 1px solid var(--primary-gold);
                color: var(--text-gold);
                padding: 10px;
            }
            
            .form-control::placeholder {
                color: rgba(255, 255, 255, 0.5);
            }
            
            .form-control:focus, .form-select:focus {
                background: rgba(26, 26, 26, 0.95);
                border-color: var(--primary-gold);
                box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
                color: var(--text-gold);
            }
            
            .btn-primary {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
                padding: 10px 20px;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            .btn-secondary {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                padding: 10px 20px;
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
            }
            
            .btn-secondary:hover {
                background: rgba(212, 175, 55, 0.1);
                color: var(--primary-gold);
                transform: translateY(-2px);
            }
            
            .btn-outline-success {
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                background: transparent;
                transition: all 0.3s ease;
            }
            
            .btn-outline-success:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
            }

            .table {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                color: var(--text-gold);
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            .table thead th {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                text-transform: uppercase;
                letter-spacing: 1px;
                font-weight: 600;
                padding: 15px;
            }

            .table tbody tr {
                border-bottom: 1px solid rgba(212, 175, 55, 0.2);
                transition: all 0.3s ease;
            }
            
            .table tbody tr:hover {
                background: rgba(212, 175, 55, 0.05);
            }
            
            .table tbody tr:last-child {
                border-bottom: none;
            }
            
            .table td, .table th {
                vertical-align: middle;
            }
            
            .text-success {
                color: #6eff7a !important;
            }
            
            .text-danger {
                color: #ff6e6e !important;
            }
            
            .btn-sm {
                padding: 5px 10px;
                font-size: 0.8rem;
            }
            
            .btn-full-width {
                width: 100%;
                margin-top: 5px;
            }
            
            .btn-warning {
                background: linear-gradient(145deg, #f0ad4e, #ec971f);
                border: none;
                color: var(--dark-black);
            }
            
            .btn-info {
                background: linear-gradient(145deg, #5bc0de, #31b0d5);
                border: none;
                color: var(--dark-black);
            }
            
            .motor-image {
                border: 2px solid var(--primary-gold);
                border-radius: 5px;
                transition: all 0.3s ease;
            }
            
            .motor-image:hover {
                transform: scale(1.05);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="container mt-4">
            <h2 class="text-center"><i class="fas fa-motorcycle me-2"></i>Motorbike Collection</h2>

            <div class="filter-container">
                <div class="d-flex justify-content-between mb-3">
                    <div>
                        <c:if test="${sessionScope.user.role eq 'admin'}">
                            <a href="addMotor" class="btn btn-primary">
                                <i class="fas fa-plus me-2"></i>Add New Motorbike
                            </a>
                            <a href="inventoryLog" class="btn btn-secondary ms-2">
                                <i class="fas fa-history me-2"></i>Inventory Log
                            </a>
                        </c:if>
                    </div>
                    <form action="searchMotors" method="get" class="d-flex">
                        <input class="form-control me-2" type="search" placeholder="Search by Name" name="searchTerm" aria-label="Search">
                        <button class="btn btn-outline-success" type="submit">
                            <i class="fas fa-search me-1"></i> Search
                        </button>
                    </form>
                </div>

                <form action="filterMotors" method="get" class="row g-3 align-items-center">
                    <div class="col-md-4">
                        <label class="form-label text-gold">Brand</label>
                        <select class="form-select" name="brandId" id="brandId">
                            <option value="">All Brands</option>
                            <c:forEach var="brand" items="${brands}">
                                <option value="${brand.brandId}">${brand.brandName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label text-gold">Fuel Type</label>
                        <select class="form-select" name="fuelId" id="fuelId">
                            <option value="">All Fuel Types</option>
                            <c:forEach var="fuel" items="${fuels}">
                                <option value="${fuel.fuelId}">${fuel.fuelName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label text-gold">Model</label>
                        <select class="form-select" name="modelId" id="modelId">
                            <option value="">All Models</option>
                            <c:forEach var="model" items="${models}">
                                <option value="${model.modelId}">${model.modelName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-md-2">
                        <label class="form-label" style="opacity: 0;">Filter</label>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-filter me-1"></i> Filter
                            </button>
                            <a href="motorList" class="btn btn-secondary">
                                <i class="fas fa-sync-alt me-1"></i> Reset
                            </a>
                        </div>
                    </div>
                </form>
            </div>

            <c:choose>
                <c:when test="${sessionScope.user.role eq 'admin'}">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Name</th>
                                    <th>Brand</th>
                                    <th>Model</th>
                                    <th>Fuel</th>
                                    <th>Color</th>
                                    <th>Price</th>
                                    <th>Date</th>
                                    <th>Quantity</th>
                                    <th>Image</th>
                                    <th>Actions</th>
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
                                        <td>$${motor.price}</td>
                                        <td>${motor.dateStart}</td>
                                        <td>${motor.quantity}</td>
                                        <td>
                                            <img src="images/${motor.picture}" alt="${motor.motorName}" class="motor-image" style="max-width: 100px; height: auto;">
                                        </td>
                                        <td>
                                            <div class="d-flex flex-column">
                                                <a href="changeQuantity?id=${motor.motorId}" class="btn btn-warning btn-sm mb-1">
                                                    <i class="fas fa-boxes me-1"></i> Change Quantity
                                                </a>
                                                <a href="toggleMotorStatus?id=${motor.motorId}" class="btn btn-secondary btn-sm mb-1">
                                                    <i class="fas ${motor.present eq true ? 'fa-eye-slash' : 'fa-eye'} me-1"></i>
                                                    ${motor.present eq true ? 'Hide' : 'Show'}
                                                </a>
                                                <a href="motorDetail?id=${motor.motorId}" class="btn btn-info btn-sm">
                                                    <i class="fas fa-info-circle me-1"></i> Details
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:when>
                <c:otherwise>
                    <jsp:include page="motor_tags_view.jsp"></jsp:include>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>