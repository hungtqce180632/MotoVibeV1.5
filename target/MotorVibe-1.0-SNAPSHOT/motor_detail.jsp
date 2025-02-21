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
        </script>
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
                    </c:otherwise>
                </c:choose>
                <a href="motorManagement" class="btn btn-secondary">Back to list</a>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
