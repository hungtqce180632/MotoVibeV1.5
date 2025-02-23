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
    <title>Welcome to MotoVibe - Experience the Ride</title> <!- More evocative title -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/style.css"> <!- Assuming you have a style.css for custom styles -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="..." crossorigin="anonymous" referrerpolicy="no-referrer" />
    <style>
        /* Custom styles for index page */
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; /* Modern font */
            color: #333;
        }
        .hero-section {
            background: #f8f9fa; /* Light grey background for hero */
            padding: 80px 0;
            text-align: center;
        }
        .hero-title {
            font-size: 2.5rem;
            font-weight: bold;
            color: #222; /* Darker title */
            margin-bottom: 20px;
        }
        .hero-subtitle {
            font-size: 1.1rem;
            color: #555; /* Slightly muted subtitle */
            margin-bottom: 30px;
        }
        .featured-motorbikes {
            padding: 50px 0;
            background-color: #fff; /* White background for featured section */
        }
        .motorbike-card {
            border: none; /* Remove default card border */
            box-shadow: 0 4px 8px rgba(0,0,0,0.05); /* Soft shadow for cards */
            transition: transform 0.3s ease;
        }
        .motorbike-card:hover {
            transform: scale(1.03); /* Slight scale up on hover */
            box-shadow: 0 8px 16px rgba(0,0,0,0.1); /* More pronounced shadow on hover */
        }
        .card-img-top {
            border-radius: 0.5rem 0.5rem 0 0; /* Rounded top corners for images */
            max-height: 200px; /* Limit image height for consistency */
            object-fit: cover; /* Cover container, crop if necessary */
        }
        .card-title {
            font-size: 1.25rem;
            font-weight: 600;
            color: #343a40; /* Dark card title */
        }
        .card-text {
            color: #6c757d; /* Muted card text */
        }
        .btn-primary-moto { /* Custom primary button style */
            background-color: #007bff;
            border-color: #007bff;
            color: white;
        }
        .btn-primary-moto:hover {
            background-color: #0056b3;
            border-color: #0056b3;
        }

    </style>
</head>
<body>

    <jsp:include page="header.jsp"></jsp:include>

    <div class="hero-section">
        <div class="container">
            <h1 class="hero-title">Welcome to MotoVibe!</h1>
            <p class="hero-subtitle">Your premier online destination for motorbikes, services, and events.</p>
            <a class="btn btn-primary btn-lg btn-primary-moto" href="motorList" type="button"><i class="fas fa-motorcycle me-2"></i> Explore Motorbikes</a>
        </div>
    </div>

    <div class="container featured-motorbikes">
        <h2 class="text-center mb-5">Featured Motorbikes</h2>
        <div class="row row-cols-1 row-cols-md-3 g-4 mb-5">
            <c:forEach var="i" begin="1" end="6"> <%-- Example: Display 6 featured motorbikes (can be dynamic later) --%>
                <div class="col">
                    <div class="card h-100 motorbike-card">
                        <img src="images/motor_pictures/featured_motorbike_${i}.jpg" class="card-img-top" alt="Featured Motorbike ${i}" onerror="this.onerror=null;this.src='images/placeholder.png';" > <!- Placeholder image on error -->
                        <div class="card-body">
                            <h5 class="card-title">Motorbike Model ${i}</h5> <!- Replace with actual motorbike name -->
                            <p class="card-text">Discover the thrill of riding with this amazing model. Perfect for city and adventure.</p> <!- Replace with actual description -->
                            <a href="motorDetail?id=1" class="btn btn-outline-primary btn-sm">View Details</a> <!- Example link, replace with dynamic links -->
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <div class="container mt-5 mb-5">
        <div class="row justify-content-center">
            <div class="col-md-8 text-center">
                <h2>Ready to Ride?</h2>
                <p class="lead">Find your dream motorbike today and experience the freedom of the open road with MotoVibe.</p>
                <c:if test="${empty sessionScope.user}">
                    <p> <a href="login.jsp">Login</a> or <a href="register.jsp">Register</a> to get started!</p>
                </c:if>
                <c:if test="${not empty sessionScope.user}">
                    <p>Welcome back, <c:out value="${sessionScope.user.email}"/>! <a href="listAppointments">View Appointments</a> or <a href="motorList">Browse Motorbikes</a>.</p>
                </c:if>
            </div>
        </div>
    </div>

    <jsp:include page="footer.jsp"></jsp:include>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
