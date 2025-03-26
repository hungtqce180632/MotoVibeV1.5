<%-- Document : order_by_employee Created on : Mar 1, 2025, 9:44:56 PM Author : ACER --%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Order for Customer - MotoVibe</title>
        <link rel="stylesheet"
              href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
        <link rel="stylesheet"
              href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
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
                min-height: calc(100vh - 80px);
                /* Account for header */
            }

            .order-container {
                max-width: 900px;
                margin: 0 auto;
            }

            h1,
            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
                position: relative;
                padding-bottom: 15px;
                margin-bottom: 30px;
            }

            h1::after,
            h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 100px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .lead,
            .text-muted {
                color: var(--text-gold) !important;
                opacity: 0.9;
            }

            .card {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                overflow: hidden;
                margin-bottom: 2rem;
            }

            .card-header {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold)) !important;
                color: var(--dark-black) !important;
                font-weight: 600;
                letter-spacing: 1px;
                border-bottom: 1px solid var(--secondary-gold);
            }

            .form-label {
                color: var(--primary-gold);
                font-weight: 500;
                letter-spacing: 1px;
                margin-bottom: 0.5rem;
            }

            .form-control,
            .form-select {
                background: rgba(0, 0, 0, 0.2) !important;
                border: 1px solid var(--secondary-gold) !important;
                color: white !important;
                padding: 10px;
            }

            .form-control:focus,
            .form-select:focus {
                background: rgba(0, 0, 0, 0.3) !important;
                border-color: var(--primary-gold) !important;
                box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.25) !important;
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
                font-weight: 600;
                transition: all 0.3s ease;
                padding: 10px 25px;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }

            .btn-secondary {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                transition: all 0.3s ease;
                padding: 10px 25px;
            }

            .btn-secondary:hover {
                background: rgba(218, 165, 32, 0.1);
                color: var(--primary-gold);
                transform: translateY(-2px);
            }

            .btn-success {
                background: linear-gradient(145deg, #28a745, #20883b);
                border: none;
                color: white;
                font-weight: 600;
                transition: all 0.3s ease;
            }

            .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            }

            .alert {
                border-left: 4px solid var(--primary-gold);
                background-color: rgba(0, 0, 0, 0.2);
                color: var(--text-gold);
            }

            .alert-danger {
                border-left-color: #dc3545;
            }

            .alert-success {
                border-left-color: #28a745;
            }

            .table {
                color: var(--text-gold);
            }

            .table-striped>tbody>tr:nth-of-type(odd) {
                background-color: rgba(0, 0, 0, 0.1);
            }

            .table-hover>tbody>tr:hover {
                background-color: rgba(212, 175, 55, 0.1);
            }

            .warranty-option {
                background: rgba(0, 0, 0, 0.2);
                border: 1px solid var(--secondary-gold);
                border-radius: 5px;
                padding: 1rem;
            }

            .form-check-input {
                background-color: var(--rich-black);
                border: 1px solid var(--secondary-gold);
            }

            .form-check-input:checked {
                background-color: var(--primary-gold);
                border-color: var(--primary-gold);
            }

            .price-info {
                background: rgba(0, 0, 0, 0.2) !important;
                border-left: 3px solid var(--primary-gold) !important;
                border-radius: 5px;
                padding: 1.5rem !important;
                color: var(--text-gold);
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp" />

        <div class="container mt-4">
            <div class="order-container">
                <h2><i class="fas fa-shopping-cart me-2"></i> Create Order for Existing Customer</h2>
                <p class="lead">Select a customer and motorcycle to create a new order.</p>

                <!-- Display success/error messages -->
                <c:if test="${not empty sessionScope.errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show">
                        <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% session.removeAttribute("errorMessage"); %>
                </c:if>

                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show">
                        <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                    </div>
                    <% session.removeAttribute("successMessage"); %>
                </c:if>

                <!-- Selection Section -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-search me-2"></i>Select Customer and Motorcycle
                    </div>
                    <div class="card-body">
                        <form action="" method="get" class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="customerName" class="form-label">Customer Name*</label>
                                    <select name="customerId" id="customerName" class="form-select"
                                            required>
                                        <option value="" disabled selected>Select Customer</option>
                                        <c:forEach var="customer" items="${customers}">
                                            <option value="${customer.customerId}" <c:if
                                                        test="${customer.customerId == param.customerId}">
                                                        selected</c:if>>
                                                    ${customer.name}
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Please select a customer.</div>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label for="motorName" class="form-label">Motorcycle Name*</label>
                                    <select name="motorId" id="motorName" class="form-select" required>
                                        <option value="" disabled selected>Select Motorcycle</option>
                                        <c:forEach var="motor" items="${motors}">
                                            <option value="${motor.motorId}" data-price="${motor.price}"
                                                    <c:if test="${motor.motorId == param.motorId}">selected
                                                    </c:if>>
                                                ${motor.motorName} - $
                                                <fmt:formatNumber value="${motor.price}"
                                                                  pattern="#,##0.00" />
                                                (${motor.quantity} in stock)
                                            </option>
                                        </c:forEach>
                                    </select>
                                    <div class="invalid-feedback">Please select a motorcycle.</div>
                                </div>
                            </div>
                            <div class="text-center mt-3">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-search me-2"></i>Show Details
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Display error message if any -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">${errorMessage}</div>
                </c:if>

                <!-- Details Section -->
                <c:if test="${not empty motor || not empty customer}">
                    <div class="row">
                        <!-- Customer Details -->
                        <c:if test="${not empty customer}">
                            <div class="col-md-6 mb-4">
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-user-circle me-2"></i>Customer Details
                                    </div>
                                    <div class="card-body">
                                        <table class="table">
                                            <tr>
                                                <td><strong>Customer ID:</strong></td>
                                                <td>${customer.customerId}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Name:</strong></td>
                                                <td>${customer.name}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Phone Number:</strong></td>
                                                <td>${customer.phoneNumber}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Address:</strong></td>
                                                <td>${customer.address}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Email:</strong></td>
                                                <td>${customer.email}</td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>

                        <!-- Motor Details -->
                        <c:if test="${not empty motor}">
                            <div class="col-md-6 mb-4">
                                <div class="card">
                                    <div class="card-header">
                                        <i class="fas fa-motorcycle me-2"></i>Motorcycle Details
                                    </div>
                                    <div class="card-body">
                                        <table class="table">
                                            <tr>
                                                <td><strong>Motor Name:</strong></td>
                                                <td>${motor.motorName}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Price:</strong></td>
                                                <td>$
                                                    <fmt:formatNumber value="${motor.price}"
                                                                      pattern="#,##0.00" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td><strong>Color:</strong></td>
                                                <td>${motor.color}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Quantity:</strong></td>
                                                <td>${motor.quantity}</td>
                                            </tr>
                                            <tr>
                                                <td><strong>Picture:</strong></td>
                                                <td> <img src="images/${motor.picture}" class="img-fluid"
                                                          alt="${motor.motorName}"
                                                          style="max-width: 200px;" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </c:if>
                    </div>
                </c:if>

                <!-- Order Creation Form -->
                <c:if test="${not empty motor && not empty customer && motor.quantity > 0}">
                    <div class="card mb-4">
                        <div class="card-header bg-success text-white">
                            <i class="fas fa-shopping-cart me-2"></i>Create Order
                        </div>
                        <div class="card-body">
                            <form action="MotorOfEmployeeCreateServlet" method="post" class="needs-validation" novalidate>
                                <input type="hidden" name="motorId" value="${motor.motorId}">
                                <input type="hidden" name="customerId" value="${customer.customerId}">

                                <div class="col-md-6 mb-3">
                                    <label for="paymentMethod" class="form-label">Payment Method*</label>
                                    <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                                        <option value="">Select payment method</option>
                                        <option value="Cash">Cash</option>
                                        <option value="Credit Card">Credit Card</option>
                                        <option value="Bank Transfer">Bank Transfer</option>
                                        <option value="Installment">Installment</option>
                                    </select>
                                    <div class="invalid-feedback">Please select a payment method.</div>
                                </div>

                                <div class="mb-4">
                                    <label class="form-label">Warranty Options</label>
                                    <div class="warranty-option">
                                        <div class="form-check mb-2">
                                            <input class="form-check-input" type="radio" name="hasWarranty" id="noWarranty" value="false" checked onchange="updatePrice()">
                                            <label class="form-check-label" for="noWarranty">
                                                No Warranty
                                            </label>
                                        </div>
                                        <div class="form-check">
                                            <input class="form-check-input" type="radio" name="hasWarranty" id="withWarranty" value="true" onchange="updatePrice()">
                                            <label class="form-check-label" for="withWarranty">
                                                <span style="color: var(--primary-gold);">Include Warranty (Recommended)</span>
                                                <small class="text-muted d-block">Protects your purchase for 12 months</small>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <div class="price-info mb-4 p-3" style="background: rgba(0,0,0,0.2); border-left: 3px solid var(--primary-gold); border-radius: 5px;">
                                    <h5>Order Summary</h5>
                                    <div class="d-flex justify-content-between">
                                        <div>Base Price:</div>
                                        <div>$<span id="basePrice">${motor.price}</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between" id="warrantyRow" style="display: none;">
                                        <div>Warranty (10%):</div>
                                        <div>$<span id="warrantyPrice">0.00</span></div>
                                    </div>
                                    <div class="d-flex justify-content-between mt-2 pt-2" style="border-top: 1px solid rgba(212, 175, 55, 0.3);">
                                        <div><strong>Total Price:</strong></div>
                                        <div><strong>$<span id="totalPrice">${motor.price}</span></strong></div>
                                    </div>
                                </div>

                                <div class="text-center">
                                    <button type="submit" class="btn btn-success btn-lg">
                                        <i class="fas fa-check-circle me-2"></i>Create Order
                                    </button>
                                </div>

                                <div class="d-flex justify-content-between mt-4">
                                    <a href="adminOrders" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left me-2"></i>Back to Orders
                                    </a>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:if>

                <%-- [Rest of the HTML remains unchanged] --%>

                <script>
                    function updatePrice() {
                        const basePriceElement = document.getElementById('basePrice');
                        const basePrice = parseFloat(basePriceElement.textContent);
                        const hasWarranty = document.getElementById('withWarranty').checked;
                        const warrantyRow = document.getElementById('warrantyRow');
                        const warrantyPrice = document.getElementById('warrantyPrice');
                        const totalPrice = document.getElementById('totalPrice');

                        let warrantyAmount = 0;
                        let total = basePrice;

                        if (hasWarranty) {
                            warrantyAmount = basePrice * 0.10; // 10% of base price
                            total = basePrice + warrantyAmount;
                            warrantyRow.style.display = 'flex';
                            warrantyPrice.textContent = warrantyAmount.toFixed(2);
                        } else {
                            warrantyRow.style.display = 'none';
                            warrantyPrice.textContent = '0.00';
                        }

                        totalPrice.textContent = total.toFixed(2);
                    }

                    document.addEventListener('DOMContentLoaded', function () {
                        // Initial price setup
                        updatePrice();

                        // Add event listeners for warranty radio buttons
                        const warrantyRadios = document.querySelectorAll('input[name="hasWarranty"]');
                        warrantyRadios.forEach(radio => {
                            radio.addEventListener('change', updatePrice);
                        });

                        // Update price when motor selection changes
                        const motorElement = document.getElementById('motorName');
                        if (motorElement) {
                            motorElement.addEventListener('change', function () {
                                const selectedOption = this.options[this.selectedIndex];
                                
                                    const newBasePrice = parseFloat(selectedOption.dataset.price);
                                    document.getElementById('basePrice').textContent = newBasePrice.toFixed(2);
                                    updatePrice();
                                
                            });
                        }
                    });
                </script>
                </body>
                </html>