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
    <title>Order Management - MotoVibe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
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
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            color: var(--text-gold);
            background: var(--dark-black);
        }

        .orders-section {
            background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            border: 1px solid var(--primary-gold);
            margin: 2rem auto;
            max-width: 1200px;
        }

        .section-title {
            color: var(--primary-gold);
            font-size: 2rem;
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
            height: 2px;
            background: var(--primary-gold);
            box-shadow: 0 0 10px var(--primary-gold);
        }

        .table {
            margin-top: 2rem;
            border: 1px solid var(--primary-gold);
            border-radius: 10px;
            overflow: hidden;
            color: var(--text-gold);
        }

        .table thead th {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            color: var(--dark-black);
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
            border: none;
            padding: 1rem;
            vertical-align: middle;
        }

        .table tbody td {
            color: var(--text-gold);
            border-color: rgba(212, 175, 55, 0.2);
            padding: 1rem;
            vertical-align: middle;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            background: transparent;
        }

        .table tbody tr:hover {
            background: rgba(212, 175, 55, 0.05);
            transform: translateY(-2px);
        }

        .btn-primary {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            border: none;
            color: var(--dark-black);
            font-weight: 600;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }

        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.8rem;
        }

        .alert-info {
            background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            border: 1px solid var(--primary-gold);
            color: var(--text-gold);
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
            margin-top: 2rem;
        }

        .order-filters {
            display: flex;
            gap: 1rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .filter-btn {
            background: transparent;
            border: 1px solid var(--secondary-gold);
            color: var(--text-gold);
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }

        .filter-btn:hover, .filter-btn.active {
            background: var(--primary-gold);
            color: var(--dark-black);
            transform: translateY(-2px);
        }

        /* Status pill badges */
        .status-badge {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .status-pending {
            background: linear-gradient(145deg, #ffc107, #e0a800);
            color: var(--dark-black);
        }

        .status-shipped {
            background: linear-gradient(145deg, #17a2b8, #138496);
            color: white;
        }

        .status-delivered {
            background: linear-gradient(145deg, #28a745, #218838);
            color: white;
        }

        .status-cancelled {
            background: linear-gradient(145deg, #dc3545, #c82333);
            color: white;
        }

        .warranty-badge {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            color: var(--dark-black);
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
        }

        .container {
            padding-top: 80px;
            padding-bottom: 50px;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"/>

    <div class="container">
        <div class="orders-section">
            <h2 class="section-title"><i class="fas fa-shopping-cart me-2"></i>Order Management</h2>

            <div class="order-filters">
                <button class="filter-btn active" data-filter="all">All Orders</button>
                <button class="filter-btn" data-filter="pending">Pending</button>
                <button class="filter-btn" data-filter="shipped">Shipped</button>
                <button class="filter-btn" data-filter="delivered">Delivered</button>
                <button class="filter-btn" data-filter="warranty">With Warranty</button>
            </div>

            <c:if test="${empty orders}">
                <div class="alert alert-info">
                    <i class="fas fa-info-circle me-2"></i> No orders found.
                </div>
            </c:if>

            <c:if test="${not empty orders}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Order ID</th>
                                <th>Motor</th>
                                <th>Status</th>
                                <th>Total Amount</th>
                                <th>Warranty</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="o" items="${orders}">
                                <tr>
                                    <td>#${o.orderId}</td>
                                    <td>${o.motorId}</td>
                                    <td>
                                        <span class="status-badge 
                                            ${o.orderStatus eq 'Pending' ? 'status-pending' : 
                                             o.orderStatus eq 'Shipped' ? 'status-shipped' : 
                                             o.orderStatus eq 'Delivered' ? 'status-delivered' : 
                                             'status-cancelled'}">
                                            <i class="fas 
                                                ${o.orderStatus eq 'Pending' ? 'fa-clock' : 
                                                 o.orderStatus eq 'Shipped' ? 'fa-truck' : 
                                                 o.orderStatus eq 'Delivered' ? 'fa-check-circle' : 
                                                 'fa-times-circle'} me-1"></i>
                                            ${o.orderStatus}
                                        </span>
                                    </td>
                                    <td>$${o.totalAmount}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${o.hasWarranty}">
                                                <span class="warranty-badge">
                                                    <i class="fas fa-shield-alt me-1"></i> Included
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">None</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <a href="viewOrderDetails?orderId=${o.orderId}" class="btn btn-primary btn-sm me-1">
                                            <i class="fas fa-info-circle me-1"></i> Details
                                        </a>
                                        <c:if test="${o.hasWarranty}">
                                            <a href="viewOrderWarranty?orderId=${o.orderId}" class="btn btn-primary btn-sm">
                                                <i class="fas fa-shield-alt me-1"></i> Warranty
                                            </a>
                                        </c:if>
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
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // Filter buttons functionality
            const filterButtons = document.querySelectorAll('.filter-btn');
            const orderRows = document.querySelectorAll('tbody tr');

            filterButtons.forEach(button => {
                button.addEventListener('click', function() {
                    // Remove active class from all buttons
                    filterButtons.forEach(btn => btn.classList.remove('active'));
                    // Add active class to clicked button
                    this.classList.add('active');

                    const filter = this.getAttribute('data-filter');

                    orderRows.forEach(row => {
                        if (filter === 'all') {
                            row.style.display = '';
                        } else if (filter === 'warranty') {
                            if (row.querySelector('.warranty-badge')) {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        } else {
                            const statusText = row.querySelector('.status-badge').textContent.trim();
                            if (statusText.toLowerCase().includes(filter)) {
                                row.style.display = '';
                            } else {
                                row.style.display = 'none';
                            }
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>

