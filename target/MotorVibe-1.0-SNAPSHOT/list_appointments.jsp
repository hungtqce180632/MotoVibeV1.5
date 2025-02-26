<%-- 
    Document   : list_appointments
    Created on : Feb 23, 2025, 12:36:57 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%> <%-- For formatting dates --%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Appointment List</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="..." crossorigin="anonymous" referrerpolicy="no-referrer" />
    </head>

    <body>
        
            <jsp:include page="header.jsp"></jsp:include>
            
            <div class="container mt-4 pt-5">
            <c:choose>
                <c:when test="${userRole == 'customer'}">
                    <h1><i class="fas fa-calendar-check"></i> Your Appointments</h1>
                    <p class="lead">Manage and view your scheduled motorbike service appointments.</p>
                </c:when>
                <c:when test="${userRole == 'employee'}">
                    <h1><i class="fas fa-calendar-day"></i> Customer Appointment Management</h1>
                    <p class="lead">Review and manage appointments scheduled by customers.</p>
                </c:when>
                <c:otherwise>
                    <h1><i class="fas fa-calendar"></i> Appointments</h1> <%-- Default heading if role is not customer/employee --%>
                </c:otherwise>
            </c:choose>

                    
            <div class="table-responsive">
                <table class="table table-striped table-bordered">
                    <thead class="table-light">
                        <tr>
                            <th>Appointment ID</th>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Note</th>
                            <th>Status</th>
                                <c:if test="${userRole == 'employee'}">
                                <th>Actions</th> </c:if>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="appointment" items="${appointments}">
                            <tr>
                                <td>${appointment.appointmentId}</td>
                                <td><fmt:formatDate value="${appointment.dateStart}" pattern="yyyy-MM-dd HH:mm" /></td> <%-- Format date and time --%>
                                <td><fmt:formatDate value="${appointment.dateEnd}" pattern="yyyy-MM-dd HH:mm" /></td>
                                <td>${appointment.note}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${appointment.appointmentStatus}">
                                            <span class="badge bg-success">Active</span> <%-- Or Pending, depending on your status logic --%>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Inactive</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <c:if test="${userRole == 'employee'}">
                                    <td>
                                        <button class="btn btn-outline-success btn-sm me-1" title="Approve Appointment"><i class="fas fa-check"></i> Approve</button>
                                        <button class="btn btn-outline-danger btn-sm" title="Decline Appointment"><i class="fas fa-times"></i> Decline</button>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>
                        <c:if test="${appointments.isEmpty()}">
                            <tr>
                                <td colspan="<c:choose><c:when test="${userRole == 'employee'}">6</c:when><c:otherwise>5</c:otherwise></c:choose>" class="text-center">No appointments found.</td>
                                    </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
            <div class="mt-3">
                <a href="index.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
            </div>
        </div>
        <jsp:include page="footer.jsp"></jsp:include> <%-- Include footer --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>