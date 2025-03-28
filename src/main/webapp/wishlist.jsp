<%-- Document : wishlist
     Created on : Feb 23, 2025, 12:57:46 AM 
     Author : sanghtpce181720 --%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="models.Motor" %>
<%@ page import="dao.WishlistDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="jakarta.servlet.http.HttpServletRequest" %>
<%@ page import="jakarta.servlet.http.HttpServletResponse" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Your Wishlist</title>
        <link rel="stylesheet" href="css/luxury-theme.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            /* Container for main content */
            .container {
                width: 90%;
                max-width: 1200px;
                margin: 2rem auto;
            }
            /* Wishlist styles */
            .wishlist-container {
                background: var(--dark-black);
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 4px 8px rgba(0,0,0,0.3);
            }
            .wishlist-container p {
                color: var(--text-gold);
                font-size: 1.2rem;
            }
            .wishlist-table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 1rem;
            }
            .wishlist-table th,
            .wishlist-table td {
                border: 1px solid var(--secondary-gold);
                padding: 0.75rem;
                text-align: center;
                color: var(--text-gold);
            }
            .wishlist-table th {
                background: var(--primary-gold);
                color: var(--dark-black);
            }
            .remove-btn {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
                cursor: pointer;
                transition: all 0.3s ease;
                border-radius: 5px;
            }
            .remove-btn:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
            }
            /* Success/Error messages styling */
            .alert {
                width: 90%;
                max-width: 1200px;
                margin: 1rem auto;
                padding: 1rem;
                text-align: center;
                font-weight: bold;
                border-radius: 5px;
            }
            #success-message {
                background: #d4edda;
                border: 1px solid #c3e6cb;
                color: #155724;
            }
            #error-message {
                background: #f8d7da;
                border: 1px solid #f5c6cb;
                color: #721c24;
            }
            /* Back to List button styles */
            .back-btn-container {
                text-align: center;
                margin-top: 1.5rem;
            }
            .back-btn {
                background: var(--primary-gold);
                color: var(--dark-black);
                padding: 0.75rem 1.5rem;
                text-decoration: none;
                border-radius: 5px;
                font-weight: bold;
                transition: background 0.3s ease;
            }
            .back-btn:hover {
                background: #d4af37; /* Adjusted hover color */
            }
        </style>
    </head>
    <body>
        <!-- Header include -->
        <jsp:include page="header.jsp" />

        <!-- Main Container -->
        <div class="container">
            <!-- Success and Error Messages -->
            <div id="success-message" class="alert" style="display:none;">Added to Wishlist successfully!</div>
            <div id="error-message" class="alert" style="display:none;">Error adding to Wishlist.</div>

            <!-- Wishlist Table -->
            <div class="wishlist-container">
                <c:if test="${empty wishlist}">
                    <p>Your wishlist is empty. Start adding items!</p>
                </c:if>

                <c:if test="${not empty wishlist}">
                    <table class="wishlist-table">
                        <thead>
                            <tr>
                                <th>Motor Name</th>
                                <th>Price</th>
                                <th>Description</th>
                                <th>Order</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="motor" items="${wishlist}">
                                <tr>
                                    <td>${motor.motorName}</td>
                                    <td>${motor.price}</td>
                                    <td>${motor.description}</td>
                                    <td>
                                         <a href="orderMotor?id=${motor.motorId}" class="btn btn-success">
                                            <i class="fas fa-shopping-cart me-1"></i> Order
                                        </a>
                                    </td>
                                    <td>
                                        <form class="wishlist-action-form" data-motor-id="${motor.motorId}">
                                            <input type="hidden" name="motorId" value="${motor.motorId}" />
                                            <input type="hidden" name="action" value="remove" />
                                            <button type="submit" class="remove-btn">Remove</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                    <!-- Place the 'Back to List' button below the table -->
                    <div class="back-btn-container">
                        <a href="motorList" class="back-btn">
                            <i class="fas fa-arrow-left"></i> Back to List
                        </a>
                    </div>
                </c:if>
            </div>
        </div>


        <script>
            // Handle Add to Wishlist via AJAX
            $("#add-wishlist-form").submit(function (event) {
                event.preventDefault(); // Prevent form submission (no page reload)

                var motorId = $("#motorId").val();
                var action = $("input[name='action']").val();

                if (motorId == "") {
                    alert("Please enter a valid motorId.");
                    return;
                }

                $.ajax({
                    url: "wishlist",
                    type: "POST",
                    data: {motorId: motorId, action: action},
                    success: function (response) {
                        console.log(response);  // Log response for debugging
                        if (response === "success") {
                            $("#success-message").show().delay(3000).fadeOut();
                            location.reload(); // Reload page to reflect the change
                        } else {
                            $("#error-message").show().delay(3000).fadeOut();
                        }
                    },
                    error: function () {
                        $("#error-message").show().delay(3000).fadeOut();
                    }
                });
            });

            // Handle Remove from Wishlist
            $(".wishlist-action-form").submit(function (event) {
                event.preventDefault(); // Prevent form submission

                var motorId = $(this).find("input[name='motorId']").val();
                var action = $(this).find("input[name='action']").val();

                $.ajax({
                    url: "wishlist",
                    type: "POST",
                    data: {motorId: motorId, action: action},
                    success: function (response) {
                        console.log(response); // Log response for debugging
                        if (response === "success") {
                            alert("Motor removed from wishlist!");
                            location.reload(); // Reload page to reflect the change
                        } else {
                            alert("Error removing motor from wishlist.");
                        }
                    },
                    error: function () {
                        alert("Error removing motor from wishlist.");
                    }
                });
            });
        </script>
        <!-- Footer include -->
        <jsp:include page="footer.jsp" />
    </body>
</html>
