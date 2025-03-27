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
                                                <option value="" data-price="0">Select a motorcycle</option>
                                                <c:forEach var="motor" items="${motors}">
                                                    <option value="${motor.motorId}" data-price="${motor.price}"
                                                        data-name="${motor.motorName}" data-color="${motor.color}"
                                                        data-quantity="${motor.quantity}"
                                                        data-picture="${motor.picture}">
                                                        ${motor.motorName} - $
                                                        <fmt:formatNumber value="${motor.price}" pattern="#,##0.00" />
                                                        (${motor.quantity} in stock)
                                                    </option>
                                                </c:forEach>
                                            </select>
                                            <div class="invalid-feedback">Please select a motorcycle.</div>
                                        </div>
                                        <div class="col-md-6 mb-3">
                                            <button type="button" id="viewDetailsBtn" class="btn btn-secondary mt-4"
                                                style="display:none;">
                                                <i class="fas fa-eye me-2"></i>View Motorcycle Details
                                            </button>
                                        </div>
                                    </div>

                                    <div class="row">
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

                                    <div class="mb-4">
                                        <label class="form-label">Warranty Options</label>
                                        <div class="warranty-option">
                                            <div class="form-check mb-2">
                                                <input class="form-check-input" type="radio" name="hasWarranty"
                                                    id="noWarranty" value="false" checked>
                                                <label class="form-check-label" for="noWarranty">
                                                    No Warranty
                                                </label>
                                            </div>
                                            <div class="form-check">
                                                <input class="form-check-input" type="radio" name="hasWarranty"
                                                    id="withWarranty" value="true">
                                                <label class="form-check-label" for="withWarranty">
                                                    <span style="color: var(--primary-gold);">Include Warranty
                                                        (Recommended)</span>
                                                    <small class="text-muted d-block">Protects your purchase for 12
                                                        months</small>
                                                </label>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- Motorcycle Details Table -->
                                    <div id="motorDetails" class="mt-3" style="display: none;">
                                        <table class="table table-dark table-striped">
                                            <thead>
                                                <tr></tr>
                                                <th>Picture</th>
                                                <th>Name</th>
                                                <th>Price</th>
                                                <th>Color</th>
                                                <th>Quantity</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <tr>
                                                    <td><img id="detailPicture" src="" alt="Motorcycle Picture"
                                                            style="width: 100px;"></td>
                                                    <td id="detailName"></td>
                                                    <td id="detailPrice"></td>
                                                    <td id="detailColor"></td>
                                                    <td id="detailQuantity"></td>
                                                </tr>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Order Creation Form -->
                            <div class="price-info mb-4 p-3">
                                <h5>Order Summary</h5>
                                <div class="d-flex justify-content-between">
                                    <div>Base Price:</div>
                                    <div>$<span id="basePrice">0.00</span></div>
                                </div>
                                <div class="d-flex justify-content-between" id="warrantyRow" style="display: none;">
                                    <div>Warranty (10%):</div>
                                    <div>$<span id="warrantyPrice">0.00</span></div>
                                </div>
                                <div class="d-flex justify-content-between mt-2 pt-2"
                                    style="border-top: 1px solid rgba(212, 175, 55, 0.3);">
                                    <div><strong>Total Price:</strong></div>
                                    <div><strong>$<span id="totalPrice">0.00</span></strong></div>
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

                    <%-- [Rest of the HTML remains unchanged] --%>

                        <script>
                            function formatWithCommas(number) {
                                return number.toLocaleString('en-US', {
                                    minimumFractionDigits: 2,
                                    maximumFractionDigits: 2
                                });
                            }

                            function updatePriceAndDetails() {
                                try {
                                    // Get the selected motorcycle option
                                    const motorSelect = document.getElementById('motorId');
                                    const viewDetailsBtn = document.getElementById('viewDetailsBtn');
                                    let basePrice = 0;
                                    let motorSelected = false;

                                    if (motorSelect && motorSelect.selectedIndex > 0) {
                                        const selectedOption = motorSelect.options[motorSelect.selectedIndex];
                                        if (selectedOption && selectedOption.value) {
                                            basePrice = parseFloat(selectedOption.getAttribute('data-price') || 0);
                                            motorSelected = true;

                                            // Update details table
                                            document.getElementById('detailName').textContent = selectedOption.getAttribute('data-name');
                                            document.getElementById('detailPrice').textContent = formatWithCommas(basePrice);
                                            document.getElementById('detailColor').textContent = selectedOption.getAttribute('data-color');
                                            document.getElementById('detailQuantity').textContent = selectedOption.getAttribute('data-quantity');

                                            // Fix image path and ensure it's displayed correctly
                                            const imagePath = selectedOption.getAttribute('data-picture');
                                            document.getElementById('detailPicture').src = imagePath.startsWith('images/') ? imagePath : 'images/' + imagePath;

                                            // Show the View Details button when a motorcycle is selected
                                            viewDetailsBtn.style.display = 'block';
                                        }
                                    } else {
                                        // Hide the View Details button when no motorcycle is selected
                                        viewDetailsBtn.style.display = 'none';
                                    }

                                    // Calculate prices
                                    const basePriceElement = document.getElementById('basePrice');
                                    const withWarranty = document.getElementById('withWarranty').checked;
                                    const warrantyRow = document.getElementById('warrantyRow');
                                    const warrantyPrice = document.getElementById('warrantyPrice');
                                    const totalPrice = document.getElementById('totalPrice');

                                    // Display base price with proper formatting
                                    basePriceElement.textContent = formatWithCommas(basePrice);

                                    // Calculate warranty and total price
                                    if (withWarranty) {
                                        const warrantyAmount = basePrice * 0.1;
                                        warrantyRow.style.display = 'flex';
                                        warrantyPrice.textContent = formatWithCommas(warrantyAmount);
                                        totalPrice.textContent = formatWithCommas(basePrice + warrantyAmount);
                                    } else {
                                        warrantyRow.style.display = 'none';
                                        warrantyPrice.textContent = '0.00';
                                        totalPrice.textContent = formatWithCommas(basePrice);
                                    }
                                } catch (error) {
                                    console.error("Error in updatePriceAndDetails:", error);
                                }
                            }

                            document.addEventListener('DOMContentLoaded', function () {
                                // Initial setup
                                updatePriceAndDetails();

                                // Add event listeners
                                const motorSelect = document.getElementById('motorId');
                                if (motorSelect) {
                                    motorSelect.addEventListener('change', updatePriceAndDetails);
                                }

                                const warrantyRadios = document.querySelectorAll('input[name="hasWarranty"]');
                                warrantyRadios.forEach(radio => {
                                    radio.addEventListener('change', updatePriceAndDetails);
                                });

                                // View Details button functionality
                                const viewDetailsBtn = document.getElementById('viewDetailsBtn');
                                const motorDetails = document.getElementById('motorDetails');

                                if (viewDetailsBtn && motorDetails) {
                                    viewDetailsBtn.addEventListener('click', function () {
                                        if (motorDetails.style.display === 'none') {
                                            motorDetails.style.display = 'block';
                                            viewDetailsBtn.innerHTML = '<i class="fas fa-eye-slash me-2"></i>Hide Details';
                                        } else {
                                            motorDetails.style.display = 'none';
                                            viewDetailsBtn.innerHTML = '<i class="fas fa-eye me-2"></i>View Motorcycle Details';
                                        }
                                    });
                                }

                                // Form validation
                                const form = document.querySelector('.needs-validation');
                                if (form) {
                                    form.addEventListener('submit', function (event) {
                                        if (!form.checkValidity()) {
                                            event.preventDefault();
                                            event.stopPropagation();
                                        }
                                        form.classList.add('was-validated');
                                    });
                                }
                            });
                        </script>
            </body>

            </html>