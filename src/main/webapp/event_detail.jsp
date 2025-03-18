<%-- Document : event_detail Created on : Mar 1, 2025, 11:30:24 AM Author : Jackt --%>

    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
                        margin-bottom: 0.5rem;
                        text-shadow: 0 2px 10px rgba(0, 0, 0, 0.7);
                    }

                    .event-dates {
                        color: white;
                        display: flex;
                        align-items: center;
                        font-size: 1.1rem;
                    }

                    .event-dates i {
                        color: var(--secondary-gold);
                        margin-right: 10px;
                    }

                    .event-content {
                        padding: 2rem;
                    }

                    .event-status {
                        display: inline-block;
                        padding: 0.5rem 1rem;
                        border-radius: 50px;
                        margin-bottom: 1.5rem;
                        font-weight: 600;
                    }

                    .status-active {
                        background-color: rgba(40, 167, 69, 0.2);
                        border: 1px solid #28a745;
                        color: #28a745;
                    }

                    .status-inactive {
                        background-color: rgba(220, 53, 69, 0.2);
                        border: 1px solid #dc3545;
                        color: #dc3545;
                    }

                    .event-description {
                        color: white;
                        line-height: 1.8;
                        font-size: 1.1rem;
                        margin-bottom: 2rem;
                        white-space: pre-line;
                    }

                    .action-buttons {
                        display: flex;
                        gap: 1rem;
                        margin-top: 2rem;
                    }

                    .btn-gold {
                        background: var(--primary-gold);
                        color: var(--dark-black);
                        border: none;
                        padding: 0.7rem 1.5rem;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .btn-gold:hover {
                        background: var(--secondary-gold);
                        transform: translateY(-3px);
                        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
                    }

                    .btn-outline-gold {
                        background: transparent;
                        color: var(--primary-gold);
                        border: 1px solid var(--primary-gold);
                        padding: 0.7rem 1.5rem;
                        font-weight: 600;
                        transition: all 0.3s ease;
                    }

                    .btn-outline-gold:hover {
                        color: var(--dark-black);
                        background: var(--primary-gold);
                        transform: translateY(-3px);
                        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.4);
                    }

                    .related-events {
                        margin-top: 4rem;
                        padding-bottom: 3rem;
                    }

                    .related-events h3 {
                        color: var(--primary-gold);
                        margin-bottom: 2rem;
                        position: relative;
                        display: inline-block;
                        padding-bottom: 10px;
                    }

                    .related-events h3::after {
                        content: '';
                        position: absolute;
                        bottom: 0;
                        left: 0;
                        width: 50%;
                        height: 3px;
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
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger" role="alert">
                            ${error}
                        </div>
                    </c:if>

                    <c:if test="${not empty event}">
                        <div class="event-detail-container">
                            <div class="event-header">
                                <!-- Use the base64 encoded image data if available -->
                                <c:choose>
                                    <c:when test="${not empty event.image && event.image.startsWith('data:')}">
                                        <img src="${event.image}" alt="${event.event_name}" class="event-image">
                                    </c:when>
                                    <c:otherwise>
                                        <!-- Fallback to a default image -->
                                        <img src="${pageContext.request.contextPath}/images/new-motorcycle-launch.jpg"
                                            alt="${event.event_name}" class="event-image">
                                    </c:otherwise>
                                </c:choose>
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
                                    <i
                                        class="fas ${event.event_status ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                                    ${event.event_status ? 'Active Event' : 'Inactive Event'}
                                </div>

                                <div class="event-description">
                                    ${event.event_details}
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
                    </c:if>
                </div>

                <jsp:include page="footer.jsp"></jsp:include>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>