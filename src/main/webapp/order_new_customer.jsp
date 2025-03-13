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
            </head>

            <body>
                <jsp:include page="header.jsp" />

                <div class="container mt-4">
                    <div class="row">
                        <div class="col-md-12">
                            <h2>Create Order for New Customer</h2>
                            <p class="text-muted">This form will create a new customer account and place an order in one
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
                                    <div class="card-header bg-primary text-white">
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
                                                <input type="email" class="form-control" id="email" name="email"
                                                    required>
                                                <small class="text-muted">This email will be used as the login username
                                                    (password will be set to "123")</small>
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
                                    <div class="card-header bg-primary text-white">
                                        <i class="fas fa-shopping-cart me-2"></i>Order Information
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="motorId" class="form-label">Select Motorcycle*</label>
                                                <select class="form-select" id="motorId" name="motorId" required>
                                                    <option value="">Select a motorcycle</option>
                                                    <c:forEach var="motor" items="${motors}">
                                                        <option value="${motor.motorId}" data-price="${motor.price}"
                                                            <c:if test="${motor.motorId eq motor.motorId}">selected
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
                                            <div class="col-md-6 mb-3">
                                                <label for="paymentMethod" class="form-label">Payment Method*</label>
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

                                <!-- Order Summary Section -->
                                <div class="card mb-4">
                                    <div class="card-header bg-primary text-white">
                                        <i class="fas fa-receipt me-2"></i>Order Summary
                                    </div>
                                    <div class="card-body">
                                        <div class="row">
                                            <div class="col-md-6">
                                                <p><strong>Selected Motorcycle:</strong> <span id="selectedMotor">None
                                                        selected</span></p>
                                                <p><strong>Total Amount:</strong> $<span id="totalAmount">0.00</span>
                                                </p>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-between">
                                    <a href="adminOrders" class="btn btn-secondary"><i
                                            class="fas fa-arrow-left me-2"></i>Back to Orders</a>
                                    <button type="submit" class="btn btn-success"><i class="fas fa-save me-2"></i>Create
                                        Customer & Place Order</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>

                <jsp:include page="admin_footer.jsp" />

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
                <script>
                    document.addEventListener('DOMContentLoaded', function () {
                        // Form validation
                        const form = document.querySelector('.needs-validation');
                        form.addEventListener('submit', function (event) {
                            if (!form.checkValidity()) {
                                event.preventDefault();
                                event.stopPropagation();
                            }
                            form.classList.add('was-validated');
                        });

                        // Update order summary when motorcycle selection changes
                        const motorSelect = document.getElementById('motorId');
                        motorSelect.addEventListener('change', function () {
                            const selectedOption = motorSelect.options[motorSelect.selectedIndex];
                            const selectedMotorElem = document.getElementById('selectedMotor');
                            const totalAmountElem = document.getElementById('totalAmount');

                            if (motorSelect.value) {
                                selectedMotorElem.textContent = selectedOption.text;
                                const price = parseFloat(selectedOption.getAttribute('data-price'));
                                totalAmountElem.textContent = price.toLocaleString('en-US', {
                                    minimumFractionDigits: 2,
                                    maximumFractionDigits: 2
                                });
                            } else {
                                selectedMotorElem.textContent = 'None selected';
                                totalAmountElem.textContent = '0.00';
                            }
                        });

                        // Trigger change event to initialize summary if a motor is pre-selected
                        motorSelect.dispatchEvent(new Event('change'));
                    });
                </script>
            </body>

            </html>