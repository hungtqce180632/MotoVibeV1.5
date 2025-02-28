<%-- 
    Document   : motor_detail
    Created on : Feb 21, 2025, 3:17:46 PM
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Motorbike Details</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const tooltip = document.createElement("div");
                tooltip.id = "brandTooltip";
                tooltip.style.position = "absolute";
                tooltip.style.display = "none";
                tooltip.style.backgroundColor = "rgba(0, 0, 0, 0.75)";
                tooltip.style.color = "white";
                tooltip.style.padding = "5px";
                tooltip.style.borderRadius = "5px";
                tooltip.style.fontSize = "14px";
                document.body.appendChild(tooltip);
            });

            function showTooltip(event, text) {
                let tooltip = document.getElementById("brandTooltip");
                tooltip.innerHTML = text;
                tooltip.style.display = "block";
                tooltip.style.left = event.pageX + 10 + "px";
                tooltip.style.top = event.pageY + 10 + "px";
            }

            function hideTooltip() {
                let tooltip = document.getElementById("brandTooltip");
                tooltip.style.display = "none";
            }

            function addToWishlist(event, motorId) {
                event.preventDefault(); // Ngừng chuyển trang

                // Kiểm tra nếu motorId không hợp lệ (chắc chắn nó phải là một số hợp lệ)
                if (isNaN(motorId) || motorId === "") {
                    alert("Invalid motorId.");
                    return;
                }

                $.ajax({
                    url: "wishlist",
                    type: "POST",
                    data: {motorId: motorId, action: 'add'},
                    success: function (response) {
                        if (response === "success") {
                            $("#success-message").show().delay(3000).fadeOut();
                            location.reload(); // Reload trang để cập nhật danh sách
                        } else {
                            $("#error-message").show().delay(3000).fadeOut();
                            alert('Error adding motor to wishlist: ' + response);
                        }
                    },
                    error: function () {
                        $("#error-message").show().delay(3000).fadeOut();
                        alert('Error adding motor to wishlist.');
                    }
                });
            }




        </script>
        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }

            body {
                background: var(--dark-black);
                color: var(--text-gold);
            }

            .container {
                padding-top: 80px;
            }

            .card {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            .card-title {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            }

            .card-body {
                color: var(--text-gold);
            }

            strong {
                color: var(--primary-gold);
            }

            .btn {
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                margin: 0 5px;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }

            #brandTooltip {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black)) !important;
                border: 1px solid var(--primary-gold) !important;
                color: var(--text-gold) !important;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            }
        </style>
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Motorbike Details</h2>

            <div class="card mx-auto" style="max-width: 900px;">
                <div class="row g-0 align-items-center">
                    <div class="col-md-5">
                        <img src="images/${motor.picture}" class="img-fluid rounded-start" alt="${motor.motorName}">
                    </div>
                    <div class="col-md-7">
                        <div class="card-body">
                            <h3 class="card-title">${motor.motorName}</h3>
                            <p class="text-muted fst-italic">${motor.description}</p>
                            <p><strong>Brand:</strong> 
                                <span onmouseover="showTooltip(event, '${brand.countryOfOrigin} <br> ${brand.description}')" 
                                      onmouseout="hideTooltip()" style="cursor: pointer; text-decoration: underline;">${brand.brandName}</span>
                            </p>
                            <p><strong>Model:</strong> ${model.modelName}</p>
                            <p><strong>Fuel Type:</strong> ${fuel.fuelName}</p>
                            <p><strong>Color:</strong> ${motor.color}</p>
                            <p><strong>Price:</strong> $${motor.price}</p>
                            <p><strong>Availability:</strong> 
                                <c:choose>
                                    <c:when test="${motor.quantity > 0}">
                                        <span class="text-success fw-bold">In Stock</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger fw-bold">Out of Stock</span>
                                    </c:otherwise>
                                </c:choose>
                            </p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="mt-4 text-center">
                <c:choose>
                    <c:when test="${sessionScope.user.role eq 'admin'}">
                        <a href="editMotor?id=${motor.motorId}" class="btn btn-primary">Edit Motor</a>
                    </c:when>
                    <c:otherwise>
                        <a href="orderMotor?id=${motor.motorId}" class="btn btn-success">Order Motor</a>
                        <button class="btn btn-success" onclick="addToWishlist(event, ${motor.motorId})">Add to Wishlist</button>
                    </c:otherwise>
                </c:choose>
                <a href="motorManagement" class="btn btn-secondary">Back to list</a>
            </div>
        </div>

        <jsp:include page="review.jsp"/>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

