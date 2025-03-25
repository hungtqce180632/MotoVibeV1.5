<%-- Document : order_by_employee Created on : Mar 1, 2025, 9:44:56 PM Author : ACER --%>

    <%@ page contentType="text/html; charset=UTF-8" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Create Order</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
            </head>

            <body>

                <div class="container mt-5">
                    <h1 class="mb-4 text-center">Create Order for Customer</h1>

                    <!-- Display success/error messages -->
                    <c:if test="${not empty sessionScope.errorMessage}">
                        <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <i class="fas fa-exclamation-triangle me-2"></i>${sessionScope.errorMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% session.removeAttribute("errorMessage"); %>
                    </c:if>

                    <c:if test="${not empty sessionScope.successMessage}">
                        <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                        </div>
                        <% session.removeAttribute("successMessage"); %>
                    </c:if>

                    <h1>Select a Customer</h1>

                    <!-- Dropdown to select a customer by name -->
                    <form action="" method="get">
                        <label for="customerName"><strong>Customer Name</strong></label>
                        <select name="customerId" id="customerName" required>
                            <option value="" disabled selected>Select Customer</option>
                            <c:forEach var="customer" items="${customers}">
                                <option value="${customer.customerId}" <c:if
                                    test="${customer.customerId == param.customerId}">selected</c:if>>
                                    ${customer.name}
                                </option>
                            </c:forEach>
                        </select>
                        <!--<button type="submit">Show Details</button>-->




                        <h1>Select a Motorcycle</h1>

                        <label for="motorName"><strong>Motorcycle Name</strong></label>
                        <select name="motorId" id="motorName" required>
                            <option value="" disabled selected>Select Motorcycle</option>
                            <c:forEach var="motor" items="${motors}">
                                <option value="${motor.motorId}" <c:if test="${motor.motorId == param.motorId}">selected
                                    </c:if>>
                                    ${motor.motorName}
                                </option>
                            </c:forEach>
                        </select>
                        <button type="submit">Show Details</button>
                    </form>

                    <br>

                    <!-- Display motor details if a motor is selected -->
                    <c:if test="${not empty motor && not empty customer}">
                        <h2>Motor Details:</h2>
                        <table class="table">
                            <tr>
                                <td><strong>Motor Name:</strong></td>
                                <td>${motor.motorName}</td>
                            </tr>
                            <tr>
                                <td><strong>Price:</strong></td>
                                <td>${motor.price}</td>
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
                                <td><img src="${motor.picture}" alt="Motor Picture" /></td>
                            </tr>
                        </table>
                    </c:if>
                    <br>

                    <!-- Display selected customer details if a customer is selected -->
                    <c:if test="${not empty customer}">
                        <h2>Customer Details:</h2>
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
                    </c:if>

                </div>

                <!-- Display error message if any -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">${errorMessage}</div>
                </c:if>

                <!-- Add the order creation form - Only show if both motor and customer are selected -->
                <c:if test="${not empty motor && not empty customer && motor.quantity > 0}">
                    <div class="container mt-4">
                        <h2>Create Order</h2>
                        <form action="MotorOfEmployeeCreateServlet" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="motorId" value="${motor.motorId}">
                            <input type="hidden" name="customerId" value="${customer.customerId}">

                            <div class="mb-3">
                                <label for="paymentMethod" class="form-label">Payment Method</label>
                                <select class="form-control" id="paymentMethod" name="paymentMethod" required>
                                    <option value="">Select payment method</option>
                                    <option value="Cash">Cash</option>
                                    <option value="Credit Card">Credit Card</option>
                                    <option value="Bank Transfer">Bank Transfer</option>
                                    <option value="Digital Wallet">Digital Wallet</option>
                                </select>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="hasWarranty" name="hasWarranty">
                                <label class="form-check-label" for="hasWarranty">Include Warranty</label>
                            </div>

                            <div class="mb-3 form-check">
                                <input type="checkbox" class="form-check-input" id="depositStatus" name="depositStatus">
                                <label class="form-check-label" for="depositStatus">Deposit Received</label>
                            </div>

                            <button type="submit" class="btn btn-primary">Create Order</button>
                        </form>
                    </div>
                </c:if>

                <c:if test="${not empty motor && motor.quantity <= 0}">
                    <div class="alert alert-warning mt-4">
                        <p>This motor is currently out of stock. Please select a different motor.</p>
                    </div>
                </c:if>

                <div class="text-center mt-4">
                    <a href="adminOrders" class="btn btn-secondary btn-lg">
                        <i class="fas fa-arrow-left me-2"></i> Back to Selection
                    </a>
                </div>

                <!-- Ensure Bootstrap JS is included for alert dismissal -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>