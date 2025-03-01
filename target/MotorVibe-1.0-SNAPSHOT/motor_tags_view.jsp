<%-- 
    Document   : motor_tags_view
    Created on : Feb 23, 2025, 5:22:43 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
    .motor-card {
        background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
        border: 1px solid var(--secondary-gold);
        border-radius: 10px;
        overflow: hidden;
        transition: all 0.4s ease;
        box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
        height: 100%;
        display: flex;
        flex-direction: column;
        position: relative;
    }
    
    .motor-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 15px 35px rgba(212, 175, 55, 0.3);
        border-color: var(--primary-gold);
    }
    
    .product-img {
        position: relative;
        height: 200px;
        overflow: hidden;
        border-bottom: 1px solid var(--secondary-gold);
    }
    
    .product-img img {
        width: 100%;
        height: 100%;
        object-fit: cover;
        transition: all 0.5s ease;
    }
    
    .motor-card:hover .product-img img {
        transform: scale(1.1);
        filter: brightness(1.1);
    }
    
    .product-img::after {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(0deg, rgba(17, 17, 17, 0.8) 0%, rgba(26, 26, 26, 0) 50%);
    }
    
    .motor-card .card-body {
        padding: 1.25rem;
        color: var(--text-gold);
        background: transparent;
        flex-grow: 1;
        display: flex;
        flex-direction: column;
    }
    
    .motor-card .card-title {
        color: var(--primary-gold);
        font-size: 1.5rem;
        font-weight: 600;
        margin-bottom: 1rem;
        padding-bottom: 0.75rem;
        border-bottom: 1px solid rgba(212, 175, 55, 0.2);
        text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
    }
    
    .motor-card .card-text {
        margin-bottom: 1.5rem;
        flex-grow: 1;
        line-height: 1.6;
    }
    
    .motor-card .card-text strong {
        color: var(--primary-gold);
        font-weight: 600;
        margin-right: 5px;
    }
    
    .motor-card .btn-info {
        background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
        border: none;
        color: var(--dark-black);
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
        padding: 0.75rem 1.25rem;
        transition: all 0.3s ease;
        margin-top: auto;
        width: 100%;
        position: relative;
        z-index: 2; /* Ensure button is above other elements */
    }
    
    .motor-card .btn-info:hover {
        transform: translateY(-2px);
        box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
    }
    
    .price-tag {
        position: absolute;
        top: 10px;
        right: 10px;
        background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
        color: var(--dark-black);
        padding: 0.5rem 1rem;
        border-radius: 20px;
        font-weight: 700;
        font-size: 1rem;
        z-index: 2;
        box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
    }
    
    .badge-status {
        position: absolute;
        top: 10px;
        left: 10px;
        font-size: 0.8rem;
        padding: 0.5rem 0.75rem;
        border-radius: 20px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 1px;
        z-index: 2;
    }
    
    .badge-available {
        background: rgba(40, 167, 69, 0.8);
        color: white;
    }
    
    .badge-unavailable {
        background: rgba(220, 53, 69, 0.8);
        color: white;
    }
    
    /* Add beautiful hover effects */
    .motor-card::before {
        content: '';
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: linear-gradient(45deg, transparent, rgba(212, 175, 55, 0.1), transparent);
        background-size: 200% 200%;
        z-index: 1;
        opacity: 0;
        transition: all 0.6s ease;
        pointer-events: none; /* Add this line to make the overlay non-blocking */
    }
    
    .motor-card:hover::before {
        opacity: 1;
        animation: shimmer 1.5s infinite;
    }
    
    @keyframes shimmer {
        0% { background-position: -200% 0; }
        100% { background-position: 200% 0; }
    }
    
    .card-text .detail-row {
        margin-bottom: 0.25rem;
    }
    
    .no-results {
        background: linear-gradient(145deg, var(--rich-black), var(--dark-black));
        border: 1px dashed var(--secondary-gold);
        border-radius: 10px;
        padding: 3rem;
        text-align: center;
        color: var(--text-gold);
        width: 100%;
        margin: 2rem 0;
    }
    
    .no-results i {
        font-size: 3rem;
        color: var(--primary-gold);
        opacity: 0.7;
        margin-bottom: 1rem;
    }
</style>

<div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4">
    <c:choose>
        <c:when test="${empty motors}">
            <div class="no-results col-12">
                <i class="fas fa-search"></i>
                <h4>No motorcycles found</h4>
                <p>Please try different search criteria or check back later.</p>
            </div>
        </c:when>
        <c:otherwise>
            <c:forEach var="motor" items="${motors}">
                <div class="col">
                    <div class="motor-card">
                        <div class="price-tag">$${motor.price}</div>
                        <c:choose>
                            <c:when test="${motor.present eq true}">
                                <div class="badge-status badge-available">
                                    <i class="fas fa-check-circle me-1"></i>Available
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="badge-status badge-unavailable">
                                    <i class="fas fa-times-circle me-1"></i>Unavailable
                                </div>
                            </c:otherwise>
                        </c:choose>
                        <div class="product-img">
                            <img src="images/${motor.picture}" alt="${motor.motorName}" onerror="this.src='images/default-motorcycle.jpg'">
                        </div>
                        <div class="card-body">
                            <h5 class="card-title">${motor.motorName}</h5>
                            <div class="card-text">
                                <div class="detail-row">
                                    <strong><i class="fas fa-industry me-1"></i>Brand:</strong> ${brandMap[motor.brandId]}
                                </div>
                                <div class="detail-row">
                                    <strong><i class="fas fa-tag me-1"></i>Model:</strong> ${modelMap[motor.modelId]}
                                </div>
                                <div class="detail-row">
                                    <strong><i class="fas fa-gas-pump me-1"></i>Fuel:</strong> ${fuelMap[motor.fuelId]}
                                </div>
                                <div class="detail-row">
                                    <strong><i class="fas fa-palette me-1"></i>Color:</strong> ${motor.color}
                                </div>
                            </div>
                            <a href="motorDetail?id=${motor.motorId}" class="btn btn-info">
                                <i class="fas fa-eye me-1"></i> View Details
                            </a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </c:otherwise>
    </c:choose>
</div>