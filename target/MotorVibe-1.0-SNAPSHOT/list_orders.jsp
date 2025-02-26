<%-- 
    Document   : list_orders
    Created on : Feb 27, 2025, 5:46:09 AM
    Author     : truon
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="models.Order" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Order List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-gold: #D4AF37;
            --secondary-gold: #C5A028;
            --dark-black: #111111;
            --rich-black: #1A1A1A;
            --text-gold: #F5E6CC;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-gold);
            background: var(--dark-black);
        }

        .orders-section {
            background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            padding: 2rem;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            border: 1px solid var(--primary-gold);
        }

        .section-title {
            color: var(--primary-gold);
            font-size: 2.5rem;
            font-weight: 700;
            text-transform: uppercase;
            margin-bottom: 2rem;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            position: relative;
        }

        .section-title::after {
            content: '';
            position: absolute;
            bottom: -15px;
            left: 50%;
            transform: translateX(-50%);
            width: 100px;
            height: 3px;
            background: var(--primary-gold);
            box-shadow: 0 0 10px var(--primary-gold);
        }

        .table {
            background: transparent;
            border-radius: 10px;
            overflow: hidden;
            margin-top: 2rem;
        }

        .table-dark {
            background: linear-gradient(145deg, var(--rich-black), var(--dark-black));
            border-color: var(--primary-gold);
        }

        .table th {
            color: var(--primary-gold);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-bottom: 2px solid var(--primary-gold);
            padding: 1rem;
        }

        .table td {
            color: var(--text-gold);
            border-color: rgba(212, 175, 55, 0.2);
            padding: 1rem;
            vertical-align: middle;
        }

        .table tbody tr {
            transition: all 0.3s ease;
        }

        .table tbody tr:hover {
            background: rgba(212, 175, 55, 0.1);
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            border: none;
            color: var(--dark-black);
            font-weight: 600;
            padding: 0.5rem 1rem;
            border-radius: 5px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            background: linear-gradient(145deg, var(--secondary-gold), var(--primary-gold));
        }

        .alert-info {
            background: linear-gradient(145deg, #1a1a1a, #222);
            border: 1px solid var(--primary-gold);
            color: var(--text-gold);
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            margin-top: 2rem;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container mt-5" style="margin-top: 100px !important;">
        <div class="orders-section">
            <h2 class="section-title">Order List</h2>

            <c:if test="${empty orders}">
                <div class="alert alert-info">No orders found.</div>
            </c:if>

            <c:if test="${not empty orders}">
                <div class="table-responsive">
                    <table class="table table-bordered">
                        <thead class="table-dark">
                            <tr>
                                <th>Order ID</th>
                                <th>Motor ID</th>
                                <th>Order Status</th>
                                <th>Total Amount</th>
                                <th>Has Warranty?</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td>${o.orderId}</td>
                                    <td>${o.motorId}</td>
                                    <td>${o.orderStatus}</td>
                                    <td>${o.totalAmount}</td>
                                    <td><c:choose>
                                        <c:when test="${o.hasWarranty}">Yes</c:when>
                                        <c:otherwise>No</c:otherwise>
                                    </c:choose></td>
                                    <td>
                                        <a href="viewOrderWarranty?orderId=${o.orderId}" class="btn btn-sm btn-primary">
                                            View Warranty
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>

    <jsp:include page="footer.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

