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
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            h1 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 1.5rem;
                position: relative;
            }
            
            h1::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            
            .form-label {
                color: var(--primary-gold);
                font-weight: 500;
                letter-spacing: 1px;
            }
            
            .form-control, .form-select {
                background-color: var(--rich-black);
                border: 1px solid var(--secondary-gold);
                color: white;
            }
            
            .form-control:focus, .form-select:focus {
                background-color: var(--rich-black);
                border-color: var(--primary-gold);
                box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.25);
                color: white;
            }
            
            .btn-success {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
                transition: all 0.3s ease;
                padding: 10px 25px;
            }
            
            .btn-success:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            form {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                padding: 2rem;
                border-radius: 10px;
                border: 1px solid var(--primary-gold);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                max-width: 800px;
                margin: 0 auto;
            }
            
            .create-event-form {
                background: var(--dark-black);
                border: 1px solid var(--secondary-gold);
                border-radius: 10px;
                padding: 2rem;
                margin: 2rem auto;
                width: 600px;
            }
            .btn-create-event {
                background: var(--primary-gold);
                color: var(--dark-black);
                margin-top: 1rem;
            }
        </style>
    </head>
    <body class="d-flex flex-column min-vh-100">
        <jsp:include page="header.jsp"></jsp:include>
        
        <div class="container my-5">
            <h1 class="text-center mb-4"><i class="fas fa-calendar-plus me-2"></i>Create New Event</h1>
            
            <div class="create-event-form">
                <form action="CreateEventServlet" method="post" enctype="multipart/form-data">
                    <div class="mb-3">
                        <label for="event_name" class="form-label">Event Name</label>
                        <input type="text" class="form-control" id="event_name" name="event_name" required>
                    </div>

                    <div class="mb-3">
                        <label for="event_detail" class="form-label">Event Details</label>
                        <textarea class="form-control" id="event_detail" name="event_detail" rows="4" required></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="event_image" class="form-label">Event Image</label>
                        <input type="file" class="form-control" id="event_image" name="event_image" accept="image/*" required>
                        <div id="preview-container" class="mt-3 d-none">
                            <label class="form-label">Image Preview:</label>
                            <img id="image-preview" src="#" alt="Preview" style="max-width: 100%; max-height: 200px; border: 2px solid var(--primary-gold); border-radius: 5px;">
                        </div>
                    </div>

                    <div class="row mb-3">
                        <div class="col-md-6">
                            <label for="date_start" class="form-label">Start Date</label>
                            <input type="date" class="form-control" id="date_start" name="date_start" required>
                        </div>

                        <div class="col-md-6">
                            <label for="date_end" class="form-label">End Date</label>
                            <input type="date" class="form-control" id="date_end" name="date_end" required>
                        </div>
                    </div>

                    <div class="text-center mt-4">
                        <button type="submit" class="btn btn-create-event"><i class="fas fa-save me-2"></i>Create Event</button>
                    </div>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        
        <script>
            // Add preview functionality for the image upload
            document.getElementById('event_image').addEventListener('change', function(e) {
                const file = e.target.files[0];
                if (file) {
                    const reader = new FileReader();
                    const previewContainer = document.getElementById('preview-container');
                    const imagePreview = document.getElementById('image-preview');
                    
                    reader.onload = function(e) {
                        imagePreview.src = e.target.result;
                        previewContainer.classList.remove('d-none');
                    }
                    
                    reader.readAsDataURL(file);
                }
            });
            
            // Validate end date is after start date
            document.getElementById('date_start').addEventListener('change', function() {
                document.getElementById('date_end').min = this.value;
            });
        </script>
    </body>
</html>