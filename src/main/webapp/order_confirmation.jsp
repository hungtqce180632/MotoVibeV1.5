<%-- 
    Document   : order_confirmation
    Created on : Feb 24, 2025, 4:50:55 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Confirmation</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="..." crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="container mt-5">
        <div class="alert alert-success" role="alert">
            <h4 class="alert-heading"><i class="fas fa-check-circle"></i> Order Placed Successfully!</h4>
            <p>Thank you for your order. Your order has been received and is being processed.</p>
            <hr>
            <p class="mb-0">You will receive an email confirmation shortly with your order details.</p>
        </div>
        <div class="mt-3">
            <a href="motorList" class="btn btn-primary"><i class="fas fa-motorcycle"></i> Back to Motorbike List</a>
            <a href="index.jsp" class="btn btn-secondary ms-2"><i class="fas fa-home"></i> Back to Home</a>
        </div>
    </div>
    <jsp:include page="footer.jsp"></jsp:include>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
