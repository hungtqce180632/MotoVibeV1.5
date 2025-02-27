<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="models.Review"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Reviews Management</title>
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            body { background: var(--rich-black); color: var(--text-gold); }
            .reviews-container {
                background: var(--dark-black);
                border: 1px solid var(--secondary-gold);
                border-radius: 10px;
                padding: 2rem;
                margin: 2rem auto;
                max-width: 1200px;
            }
            .review-card {
                background: var(--rich-black);
                border: 1px solid var(--secondary-gold);
                margin-bottom: 1rem;
                padding: 1rem;
                border-radius: 8px;
            }
            .btn-group .btn {
                margin-right: 0.5rem;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <div class="container mt-5" style="margin-top: 100px !important;">
            <div class="reviews-container">
                <h1 class="text-center mb-4">Reviews Management</h1>
                
                <%
                    List<Review> reviews = (List<Review>)request.getAttribute("reviews");
                    if(reviews != null && !reviews.isEmpty()) {
                        for(Review review : reviews) {
                %>
                <div class="review-card">
                    <div class="row">
                        <div class="col-md-8">
                            <h5>Review #<%= review.getReviewId() %></h5>
                            <p><strong>Customer:</strong> <%= review.getCustomer_name() %></p>
                            <p><strong>Rating:</strong> <%= review.getRating() %>/5</p>
                            <p><strong>Review:</strong> <%= review.getReviewText() %></p>
                            <p><strong>Date:</strong> <%= review.getReviewDate() %></p>
                        </div>
                        <div class="col-md-4 text-end">
                            <div class="btn-group">
                                <a href="motorDetail?id=<%= review.getMotorId() %>" class="btn btn-outline-gold">
                                    <i class="fas fa-eye"></i> View
                                </a>
                                <a href="EditReviewServlet?reviewId=<%= review.getReviewId() %>" class="btn btn-outline-gold">
                                    <i class="fas fa-edit"></i> Edit
                                </a>
                                <a href="DeleteReviewServlet?reviewId=<%= review.getReviewId() %>" 
                                   class="btn btn-outline-danger"
                                   onclick="return confirm('Are you sure you want to delete this review?');">
                                    <i class="fas fa-trash"></i> Delete
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <p class="text-center">No reviews found.</p>
                <%
                    }
                %>
            </div>
        </div>
        
        <jsp:include page="footer.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>