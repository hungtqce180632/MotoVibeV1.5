<%-- 
    Document   : view_order_warranty
    Created on : Feb 23, 2025, 12:28:46 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Order"%>
<%@page import="models.Warranty"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Order Warranty Details</title>
        <!-- Include your Bootstrap / CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <style>
            body {
                background: var(--dark-black);
                color: var(--text-gold);
                padding-top: 80px; /* if you have a fixed header */
            }
            .warranty-container {
                max-width: 800px;
                margin: 0 auto;
                background: var(--rich-black);
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 2rem;
                box-shadow: 0 5px 15px rgba(0,0,0,0.3);
            }
            h2.warranty-heading {
                color: var(--primary-gold);
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            }
            .btn-custom {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                padding: 0.5rem 1rem;
                text-decoration: none;
                border-radius: 5px;
            }
            .btn-custom:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
        </style>
    </head>
    <body>

        <!-- Optionally include your header -->
        <jsp:include page="header.jsp"/>

        <div class="container">
            <div class="warranty-container">
                <h2 class="warranty-heading">Order Warranty Details</h2>
                <%
                    // The servlet should have: request.setAttribute("order", someOrder);
                    Order order = (Order) request.getAttribute("order");
                    if (order == null) {
                %>
                <div class="alert alert-danger">Order not found or no warranty available.</div>
                <%
                    } else {
                        Warranty w = order.getWarranty();
                %>
                <p><strong>Order ID:</strong> <%= order.getOrderId() %></p>
                <p><strong>Motor ID:</strong> <%= order.getMotorId() %></p>
                <p><strong>Order Status:</strong> <%= order.getOrderStatus() %></p>
                <p><strong>Has Warranty?</strong> <%= order.isHasWarranty() ? "Yes" : "No" %></p>

                <hr>
                <h4>Warranty Information</h4>
                <%
                    if (w == null) {
                %>
                <div class="alert alert-warning">No warranty details found.</div>
                <%
                    } else {
                %>
                <p><strong>Warranty ID:</strong> <%= w.getWarrantyId() %></p>
                <p><strong>Warranty Details:</strong> <%= w.getWarrantyDetails() %></p>
                <p><strong>Warranty Expiry:</strong> <%= w.getWarrantyExpiry() %></p>
                <%
                    }
                }
                %>
                <hr>
                <a href="profile" class="btn btn-custom">Back to Profile</a>
            </div>
        </div>

        <!-- Optionally include your footer -->
        <jsp:include page="footer.jsp"/>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

