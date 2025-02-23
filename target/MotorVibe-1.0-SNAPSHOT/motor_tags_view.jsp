<%-- 
    Document   : motor_tags_view
    Created on : Feb 23, 2025, 5:22:43 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div class="row row-cols-1 row-cols-md-3 row-cols-lg-4 g-4"> <%-- Bootstrap grid for responsive card layout --%>
    <c:forEach var="motor" items="${motors}"> <%-- Loop through the list of motors --%>
        <div class="col"> <%-- Each motor is in a column --%>
            <div class="card h-100"> <%-- Bootstrap card with fixed height --%>
                <img src="${motor.picture}" class="card-img-top" alt="${motor.motorName}"> <%-- Motorbike picture --%>
                <div class="card-body"> <%-- Card body for content --%>
                    <h5 class="card-title ${motor.present eq true ? 'text-success' : 'text-danger'}">${motor.motorName}</h5> <%-- Motor name as title, colored based on 'present' status --%>
                    <p class="card-text">
                        <strong>Brand:</strong> ${brandMap[motor.brandId]}<br> <%-- Brand name --%>
                        <strong>Model:</strong> ${modelMap[motor.modelId]}<br> <%-- Model name --%>
                        <strong>Fuel:</strong> ${fuelMap[motor.fuelId]}<br> <%-- Fuel type --%>
                        <strong>Color:</strong> ${motor.color}<br> <%-- Color --%>
                        <strong>Price:</strong> ${motor.price} $<%-- Price --%>
                    </p>
                    <a href="motorDetail?id=${motor.motorId}" class="btn btn-info">View Details</a> <%-- Button to view motor details --%>
                </div>
                <%-- Card footer removed - "Available from" date is no longer displayed in tag view --%>
            </div>
        </div>
    </c:forEach>
</div>