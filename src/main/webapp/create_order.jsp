<%-- 
    Document   : create_order
    Created on : Feb 24, 2025, 4:30:58 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create Order</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="..." crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        :root {
            --primary-gold: #D4AF37;
            --secondary-gold: #C5A028;
            --dark-black: #111111;
            --rich-black: #1A1A1A;
            --text-gold: #F5E6CC;
        }

        body {
            background: var(--dark-black) !important;
            color: var(--text-gold);
            min-height: 100vh;
        }

        .container {
            background: var(--dark-black) !important;
            padding-top: 80px;
            min-height: calc(100vh - 80px); /* Account for header */
        }

        h1 {
            color: var(--primary-gold);
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100px;
            height: 2px;
            background: var(--primary-gold);
            box-shadow: 0 0 10px var(--primary-gold);
        }

        .lead {
            color: var(--text-gold);
            opacity: 0.9;
        }

        .card {
            background: linear-gradient(145deg, var(--dark-black), var(--rich-black)) !important;
            border: 1px solid var(--primary-gold);
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        }

        .card-title {
            color: var(--primary-gold);
            font-weight: 600;
        }

        .card-text {
            color: var(--text-gold);
        }

        .form-label {
            color: var(--primary-gold);
            font-weight: 500;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-size: 0.9rem;
        }

        .form-control,
        .form-select,
        textarea {
            background: var(--rich-black) !important;
            border: 1px solid var(--primary-gold) !important;
            color: var(--text-gold) !important;
            transition: all 0.3s ease;
        }

        .form-control:focus,
        .form-select:focus,
        textarea:focus {
            background: var(--dark-black) !important;
            border-color: var(--secondary-gold) !important;
            box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25) !important;
        }

        .btn {
            text-transform: uppercase;
            letter-spacing: 1px;
            transition: all 0.3s ease;
            margin: 0 5px;
            padding: 10px 20px;
        }

        .btn-primary {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            border: none;
            color: var(--dark-black);
        }

        .btn-secondary {
            background: transparent;
            border: 1px solid var(--primary-gold);
            color: var(--primary-gold);
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }

        .text-muted {
            color: var(--text-gold) !important;
            opacity: 0.7;
        }

        /* Custom styling for the availability badge */
        .availability-badge {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            color: var(--dark-black);
            padding: 5px 10px;
            border-radius: 15px;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .out-of-stock {
            background: linear-gradient(145deg, #dc3545, #c82333);
            color: white;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="container mt-4">
        <h1><i class="fas fa-shopping-cart"></i> Create Your Order</h1>
        <p class="lead">Please review the motorbike details and enter your information to place your order.</p>

        <div class="card mb-4">
            <div class="row g-0">
                <div class="col-md-4">
                    <img src="images/${motor.picture}" class="img-fluid rounded-start" alt="${motor.motorName}">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title">${motor.motorName}</h5>
                        <p class="card-text"><strong>Price:</strong> $${motor.price}</p>
                        <p class="card-text">
                            <span class="availability-badge ${motor.quantity > 0 ? '' : 'out-of-stock'}">
                                <c:choose>
                                    <c:when test="${motor.quantity > 0}">In Stock</c:when>
                                    <c:otherwise>Out of Stock</c:otherwise>
                                </c:choose>
                            </span>
                        </p>
                    </div>
                </div>
            </div>
        </div>

        <form action="confirmOrder" method="post" class="needs-validation" novalidate>
            <input type="hidden" name="motorId" value="${motor.motorId}">

            <div class="mb-3">
                <label for="customerName" class="form-label">Your Name</label>
                <input type="text" class="form-control" id="customerName" name="customerName" required>
            </div>
            <div class="mb-3">
                <label for="customerEmail" class="form-label">Email Address</label>
                <input type="email" class="form-control" id="customerEmail" name="customerEmail" required>
            </div>
            <div class="mb-3">
                <label for="customerPhone" class="form-label">Phone Number</label>
                <input type="tel" class="form-control" id="customerPhone" name="customerPhone" required>
            </div>
            <div class="mb-3">
                <label for="customerIdNumber" class="form-label">ID Number (e.g., Passport/ID Card)</label>
                <input type="text" class="form-control" id="customerIdNumber" name="customerIdNumber" required>
            </div>
            <div class="mb-3">
                <label for="customerAddress" class="form-label">Shipping Address</label>
                <textarea class="form-control" id="customerAddress" name="customerAddress" rows="3" required></textarea>
            </div>

            <div class="mt-4">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-check"></i> Confirm Order
                </button>
                <a href="motorDetail?id=${motor.motorId}" class="btn btn-secondary">
                    <i class="fas fa-times"></i> Cancel
                </a>
            </div>
        </form>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
