<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Create Order for New Customer - MotoVibe</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <link rel="stylesheet" href="css/style.css">
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
                        background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                        border: none;
                        color: var(--dark-black);
                        font-weight: 600;
                        transition: all 0.3s ease;
                        padding: 10px 25px;
                    }

                    .btn-success:hover {
                        transform: translateY(-2px);
                        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
                    }

                    .alert {
                        border-left: 4px solid var(--primary-gold);
                        background-color: rgba(0, 0, 0, 0.2);
                        color: var(--text-gold);
                    }

                    .alert-danger {
                        border-left-color: #dc3545;
                    }

                    .form-check-input {
                        background-color: var(--rich-black);
                        border: 1px solid var(--secondary-gold);
                    }

                    .form-check-input:checked {
                        background-color: var(--primary-gold);
                        border-color: var(--primary-gold);
                    }

                    .form-switch .form-check-input:focus {
                        background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='-4 -4 8 8'%3e%3ccircle r='3' fill='%23D4AF37'/%3e%3c/svg%3e");
                    }

                    .price-info {
                        background: rgba(0, 0, 0, 0.2) !important;
                        border-left: 3px solid var(--primary-gold) !important;
                        border-radius: 5px;
                        padding: 1.5rem !important;
                        color: var(--text-gold);
                    }

                    .form-check-label {
                        color: var(--text-gold);
                    }
                </style>
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <div class="container mt-4">
                    <div class="order-container">
                        <h2><i class="fas fa-user-plus me-2"></i> Create Order for New Customer</h2>
                        <p class="lead">This form will create a new customer account and place an order in one
                            step.</p>

                        <c:if test="${not empty sessionScope.errorMessage}">
                            <div class="alert alert-danger alert-dismissible fade show">
                                ${sessionScope.errorMessage}
                                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% session.removeAttribute("errorMessage"); %>
                        </c:if>

                        <form action="orderNewCustomer" method="post" class="needs-validation" novalidate>
                            <!-- Customer Information Section -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-user me-2"></i>New Customer Information
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="fullName" class="form-label">Full Name*</label>
                                            <input type="text" class="form-control" id="fullName" name="fullName"
                                                required>
                                            <div class="invalid-feedback">Please enter customer's full name.</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="email" class="form-label">Email*</label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                            <small class="text-muted">This email will be used as the login username
                                                (password
                                                will be set to "123")</small>
                                            <div class="invalid-feedback">Please enter a valid email address.</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="phone" class="form-label">Phone Number*</label>
                                            <input type="tel" class="form-control" id="phone" name="phone" required>
                                            <div class="invalid-feedback">Please enter a phone number.</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="address" class="form-label">Address</label>
                                            <textarea class="form-control" id="address" name="address"
                                                rows="2"></textarea>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Information Section -->
                            <div class="card mb-4">
                                <div class="card-header">
                                    <i class="fas fa-shopping-cart me-2"></i>Order Information
                                </div>
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <label for="motorId" class="form-label">Select Motorcycle*</label>
                                            <select class="form-select" id="motorId" name="motorId" required>
                                                <option value="">Select a motorcycle</option>
                                                <c:forEach var="motor" items="${motors}">
                                                    <option value="${motor.motorId}" data-price="${motor.price}" <c:if
                                                        test="${motor.motorId eq motor.motorId}">selected
                                                        </c:if>>
                                                        ${motor.motorName} - $
                                                        <fmt:formatNumber value="${motor.price}" pattern="#,##0.00" />
                                                        (${motor.quantity} in stock)
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <div class="invalid-feedback">Please select a motorcycle.</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <label for="paymentMethod" class="form-label">Payment
                                                Method*</label>
                                            <select class="form-select" id="paymentMethod" name="paymentMethod"
                                                required>
                                                <option value="">Select payment method</option>
                                                <option value="Cash">Cash</option>
                                                <option value="Credit Card">Credit Card</option>
                                                <option value="Bank Transfer">Bank Transfer</option>
                                                <option value="Installment">Installment</option>
                                            </select>
                                            <div class="invalid-feedback">Please select a payment method.</div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-md-6 mb-3">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="hasWarranty"
                                                    name="hasWarranty">
                                                <label class="form-check-label" for="hasWarranty">Include
                                                    Warranty</label>
                                            </div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <div class="form-check form-switch">
                                                <input class="form-check-input" type="checkbox" id="depositStatus"
                                                    name="depositStatus">
                                                <label class="form-check-label" for="depositStatus">Deposit
                                                    Received</label>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- Display the price information -->
                            <div class="price-info mb-4">
                                <h5 style="color: var(--primary-gold);">Order Summary</h5>
                                <div class="d-flex justify-content-between">
                                    <div>Base Price:</div>
                                    <div>$<span id="basePrice">0.00</span></div>
                                </div>
                                <div class="d-flex justify-content-between" id="warrantyRow">
                                    <div>Warranty (10%):</div>
                                    <div>$<span id="warrantyPrice">0.00</span></div>
                                </div>
                                <div class="d-flex justify-content-between mt-2 pt-2"
                                    style="border-top: 1px solid rgba(212, 175, 55, 0.3);">
                                    <div><strong>Total Price:</strong></div>
                                    <div><strong>$<span id="totalPrice">0.00</span></strong></div>
                                </div>
                            </div>

                            <div class="d-flex justify-content-between">
                                <a href="adminOrders" class="btn btn-secondary"><i
                                        class="fas fa-arrow-left me-2"></i>Back to
                                    Orders</a>
                                <button type="submit" class="btn btn-primary"><i class="fas fa-save me-2"></i>Create
                                    Customer &
                                    Place Order</button>
                            </div>
                        </form>
                    </div>
                </div>

                <jsp:include page="admin_footer.jsp" />

                <script>
                    // Price update calculation for warranty and motorcycle selection
                    function updatePrice() {
                        try {
                            // Get the selected motorcycle option
                            const motorSelect = document.getElementById('motorId');
                            let basePrice = 0;

                            if (motorSelect && motorSelect.selectedIndex >= 0) {
                                const selectedOption = motorSelect.options[motorSelect.selectedIndex];
                                if (selectedOption && selectedOption.value) {
                                    basePrice = parseFloat(selectedOption.getAttribute('data-price'));
                                }
                            }

                            // Update the base price display
                            const basePriceElement = document.getElementById('basePrice');
                            if (basePriceElement) {
                                basePriceElement.textContent = basePrice.toFixed(2);
                            }

                            // Calculate warranty if checked
                            const hasWarranty = document.getElementById('hasWarranty').checked;
                            const warrantyRow = document.getElementById('warrantyRow');
                            const warrantyPrice = document.getElementById('warrantyPrice');
                            const totalPrice = document.getElementById('totalPrice');

                            if (hasWarranty) {
                                const warrantyAmount = basePrice * 0.1; // 10% of base price
                                warrantyRow.style.display = 'flex';
                                warrantyPrice.textContent = warrantyAmount.toFixed(2);
                                totalPrice.textContent = (basePrice + warrantyAmount).toFixed(2);
                            } else {
                                warrantyRow.style.display = 'none';
                                totalPrice.textContent = basePrice.toFixed(2);
                            }
                        } catch (error) {
                            console.error("Error in updatePrice:", error);
                        }
                    }

                    // Initialize when the page loads
                    document.addEventListener('DOMContentLoaded', function () {
                        // Hide warranty row initially
                        const warrantyRow = document.getElementById('warrantyRow');
                        if (warrantyRow) {
                            warrantyRow.style.display = 'none';
                        }

                        // Set initial values
                        updatePrice();

                        // Add event listeners
                        const motorSelect = document.getElementById('motorId');
                        if (motorSelect) {
                            motorSelect.addEventListener('change', updatePrice);
                        }

                        const hasWarrantyCheckbox = document.getElementById('hasWarranty');
                        if (hasWarrantyCheckbox) {
                            hasWarrantyCheckbox.addEventListener('change', updatePrice);
                        }
                    });
                </script>
            </body>

            </html>