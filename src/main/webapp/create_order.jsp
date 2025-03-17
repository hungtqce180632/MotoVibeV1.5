<%-- 
    Document   : create_order
    Created on : Feb 24, 2025, 4:30:58 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="models.UserAccount" %>
<%@ page import="models.Customer" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="models.Motor" %>

<%
    // Get the logged-in user
    UserAccount user = (UserAccount) session.getAttribute("user");
    
    // Get motor from request attribute (set by OrderMotorServlet)
    Motor motor = (Motor) request.getAttribute("motor");
    
    // Default values
    String customerName = "";
    String customerEmail = "";
    String customerPhone = "";
    String customerAddress = "";
    
    // Auto-fill if user is logged in
    if (user != null && "customer".equalsIgnoreCase(user.getRole())) {
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
        if (customer != null) {
            customerName = customer.getName();
            customerEmail = user.getEmail();
            customerPhone = customer.getPhoneNumber();
            customerAddress = customer.getAddress();
        }
    }
    
    // Generate order code
    String orderCode = "MV-" + System.currentTimeMillis() % 100000;
%>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Create Order</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            min-height: calc(100vh - 80px); /* Account for header */
        }

        .order-container {
            max-width: 900px;
            margin: 0 auto;
        }
        
        h1 {
            color: var(--primary-gold);
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            position: relative;
            padding-bottom: 15px;
            margin-bottom: 30px;
        }

        h1::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 100px;
            height: 2px;
            background: var(--primary-gold);
            box-shadow: 0 0 10px var(--primary-gold);
        }

        .lead {
            color: var (--text-gold);
            opacity: 0.9;
        }

        .motor-card {
            background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            border: 1px solid var(--primary-gold);
            border-radius: 10px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            overflow: hidden;
        }
        
        .motor-card img {
            border-bottom: 1px solid var(--secondary-gold);
            transition: transform 0.3s ease;
            max-height: 250px;
            object-fit: cover;
            width: 100%;
        }
        
        .motor-card:hover img {
            transform: scale(1.05);
        }
        
        .card-title {
            color: var(--primary-gold);
            font-weight: 600;
            letter-spacing: 1px;
        }
        
        .form-section {
            background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            border: 1px solid var(--primary-gold);
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            margin-top: 2rem;
        }
        
        .form-label {
            color: var(--primary-gold);
            font-weight: 500;
            letter-spacing: 1px;
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            background: rgba(0, 0, 0, 0.2) !important;
            border: 1px solid var(--secondary-gold) !important;
            color: white !important;
            padding: 10px;
        }
        
        .form-control:focus, .form-select:focus {
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

        .text-muted {
            color: var(--text-gold) !important;
            opacity: 0.7;
        }

        /* Custom styling for the availability badge */
        .availability-badge {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            color: var(--dark-black);
            padding: 5px 10px;
            border-radius: 15px;
            font-weight: 600;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            display: inline-block;
        }

        .out-of-stock {
            background: linear-gradient(145deg, #dc3545, #c82333);
            color: white;
        }

        /* Warranty section */
        .warranty-option {
            background: rgba(0,0,0,0.2);
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

        .create-order-container {
            background: var(--dark-black);
            border: 1px solid var(--primary-gold);
            border-radius: 8px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            max-width: 600px;
            margin: 2rem auto;
        }
        .btn-submit-order {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            color: var(--dark-black);
            border: none;
            margin-top: 1rem;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    <div class="container my-5">
        <div class="order-container">
            <h1><i class="fas fa-shopping-cart me-2"></i> Create Your Order</h1>
            <p class="lead">Please fill in the form below to confirm your order.</p>

            <div class="motor-card mb-4">
                <div class="row g-0">
                    <div class="col-md-4">
                        <img src="images/${motor.picture}" class="img-fluid" alt="${motor.motorName}">
                    </div>
                    <div class="col-md-8">
                        <div class="card-body">
                            <h5 class="card-title">${motor.motorName}</h5>
                            <p class="card-text"><strong>Price:</strong> <span style="color: var(--primary-gold); font-size: 1.2rem;">$${motor.price}</span></p>
                            <p class="card-text">
                                <span class="availability-badge ${motor.quantity > 0 ? '' : 'out-of-stock'}">
                                    <i class="fas ${motor.quantity > 0 ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                                    <c:choose>
                                        <c:when test="${motor.quantity > 0}">In Stock</c:when>
                                        <c:otherwise>Out of Stock</c:otherwise>
                                    </c:choose>
                                </span>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="form-section">
                <form action="confirmOrder" method="post" class="needs-validation" novalidate>
                    <input type="hidden" name="motorId" value="${motor.motorId}">
                    <input type="hidden" name="orderCode" value="<%= orderCode %>">
                    
                    <!-- Display order code for reference -->
                    <div class="mb-3">
                        <p><strong>Order Code:</strong> <span class="badge bg-warning"><%= orderCode %></span></p>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="customerName" class="form-label">Your Name</label>
                            <input type="text" class="form-control" id="customerName" name="customerName" value="<%= customerName %>" required>
                        </div>
                        <div class="col-md-6">
                            <label for="customerEmail" class="form-label">Email Address</label>
                            <input type="email" class="form-control" id="customerEmail" name="customerEmail" value="<%= customerEmail %>" required>
                        </div>
                    </div>
                    
                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="customerPhone" class="form-label">Phone Number (10 digits)</label>
                            <input type="tel" 
                                class="form-control" 
                                id="customerPhone" 
                                name="customerPhone" 
                                pattern="[0-9]{10}"
                                maxlength="10"
                                title="Please enter a valid 10-digit phone number"
                                value="<%= customerPhone %>"
                                required>
                            <div class="invalid-feedback">
                                Please enter a valid 10-digit phone number
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="customerIdNumber" class="form-label">ID Number (12 digits)</label>
                            <input type="text" 
                                class="form-control" 
                                id="customerIdNumber" 
                                name="customerIdNumber" 
                                pattern="[0-9]{12}"
                                maxlength="12"
                                title="Please enter a valid 12-digit ID number"
                                required>
                            <div class="invalid-feedback">
                                Please enter a valid 12-digit ID number
                            </div>
                        </div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="customerAddress" class="form-label">Shipping Address</label>
                        <textarea class="form-control" id="customerAddress" name="customerAddress" rows="3" required><%= customerAddress %></textarea>
                    </div>

                    <!-- Add the missing payment method dropdown -->
                    <div class="mb-3">
                        <label for="paymentMethod" class="form-label">Payment Method</label>
                        <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                            <option value="Bank Transfer">Bank Transfer</option>
                            <option value="Credit Card" disabled>Credit Card - Coming Soon</option>
                            <option value="Cash on Delivery" disabled>Cash on Delivery - Coming Soon</option>
                            <option value="Finance" disabled>Financing - Coming Soon</option>
                        </select>
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

                    <div class="mb-4" style="display: none;">
                        <div class="form-check">
                            <input class="form-check-input" type="checkbox" id="depositStatus" name="depositStatus">
                            <label class="form-check-label" for="depositStatus">
                                Pay Deposit
                            </label>
                        </div>
                    </div>

                    <!-- Display the price information -->
                    <div class="price-info mb-4 p-3" style="background: rgba(0,0,0,0.2); border-left: 3px solid var(--primary-gold); border-radius: 5px;">
                        <h5>Order Summary</h5>
                        <div class="d-flex justify-content-between">
                            <div>Base Price:</div>
                            <div>$<span id="basePrice">${motor.price}</span></div>
                        </div>
                        <div class="d-flex justify-content-between" id="warrantyRow" style="display: none !important;">
                            <div>Warranty (10%):</div>
                            <div>$<span id="warrantyPrice">0.00</span></div>
                        </div>
                        <div class="d-flex justify-content-between mt-2 pt-2" style="border-top: 1px solid rgba(212, 175, 55, 0.3);">
                            <div><strong>Total Price:</strong></div>
                            <div><strong>$<span id="totalPrice">${motor.price}</span></strong></div>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <a href="motorDetail?id=${motor.motorId}" class="btn btn-secondary me-2">
                            <i class="fas fa-times me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-check me-1"></i> Proceed to Payment
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            
            const forms = document.querySelectorAll('.needs-validation')
            
            // Phone number validation
            const phoneInput = document.getElementById('customerPhone')
            phoneInput.addEventListener('input', function(e) {
                // Remove any non-digit characters
                this.value = this.value.replace(/\D/g, '')
                
                // Check if length is exactly 10 digits
                if (this.value.length !== 10) {
                    this.setCustomValidity('Phone number must be exactly 10 digits')
                } else {
                    this.setCustomValidity('')
                }
            })
            
            // ID number validation
            const idInput = document.getElementById('customerIdNumber')
            idInput.addEventListener('input', function(e) {
                // Remove any non-digit characters
                this.value = this.value.replace(/\D/g, '')
                
                // Check if length is exactly 12 digits
                if (this.value.length !== 12) {
                    this.setCustomValidity('ID number must be exactly 12 digits')
                } else {
                    this.setCustomValidity('')
                }
            })

            // Loop over forms and prevent submission if invalid
            Array.prototype.slice.call(forms).forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }
                    form.classList.add('was-validated')
                }, false)
            })
        })()
        
        // Price update calculation for warranty
        function updatePrice() {
            const basePrice = parseFloat(${motor.price});
            const hasWarranty = document.getElementById('withWarranty').checked;
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
        }
        
        // Initialize price
        document.addEventListener('DOMContentLoaded', function() {
            updatePrice();
            
            // Update form action to go through payment confirmation step
            const form = document.querySelector('form[action="confirmOrder"]');
            if (form) {
                form.action = "paymentConfirmation";
            }
        });
    </script>
</body>
</html>
