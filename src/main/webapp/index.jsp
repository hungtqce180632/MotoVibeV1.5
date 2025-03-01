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
        <title>Welcome to MotoVibe - Experience the Ride</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: var(--text-gold);
                background: var(--dark-black);
            }

            /* Hero Section Enhancement */
            .hero-section {
                background: linear-gradient(135deg, var(--dark-black), var(--rich-black));
                position: relative;
                overflow: hidden;
                padding: 180px 0 120px;
                border-bottom: 1px solid var(--primary-gold);
            }

            .hero-section::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                bottom: 0;
                background:
                    linear-gradient(45deg, transparent 45%, var(--primary-gold) 45%, var(--primary-gold) 55%, transparent 55%),
                    radial-gradient(circle at 50% 50%, var(--primary-gold) 0%, transparent 20%);
                opacity: 0.05;
                animation: shine 8s infinite linear;
            }

            .hero-title {
                color: var(--primary-gold);
                font-size: 4rem;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5),
                    0 0 20px rgba(212, 175, 55, 0.3);
                margin-bottom: 1.5rem;
                animation: fadeInUp 1.2s ease-out;
            }

            .hero-subtitle {
                color: var(--text-gold);
                font-size: 1.4rem;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
                margin-bottom: 2rem;
                animation: fadeInUp 1.2s ease-out 0.3s;
                animation-fill-mode: both;
            }

            .hero-section .btn {
                animation: fadeInUp 1.2s ease-out 0.6s;
                animation-fill-mode: both;
            }

            /* Featured Motorbikes Section */
            .featured-motorbikes {
                padding: 80px 0;
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                position: relative;
            }

            .featured-motorbikes h2 {
                color: var(--primary-gold);
                font-size: 2.5rem;
                font-weight: 700;
                text-transform: uppercase;
                margin-bottom: 3rem;
                text-align: center;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                position: relative;
            }

            .featured-motorbikes h2::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 3px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .motorbike-card {
                background: linear-gradient(145deg, #1a1a1a, #222);
                border: 1px solid var(--primary-gold);
                border-radius: 15px;
                overflow: hidden;
                transition: all 0.4s ease;
                box-shadow: 0 10px 20px rgba(0,0,0,0.3),
                    inset 0 0 10px rgba(212, 175, 55, 0.1);
                transform-style: preserve-3d;
                perspective: 1000px;
            }

            .motorbike-card:hover {
                transform: translateY(-10px) rotateX(5deg);
                box-shadow: 0 20px 40px rgba(212, 175, 55, 0.2),
                    inset 0 0 20px rgba(212, 175, 55, 0.2);
            }

            .card-img-top {
                height: 250px;
                object-fit: cover;
                border-bottom: 2px solid var(--primary-gold);
                transition: all 0.4s ease;
            }

            .motorbike-card:hover .card-img-top {
                transform: scale(1.05);
            }

            .card-body {
                padding: 1.5rem;
                background: linear-gradient(145deg, #1a1a1a, #222);
            }

            .card-title {
                color: var(--primary-gold);
                font-size: 1.4rem;
                font-weight: 600;
                margin-bottom: 1rem;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
            }

            .card-text {
                color: var(--text-gold);
                font-size: 1rem;
                margin-bottom: 1.5rem;
            }

            .btn-outline-primary {
                color: var(--primary-gold);
                border: 2px solid var(--primary-gold);
                background: transparent;
                padding: 0.5rem 1.5rem;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
                font-weight: 600;
                position: relative;
                overflow: hidden;
            }

            .btn-outline-primary:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
                box-shadow: 0 0 20px rgba(212, 175, 55, 0.4);
                transform: translateY(-2px);
            }

            /* Ready to Ride Section */
            .ready-to-ride {
                background: linear-gradient(145deg, var(--dark-black), var (--rich-black));
                padding: 80px 0;
                text-align: center;
                border-top: 1px solid var(--primary-gold);
                position: relative;
            }

            .ready-to-ride h2 {
                color: var(--primary-gold);
                font-size: 2.5rem;
                margin-bottom: 1.5rem;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            }

            .ready-to-ride .lead {
                color: var(--text-gold);
                font-size: 1.2rem;
                margin-bottom: 2rem;
            }

            .ready-to-ride a {
                color: var(--primary-gold);
                text-decoration: none;
                transition: all 0.3s ease;
                position: relative;
            }

            .ready-to-ride a:hover {
                color: var(--secondary-gold);
                text-shadow: 0 0 10px rgba(212, 175, 55, 0.4);
            }

            /* Chat Widget Enhancement */
            #chat-button {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                padding: 12px 20px;
                border-radius: 10px;
                color: var(--dark-black);
                font-weight: 600;
                box-shadow: 0 4px 15px rgba(212, 175, 55, 0.3);
                transition: all 0.3s ease;
            }

            #chat-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 6px 20px rgba(212, 175, 55, 0.4);
            }

            #chat-popup {
                background: linear-gradient(145deg, #1a1a1a, #222);
                border: 1px solid var(--primary-gold);
                border-radius: 15px;
                box-shadow: 0 10px 30px rgba(0,0,0,0.5);
            }

            #chat-header {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border-radius: 14px 14px 0 0;
            }

            /* Chat Widget Styles - ADDED CSS FROM CHAT WIDGET */
            #chat-widget-container {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 1000;
            }

            #chat-button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 5px;
                cursor: pointer;
            }

            #chat-popup {
                display: none; /* Hidden by default */
                position: absolute;
                bottom: 50px;
                right: 0;
                border: 1px solid #ccc;
                border-radius: 5px;
                width: 450px;
                height: 550px;
                background-color: white;
                flex-direction: column; /* Enable flexbox layout */
                display: flex; /* Enable flexbox layout */
            }

            #chat-header {
                background-color: #007bff;
                color: white;
                padding: 10px;
                border-top-left-radius: 5px;
                border-top-right-radius: 5px;
                display: flex; /* Use flexbox for header */
                justify-content: space-between; /* Space out title and close button */
                align-items: center; /* Align items vertically in the center */
            }

            #chat-title {
                margin: 0; /* Reset default margin */
            }

            #chat-close-button {
                background: none;
                border: none;
                color: white;
                font-size: 1.2em;
                cursor: pointer;
            }

            #chat-body {
                padding: 10px;
                overflow-y: auto; /* Enable vertical scroll if needed */
                max-height: 400px; /* Limit chat body height */
                flex-grow: 1; /* Allow body to grow and take available space */
            }

            #chat-input-area {
                padding: 10px;
                border-top: 1px solid #ccc;
                display: flex; /* Use flexbox for input area */
            }

            #chat-input {
                flex-grow: 1; /* Input takes up most space */
                padding: 8px;
                border: 1px solid #ccc;
                border-radius: 3px;
                margin-right: 5px;
            }

            #chat-send-button {
                background-color: #007bff;
                color: white;
                border: none;
                padding: 8px 12px;
                border-radius: 3px;
                cursor: pointer;
            }

            .message {
                padding: 8px;
                border-radius: 5px;
                margin-bottom: 5px;
                word-wrap: break-word;
            }

            .user-message {
                background-color: #e2f0ff;
                text-align: right;
            }

            .ai-message {
                background-color: #f0f0f0;
                text-align: left;
            }

            #appointment-button-container {
                display: none; /* Hidden initially */
                padding: 10px;
                text-align: center;
            }

            #create-appointment-button {
                background-color: #28a745; /* Green color */
                color: white;
                border: none;
                padding: 10px 15px;
                border-radius: 5px;
                cursor: pointer;
            }

            /* Enhanced animations for hero section */
            @keyframes shine {
                0% {
                    background-position: -300px -300px;
                }
                100% {
                    background-position: 300px 300px;
                }
            }

            @keyframes fadeInUp {
                from {
                    opacity: 0;
                    transform: translateY(30px);
                }
                to {
                    opacity: 1;
                    transform: translateY(0);
                }
            }

            /* Gold particle animations */
            .gold-particles {
                position: absolute;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                overflow: hidden;
                z-index: 1;
            }

            .particle {
                position: absolute;
                background: var(--primary-gold);
                border-radius: 50%;
                opacity: 0.2;
                animation: float 15s infinite linear;
            }

            @keyframes float {
                0% {
                    transform: translateY(0) rotate(0deg);
                    opacity: 0;
                }
                50% {
                    opacity: 0.3;
                }
                100% {
                    transform: translateY(-100vh) rotate(360deg);
                    opacity: 0;
                }
            }

            /* Testimonials section */
            .testimonials {
                padding: 80px 0;
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                position: relative;
                border-bottom: 1px solid var(--primary-gold);
            }

            .testimonials h2 {
                color: var(--primary-gold);
                font-size: 2.5rem;
                font-weight: 700;
                text-transform: uppercase;
                margin-bottom: 3rem;
                text-align: center;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                position: relative;
            }

            .testimonials h2::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 3px;
                background: var (--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .testimonial-card {
                background: linear-gradient(145deg, #1a1a1a, #222);
                border: 1px solid var(--primary-gold);
                border-radius: 15px;
                padding: 2rem;
                margin-bottom: 2rem;
                position: relative;
                overflow: hidden;
            }

            .testimonial-card::before {
                content: '\201C';
                position: absolute;
                top: 10px;
                left: 10px;
                font-size: 5rem;
                color: var(--primary-gold);
                opacity: 0.2;
                font-family: serif;
            }

            .testimonial-text {
                color: var(--text-gold);
                font-style: italic;
                margin-bottom: 1.5rem;
                position: relative;
                z-index: 2;
            }

            .testimonial-author {
                display: flex;
                align-items: center;
            }

            .testimonial-avatar {
                width: 50px;
                height: 50px;
                border-radius: 50%;
                border: 2px solid var(--primary-gold);
                margin-right: 1rem;
            }

            .testimonial-name {
                color: var(--primary-gold);
                font-weight: 600;
                margin-bottom: 0.2rem;
            }

            .testimonial-role {
                color: var(--text-gold);
                opacity: 0.8;
                font-size: 0.9rem;
            }

            /* Brand showcase section */
            .brand-showcase {
                padding: 60px 0;
                background: linear-gradient(145deg, var(--rich-black), var(--dark-black));
                text-align: center;
                position: relative;
            }

            .brand-showcase h3 {
                color: var(--primary-gold);
                font-size: 1.8rem;
                margin-bottom: 2.5rem;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .brand-logos {
                display: flex;
                justify-content: center;
                align-items: center;
                flex-wrap: wrap;
                gap: 3rem;
            }

            .brand-logo {
                max-width: 120px;
                height: auto;
                filter: brightness(0) invert(0.8) sepia(1) saturate(5) hue-rotate(20deg);
                opacity: 0.8;
                transition: all 0.3s ease;
            }

            .brand-logo:hover {
                filter: brightness(0) invert(0.9) sepia(1) saturate(10) hue-rotate(20deg);
                transform: scale(1.05);
                opacity: 1;
            }

            /* Enhanced Chat Widget styling to match luxury theme */
            #chat-widget-container {
                position: fixed;
                bottom: 30px;
                right: 30px;
                z-index: 1000;
            }

            #chat-button {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                padding: 12px 25px;
                border-radius: 30px;
                font-weight: 600;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                letter-spacing: 1px;
            }

            #chat-button:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 25px rgba(212, 175, 55, 0.4);
            }

            #chat-button i {
                margin-right: 8px;
                font-size: 1.2em;
            }

            #chat-popup {
                border: 1px solid var(--primary-gold);
                border-radius: 15px;
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
                overflow: hidden;
                width: 360px;
                height: 450px;
                right: 0;
                bottom: 80px;
            }

            #chat-header {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                padding: 15px 20px;
                font-weight: 600;
                letter-spacing: 1px;
            }

            #chat-title {
                margin: 0;
                font-size: 1.1rem;
                font-weight: 700;
            }

            #chat-close-button {
                background: none;
                border: none;
                color: var(--dark-black);
                font-size: 1.4rem;
                cursor: pointer;
                transition: all 0.2s ease;
                width: 30px;
                height: 30px;
                display: flex;
                align-items: center;
                justify-content: center;
                border-radius: 50%;
            }

            #chat-close-button:hover {
                background: rgba(0, 0, 0, 0.1);
                transform: rotate(90deg);
            }

            #chat-body {
                padding: 15px;
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            }

            .message {
                padding: 10px 15px;
                border-radius: 20px;
                margin-bottom: 10px;
                max-width: 80%;
                word-break: break-word;
                line-height: 1.5;
            }

            .user-message {
                background: rgba(212, 175, 55, 0.2);
                color: var(--primary-gold);
                margin-left: auto;
                border-bottom-right-radius: 5px;
            }

            .ai-message {
                background: rgba(255, 255, 255, 0.1);
                color: var(--text-gold);
                margin-right: auto;
                border-bottom-left-radius: 5px;
            }

            #chat-input-area {
                padding: 10px 15px;
                background: var(--rich-black);
                border-top: 1px solid rgba(212, 175, 55, 0.3);
                display: flex;
            }

            #chat-input {
                flex: 1;
                background: rgba(255, 255, 255, 0.05);
                border: 1px solid rgba(212, 175, 55, 0.3);
                border-radius: 20px;
                color: white;
                padding: 10px 15px;
                margin-right: 10px;
            }

            #chat-input:focus {
                outline: none;
                border-color: var(--primary-gold);
                box-shadow: 0 0 0 2px rgba(212, 175, 55, 0.2);
            }

            #chat-send-button {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                border-radius: 50%;
                width: 40px;
                height: 40px;
                display: flex;
                align-items: center;
                justify-content: center;
                cursor: pointer;
                transition: all 0.3s ease;
            }

            #chat-send-button:hover {
                transform: rotate(15deg);
                box-shadow: 0 0 10px rgba(212, 175, 55, 0.4);
            }

            #appointment-button-container {
                padding: 15px;
                text-align: center;
                background: var(--rich-black);
                border-top: 1px solid rgba(212, 175, 55, 0.3);
            }

            #create-appointment-button {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                border-radius: 30px;
                padding: 10px 20px;
                font-weight: 600;
                letter-spacing: 1px;
                transition: all 0.3s ease;
                width: 100%;
                text-transform: uppercase;
                font-size: 0.9rem;
            }

            #create-appointment-button:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }

            /* Responsive fixes */
            @media (max-width: 768px) {
                .video-background-section {
                    flex-direction: column;
                }

                .video-side {
                    height: 50vh;
                }

                .testimonial-card {
                    margin-bottom: 1.5rem;
                }

                .brand-logos {
                    gap: 2rem;
                }

                #chat-popup {
                    width: 320px;
                    height: 400px;
                    right: 10px;
                    bottom: 70px;
                }
            }
        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <!-- Hero Section with Gold Particles -->
            <div class="hero-section">
                <div class="gold-particles">
                    <!-- These will be generated by JavaScript -->
                </div>
                <div class="container position-relative" style="z-index: 2;">
                    <h1 class="hero-title">Welcome to MotoVibe</h1>
                    <p class="hero-subtitle">Experience Luxury on Two Wheels</p>
                    <a class="btn btn-outline-primary btn-lg" href="motorList">
                        <i class="fas fa-motorcycle me-2"></i> Explore Our Collection
                    </a>
                </div>
            </div>

            <div class="page-content">
                <!-- Featured Motorbikes Section -->
                <div class="featured-motorbikes-wrapper">
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
            </div>

            <!-- Add Testimonials Section -->
            <div class="testimonials">
                <div class="container">
                    <h2>What Our Riders Say</h2>
                    <div class="row">
                        <div class="col-md-4">
                            <div class="testimonial-card">
                                <p class="testimonial-text">"In this society there are only those who make money and those who depend on others."</p>
                                <div class="testimonial-author">
                                    <img src="images/avatar1.jpg" alt="Customer Avatar" class="testimonial-avatar" onerror="this.src='https://via.placeholder.com/50/111111/FFD700?text=MV';">
                                    <div>
                                        <div class="testimonial-name">Hưng Trương</div>
                                        <div class="testimonial-role">Thợ Săn Phú Bà</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="testimonial-card">
                                <p class="testimonial-text">"Specializing in providing solutions to problems using AI at the cheapest price on the market"</p>
                                <div class="testimonial-author">
                                    <img src="images/avatar2.jpg" alt="Customer Avatar" class="testimonial-avatar" onerror="this.src='https://via.placeholder.com/50/111111/FFD700?text=MV';">
                                    <div>
                                        <div class="testimonial-name">Hưng DPS</div>
                                        <div class="testimonial-role">Store Digitial Products Số 1 VN</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-4">
                            <div class="testimonial-card">
                                <p class="testimonial-text">"Bird's nest is a friend not an animal, eat bird's nest to increase resistance meo meo meo meo"</p>
                                <div class="testimonial-author">
                                    <img src="images/avatar3.jpg" alt="Customer Avatar" class="testimonial-avatar" onerror="this.src='https://via.placeholder.com/50/111111/FFD700?text=MV';">
                                    <div>
                                        <div class="testimonial-name">Hưng Bán Yến</div>
                                        <div class="testimonial-role">Kẻ Bán Yến Số 1 VN</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Ready to Ride Section with Videos -->
            <div class="container-fluid p-0">
                <div class="video-background-section">
                    <div class="video-side">
                        <video class="video-background" autoplay loop muted playsinline>
                            <source src="images/motor_pictures/index_motor_1.mp4" type="video/mp4">
                        </video>
                    </div>

                    <div class="content-side">
                        <div class="ready-to-ride-content text-center">
                            <h2 class="ready-to-ride-title">Ready to Ride?</h2>
                            <p class="ready-to-ride-text">Find your dream motorbike today and experience the freedom of the open road with MotoVibe.</p>

                            <div class="ready-to-ride-links">
                                <c:if test="${empty sessionScope.user}">
                                    <a href="login.jsp" class="btn-luxury" style="color: white !important;">
                                        <i class="fas fa-sign-in-alt me-2" style="color: white !important;"></i>Login
                                    </a>
                                    <a href="register.jsp" class="btn-luxury" style="color: white !important;">
                                        <i class="fas fa-user-plus me-2" style="color: white !important;"></i>Register
                                    </a>
                                </c:if>
                                <c:if test="${not empty sessionScope.user}">

                                    <a href="listAppointments" class="btn-luxury" style="color: white !important;">
                                        <i class="fas fa-sign-in-alt me-2" style="color: white !important;"></i>View List Appointments
                                    </a>

                                    <a href="motorList" class="btn-luxury" style="color: white !important;">
                                        <i class="fas fa-sign-in-alt me-2" style="color: white !important;"></i>View MotorList
                                    </a>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <div class="video-side">
                        <video class="video-background" autoplay loop muted playsinline>
                            <source src="images/motor_pictures/index_motor_2.mp4" type="video/mp4">
                        </video>
                    </div>
                </div>
            </div>

            <!-- Add Brand Showcase -->
            <div class="brand-showcase">
                <div class="container">
                    <h3>Premium Brands We Carry</h3>
                    <div class="brand-logos">
                        <img src="images/brands/ducati.png" alt="Ducati" class="brand-logo" onerror="this.src='https://via.placeholder.com/120x60/111111/FFD700?text=DUCATI';">
                        <img src="images/brands/bmw.png" alt="BMW" class="brand-logo" onerror="this.src='https://via.placeholder.com/120x60/111111/FFD700?text=BMW';">
                        <img src="images/brands/harley.png" alt="Harley-Davidson" class="brand-logo" onerror="this.src='https://via.placeholder.com/120x60/111111/FFD700?text=HARLEY';">
                        <img src="images/brands/triumph.png" alt="Triumph" class="brand-logo" onerror="this.src='https://via.placeholder.com/120x60/111111/FFD700?text=TRIUMPH';">
                        <img src="images/brands/honda.png" alt="Honda" class="brand-logo" onerror="this.src='https://via.placeholder.com/120x60/111111/FFD700?text=HONDA';">
                    </div>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

            <!-- Enhanced Chat Widget -->
            <div id="chat-widget-container">
                <button id="chat-button"><i class="fas fa-comment-dots"></i> Chat with MotoVibe</button>
                <div id="chat-popup">
                    <div id="chat-header">
                        <h5 id="chat-title"><i class="fas fa-robot me-2"></i> MotoVibe AI Assistant</h5>
                        <button id="chat-close-button">&times;</button>
                    </div>
                    <div id="chat-body">
                        <!-- Messages will be added here by JavaScript -->
                        <div class="message ai-message">
                            Welcome to MotoVibe! How can I assist you with your motorcycle needs today?
                        </div>
                    </div>
                    <div id="appointment-button-container" style="display: none;">
                        <button id="create-appointment-button"><i class="fas fa-calendar-check me-2"></i> Schedule Appointment</button>
                    </div>
                    <div id="chat-input-area">
                        <input type="text" id="chat-input" placeholder="Ask me about our motorcycles...">
                        <button id="chat-send-button"><i class="fas fa-paper-plane"></i></button>
                    </div>
                </div>
            </div>

            <script>
                // Gold particles animation
                document.addEventListener('DOMContentLoaded', function () {
                    const particlesContainer = document.querySelector('.gold-particles');
                    const particleCount = 20;

                    for (let i = 0; i < particleCount; i++) {
                        createParticle(particlesContainer);
                    }

                    function createParticle(container) {
                        const particle = document.createElement('div');
                        particle.classList.add('particle');

                        // Random size between 5px and 20px
                        const size = Math.random() * 15 + 5;
                        particle.style.width = `${size}px`;
                        particle.style.height = `${size}px`;

                        // Random position
                        const posX = Math.random() * 100;
                        const posY = Math.random() * 100 + 100; // Start below the viewport
                        particle.style.left = `${posX}%`;
                        particle.style.bottom = `${-posY}px`;

                        // Random animation duration between 15s and 30s
                        const duration = Math.random() * 15 + 15;
                        particle.style.animation = `float ${duration}s infinite linear`;

                        // Random animation delay
                        const delay = Math.random() * 10;
                        particle.style.animationDelay = `${delay}s`;

                        container.appendChild(particle);
                    }
                });

                // Enhanced chat widget with luxury styling
                document.addEventListener('DOMContentLoaded', function () {
                    const chatButton = document.getElementById('chat-button');
                    const chatPopup = document.getElementById('chat-popup');
                    const chatCloseButton = document.getElementById('chat-close-button');
                    const chatBody = document.getElementById('chat-body');
                    const chatInput = document.getElementById('chat-input');
                    const chatSendButton = document.getElementById('chat-send-button');
                    const appointmentButtonContainer = document.getElementById('appointment-button-container');
                    const createAppointmentButton = document.getElementById('create-appointment-button');
                    
                    let questionCount = 0;
                    let isChatOpen = false;
                    
                    // Toggle chat popup visibility
                    chatButton.addEventListener('click', () => {
                        chatPopup.style.display = 'flex';
                        isChatOpen = true;
                        chatInput.focus();
                    });
                    
                    chatCloseButton.addEventListener('click', () => {
                        chatPopup.style.display = 'none';
                        isChatOpen = false;
                    });
                    
                    // Close chat when clicking outside of it
                    document.addEventListener('click', function (event) {
                        if (isChatOpen && !chatPopup.contains(event.target) && !chatButton.contains(event.target)) {
                            chatPopup.style.display = 'none';
                            isChatOpen = false;
                        }
                    });
                    
                    // Send message functionality
                    chatSendButton.addEventListener('click', sendMessage);
                    
                    chatInput.addEventListener('keypress', function (event) {
                        if (event.key === 'Enter') {
                            sendMessage();
                            event.preventDefault();
                        }
                    });
                    
                    // Appointment button functionality
                    createAppointmentButton.addEventListener('click', function () {
                        var isLoggedIn = <%= session.getAttribute("user") != null %>;
                        if (isLoggedIn) {
                            window.location.href = 'listAppointments';
                        } else {
                            window.location.href = 'register.jsp';
                        }
                    });
                    
                    // Function to send message to server and handle response
                    function sendMessage() {
                        const messageText = chatInput.value.trim();
                        if (messageText) {
                            // Add user message to chat
                            appendMessage(messageText, 'user-message');
                            chatInput.value = '';
                            
                            // Show loading indicator
                            const loadingMessage = appendMessage('Thinking...', 'ai-message');
                            
                            // Send to server
                            fetch('ChatServlet', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/x-www-form-urlencoded',
                                },
                                body: 'message=' + encodeURIComponent(messageText)
                            })
                            .then(response => {
                                if (!response.ok) {
                                    throw new Error('Server response was not ok');
                                }
                                return response.text();
                            })
                            .then(aiResponse => {
                                // Remove loading indicator
                                chatBody.removeChild(loadingMessage);
                                
                                // Add AI response
                                appendMessage(aiResponse, 'ai-message');
                                
                                // Show appointment button after 2 questions
                                questionCount++;
                                if (questionCount >= 2) {
                                    appointmentButtonContainer.style.display = 'block';
                                }
                            })
                            .catch(error => {
                                console.error('Error sending message:', error);
                                chatBody.removeChild(loadingMessage);
                                appendMessage('I apologize, but I\'m having trouble connecting right now. Please try again or visit one of our stores for assistance.', 'ai-message');
                            });
                        }
                    }
                    
                    // Function to append messages to chat
                    function appendMessage(message, messageClass) {
                        const messageDiv = document.createElement('div');
                        messageDiv.classList.add('message', messageClass);
                        messageDiv.textContent = message;
                        chatBody.appendChild(messageDiv);
                        chatBody.scrollTop = chatBody.scrollHeight;
                        
                        // Add subtle animation to new messages
                        messageDiv.style.opacity = '0';
                        messageDiv.style.transform = 'translateY(10px)';
                        messageDiv.style.transition = 'all 0.3s ease';
                        
                        setTimeout(() => {
                            messageDiv.style.opacity = '1';
                            messageDiv.style.transform = 'translateY(0)';
                        }, 10);
                        
                        return messageDiv; // Return for potential removal (loading indicator)
                    }
                });
            </script>

            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        </body>
        </html>
