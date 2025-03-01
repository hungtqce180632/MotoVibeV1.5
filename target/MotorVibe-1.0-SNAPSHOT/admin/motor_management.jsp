<%-- 
    Document   : motor_management
    Created on : Feb 23, 2025, 6:27:45 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - Motor Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>Motor Management Dashboard</h1>

        <nav>
            <ul class="nav">
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/motor/admin/motorManagement">Motorbike List</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%=request.getContextPath()%>/motor/admin/add">Add New Motorbike</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="<%=request.getContextPath()%>/motor/admin/featuredMotorManagement">Featured Motorbike Management</a> <%-- ADD THIS LINK --%>
                </li>
                <%-- Add other admin navigation links here as needed (e.g., Brands, Models, Fuels management, User Management etc.) --%>
            </ul>
        </nav>

        <h2>Motorbike List</h2>
        <a href="<%=request.getContextPath()%>/motor/admin/add" class="btn btn-primary mb-3">Add New Motorbike</a>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Motor ID</th>
                    <th>Name</th>
                    <th>Brand</th>
                    <th>Model</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Featured</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="motor" items="${listMotors}">
                    <tr>
                        <td><c:out value="${motor.motorId}"/></td>
                        <td><c:out value="${motor.motorName}"/></td>
                        <td><c:out value="${motor.brand.brandName}"/></td>
                        <td><c:out value="${motor.model.modelName}"/></td>
                        <td><c:out value="${motor.price}"/></td>
                        <td><c:out value="${motor.quantity}"/></td>
                        <td><c:out value="${motor.featured ? 'Yes' : 'No'}"/></td> <%-- Display Featured status in Motor List --%>
                        <td>
                            <a href="<%=request.getContextPath()%>/motor/admin/edit?motorId=${motor.motorId}" class="btn btn-primary btn-sm">Edit</a>
                            <a href="<%=request.getContextPath()%>/motor/admin/delete?motorId=${motor.motorId}" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
