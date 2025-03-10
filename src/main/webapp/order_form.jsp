<%@ page import="models.UserAccount" %>
<%@ page import="models.Customer" %>
<%@ page import="dao.CustomerDAO" %>
<%@ page import="models.Motor" %>
<%@ page import="dao.MotorDAO" %>

<%
    // Get the logged-in user
    UserAccount user = (UserAccount) session.getAttribute("user");
    
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
    
    // Get motor details
    int motorId = Integer.parseInt(request.getParameter("id"));
    MotorDAO motorDAO = new MotorDAO();
    Motor motor = motorDAO.getMotorById(motorId);
    
    // Generate order code
    String orderCode = "MV-" + System.currentTimeMillis() % 100000;
%>

<!DOCTYPE html>
<html>
<head>
    <title>Order Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/luxury-theme.css">
</head>
<body>
    <div class="container mt-5">
        <div class="order-form-section">
            <h2>Complete Your Order</h2>
            <form action="confirmOrder" method="post">
                <input type="hidden" name="motorId" value="<%= motorId %>">
                <input type="hidden" name="orderCode" value="<%= orderCode %>">
                
                <div class="order-summary">
                    <h4>Order Summary</h4>
                    <p><strong>Order #:</strong> <span class="order-code"><%= orderCode %></span></p>
                    <p><strong>Model:</strong> <%= motor.getMotorName() %></p>
                    <p><strong>Price:</strong> $<%= motor.getPrice() %></p>
                </div>
                
                <div class="mb-3">
                    <label for="customerName" class="form-label">Full Name</label>
                    <input type="text" class="form-control" id="customerName" name="customerName" value="<%= customerName %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="customerEmail" class="form-label">Email</label>
                    <input type="email" class="form-control" id="customerEmail" name="customerEmail" value="<%= customerEmail %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="customerPhone" class="form-label">Phone Number</label>
                    <input type="tel" class="form-control" id="customerPhone" name="customerPhone" value="<%= customerPhone %>" required>
                </div>
                
                <div class="mb-3">
                    <label for="customerAddress" class="form-label">Address</label>
                    <textarea class="form-control" id="customerAddress" name="customerAddress" rows="2" required><%= customerAddress %></textarea>
                </div>
                
                <div class="mb-3">
                    <label for="customerIdNumber" class="form-label">ID Number (12 Digits)</label>
                    <input type="text" class="form-control" id="customerIdNumber" name="customerIdNumber" pattern="[0-9]{12}" title="Please enter a valid 12-digit ID number" required>
                    <div class="form-text text-light">Your national identification number is required for purchase verification.</div>
                </div>
                
                <div class="mb-3">
                    <label for="paymentMethod" class="form-label">Payment Method</label>
                    <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                        <option value="Credit Card">Credit Card</option>
                        <option value="Bank Transfer">Bank Transfer</option>
                        <option value="Cash on Delivery">Cash on Delivery</option>
                        <option value="Finance">Financing</option>
                    </select>
                </div>
                
                <div class="mb-3 form-check">
                    <input type="checkbox" class="form-check-input" id="hasWarranty" name="hasWarranty" value="true">
                    <label class="form-check-label" for="hasWarranty">Include Premium Protection Plan</label>
                </div>
                
                <!-- Removed "Pay Deposit" option -->
                
                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg">Complete Order</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>