<%-- 
    Document   : motor_list
    Created on : Feb 21, 2025, 3:01:41 PM
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Motorbike List</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Motorbike List</h2>
            <div class="d-flex float-end mb-3">
                <a href="addMotor" class="btn btn-primary">Add New Motorbike</a>
                <a href="inventoryLog" class="btn btn-primary ms-2">Inventory Log</a>
            </div>
            <table class="table table-bordered table-hover">
                <thead class="table-dark">
                    <tr>
                        <th>ID</th>
                        <th>Motor Name</th>
                        <th>Brand</th>
                        <th>Model</th>
                        <th>Fuel</th>
                        <th>Color</th>
                        <th>Price</th>
                        <th>Start Date</th>
                        <th>Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="motor" items="${motors}">
                        <tr>
                            <td>${motor.motorId}</td>
                            <td>
                                <a href="motorDetail?id=${motor.motorId}" class="fw-bold text-decoration-none ${motor.present eq true ? 'text-success' : 'text-danger'}">
                                    ${motor.motorName}
                                </a>
                            </td>
                            <td>${brandMap[motor.brandId]}</td>
                            <td>${modelMap[motor.modelId]}</td>
                            <td>${fuelMap[motor.fuelId]}</td>
                            <td>${motor.color}</td>
                            <td>${motor.price}</td>
                            <td>${motor.dateStart}</td>
                            <td>${motor.quantity}</td>
                            <td>
                                <a href="changeQuantity?id=${motor.motorId}" class="btn btn-warning btn-sm btn-full-width mt-1">Change Quantity</a>
                                <a href="toggleMotorStatus?id=${motor.motorId}" class="btn btn-secondary btn-sm btn-full-width mt-1">${motor.present eq true ? 'Hide' : 'Unhide'}</a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
