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
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="container mt-4">
        <h1><i class="fas fa-shopping-cart"></i> Create Your Order</h1>
        <p class="lead">Please review the motorbike details and enter your information to place your order.</p>

        <div class="card mb-3">
            <div class="row g-0">
                <div class="col-md-4">
                    <img src="images/${motor.picture}" class="img-fluid rounded-start" alt="${motor.motorName}">
                </div>
                <div class="col-md-8">
                    <div class="card-body">
                        <h5 class="card-title">${motor.motorName}</h5>
                        <p class="card-text"><strong>Price:</strong> $${motor.price}</p>
                        <p class="card-text"><small class="text-muted">Availability: <c:choose>
                            <c:when test="${motor.quantity > 0}">In Stock</c:when><c:otherwise>Out of Stock</c:otherwise></c:choose></small></p>
                    </div>
                </div>
            </div>
        </div>

        <form action="confirmOrder" method="post"> <!- Form will submit to ConfirmOrderServlet (to be created) -->
            <input type="hidden" name="motorId" value="${motor.motorId}"> <!- Hidden field to pass motorId -->

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

            <button type="submit" class="btn btn-primary"><i class="fas fa-check"></i> Confirm Order</button>
            <a href="motorDetail?id=${motor.motorId}" class="btn btn-secondary ms-2"><i class="fas fa-times"></i> Cancel</a>
        </form>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
