<%-- 
    Document   : add_appointment
    Created on : Feb 28, 2025, 9:35:00 AM
    Author     : Jackt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Appointment</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include> <%-- Include Header --%>

            <div class="container mt-4">
                <h2><i class="fas fa-calendar-plus"></i> Schedule an Appointment</h2>
                <p class="lead">Fill out the form below to schedule a motorbike service appointment.</p>

                <form action="appointment" method="POST">
                    <div class="mb-3">
                        <label for="customerId" class="form-label">Customer ID:</label>
                        <input type="number" class="form-control" id="customerId" name="customerId" value="${customerId}" readonly>
                </div>
                <div class="mb-3">
                    <label for="employeeId" class="form-label">Assign Employee (Optional):</label>
                    <select class="form-control" id="employeeId" name="employeeId">
                        <option value="">-- Select an Employee --</option>
                        <c:forEach var="employee" items="${employees}">
                            <option value="${employee.employeeId}">${employee.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="mb-3">
                    <label for="dateStart" class="form-label">Start Date:</label>
                    <input type="datetime-local" class="form-control" id="dateStart" name="dateStart" required>
                </div>
                <div class="mb-3">
                    <label for="dateEnd" class="form-label">End Date (Optional):</label>
                    <input type="datetime-local" class="form-control" id="dateEnd" name="dateEnd">
                </div>
                <div class="mb-3">
                    <label for="note" class="form-label">Note:</label>
                    <textarea class="form-control" id="note" name="note" rows="3"></textarea>
                </div>
                <div class="mb-3">
                    <label for="appointmentStatus" class="form-label">Appointment Status:</label>
                    <input type="hidden" name="appointmentStatus" value="0">
                    <select class="form-control" id="appointmentStatus" name="appointmentStatus" disabled>
                        <option value="1">Active</option>
                        <option value="0" selected>Inactive</option>
                    </select>
                </div>
                <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Appointment</button>
                <a href="listAppointments" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
            </form>
        </div>

        <jsp:include page="footer.jsp"></jsp:include> <%-- Include Footer --%>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

