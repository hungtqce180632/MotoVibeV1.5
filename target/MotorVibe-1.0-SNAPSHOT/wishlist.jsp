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
    <link rel="stylesheet" href="styles.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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

    <!-- Add new motorbike to wishlist -->
    <div class="add-motor">
        <h2>Add a new motorbike to your wishlist</h2>
        <form id="add-wishlist-form">
            <label for="motorId">Motorbike ID:</label>
            <input type="number" name="motorId" id="motorId" required>
            <input type="hidden" name="action" value="add" />
            <button type="submit">Add to Wishlist</button>
        </form>
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
