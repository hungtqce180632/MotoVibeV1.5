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
            body { 
                background: var(--dark-black); 
                color: var(--text-gold); 
                font-family: 'Montserrat', sans-serif;
            }
            
            .reviews-container {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 2rem;
                margin: 2rem auto;
                max-width: 1200px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
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
            
            .review-card {
                background: linear-gradient(145deg, var(--rich-black), var(--dark-black));
                border: 1px solid var(--secondary-gold);
                margin-bottom: 1.5rem;
                padding: 1.5rem;
                border-radius: 8px;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }
            
            .review-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0, 0, 0, 0.4);
                border-color: var(--primary-gold);
            }
            
            .review-card::before {
                content: '';
                position: absolute;
                top: -50px;
                right: -50px;
                width: 100px;
                height: 100px;
                background: radial-gradient(circle, var(--primary-gold) 0%, transparent 70%);
                opacity: 0.1;
            }
            
            h5 {
                color: var(--primary-gold);
                font-weight: 600;
                margin-bottom: 1rem;
                border-bottom: 1px solid rgba(212, 175, 55, 0.3);
                padding-bottom: 0.5rem;
            }
            
            strong {
                color: var(--primary-gold);
                font-weight: 600;
            }
            
            .btn-group {
                margin-top: 1rem;
            }
            
            .btn-outline-gold {
                color: var(--primary-gold);
                border: 1px solid var(--primary-gold);
                background: transparent;
                margin-right: 0.5rem;
                transition: all 0.3s ease;
            }
            
            .btn-outline-gold:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            .btn-outline-danger {
                color: #ff6b6b;
                border: 1px solid #ff6b6b;
                background: transparent;
                transition: all 0.3s ease;
            }
            
            .btn-outline-danger:hover {
                background: #ff6b6b;
                color: var(--dark-black);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(255, 107, 107, 0.3);
            }
            
            .text-center {
                color: var(--text-gold);
                margin-top: 2rem;
                font-style: italic;
            }
            
            /* Rating stars */
            .rating {
                color: var(--primary-gold);
                font-size: 1.2rem;
                margin-bottom: 0.5rem;
            }
            
            /* Add some space at the top to account for header */
            .container {
                margin-top: 100px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>
        
        <div class="container">
            <div class="reviews-container">
                <h1><i class="fas fa-star me-2"></i>Reviews Management</h1>
                
                <%
                    List<Review> reviews = (List<Review>)request.getAttribute("reviews");
                    if(reviews != null && !reviews.isEmpty()) {
                        for(Review review : reviews) {
                %>
                <div class="review-card">
                    <div class="row">
                        <div class="col-md-8">
                            <h5><i class="fas fa-comment-alt me-2"></i>Review #<%= review.getReviewId() %></h5>
                            <p><strong>Customer:</strong> <%= review.getCustomer_name() %></p>
                            
                            <div class="rating">
                                <% for(int i = 1; i <= 5; i++) { %>
                                    <% if(i <= review.getRating()) { %>
                                        <i class="fas fa-star"></i>
                                    <% } else { %>
                                        <i class="far fa-star"></i>
                                    <% } %>
                                <% } %>
                                <span class="ms-2 d-none"><%= review.getRating() %>/5</span>
                            </div>
                            
                            <p><strong>Review:</strong> <%= review.getReviewText() %></p>
                            <p><strong>Date:</strong> <%= review.getReviewDate() %></p>
                        </div>
                        <div class="col-md-4 d-flex align-items-center justify-content-end">
                            <div class="btn-group">
                                <a href="motorDetail?id=<%= review.getMotorId() %>" class="btn btn-outline-gold">
                                    <i class="fas fa-eye me-1"></i> View Product
                                </a>
                                <a href="EditReviewServlet?reviewId=<%= review.getReviewId() %>" class="btn btn-outline-gold">
                                    <i class="fas fa-edit me-1"></i> Edit
                                </a>
                                <a href="DeleteReviewServlet?reviewId=<%= review.getReviewId() %>" 
                                   class="btn btn-outline-danger"
                                   onclick="return confirm('Are you sure you want to delete this review?');">
                                    <i class="fas fa-trash me-1"></i> Delete
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <%
                        }
                    } else {
                %>
                <p class="text-center">No reviews found. Be the first to share your experience!</p>
                <%
                    }
                %>
                
                <div class="text-center mt-4">
                    <a href="index.jsp" class="btn btn-outline-gold">
                        <i class="fas fa-home me-1"></i> Return to Home
                    </a>
                </div>
            </div>
        </div>
        
        <jsp:include page="footer.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>