<%-- 
    Document   : event_detail
    Created on : Mar 1, 2025, 11:30:24 AM
    Author     : Jackt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${event.event_name} - MotoVibe</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .event-detail-container {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 15px;
                padding: 0;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
                margin: 3rem auto;
                overflow: hidden;
                max-width: 1000px;
            }
            
            .event-header {
                position: relative;
                height: 350px;
                overflow: hidden;
                border-bottom: 1px solid var(--primary-gold);
            }
            
            .event-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
            }
            
            .event-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(to bottom, rgba(17, 17, 17, 0.2) 0%, rgba(17, 17, 17, 0.8) 100%);
                display: flex;
                flex-direction: column;
                justify-content: flex-end;
                padding: 2rem;
            }
            
            .event-title {
                color: var(--primary-gold);
                font-size: 2.5rem;
                font-weight: 700;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 0.5rem;
            }
            
            .event-dates {
                color: var(--text-gold);
                font-size: 1.2rem;
                display: flex;
                align-items: center;
            }
            
            .event-dates i {
                color: var(--primary-gold);
                margin-right: 0.5rem;
            }
            
            .event-content {
                padding: 2rem;
            }
            
            .event-description {
                color: var(--text-gold);
                font-size: 1.1rem;
                line-height: 1.8;
                margin-bottom: 2rem;
                white-space: pre-line;
            }
            
            .event-status {
                display: inline-block;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-size: 0.9rem;
                font-weight: 600;
                margin-bottom: 1.5rem;
            }
            
            .status-active {
                background: rgba(40, 167, 69, 0.2);
                color: #6eff7a;
                border: 1px solid #28a745;
            }
            
            .status-inactive {
                background: rgba(220, 53, 69, 0.2);
                color: #ff6e6e;
                border: 1px solid #dc3545;
            }
            
            .action-buttons {
                margin-top: 2rem;
                padding-top: 2rem;
                border-top: 1px solid rgba(212, 175, 55, 0.3);
                display: flex;
                justify-content: center;
                gap: 1rem;
            }
            
            .btn-gold {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .btn-gold:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            .btn-outline-gold {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                padding: 0.75rem 1.5rem;
                font-weight: 600;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .btn-outline-gold:hover {
                background: rgba(212, 175, 55, 0.1);
                transform: translateY(-3px);
            }
            
            .container {
                padding-top: 80px;
                padding-bottom: 80px;
            }
            
            /* 3D card effect */
            .event-detail-container {
                transform-style: preserve-3d;
                transition: transform 0.5s;
            }
            
            .event-detail-container:hover {
                transform: translateY(-5px);
            }
            
            .related-events {
                margin-top: 3rem;
            }
            
            .related-events h3 {
                color: var(--primary-gold);
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                text-align: center;
                position: relative;
                padding-bottom: 0.5rem;
            }
            
            .related-events h3::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            
            .related-event-card {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--secondary-gold);
                border-radius: 8px;
                overflow: hidden;
                transition: all 0.3s ease;
                height: 100%;
            }
            
            .related-event-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
                border-color: var(--primary-gold);
            }
            
            .related-event-img {
                height: 150px;
                overflow: hidden;
                border-bottom: 1px solid var(--secondary-gold);
            }
            
            .related-event-img img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s;
            }
            
            .related-event-card:hover .related-event-img img {
                transform: scale(1.1);
            }
            
            .related-event-body {
                padding: 1rem;
            }
            
            .related-event-title {
                color: var(--primary-gold);
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }
            
            .related-event-date {
                color: var(--text-gold);
                font-size: 0.9rem;
                opacity: 0.8;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
        <div class="container">
            <div class="event-detail-container">
                <div class="event-header">
                    <img src="images/${event.event_image}" alt="${event.event_name}" class="event-image">
                    <div class="event-overlay">
                        <h1 class="event-title">${event.event_name}</h1>
                        <div class="event-dates">
                            <i class="fas fa-calendar-alt"></i>
                            <span>${event.date_start} - ${event.date_end}</span>
                        </div>
                    </div>
                </div>
                
                <div class="event-content">
                    <div class="event-status ${event.event_status ? 'status-active' : 'status-inactive'}">
                        <i class="fas ${event.event_status ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                        ${event.event_status ? 'Active Event' : 'Inactive Event'}
                    </div>
                    
                    <div class="event-description">
                        ${event.event_detail}
                    </div>
                    
                    <div class="action-buttons">
                        <c:if test="${sessionScope.user.role eq 'admin'}">
                            <a href="EditEventServlet?id=${event.event_id}" class="btn btn-gold">
                                <i class="fas fa-edit me-2"></i> Edit Event
                            </a>
                        </c:if>
                        <a href="listevents" class="btn btn-outline-gold">
                            <i class="fas fa-arrow-left me-2"></i> Back to Events
                        </a>
                    </div>
                </div>
            </div>
            
            <c:if test="${not empty relatedEvents}">
                <div class="related-events">
                    <h3>Other Events You Might Like</h3>
                    
                    <div class="row row-cols-1 row-cols-md-3 g-4">
                        <c:forEach var="relEvent" items="${relatedEvents}" end="2">
                            <div class="col">
                                <div class="related-event-card">
                                    <div class="related-event-img">
                                        <img src="images/${relEvent.event_image}" alt="${relEvent.event_name}">
                                    </div>
                                    <div class="related-event-body">
                                        <h5 class="related-event-title">${relEvent.event_name}</h5>
                                        <p class="related-event-date">
                                            <i class="fas fa-calendar-alt me-1"></i> 
                                            ${relEvent.date_start} - ${relEvent.date_end}
                                        </p>
                                        <a href="listevents?event_id=${relEvent.event_id}" class="btn btn-outline-gold btn-sm mt-2">
                                            View Details
                                        </a>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </c:if>
        </div>
        
        <jsp:include page="footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
