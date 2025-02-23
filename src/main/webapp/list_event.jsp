<%-- 
    Document   : list_event
    Created on : Feb 23, 2025, 12:56:24 PM
    Author     : Jackt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>List Events</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">       

        <style>
            .flex-container {
                display: flex;
                align-items: stretch;
            }

            .flex-container > div {
                width: 200px;
                text-align: left;
                line-height: 25px;
                font-size: 20px;
            }

        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <jsp:include page="header.jsp"></jsp:include>
            <h1 class="text-center">Event List</h1>


            <div class="container my-5 pt-5">


            <c:choose>
                <c:when test="${not empty events}">
                    <div class="row">
                        <c:forEach var="event" items="${events}">
                            <div class="col-md-6 mb-4">
                                <div class="card">

                                    <h5 class="card-title">${event.event_name}</h5>
                                    <hr>
                                    <p ><strong>Details:</strong> ${event.event_details}</p>

                                    <div class="flex-container">
                                        <div>
                                            <p class="mb-0"><small class="text-muted">Start: ${event.date_start}</small></p>
                                            <p class="mb-0"><small class="text-muted">End: ${event.date_end}</small></p>
                                        </div>
                                        <div> </div>

                                        <div>
                                            <!-- 🛠 Button "View Detail" -->
                                            <form action="#" method="get">
                                                <input type="hidden" name="event_id" value="${event.event_id}">
                                                <button type="submit" class="btn btn-primary">View Detail</button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <h4 class="text-center">No Events Available</h4>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>


    </body>
</html>
