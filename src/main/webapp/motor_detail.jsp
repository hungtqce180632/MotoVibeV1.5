<%-- 
    Document   : motor_detail
    Created on : Feb 21, 2025, 3:17:46 PM
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>${motor.motorName} - MotoVibe</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style>
            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 1.5rem;
                position: relative;
            }
            
            h2::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            
            .detail-card {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                position: relative;
            }
            
            .detail-image-container {
                position: relative;
                overflow: hidden;
            }
            
            .detail-image {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s ease;
            }
            
            .detail-card:hover .detail-image {
                transform: scale(1.05);
            }
            
            .image-overlay {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: linear-gradient(0deg, var(--dark-black) 0%, transparent 50%);
            }
            
            .card-title {
                color: var(--primary-gold);
                font-size: 2rem;
                font-weight: 700;
                letter-spacing: 1px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
                margin-bottom: 1rem;
                border-bottom: 1px solid rgba(212, 175, 55, 0.3);
                padding-bottom: 0.75rem;
            }
            
            .card-body {
                padding: 2rem;
            }
            
            .description {
                color: var(--text-gold);
                font-style: italic;
                margin-bottom: 1.5rem;
                line-height: 1.6;
                padding: 1rem;
                background: rgba(0, 0, 0, 0.2);
                border-left: 3px solid var(--primary-gold);
                border-radius: 3px;
            }
            
            .detail-row {
                margin-bottom: 0.75rem;
                display: flex;
                align-items: center;
            }
            
            .detail-label {
                color: var(--primary-gold);
                font-weight: 600;
                letter-spacing: 1px;
                margin-right: 10px;
                width: 120px;
                flex-shrink: 0;
            }
            
            .detail-value {
                color: var(--text-gold);
                flex-grow: 1;
            }
            
            .brand-info {
                cursor: pointer;
                text-decoration: underline;
                color: var(--primary-gold);
                transition: all 0.3s ease;
            }
            
            .brand-info:hover {
                text-shadow: 0 0 10px rgba(212, 175, 55, 0.4);
            }
            
            .price-tag {
                font-size: 1.5rem;
                color: var(--primary-gold);
                font-weight: 700;
                margin-bottom: 1rem;
                background: rgba(0, 0, 0, 0.2);
                display: inline-block;
                padding: 0.5rem 1rem;
                border-radius: 5px;
                border: 1px solid var(--primary-gold);
            }
            
            .availability-badge {
                font-size: 0.9rem;
                padding: 0.5rem 1rem;
                border-radius: 5px;
                font-weight: 600;
                letter-spacing: 1px;
                display: inline-block;
                margin-bottom: 1.5rem;
            }
            
            .in-stock {
                background: rgba(40, 167, 69, 0.2);
                color: #6eff7a;
                border: 1px solid #28a745;
            }
            
            .out-of-stock {
                background: rgba(220, 53, 69, 0.2);
                color: #ff6e6e;
                border: 1px solid #dc3545;
            }
            
            .btn-container {
                margin-top: 2rem;
                padding-top: 1.5rem;
                border-top: 1px solid rgba(212, 175, 55, 0.3);
                display: flex;
                justify-content: center;
                gap: 1rem;
            }
            
            .btn {
                text-transform: uppercase;
                letter-spacing: 1px;
                padding: 0.75rem 1.5rem;
                transition: all 0.3s ease;
            }
            
            .btn:hover {
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            }
            
            .btn-primary {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
            }
            
            .btn-primary:hover {
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            .btn-success {
                background: linear-gradient(145deg, #28a745, #218838);
                border: none;
            }
            
            .btn-success:hover {
                box-shadow: 0 5px 15px rgba(40, 167, 69, 0.3);
            }
            
            .btn-secondary {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
            }
            
            .btn-secondary:hover {
                background: rgba(212, 175, 55, 0.1);
                color: var(--primary-gold);
            }
            
            #brandTooltip {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black)) !important;
                border: 1px solid var(--primary-gold) !important;
                color: var(--text-gold) !important;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                padding: 1rem;
                border-radius: 5px;
                z-index: 1000;
            }
            
            .container {
                padding-top: 80px;
                padding-bottom: 50px;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        
        <div class="container">
            <div id="brandTooltip" style="position: absolute; display: none;"></div>
            
            <h2 class="text-center"><i class="fas fa-motorcycle me-2"></i>Motorbike Details</h2>

            <div class="detail-card mx-auto" style="max-width: 900px;">
                <div class="row g-0 align-items-center">
                    <div class="col-md-5 detail-image-container">
                        <img src="images/${motor.picture}" class="detail-image" alt="${motor.motorName}">
                        <div class="image-overlay"></div>
                    </div>
                    
                    <div class="col-md-7">
                        <div class="card-body">
                            <h3 class="card-title">${motor.motorName}</h3>
                            <div class="description">${motor.description}</div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Brand:</span>
                                <span class="detail-value">
                                    <span class="brand-info" 
                                          onmouseover="showTooltip(event, '${brand.countryOfOrigin} <br> ${brand.description}')" 
                                          onmouseout="hideTooltip()">
                                        ${brand.brandName}
                                    </span>
                                </span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Model:</span>
                                <span class="detail-value">${model.modelName}</span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Fuel Type:</span>
                                <span class="detail-value">${fuel.fuelName}</span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Color:</span>
                                <span class="detail-value">${motor.color}</span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Price:</span>
                                <span class="detail-value">
                                    <span class="price-tag">$${motor.price}</span>
                                </span>
                            </div>
                            
                            <div class="detail-row">
                                <span class="detail-label">Availability:</span>
                                <span class="detail-value">
                                    <c:choose>
                                        <c:when test="${motor.quantity > 0}">
                                            <span class="availability-badge in-stock"><i class="fas fa-check-circle me-1"></i>In Stock</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="availability-badge out-of-stock"><i class="fas fa-times-circle me-1"></i>Out of Stock</span>
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>
                
                <div class="card-body">
                    <div class="btn-container">
                        <c:choose>
                            <c:when test="${sessionScope.user.role eq 'admin'}">
                                <a href="editMotor?id=${motor.motorId}" class="btn btn-primary">
                                    <i class="fas fa-edit me-1"></i> Edit Motor
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="orderMotor?id=${motor.motorId}" class="btn btn-success">
                                    <i class="fas fa-shopping-cart me-1"></i> Order Motor
                                </a>
                                <button class="btn btn-primary" onclick="addToWishlist(event, ${motor.motorId})">
                                    <i class="fas fa-heart me-1"></i> Add to Wishlist
                                </button>
                            </c:otherwise>
                        </c:choose>
                        <a href="motorList" class="btn btn-secondary">
                            <i class="fas fa-arrow-left me-1"></i> Back to List
                        </a>
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="review.jsp"/>
        
        <script>
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
                event.preventDefault(); // Stop page navigation

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
                            Swal.fire({
                                icon: 'success',
                                title: 'Added to Wishlist',
                                text: 'This motorbike has been added to your wishlist!',
                                confirmButtonColor: '#D4AF37',
                                background: '#1A1A1A',
                                color: '#F5E6CC'
                            }).then(() => {
                                location.reload(); // Reload page to update UI
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Error',
                                text: 'Error adding motor to wishlist: ' + response,
                                confirmButtonColor: '#D4AF37',
                                background: '#1A1A1A',
                                color: '#F5E6CC'
                            });
                        }
                    },
                    error: function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'Error adding motor to wishlist. Please try again.',
                            confirmButtonColor: '#D4AF37',
                            background: '#1A1A1A',
                            color: '#F5E6CC'
                        });
                    }
                });
            }
        </script>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    </body>
</html>

