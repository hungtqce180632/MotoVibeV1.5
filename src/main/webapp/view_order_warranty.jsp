<%-- Document : view_order_warranty 
     Created on : Feb 23, 2025, 12:28:46 AM 
     Author : truon --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Order,models.Warranty"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Warranty Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/luxury-theme.css">
    <style>
        body {
            background: var(--dark-black);
            color: var(--text-gold);
            padding-top: 80px;
        }

        .warranty-container {
            max-width: 800px;
            margin: 20px auto;
            background: var(--rich-black);
            border: 1px solid var(--primary-gold);
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }

        h2.warranty-heading {
            color: var(--primary-gold);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            margin-bottom: 1.5rem;
        }

        .btn-custom {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            color: var(--dark-black);
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .btn-custom:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            color: var(--dark-black);
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="warranty-container">
            <h2 class="warranty-heading">Order Warranty Details</h2>
            <c:choose>
                <c:when test="${empty order}">
                    <div class="alert alert-danger">Order not found or no warranty available.</div>
                </c:when>
                <c:otherwise>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Order ID:</strong> ${order.orderId}</p>
                            <p><strong>Motor ID:</strong> ${order.motorId}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Order Status:</strong> ${order.orderStatus}</p>
                            <p><strong>Has Warranty?</strong> ${order.hasWarranty ? 'Yes' : 'No'}</p>
                        </div>
                    </div>

                    <hr>
                    <h4>Warranty Information</h4>
                    <c:choose>
                        <c:when test="${empty order.warranty}">
                            <div class="alert alert-warning">No warranty details found.</div>
                        </c:when>
                        <c:otherwise>
                            <p><strong>Warranty ID:</strong> ${order.warranty.warrantyId}</p>
                            <p><strong>Warranty Details:</strong> ${order.warranty.warrantyDetails}</p>
                            <p><strong>Warranty Expiry:</strong> ${order.warranty.warrantyExpiry}</p>
                        </c:otherwise>
                    </c:choose>
                </c:otherwise>
            </c:choose>

            <hr>
            <div class="mt-3">
                <a href="profile" class="btn btn-custom me-2">Back to Profile</a>
                <c:if test="${sessionScope.user.role == 'admin' || sessionScope.user.role == 'employee'}">
                    <a href="adminOrders" class="btn btn-custom">
                        <i class="fas fa-cog me-2"></i>Back to Admin Orders
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>