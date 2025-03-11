<%-- 
    Document   : order_by_employee
    Created on : Mar 1, 2025, 9:44:56 PM
    Author     : ACER
--%>

<%@ page contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Create Order</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css">
    </head>
    <body>

        <div class="container mt-5">
            <h1 class="mb-4 text-center">Create Order for Customer</h1>

            <h1>Select a Customer</h1>

            <!-- Dropdown to select a customer by name -->
            <form action="" method="get">
                <label for="customerName"><strong>Customer Name</strong></label>
                <select name="customerId" id="customerName" required>
                    <option value="" disabled selected>Select Customer</option>
                    <c:forEach var="customer" items="${customers}">
                        <option value="${customer.customerId}" 
                                <c:if test="${customer.customerId == param.customerId}">selected</c:if>>
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
                        <option value="${motor.motorId}" 
                                <c:if test="${motor.motorId == param.motorId}">selected</c:if>>
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
                    <tr><td><strong>Motor Name:</strong></td><td>${motor.motorName}</td></tr>
                    <tr><td><strong>Price:</strong></td><td>${motor.price}</td></tr>
                    <tr><td><strong>Color:</strong></td><td>${motor.color}</td></tr>
                    <tr><td><strong>Quantity:</strong></td><td>${motor.quantity}</td></tr>
                    <tr><td><strong>Picture:</strong></td><td><img src="${motor.picture}" alt="Motor Picture" /></td></tr>
                </table>
            </c:if>
            <br>

            <!-- Display selected customer details if a customer is selected -->
            <c:if test="${not empty customer}">
                <h2>Customer Details:</h2>
                <table class="table">
                    <tr><td><strong>Customer ID:</strong></td><td>${customer.customerId}</td></tr>
                    <tr><td><strong>Name:</strong></td><td>${customer.name}</td></tr>
                    <tr><td><strong>Phone Number:</strong></td><td>${customer.phoneNumber}</td></tr>
                    <tr><td><strong>Address:</strong></td><td>${customer.address}</td></tr>
                    <tr><td><strong>Email:</strong></td><td>${customer.email}</td></tr>
                </table>
            </c:if>

        </div>
        <div class="text-center mt-4">
            <a href="MotorOfEmployeeCreateServlet" class="btn btn-primary btn-lg">
                <i class="fas fa-plus me-2"></i> Create Order
            </a>
        </div>

    </body>
</html>