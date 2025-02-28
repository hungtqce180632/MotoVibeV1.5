<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edit Event - MotoVibe</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="container mt-4">
            <h2>Edit Event</h2>

            <form action="EditEventServlet" method="post" enctype="multipart/form-data">
                <input type="hidden" name="event_id" value="${event.event_id}">
                <div class="mb-3">
                    <label for="event_name" class="form-label">Event Name</label>
                    <input type="text" class="form-control" id="event_name" name="event_name" value="${event.event_name}" required>
                </div>
                <div class="mb-3">
                    <label for="event_details" class="form-label">Event Details</label>
                    <textarea class="form-control" id="event_details" name="event_details" required>${event.event_details}</textarea>
                </div>
                <div class="mb-3">
                    <label for="image" class="form-label">Image (Leave empty to keep current)</label>
                    <input type="file" class="form-control" id="image" name="image">
                    <input type="hidden" name="existingPicture" value="${event.image}">
                </div>
                <div class="mb-3">
                    <label for="date_start" class="form-label">Start Date</label>
                    <input type="date" class="form-control" id="date_start" name="date_start" value="${event.date_start}" required>
                </div>
                <div class="mb-3">
                    <label for="date_end" class="form-label">End Date</label>
                    <input type="date" class="form-control" id="date_end" name="date_end" value="${event.date_end}" required>
                </div>
                <div class="mb-3">
                    <label for="event_status" class="form-label">Event Status</label>
                    <select class="form-select" name="event_status" id="event_status">
                        <option value="true" ${event.event_status ? 'selected' : ''}>Active</option>
                        <option value="false" ${!event.event_status ? 'selected' : ''}>Inactive</option>
                    </select>
                </div>
                <div class="mb-3">
                    <input type="hidden" name="user_id" value="${event.user_id}">
                    <button type="submit" class="btn btn-primary">Update Event</button>
                </div>
            </form>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>
