<%-- Document : view_order_warranty 
     Created on : Feb 23, 2025, 12:28:46 AM 
     Author : truon --%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Order,models.Warranty"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Order Warranty Details</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
    <link rel="stylesheet" href="css/luxury-theme.css">
    <style>
        body {
            background: linear-gradient(135deg, var(--dark-black) 0%, #121212 100%);
            color: var(--text-gold);
            padding-top: 80px;
            font-family: 'Poppins', sans-serif;
        }

        .warranty-container {
            max-width: 900px;
            margin: 40px auto;
            background: var(--rich-black);
            border: 2px solid var(--primary-gold);
            border-radius: 15px;
            padding: 2.5rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            position: relative;
            overflow: hidden;
        }
        
        .warranty-container::before {
            content: '';
            position: absolute;
            top: -10px;
            right: -10px;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, rgba(212,175,55,0.2) 0%, rgba(0,0,0,0) 70%);
            z-index: 0;
        }

        h2.warranty-heading {
            color: var(--primary-gold);
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
            margin-bottom: 2rem;
            font-weight: 700;
            font-size: 2.2rem;
            border-bottom: 1px solid rgba(212, 175, 55, 0.3);
            padding-bottom: 1rem;
            position: relative;
        }
        
        h2.warranty-heading::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 100px;
            height: 3px;
            background: linear-gradient(90deg, var(--primary-gold), transparent);
        }
        
        .warranty-icon {
            color: var(--primary-gold);
            font-size: 1.2rem;
            margin-right: 10px;
            width: 25px;
            text-align: center;
        }
        
        .info-card {
            background: rgba(0,0,0,0.2);
            border: 1px solid rgba(212, 175, 55, 0.2);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }
        
        .info-card:hover {
            border-color: var(--primary-gold);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
        }
        
        .info-label {
            color: var(--secondary-gold);
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            margin-bottom: 5px;
            font-weight: 600;
        }
        
        .info-value {
            color: white;
            font-size: 1.1rem;
            font-weight: 500;
        }
        
        .card-title {
            color: var(--primary-gold);
            font-size: 1.3rem;
            margin-bottom: 1.2rem;
            font-weight: 600;
            position: relative;
            padding-left: 30px;
        }
        
        .card-title i {
            position: absolute;
            left: 0;
            top: 5px;
        }

        .btn-custom {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            color: var(--dark-black);
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            transition: all 0.3s ease;
            font-weight: 600;
            letter-spacing: 0.5px;
            display: inline-flex;
            align-items: center;
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
        }

        .btn-custom:hover {
            transform: translateY(-3px);
            box-shadow: 0 7px 15px rgba(212, 175, 55, 0.3);
            color: var(--dark-black);
        }
        
        .btn-custom i {
            margin-right: 8px;
        }
        
        hr {
            border-color: rgba(212, 175, 55, 0.2);
            margin: 2rem 0;
        }
        
        .warranty-status {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 50px;
            font-size: 0.85rem;
            font-weight: 600;
            margin-top: 5px;
            background: rgba(40, 167, 69, 0.2);
            color: #2ecc71;
            border: 1px solid rgba(46, 204, 113, 0.3);
        }
        
        .warranty-badge {
            position: absolute;
            top: 0;
            right: 0;
            background: linear-gradient(135deg, var(--primary-gold), var(--secondary-gold));
            color: var(--dark-black);
            padding: 10px 20px;
            transform: rotate(45deg) translate(25%, -120%);
            transform-origin: top right;
            font-weight: bold;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .expiry-date {
            color: #ff9f43;
            font-weight: 600;
        }
        
        .warranty-details-text {
            line-height: 1.6;
            background: rgba(0,0,0,0.2);
            border-radius: 8px;
            padding: 15px;
            border-left: 3px solid var(--primary-gold);
        }
        
        .alert {
            border-radius: 10px;
            border-left: 4px solid #dc3545;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />

    <div class="container">
        <div class="warranty-container">
            <c:if test="${not empty order && order.hasWarranty}">
                <div class="warranty-badge">Premium Warranty</div>
            </c:if>
            
            <h2 class="warranty-heading">
                <i class="fas fa-shield-alt me-2"></i>Warranty Details
            </h2>
            
            <c:choose>
                <c:when test="${empty order}">
                    <div class="alert alert-danger">
                        <i class="fas fa-exclamation-triangle me-2"></i>
                        Order not found or no warranty available.
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="row mb-4">
                        <div class="col-md-6">
                            <div class="info-card">
                                <h5 class="card-title"><i class="fas fa-file-invoice"></i>Order Information</h5>
                                <div class="mb-3">
                                    <div class="info-label">Order ID</div>
                                    <div class="info-value">${order.orderCode != null ? order.orderCode : order.orderId}</div>
                                </div>
                                <div class="mb-3">
                                    <div class="info-label">Motor ID</div>
                                    <div class="info-value">${order.motorId} ${not empty order.motorName ? '- '.concat(order.motorName) : ''}</div>
                                </div>
                                <div>
                                    <div class="info-label">Order Status</div>
                                    <div class="info-value">
                                        <span class="badge bg-${order.orderStatus eq 'Completed' ? 'success' : order.orderStatus eq 'Processing' ? 'warning' : 'info'}">
                                            ${order.orderStatus}
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <div class="col-md-6">
                            <div class="info-card">
                                <h5 class="card-title"><i class="fas fa-shield-alt"></i>Warranty Status</h5>
                                <div class="mb-3">
                                    <div class="info-label">Protection Plan</div>
                                    <div class="info-value">
                                        <c:choose>
                                            <c:when test="${order.hasWarranty}">
                                                <span class="warranty-status">
                                                    <i class="fas fa-check-circle me-1"></i> Active
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary">No Warranty</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                
                                <c:if test="${order.hasWarranty && not empty order.warranty}">
                                    <div class="mb-3">
                                        <div class="info-label">Warranty ID</div>
                                        <div class="info-value">${order.warranty.warrantyId}</div>
                                    </div>
                                    <div>
                                        <div class="info-label">Expiration Date</div>
                                        <div class="info-value expiry-date">
                                            <i class="far fa-calendar-alt me-1"></i>
                                            <fmt:formatDate value="${order.warranty.warrantyExpiry}" pattern="MMMM dd, yyyy" />
                                        </div>
                                    </div>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <c:if test="${order.hasWarranty && not empty order.warranty}">
                        <div class="info-card">
                            <h5 class="card-title"><i class="fas fa-file-contract"></i>Warranty Coverage Details</h5>
                            <div class="warranty-details-text">
                                ${order.warranty.warrantyDetails}
                            </div>
                        </div>
                    </c:if>
                    
                    <c:if test="${order.hasWarranty && empty order.warranty}">
                        <div class="alert alert-warning">
                            <i class="fas fa-exclamation-circle me-2"></i>
                            This order has warranty coverage, Our warranty package lasts 12 months from the date of purchase, premium package can extend up to 24 months, warranty all manufacturer defects
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>

            <hr>
            <div class="mt-4 d-flex justify-content-between">
                <a href="profile" class="btn btn-custom">
                    <i class="fas fa-user"></i> Back to Profile
                </a>
                <c:if test="${sessionScope.user.role == 'admin' || sessionScope.user.role == 'employee'}">
                    <a href="adminOrders" class="btn btn-custom">
                        <i class="fas fa-list me-1"></i> Back to Orders
                    </a>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>