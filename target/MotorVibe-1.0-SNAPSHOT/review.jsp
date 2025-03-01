<%-- 
    Document   : review
    Created on : Feb 26, 2025, 10:03:03 PM
    Author     : Jackt
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="models.Review" %>
<%@ page import="models.UserAccount" %>
<%
    // We assume 'reviews' is a List<Review> from request scope
    // Also 'motor' is the Motor object from request scope
    // 'canReview' is a Boolean (true if the user purchased the motor)
    // We also can check user role from session
    UserAccount user = (UserAccount) session.getAttribute("user");
    String role = (user != null) ? user.getRole() : "";
    Boolean canReview = (Boolean) request.getAttribute("canReview");
    if (canReview == null) canReview = false;
%>

<link rel="stylesheet" href="css/luxury-theme.css">
<style>
    :root {
        --primary-gold: #D4AF37;
        --secondary-gold: #C5A028;
        --dark-black: #111111;
        --rich-black: #1A1A1A;
        --text-gold: #F5E6CC;
    }

    .reviews-section {
        background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        border: 1px solid var(--primary-gold);
    }

    .reviews-section h4 {
        color: var(--primary-gold);
        font-size: 2rem;
        margin-bottom: 1.5rem;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
        position: relative;
        padding-bottom: 0.5rem;
    }

    .reviews-section h4::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 60px;
        height: 2px;
        background: var(--primary-gold);
        box-shadow: 0 0 10px var(--primary-gold);
    }

    .reviews-section h4::before {
        content: '';
        position: absolute;
        top: -10px;
        left: 0;
        width: 100%;
        height: 1px;
        background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
    }

    .table {
        color: var(--text-gold);
        background: transparent;
        border-color: var(--primary-gold);
    }

    .table thead th {
        background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
        color: var(--dark-black);
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
        border: none;
        padding: 1rem;
    }

    .table tbody td {
        border-color: rgba(212, 175, 55, 0.2);
        padding: 1rem;
    }

    .table tbody tr {
        transition: all 0.3s ease;
    }

    .table tbody tr:hover {
        background: rgba(212, 175, 55, 0.1);
        transform: translateX(5px);
    }

    .btn-warning, .btn-danger, .btn-primary {
        text-transform: uppercase;
        letter-spacing: 1px;
        font-weight: 600;
    }

    .btn-warning, .btn-danger {
        background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
        border: none;
        color: var(--dark-black);
        padding: 0.5rem 1rem;
        margin: 0.2rem;
        transition: all 0.3s ease;
    }

    .btn-warning:hover, .btn-danger:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
    }

    .write-review-section {
        background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
        padding: 2rem;
        border-radius: 15px;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        border: 1px solid var(--primary-gold);
        margin-top: 2rem;
    }

    .write-review-section h5 {
        color: var(--primary-gold);
        font-size: 1.5rem;
        margin-bottom: 1.5rem;
        text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
    }

    .form-control {
        background: rgba(26, 26, 26, 0.9);
        border: 1px solid var(--primary-gold);
        color: var(--text-gold);
        transition: all 0.3s ease;
    }

    .form-control:focus {
        background: rgba(26, 26, 26, 0.95);
        border-color: var(--secondary-gold);
        box-shadow: 0 0 10px rgba(212, 175, 55, 0.2);
        color: var(--text-gold);
    }

    .form-label {
        color: var (--text-gold);
    }

    .btn-primary {
        background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
        border: none;
        color: var(--dark-black);
        padding: 0.7rem 2rem;
        transition: all 0.3s ease;
    }

    .btn-primary:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
    }

    .text-muted {
        color: var(--text-gold) !important;
        opacity: 0.7;
    }

    .review-container {
        background: var(--dark-black);
        border: 1px solid var(--primary-gold);
        border-radius: 10px;
        padding: 2rem;
        max-width: 700px;
        margin: 2rem auto;
    }

    .review-container h2 {
        color: var(--primary-gold);
    }
</style>

<div class="container mt-4">
    <div class="reviews-section">
        <h4>Reviews</h4>
        <c:if test="${reviews != null && reviews.size() > 0}">
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Customer ID</th>
                        <th>Rating</th>
                        <th>Review</th>
                        <th>Date</th>
                        <c:if test="${role eq 'employee'}">
                            <th>Actions</th>
                        </c:if>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="rev" items="${reviews}">
                        <tr>
                            <td>${rev.customerId}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${rev.rating > 0}">${rev.rating}</c:when>
                                    <c:otherwise>(none)</c:otherwise>
                                </c:choose>
                            </td>
                            <td>${rev.reviewText}</td>
                            <td>${rev.reviewDate}</td>
                            <c:if test="${role eq 'employee'}">
                                <td>
                                    <!-- Edit link -> goes to EditReviewServlet?reviewId= -->
                                    <a href="EditReviewServlet?reviewId=${rev.reviewId}" class="btn btn-sm btn-warning">Edit</a>
                                    <!-- Delete link -> goes to DeleteReviewServlet?reviewId= -->
                                    <a href="DeleteReviewServlet?reviewId=${rev.reviewId}" class="btn btn-sm btn-danger">Delete</a>
                                </td>
                            </c:if>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>
        <c:if test="${reviews == null || reviews.size() == 0}">
            <p class="text-muted">No reviews yet.</p>
        </c:if>
    </div>

    <!-- If the user can review, show a 'create review' form -->
    <c:if test="${canReview}">
        <div class="write-review-section">
            <h5>Write a Review</h5>
            <form action="CreateReviewServlet" method="post">
                <!-- We need motorId to link the review to the motor -->
                <input type="hidden" name="motorId" value="${motor.motorId}" />
                <div class="mb-3">
                    <label class="form-label">Rating (1-5, optional)</label>
                    <input type="number" class="form-control" name="rating" min="1" max="5" />
                </div>
                <div class="mb-3">
                    <label class="form-label">Review Text</label>
                    <textarea class="form-control" name="reviewText" rows="3" required></textarea>
                </div>
                <button type="submit" class="btn btn-primary">Submit Review</button>
            </form>
        </div>
    </c:if>
</div>
