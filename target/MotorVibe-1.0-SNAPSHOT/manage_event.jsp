<%-- 
    Document   : manage_event
    Created on : Feb 28, 2025, 2:23:46 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Event Management - MotoVibe</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                position: relative;
                padding-bottom: 15px;
                margin-bottom: 30px;
            }

            h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .event-management-container {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 2rem;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
                margin-bottom: 2rem;
            }
            
            .table {
                color: var(--text-gold);
                margin-top: 1.5rem;
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                overflow: hidden;
            }
            
            .table thead th {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                text-transform: uppercase;
                letter-spacing: 1px;
                font-size: 0.9rem;
                font-weight: 600;
                padding: 1rem;
                vertical-align: middle;
                border: none;
            }
            
            .table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-top: 1px solid rgba(212, 175, 55, 0.2);
            }
            
            .table tbody tr {
                transition: all 0.3s ease;
            }
            
            .table tbody tr:hover {
                background: rgba(212, 175, 55, 0.05);
                transform: translateY(-2px);
            }
            
            .btn {
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                margin: 0.25rem;
            }
            
            .btn-primary {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
            }
            
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            .btn-warning {
                background: linear-gradient(145deg, #ffc107, #e0a800);
                border: none;
                color: var(--dark-black);
            }
            
            .btn-danger {
                background: linear-gradient(145deg, #dc3545, #c82333);
                border: none;
                color: white;
            }
            
            .btn-info {
                background: linear-gradient(145deg, #17a2b8, #138496);
                border: none;
                color: white;
            }
            
            .btn-sm {
                padding: 0.25rem 0.75rem;
                font-size: 0.8rem;
            }
            
            .form-control {
                background-color: rgba(26, 26, 26, 0.9);
                border: 1px solid var(--primary-gold);
                color: var(--text-gold);
            }
            
            .form-control:focus {
                background-color: rgba(26, 26, 26, 0.95);
                border-color: var(--primary-gold);
                box-shadow: 0 0 0 0.25rem rgba(212, 175, 55, 0.25);
                color: var (--text-gold);
            }
            
            .btn-outline-success {
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                background: transparent;
            }
            
            .btn-outline-success:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
            }
            
            .active-badge {
                background: linear-gradient(145deg, #28a745, #218838);
                color: white;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
            }
            
            .inactive-badge {
                background: linear-gradient(145deg, #6c757d, #5a6268);
                color: white;
                padding: 0.25rem 0.75rem;
                border-radius: 20px;
                font-size: 0.75rem;
                font-weight: 600;
            }
            
            .container {
                padding-top: 80px;
                padding-bottom: 50px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="container">
            <div class="event-management-container">
                <h2 class="text-center"><i class="fas fa-calendar-alt me-2"></i>Event Management</h2>

                <div class="d-flex justify-content-between mb-4">
                    <div>
                        <a href="create_event.jsp" class="btn btn-primary">
                            <i class="fas fa-plus me-1"></i> Create New Event
                        </a>
                    </div>
                    <form action="searchEvents" method="get" class="d-flex">
                        <input class="form-control me-2" type="search" placeholder="Search by Event Name" name="searchTerm">
                        <button class="btn btn-outline-success" type="submit">
                            <i class="fas fa-search me-1"></i> Search
                        </button>
                    </form>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Event Name</th>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="event" items="${events}">
                                <tr>
                                    <td>${event.event_id}</td>
                                    <td>${event.event_name}</td>
                                    <td>${event.date_start}</td>
                                    <td>${event.date_end}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${event.event_status}">
                                                <span class="active-badge">
                                                    <i class="fas fa-check-circle me-1"></i> Active
                                                </span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="inactive-badge">
                                                    <i class="fas fa-times-circle me-1"></i> Inactive
                                                </span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <div class="d-flex">
                                            <a href="EditEventServlet?id=${event.event_id}" class="btn btn-warning btn-sm">
                                                <i class="fas fa-edit me-1"></i> Edit
                                            </a>
                                            <a href="deleteEvent?id=${event.event_id}" class="btn btn-danger btn-sm" 
                                               onclick="return confirm('Are you sure you want to delete this event?')">
                                                <i class="fas fa-trash me-1"></i> Delete
                                            </a>

                                            <form action="changeEventStatus" method="post" class="d-inline">
                                                <input type="hidden" name="event_id" value="${event.event_id}">
                                                <button type="submit" class="btn btn-info btn-sm">
                                                    <i class="fas fa-${event.event_status ? 'eye-slash' : 'eye'} me-1"></i>
                                                    ${event.event_status ? 'Deactivate' : 'Activate'}
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

