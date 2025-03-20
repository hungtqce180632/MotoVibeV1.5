<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
        <!DOCTYPE html>
        <html lang="en">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">
            <title>Edit Event - MotoVibe</title>
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
            <link rel="stylesheet" href="css/luxury-theme.css">
            <style>
                h2 {
                    color: var(--primary-gold);
                    text-transform: uppercase;
                    letter-spacing: 2px;
                    text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.5);
                    margin-bottom: 1.5rem;
                    position: relative;
                }

                h2::after {
                    content: '';
                    position: absolute;
                    bottom: -10px;
                    left: 0;
                    width: 80px;
                    height: 2px;
                    background: var(--primary-gold);
                    box-shadow: 0 0 10px var(--primary-gold);
                }

                .form-label {
                    color: var(--primary-gold);
                    font-weight: 500;
                    letter-spacing: 1px;
                }

                .form-control,
                .form-select {
                    background-color: var(--rich-black);
                    border: 1px solid var(--secondary-gold);
                    color: white;
                }

                .form-control:focus,
                .form-select:focus {
                    background-color: var(--rich-black);
                    border-color: var(--primary-gold);
                    box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.25);
                    color: white;
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

                .container {
                    background: transparent !important;
                    padding-top: 2rem;
                    padding-bottom: 2rem;
                }

                form {
                    background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                    padding: 2rem;
                    border-radius: 10px;
                    border: 1px solid var(--primary-gold);
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                }
            </style>
        </head>

        <body>
            <jsp:include page="header.jsp"></jsp:include>

            <div class="container mt-4">
                <h2>Edit Event</h2>

                <form action="EditEventServlet" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="event_id" value="${event.event_id}">
                    <div class="mb-3">
                        <label for="event_name" class="form-label">Event Name</label>
                        <input type="text" class="form-control" id="event_name" name="event_name"
                            value="${event.event_name}" required>
                    </div>
                    <div class="mb-3">
                        <label for="event_details" class="form-label">Event Details</label>
                        <textarea class="form-control" id="event_details" name="event_details" rows="4"
                            required>${event.event_details}</textarea>
                    </div>
                    <div class="mb-3">
                        <label for="image" class="form-label">Image (Leave empty to keep current)</label>
                        <input type="file" class="form-control" id="image" name="image">
                        <input type="hidden" name="existingPicture" value="${event.image}">
                        <div class="mt-2">
                            <label class="form-label">Current Image:</label>
                            <img src="${pageContext.request.contextPath}/images/events/${event.image}"
                                alt="${event.event_name}"
                                style="max-width: 200px; border: 2px solid var(--primary-gold); border-radius: 5px;"
                                class="d-block">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label for="date_start" class="form-label">Start Date</label>
                        <input type="date" class="form-control" id="date_start" name="date_start"
                            value="${event.date_start}" required>
                    </div>
                    <div class="mb-3">
                        <label for="date_end" class="form-label">End Date</label>
                        <input type="date" class="form-control" id="date_end" name="date_end" value="${event.date_end}"
                            required>
                    </div>
                    <!-- Status is now managed through the Activate/Deactivate button on the management page -->
                    <input type="hidden" name="event_status" value="${event.event_status}">
                    <div class="mb-3">
                        <input type="hidden" name="user_id" value="${event.user_id}">
                        <button type="submit" class="btn btn-primary btn-luxury">Update Event</button>
                    </div>
                </form>
            </div>

            <jsp:include page="footer.jsp"></jsp:include>
        </body>

        </html>