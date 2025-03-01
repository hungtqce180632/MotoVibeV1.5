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
        .wishlist-container {
            background: var(--dark-black);
            border: 1px solid var(--primary-gold);
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
        }
        .wishlist-table {
            width: 100%;
            border-collapse: collapse;
        }
        .wishlist-table th, 
        .wishlist-table td {
            border: 1px solid var(--secondary-gold);
            padding: 0.75rem;
            color: var(--text-gold);
        }
        .remove-btn {
            background: transparent;
            border: 1px solid var(--primary-gold);
            color: var(--primary-gold);
            padding: 0.25rem 0.5rem;
            transition: all 0.3s ease;
        }
        .remove-btn:hover {
            background: rgba(212, 175, 55, 0.1);
            color: var(--primary-gold);
        }
    </style>
</head>
<body>

    <!-- Success and Error Messages -->
    <div id="success-message" class="alert" style="display:none;">Added to Wishlist successfully!</div>
    <div id="error-message" class="alert" style="display:none;">Error adding to Wishlist. Please try again.</div>

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
                        <th>Brand</th>
                        <th>Model</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="motor" items="${wishlist}">
                        <tr>
                            <td>${motor.motorName}</td>
                            <td>${motor.brandName}</td>
                            <td>${motor.modelName}</td>
                            <td>$${motor.price}</td>
                            <td>${motor.description}</td>
                            <td>${motor.quantity}</td>
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
        </c:if>
    </div>


    <script>
        // Handle Add to Wishlist via AJAX
        $("#add-wishlist-form").submit(function(event) {
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
                data: { motorId: motorId, action: action },
                success: function(response) {
                    console.log(response);  // Log response for debugging
                    if (response === "success") {
                        $("#success-message").show().delay(3000).fadeOut();
                        location.reload(); // Reload page to reflect the change
                    } else {
                        $("#error-message").show().delay(3000).fadeOut();
                    }
                },
                error: function() {
                    $("#error-message").show().delay(3000).fadeOut();
                }
            });
        });

        // Handle Remove from Wishlist
        $(".wishlist-action-form").submit(function(event) {
            event.preventDefault(); // Prevent form submission

            var motorId = $(this).find("input[name='motorId']").val();
            var action = $(this).find("input[name='action']").val();

            $.ajax({
                url: "wishlist",
                type: "POST",
                data: { motorId: motorId, action: action },
                success: function(response) {
                    console.log(response); // Log response for debugging
                    if (response === "success") {
                        alert("Motor removed from wishlist!");
                        location.reload(); // Reload page to reflect the change
                    } else {
                        alert("Error removing motor from wishlist.");
                    }
                },
                error: function() {
                    alert("Error removing motor from wishlist.");
                }
            });
        });
    </script>
</body>
</html>
