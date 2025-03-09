<%-- 
    Document   : edit_review
    Created on : Feb 27, 2025, 6:29:34 AM
    Author     : truon
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.Review" %>
<%
    Review rev = (Review) request.getAttribute("review");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit Review</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="css/luxury-theme.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        h3 {
            color: var(--primary-gold);
        }
        
        /* Star rating styles */
        .star-rating {
            display: inline-flex;
            flex-direction: row-reverse;
            font-size: 1.5rem;
            justify-content: space-around;
            padding: 0 0.2em;
            text-align: center;
            width: 5em;
        }

        .star-rating input {
            display: none;
        }

        .star-rating label {
            color: #ccc;
            cursor: pointer;
        }

        .star-rating :checked ~ label {
            color: var(--primary-gold);
        }

        .star-rating label:hover,
        .star-rating label:hover ~ label {
            color: var(--secondary-gold);
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <h3>Edit Review #<%= rev.getReviewId() %></h3>
    <form action="EditReviewServlet" method="post">
        <input type="hidden" name="reviewId" value="<%= rev.getReviewId() %>">
        <div class="mb-3">
            <label class="form-label">Rating</label>
            <div class="star-rating">
                <input type="radio" id="star5" name="rating" value="5" <%= (rev.getRating() == 5) ? "checked" : "" %> />
                <label for="star5" title="5 stars"><i class="fas fa-star"></i></label>
                
                <input type="radio" id="star4" name="rating" value="4" <%= (rev.getRating() == 4) ? "checked" : "" %> />
                <label for="star4" title="4 stars"><i class="fas fa-star"></i></label>
                
                <input type="radio" id="star3" name="rating" value="3" <%= (rev.getRating() == 3) ? "checked" : "" %> />
                <label for="star3" title="3 stars"><i class="fas fa-star"></i></label>
                
                <input type="radio" id="star2" name="rating" value="2" <%= (rev.getRating() == 2) ? "checked" : "" %> />
                <label for="star2" title="2 stars"><i class="fas fa-star"></i></label>
                
                <input type="radio" id="star1" name="rating" value="1" <%= (rev.getRating() == 1) ? "checked" : "" %> />
                <label for="star1" title="1 star"><i class="fas fa-star"></i></label>
            </div>
        </div>
        <div class="mb-3">
            <label class="form-label">Review Text</label>
            <textarea class="form-control" name="reviewText" rows="3"><%= rev.getReviewText() %></textarea>
        </div>
        <button type="submit" class="btn btn-primary">Save Changes</button>
    </form>
</div>
</body>
</html>
