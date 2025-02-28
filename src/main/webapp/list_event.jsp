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
        <title>MotoVibe Events</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }
            
            body {
                background: var(--dark-black);
                color: var(--text-gold);
            }
            
            .event-list-container {
                padding-top: 100px;
                padding-bottom: 50px;
            }
            
            h1 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 2rem;
                text-align: center;
                position: relative;
            }
            
            h1::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 3px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            
            .btn-gold {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                padding: 10px 25px;
                border-radius: 5px;
                font-weight: 600;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                text-transform: uppercase;
            }
            
            .btn-gold:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
            }
            
            .card {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--secondary-gold);
                border-radius: 10px;
                overflow: hidden;
                margin-bottom: 30px;
                transition: all 0.4s ease;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                height: 100%;
                display: flex;
                flex-direction: column;
            }
            
            .card:hover {
                transform: translateY(-10px);
                box-shadow: 0 15px 35px rgba(212, 175, 55, 0.3);
                border-color: var(--primary-gold);
            }
            
            .card img {
                width: 100%;
                height: 250px;
                object-fit: cover;
                border-bottom: 2px solid var(--primary-gold);
                transition: all 0.5s ease;
            }
            
            .card:hover img {
                transform: scale(1.05);
                filter: brightness(1.1);
            }
            
            .card-content {
                padding: 1.5rem;
                display: flex;
                flex-direction: column;
                flex-grow: 1;
            }
            
            .card-title {
                color: var(--primary-gold);
                font-size: 1.5rem;
                font-weight: 600;
                margin-bottom: 1.5rem;
                text-align: center;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
                position: relative;
            }
            
            .card-title::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 50px;
                height: 2px;
                background: var(--primary-gold);
            }
            
            .card-meta {
                margin-top: auto;
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding-top: 1.5rem;
                border-top: 1px solid rgba(212, 175, 55, 0.2);
            }
            
            .date-info {
                font-size: 0.9rem;
                opacity: 0.8;
            }
            
            .btn-primary {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
                transition: all 0.3s ease;
            }
            
            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            .text-muted {
                color: var(--text-gold) !important;
                opacity: 0.7;
            }
            
            /* Empty state */
            .no-events {
                background: linear-gradient(145deg, var(--rich-black), var(--dark-black));
                border: 1px dashed var(--secondary-gold);
                border-radius: 10px;
                padding: 3rem;
                text-align: center;
                margin: 2rem 0;
            }
            
            .no-events h4 {
                color: var (--primary-gold);
                margin-bottom: 1rem;
            }
            
            .no-events i {
                font-size: 4rem;
                color: var(--primary-gold);
                opacity: 0.5;
                margin-bottom: 1.5rem;
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <jsp:include page="header.jsp"></jsp:include>
        
        <div class="container event-list-container">
            <h1><i class="fas fa-calendar-alt me-2"></i>Upcoming Events</h1>

            <c:if test="${sessionScope.userRole == 'admin'}">
                <div class="text-center mb-5">
                    <a href="ManageEventServlet" class="btn btn-gold">
                        <i class="fas fa-cog me-2"></i>Manage Events
                    </a>
                </div>
            </c:if>

            <c:choose>
                <c:when test="${not empty events}">
                    <div class="row row-cols-1 row-cols-md-2 g-4">
                        <c:forEach var="event" items="${events}">
                            <div class="col">
                                <div class="card h-100">
                                    <img src="${pageContext.request.contextPath}/images/new-motorcycle-launch.jpg" 
                                         alt="${event.event_name}" class="card-img-top"/>
                                    
                                    <div class="card-content">
                                        <h5 class="card-title">${event.event_name}</h5>
                                        
                                        <div class="card-meta">
                                            <div class="date-info">
                                                <div><i class="fas fa-calendar-day me-2"></i>Start: ${event.date_start}</div>
                                                <div><i class="fas fa-calendar-check me-2"></i>End: ${event.date_end}</div>
                                            </div>
                                            
                                            <form action="listevents" method="post">
                                                <input type="hidden" name="event_id" value="${event.event_id}">
                                                <button type="submit" class="btn btn-primary">
                                                    <i class="fas fa-info-circle me-1"></i> View Details
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="no-events">
                        <i class="fas fa-calendar-times"></i>
                        <h4>No Events Available</h4>
                        <p>Check back soon for upcoming events and motorcycle shows!</p>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
