<%-- 
    Document   : event_detail
    Created on : Feb 23, 2025, 10:22:40 PM
    Author     : Jackt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>Event Details</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body class="d-flex flex-column min-vh-100">
        <jsp:include page="header.jsp"></jsp:include>

            <div class="container my-5">
            <c:if test="${not empty error}">
                <h3 class="text-danger text-center">${error}</h3>
            </c:if>

            <c:if test="${not empty event}">
                <div class="card mx-auto shadow-lg p-4" style="max-width: 600px;">
                    <h2 class="text-center">${event.event_name}</h2>
                    <hr>
                    <c:choose>
                        <c:when test="${not empty event.image}">
                            <img src="${pageContext.request.contextPath}/images/${event.image}.jpg"
                                 alt="${event.image}" class="img-fluid rounded shadow" 
                                 style="max-height: 300px; object-fit: cover;">
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/images/new-motorcycle-launch.jpg" 
                                 alt="Default Event Image" class="img-fluid rounded shadow" 
                                 style="max-height: 300px; object-fit: cover;">
                        </c:otherwise>
                    </c:choose>

                    <p><strong>Details:</strong> ${event.event_details}</p>
                    <p><strong>Start Date:</strong> ${event.date_start}</p>
                    <p><strong>End Date:</strong> ${event.date_end}</p>

                    <!-- Nút Back về danh sách -->
                    <div class="text-center mt-4">
                        <a href="listevents" class="btn btn-secondary">Back to Event List</a>
                    </div>
                </div>
            </c:if>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
