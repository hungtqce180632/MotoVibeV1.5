<%-- 
    Document   : index
    Created on : Feb 23, 2025, 4:09:08 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Welcome to MotoVibe</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .motorbike-card {
            transition: transform .2s; /* Animation */
        }

        .motorbike-card:hover {
            transform: scale(1.05); /* (105% zoom - scale up) */
        }
    </style>
</head>
<body>

    <jsp:include page="header.jsp"></jsp:include>

    <div class="container mt-5">
        <div class="p-5 mb-4 bg-light rounded-3">
            <div class="container-fluid py-5">
                <h1 class="display-5 fw-bold">Welcome to MotoVibe!</h1>
                <p class="col-md-8 fs-4">Your ultimate destination for everything motorbike related. Explore our wide selection of motorbikes, services, and more.</p>
                <a class="btn btn-primary btn-lg" href="motorList" type="button">Browse Motorbikes</a>
            </div>
        </div>

        <h2 class="text-center mb-4">Featured Motorbikes</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
            <c:forEach var="i" begin="1" end="6"> <%-- Example: Display 6 featured motorbikes (can be dynamic later) --%>
                <div class="col">
                    <div class="card h-100 motorbike-card">
                        <img src="images/motor_pictures/featured_motorbike_${i}.jpg" class="card-img-top" alt="Featured Motorbike ${i}" onerror="this.src='images/placeholder.png'"> <%-- Placeholder if image not found --%>
                        <div class="card-body">
                            <h5 class="card-title">Motorbike Model ${i}</h5> <%-- Replace with actual motorbike name --%>
                            <p class="card-text">Short description of Motorbike Model ${i}.</p> <%-- Replace with actual description --%>
                            <a href="motorList" class="btn btn-outline-primary btn-sm">View Details</a>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>

        <hr class="mb-5">

        <div class="row justify-content-center mb-5">
            <div class="col-md-8 text-center">
                <h2>Get Started Today!</h2>
                <p>Whether you are a seasoned rider or just starting, MotoVibe has something for you.
                <c:if test="${empty sessionScope.user}"> <a href="login.jsp">Login</a> or <a href="register.jsp">Register</a> to unlock more features!</c:if></p>
                <c:if test="${not empty sessionScope.user}">
                     <p>Welcome back, <c:out value="${sessionScope.user.email}"/>! Explore our site or visit your <a href="dashboard">Dashboard</a>.</p>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
