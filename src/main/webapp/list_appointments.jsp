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
                <!-- Hiển thị thông báo success -->
            <c:if test="${not empty success}">
                <div id="successAlert" class="alert alert-success alert-dismissible fade show" role="alert">
                    ${success}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

            <!-- Hiển thị thông báo error -->
            <c:if test="${not empty error}">
                <div id="errorAlert" class="alert alert-danger alert-dismissible fade show" role="alert">
                    ${error}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>

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
                                <c:if test="${userRole == 'employee'}">
                                <th>Customer Name</th>
                                <th>Phone Number</th>
                                </c:if>
                            <th>Start Time</th>
                            <th>End Time</th>
                            <th>Note</th>
                            <th>Status</th>
                                <c:if test="${userRole == 'employee'}">
                                <th>Actions</th> </c:if>
                                <c:if test="${userRole == 'customer'}">
                                <th>Cancel appointment</th> </c:if>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="appointment" items="${appointments}">
                            <tr>
                                <td>${appointment.appointmentId}</td>
                                
                                <c:if test="${userRole == 'employee'}">
                                    <td>${customerMap[appointment.customerId].name}</td>
                                    <td>${customerMap[appointment.customerId].phoneNumber}</td>
                                </c:if>
                                    
                                <td><fmt:formatDate value="${appointment.dateStart}" pattern="yyyy-MM-dd" /></td> <%-- Format date and time --%>
                                <td><fmt:formatDate value="${appointment.dateEnd}" pattern="yyyy-MM-dd" /></td>
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
                                <!-- Nếu là Employee, hiển thị nút Approve / Decline -->
                                <c:if test="${userRole == 'employee'}">
                                    <td>
                                        <form action="approveAppointment" method="POST" class="d-inline">
                                            <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                                            <button type="submit" class="btn btn-outline-success btn-sm me-1" title="Approve Appointment">
                                                <i class="fas fa-check"></i> Approve
                                            </button>
                                        </form>

                                        <form action="declineAppointment" method="POST" class="d-inline">
                                            <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                                            <button type="submit" class="btn btn-outline-danger btn-sm" title="Decline Appointment">
                                                <i class="fas fa-times"></i> Decline
                                            </button>
                                        </form>
                                    </td>
                                </c:if>

                                <!-- Nếu là Customer, hiển thị nút Cancel (chỉ khi appointment là Inactive) -->
                                <c:if test="${userRole == 'customer'}">
                                    <td>
                                        <c:choose>
                                            <c:when test="${appointment.appointmentStatus}">
                                                <!-- Active Status: Disabled Delete Button -->
                                                <button class="btn btn-outline-danger btn-sm" title="Cannot delete active appointment" disabled>
                                                    <i class="fas fa-times"></i> Cancel
                                                </button>
                                            </c:when>
                                            <c:otherwise>
                                                <!-- Inactive Status: Show Active Delete Button -->
                                                <form action="listAppointments" method="POST" onsubmit="return confirm('Are you sure you want to delete this appointment?');">
                                                    <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                                                    <button type="submit" class="btn btn-outline-danger btn-sm" title="Delete Appointment">
                                                        <i class="fas fa-trash"></i> Cancel
                                                    </button>
                                                </form>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </c:if>
                            </tr>
                        </c:forEach>

                    </tbody>
                </table>
            </div>
            <div class="mt-3">
                <a href="index.jsp" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i>Back to Dashboard</a>
                <c:if test="${userRole == 'customer'}">
                    <a href="appointment" class="btn btn-outline-info"><i class="fa-solid fa-plus"></i>Add appointments</a>
                </c:if>
            </div>
        </div>
        <br>
        <jsp:include page="footer.jsp"></jsp:include> <%-- Include footer --%>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
                                                    // Tự động ẩn thông báo sau 3 giây
                                                    setTimeout(function () {
                                                        let successAlert = document.getElementById("successAlert");
                                                        let errorAlert = document.getElementById("errorAlert");

                                                        if (successAlert) {
                                                            successAlert.style.transition = "opacity 0.5s";
                                                            successAlert.style.opacity = "0";
                                                            setTimeout(() => successAlert.style.display = "none", 500);
                                                        }

                                                        if (errorAlert) {
                                                            errorAlert.style.transition = "opacity 0.5s";
                                                            errorAlert.style.opacity = "0";
                                                            setTimeout(() => errorAlert.style.display = "none", 500);
                                                        }
                                                    }, 3000); // 3 giây
        </script>
    </body>
</html>