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
        <style>
            body {
                background-color: #f8f9fa;
                color: #333;
                padding-top: 80px; /* if you have a fixed header */
            }
            .warranty-container {
                max-width: 800px;
                margin: 0 auto;
                background: #fff;
                border: 1px solid #dee2e6;
                border-radius: 10px;
                padding: 2rem;
                box-shadow: 0 0 10px rgba(0,0,0,0.05);
            }
            .warranty-heading {
                margin-bottom: 1.5rem;
            }
            .btn-custom {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 0.5rem 1rem;
                text-decoration: none;
                border-radius: 5px;
            }
            .btn-custom:hover {
                background-color: #0056b3;
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

