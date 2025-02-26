<%-- 
    Document   : review
    Created on : Feb 26, 2025, 10:03:03 PM
    Author     : Jackt
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.List" %>
<%@ page import="models.Review" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Car Reviews</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .review-container {
                padding: 15px;
                border: 1px solid #ddd;
                border-radius: 8px;
                background: #f9f9f9;
                margin-top: 20px;
            }
            .review-list {
                list-style: none;
                padding: 0;
            }
            .review-item {
                padding: 10px;
                border-bottom: 1px solid #ddd;
            }
            .review-header {
                display: flex;
                justify-content: space-between;
                font-size: 14px;
                font-weight: bold;
            }
            .review-rating {
                color: gold;
            }
            .review-text {
                font-size: 14px;
                margin-top: 5px;
            }
            .text-warning {
                color: #f39c12;
            }
            .text-muted {
                color: #ccc;
            }
        </style>
    </head>
    <body>

        <%
            // Get the list of reviews from the request
            List<Review> reviews = (List<Review>) request.getAttribute("reviews");

            if (reviews == null || reviews.isEmpty()) {
        %>
        <div class="d-flex justify-content-center">
            <p>No reviews available for this motorbike.</p>
        </div>
        <% } else { %>
        <div class="review-container">
            <h3>Customer Reviews</h3>
            <ul class="review-list">
                <% for (Review review : reviews) { %>
                <li class="review-item">
                    <div class="review-header">
                        <strong><%= review.getCustomer_name() %></strong>
                        <span class="review-date"><%= review.getReviewDate() %></span>
                    </div>
                    <div class="review-rating">
                        <% for (int i = 1; i <= 5; i++) { %>
                        <i class="fa fa-star <%= i <= review.getRating() ? "text-warning" : "text-muted" %>"></i>
                        <% } %>
                    </div>
                    <p class="review-text"><%= review.getReviewText() %></p>
                </li>
                <% } %>
            </ul>
        </div>
        <% } %>

    </body>
</html>
