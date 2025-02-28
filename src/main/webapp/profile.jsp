<%-- 
    Document   : profile
    Created on : Feb 27, 2025, 1:28:21 AM
    Author     : truon
--%>

<%@page import="models.Customer"%>
<%@page import="models.Employee"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>User Profile</title>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body {
                background: var(--rich-black);
                color: var(--text-gold);
            }

            .profile-container {
                background: var(--dark-black);
                border: 1px solid var(--secondary-gold);
                border-radius: 10px;
                padding: 2rem;
                margin: 2rem auto;
                max-width: 800px;
                box-shadow: 0 0 20px rgba(218, 165, 32, 0.2);
            }

            .form-label {
                color: var(--primary-gold);
                font-weight: 600;
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }

            .form-control {
                background: var(--rich-black) !important;
                border: 1px solid var(--secondary-gold);
                color: var(--text-gold) !important;
                margin-bottom: 1rem;
                padding: 0.75rem 1rem;
            }

            .form-control:focus {
                background: var(--rich-black) !important;
                border-color: var(--primary-gold);
                color: var(--text-gold) !important;
                box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.25);
            }

            .form-control::placeholder {
                color: rgba(245, 230, 204, 0.5);
            }

            .btn-primary {
                background: var(--primary-gold);
                border-color: var(--secondary-gold);
                color: var(--rich-black);
            }

            .btn-primary:hover {
                background: var(--secondary-gold);
                border-color: var(--primary-gold);
                color: var(--rich-black);
            }

            .profile-heading {
                color: var(--primary-gold);
                border-bottom: 2px solid var(--secondary-gold);
                padding-bottom: 10px;
                margin-bottom: 20px;
            }

            .action-buttons {
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 1px solid var(--secondary-gold);
            }

            .btn-outline-gold {
                color: var(--primary-gold) !important;
                border: 2px solid var(--primary-gold);
                background: transparent;
                transition: all 0.3s ease;
                margin: 0 0.5rem;
                font-weight: 600;
                letter-spacing: 0.5px;
                text-transform: uppercase;
                font-size: 0.9rem;
            }

            .btn-outline-gold:hover {
                background: var(--primary-gold);
                color: var(--rich-black) !important;
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }

            .btn-outline-gold i {
                color: inherit;
            }

            .btn-outline-gold:hover i {
                color: var(--rich-black);
            }

            .profile-navigation {
                display: flex;
                justify-content: center;
                gap: 1.5rem;
                margin: 2rem 0;
            }

            .profile-navigation .btn {
                min-width: 220px;
                padding: 1rem 1.5rem;
            }

            .btn i {
                margin-right: 0.5rem;
                font-size: 1.1rem;
            }

            .profile-info {
                color: var(--text-gold);
                background: var(--rich-black);
                padding: 1.5rem;
                border-radius: 8px;
                border: 1px solid var(--secondary-gold);
                margin-bottom: 2rem;
            }

            .profile-info p {
                margin-bottom: 0.75rem;
                font-size: 1.1rem;
            }

            .profile-info strong {
                color: var(--primary-gold);
                margin-right: 0.5rem;
            }

            .badge {
                font-size: 0.9rem;
                padding: 0.5em 1em;
            }

            .badge.bg-success {
                background-color: #2d8659 !important;
            }

            .badge.bg-danger {
                background-color: #8b2e2e !important;
            }

            /* Override any white backgrounds */
            .container, 
            .row, 
            .col-md-12, 
            .col-md-6, 
            .col-12 {
                background: transparent;
            }

            /* Ensure text inputs maintain dark background when autofilled */
            input:-webkit-autofill,
            input:-webkit-autofill:hover,
            input:-webkit-autofill:focus,
            input:-webkit-autofill:active {
                -webkit-box-shadow: 0 0 0 30px var(--rich-black) inset !important;
                -webkit-text-fill-color: var(--text-gold) !important;
            }

            /* Style for headings and text in the history section */
            .mt-4 h4 {
                color: var(--primary-gold);
                margin-bottom: 1rem;
            }

            .mt-4 p {
                color: var(--text-gold);
                margin-bottom: 1.5rem;
            }

            /* Style for button text */
            button.btn-outline-gold,
            a.btn-outline-gold {
                color: var(--primary-gold) !important;
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="header.jsp"/>
        
        <!-- Main Content with top margin to account for fixed header -->
        <div class="container mt-5" style="margin-top: 100px !important;">
            <div class="profile-container">
                <%
                    Boolean isCustomer = (Boolean) request.getAttribute("isCustomer");
                    Boolean isEmployee = (Boolean) request.getAttribute("isEmployee");
                    Boolean isAdmin = (Boolean) request.getAttribute("isAdmin");
                    Boolean customerNotFound = (Boolean) request.getAttribute("customerNotFound");
                    Boolean employeeNotFound = (Boolean) request.getAttribute("employeeNotFound");

                    if (isCustomer == null) isCustomer = false;
                    if (isEmployee == null) isEmployee = false;
                    if (isAdmin == null) isAdmin = false;
                    if (customerNotFound == null) customerNotFound = false;
                    if (employeeNotFound == null) employeeNotFound = false;
                %>

                <h1 class="profile-heading text-center mb-4">User Profile</h1>

                <% if (customerNotFound || employeeNotFound) { %>
                <div class="alert alert-danger">
                    <%= customerNotFound ? "Customer profile not found in database." : "Employee profile not found in database." %>
                </div>
                <% } %>

                <% if (isCustomer) {
                    Customer customer = (Customer) request.getAttribute("customerProfile");
                    if (customer != null) {
                %>
                <div class="row mb-4">
                    <div class="col-md-12">
                        <h3 class="profile-heading">Customer Profile</h3>
                        <div class="profile-info">
                            <p><strong>Email:</strong> <span><%= customer.getEmail() %></span></p>
                            <p><strong>Role:</strong> <span><%= customer.getRole() %></span></p>
                            <p><strong>Status:</strong> 
                                <span class="badge <%= customer.isStatus() ? "bg-success" : "bg-danger" %>">
                                    <%= customer.isStatus() ? "Active" : "Inactive" %>
                                </span>
                            </p>
                        </div>

                        <form action="profile" method="POST" class="needs-validation" novalidate>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Name</label>
                                    <input type="text" class="form-control" name="name" value="<%= customer.getName() %>" required>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label class="form-label">Phone</label>
                                    <input type="tel" class="form-control" name="phone" value="<%= customer.getPhoneNumber() %>" required>
                                </div>

                                <div class="col-12 mb-3">
                                    <label class="form-label">Address</label>
                                    <input type="text" class="form-control" name="address" value="<%= customer.getAddress() %>" required>
                                </div>

                                <div class="col-12 text-end">
                                    <button type="submit" class="btn btn-outline-gold">
                                        <i class="fas fa-save"></i> <span>Update Profile</span>
                                    </button>
                                </div>
                            </div>
                        </form>
                        
                        <!-- "Buy Motor History" block -->
                        <div class="mt-4">
                            <h4>Buy Motor History</h4>
                            <p>Track or view your previous orders and their warranty information.</p>
                            <a href="listOrders" class="btn btn-outline-gold">
                                <i class="fas fa-history"></i> <span>View My Orders</span>
                            </a>
                            <a href="wishlist" class="btn btn-outline-gold">
                                <i class="fas fa-history"></i> <span>View My Wishlist</span>
                            </a>
                        </div>
                        
                    </div>
                </div>
                <%
                    } else {
                %>
                <p class="text-gold">No customer profile data to display.</p>
                <%
                    }
                } else if (isEmployee) {
                    Employee emp = (Employee) request.getAttribute("employeeProfile");
                    if (emp != null) {
                %>
                <h3 class="profile-heading">Employee Profile</h3>
                <div class="profile-info">
                    <p><strong>Email:</strong> <span><%= emp.getEmail() %></span></p>
                    <p><strong>Role:</strong> <span><%= emp.getRole() %></span></p>
                    <p><strong>Status:</strong> 
                        <span class="badge <%= emp.isStatus() ? "bg-success" : "bg-danger" %>">
                            <%= emp.isStatus() ? "Active" : "Inactive" %>
                        </span>
                    </p>
                    <p><strong>Name:</strong> <span><%= emp.getName() %></span></p>
                    <p><strong>Phone:</strong> <span><%= emp.getPhoneNumber() %></span></p>
                    <p><em class="text-muted">Employees cannot edit their own profile here.</em></p>
                </div>
                <% if (isEmployee) { %>
                    <div class="mt-4">
                        <h4>Reviews Management</h4>
                        <p>Manage customer reviews across all motors.</p>
                        <a href="listReviews" class="btn btn-outline-gold">
                            <i class="fas fa-star"></i> <span>Manage Reviews</span>
                        </a>
                    </div>
                <% } %>
                <%
                    } else {
                %>
                <p class="text-gold">No employee profile data found.</p>
                <%
                    }
                } else if (isAdmin) {
                %>
                <h3>Admin Profile</h3>
                <p>Admins may not have a row in customers/employees. Customize as needed.</p>
                <%
                } else {
                %>
                <p>Unknown role or not logged in.</p>
                <%
                } %>
            </div>
        </div>

        <!-- Include Footer -->
        <jsp:include page="footer.jsp"/>

        <!-- Scripts -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Form validation
            (function () {
                'use strict'
                var forms = document.querySelectorAll('.needs-validation')
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
        </script>
    </body>
</html>
