<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Order Management - MotoVibe</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="sha512-..." crossorigin="anonymous" referrerpolicy="no-referrer" />
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

            .btn-confirm-deposit {
                background-color: var(--primary-gold);
                color: var(--dark-black);
                font-weight: bold;
                padding: 0.5rem 1rem;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            .btn-confirm-deposit:hover {
                background-color: var(--secondary-gold);
            }
            .text-message {
                font-size: 16px;
                color: #ff5722; /* You can change the color */
                font-weight: bold;
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container">
            <div class="orders-section">
                <h2 class="section-title"><i class="fas fa-shopping-cart me-2"></i>Order Management</h2>
                
                <c:if test="${sessionScope.user.role eq 'employee'}">
                    <!-- Create Order Button -->
                    <div class="text-center mt-4">
                        <a href="MotorOfEmployeeCreateServlet" class="btn btn-primary btn-lg">
                            <i class="fas fa-plus me-2"></i> Create Order
                        </a>
                    </div>
                </c:if>

                <c:if test="${sessionScope.user.role eq 'admin' ||sessionScope.user.role eq 'employee'}">
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
                                        <th>Order Code</th>
                                        <th>Order ID</th>
                                        <th>Customer ID</th>
                                        <th>Employee ID</th>
                                        <th>Motor ID</th>
                                        <th>Create Date</th>
                                        <th>Payment Method</th>
                                        <th>Total Amount</th>
                                        <th>Deposit Status</th>
                                        <th>Order Status</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="order" items="${orders}">
                                        <tr>
                                            <td><strong class="order-code">${order.orderCode}</strong></td>
                                            <td>#${order.orderId}</td>
                                            <td>${order.customerId != 0 ? order.customerId : 'N/A'}</td>
                                            <td>${order.employeeId != 0 ? order.employeeId : 'N/A'}</td>
                                            <td>${order.motorId != 0 ? order.motorId : 'N/A'}</td>
                                            <td>${not empty order.createDate ? order.createDate : 'N/A'}</td>
                                            <td>${not empty order.paymentMethod ? order.paymentMethod : 'N/A'}</td>
                                            <td>${order.totalAmount != null ? order.totalAmount : '0.00'}</td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${order.depositStatus != null && order.depositStatus}">
                                                        Yes
                                                    </c:when>
                                                    <c:otherwise>
                                                        No
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td>
                                                <span class="status-badge
                                                      ${order.orderStatus == 'Pending' ? 'status-pending' : 
                                                        order.orderStatus == 'Shipped' ? 'status-shipped' : 
                                                        order.orderStatus == 'Delivered' ? 'status-delivered' : 
                                                        'status-cancelled'}">
                                                    <i class="fas
                                                       ${order.orderStatus == 'Pending' ? 'fa-clock' : 
                                                         order.orderStatus == 'Shipped' ? 'fa-truck' : 
                                                         order.orderStatus == 'Delivered' ? 'fa-check-circle' : 
                                                         'fa-times-circle'} me-1"></i>
                                                       ${order.orderStatus}
                                                    </span>
                                                </td>
                                                <td>                                                   
                                                    <c:if test="${sessionScope.user.role eq 'admin'}">
                                                        <!-- Show Confirm Deposit Button only if Deposit Status is "No" -->
                                                        <c:if test="${order.depositStatus eq false}">
                                                            <div id="confirm-deposit-${order.orderId}" class="confirm-deposit-container">
                                                                <form action="confirmDeposit" method="post">
                                                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                                                    <button type="submit" class="btn-confirm-deposit">Confirm Deposit</button>
                                                                </form>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${order.depositStatus eq true && order.hasWarranty eq true }">
                                                            <div id="warranty-${order.orderId}" class="create-warranty-container">
                                                                <form action="createWarranty" method="post">
                                                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                                                    <button type="submit" class="btn-create-warranty">Detail Warranty</button>
                                                                </form>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${order.depositStatus eq true && order.hasWarranty eq false }">
                                                            <div id="warranty-${order.orderId}" class="create-warranty-container">
                                                                <button type="submit" class="btn-create-warranty">No Warranty</button>
                                                            </div>
                                                        </c:if>
                                                    </c:if>


                                                    <c:if test="${sessionScope.user.role eq 'employee'}">
                                                        <c:if test="${order.depositStatus eq true && order.orderStatus eq 'Processing'}">
                                                            <div id="confirm-deposit-${order.orderId}" class="confirm-deposit-container">
                                                                <form action="ConfirmOrderEmployeeServlet" method="post">
                                                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                                                    <button type="submit" class="btn-confirm-deposit">Confirm Order</button>
                                                                </form>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${order.depositStatus eq true && order.orderStatus eq 'Completed' && order.hasWarranty eq true}">
                                                            <div id="warranty-${order.orderId}" class="create-warranty-container">
                                                                <form action="createWarranty" method="post">
                                                                    <input type="hidden" name="orderId" value="${order.orderId}">
                                                                    <button type="submit" class="btn-create-warranty">Create Warranty</button>
                                                                </form>
                                                            </div>
                                                        </c:if>
                                                        <c:if test="${order.depositStatus eq true && order.orderStatus eq 'Completed' && order.hasWarranty eq false}">
                                                            <div id="warranty-${order.orderId}" class="create-warranty-container">
                                                                <input type="hidden" name="orderId" value="${order.orderId}">
                                                                <button type="submit" class="btn-create-warranty">No Warranty</button>
                                                            </div>
                                                        </c:if>
                                                    </c:if>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </c:if>
                    </c:if>


                </div>
            </div>

            <jsp:include page="footer.jsp"/>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        </body>
    </html>
