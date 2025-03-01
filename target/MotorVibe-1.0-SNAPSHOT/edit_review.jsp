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
    </style>
</head>
<body>
<div class="container mt-5">
    <h3>Edit Review #<%= rev.getReviewId() %></h3>
    <form action="EditReviewServlet" method="post">
        <input type="hidden" name="reviewId" value="<%= rev.getReviewId() %>">
        <div class="mb-3">
            <label class="form-label">Rating (1-5)</label>
            <input type="number" class="form-control" name="rating" value="<%= rev.getRating() %>" min="1" max="5">
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
