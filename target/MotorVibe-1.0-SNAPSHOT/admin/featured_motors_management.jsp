<%-- 
    Document   : featured_motors_management
    Created on : Feb 23, 2025, 6:23:30 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin - Featured Motor Management</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container">
        <h1>Featured Motorbike Management</h1>
        <a href="<%=request.getContextPath()%>/motor/admin/motorManagement" class="btn btn-secondary mb-3">Back to Motor Management</a>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Motor ID</th>
                    <th>Name</th>
                    <th>Featured</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="motor" items="${listMotors}">
                    <tr>
                        <td><c:out value="${motor.motorId}"/></td>
                        <td><c:out value="${motor.motorName}"/></td>
                        <td><c:out value="${motor.featured ? 'Yes' : 'No'}"/></td>
                        <td>
                            <c:if test="${!motor.featured}">
                                <form action="<%=request.getContextPath()%>/motor/admin/featureMotor" method="POST" style="display:inline;">
                                    <input type="hidden" name="motorId" value="${motor.motorId}">
                                    <button type="submit" class="btn btn-success btn-sm">Feature</button>
                                </form>
                            </c:if>
                            <c:if test="${motor.featured}">
                                <form action="<%=request.getContextPath()%>/motor/admin/unfeatureMotor" method="POST" style="display:inline;">
                                    <input type="hidden" name="motorId" value="${motor.motorId}">
                                    <button type="submit" class="btn btn-warning btn-sm">Unfeature</button>
                                </form>
                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
