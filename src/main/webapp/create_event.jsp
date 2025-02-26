<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Create Event</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            .design-margin {
                margin-top: 20px;
                margin-bottom: 20pxj
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <jsp:include page="header.jsp"></jsp:include>
        
        <div class="container my-5">
            <h1 class="text-center">Create New Event</h1>
            
            <form action="CreateEventServlet" method="post" enctype="multipart/form-data">
                <div class="mb-3">
                    <label for="event_name" class="form-label">Event Name</label>
                    <input type="text" class="form-control" id="event_name" name="event_name" required>
                </div>

                <div class="mb-3">
                    <label for="event_detail" class="form-label">Event Detail</label>
                    <textarea class="form-control" id="event_detail" name="event_detail" rows="4" required></textarea>
                </div>

                <div class="mb-3">
                    <label for="event_image" class="form-label">Event Image</label>
                    <input type="file" class="form-control" id="event_image" name="event_image" accept="image/*" required>
                </div>

                <div class="mb-3">
                    <label for="date_start" class="form-label">Start Date</label>
                    <input type="date" class="form-control" id="date_start" name="date_start" required>
                </div>

                <div class="mb-3">
                    <label for="date_end" class="form-label">End Date</label>
                    <input type="date" class="form-control" id="date_end" name="date_end" required>
                </div>

                <div class="text-center">
                    <button type="submit" class="btn btn-success">Create Event</button>
                </div>
            </form>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
    </body>
</html>