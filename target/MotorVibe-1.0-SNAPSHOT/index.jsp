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
        <link rel="stylesheet" href="css/luxury-theme.css">
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
            }

            .hero-subtitle {
                color: var(--text-gold);
                font-size: 1.4rem;
                text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
                margin-bottom: 2rem;
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
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
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

        </style>
    </head>
    <body>

        <jsp:include page="header.jsp"></jsp:include>

            <div class="hero-section">
                <div class="container">
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
                                    <a href="login.jsp" class="btn-luxury">
                                        <i class="fas fa-sign-in-alt me-2"></i>Login
                                    </a>
                                    <a href="register.jsp" class="btn-luxury">
                                        <i class="fas fa-user-plus me-2"></i>Register
                                    </a>
                                </c:if>
                                <c:if test="${not empty sessionScope.user}">
                                    <a href="listAppointments" class="btn-luxury">
                                        <i class="fas fa-calendar-check me-2"></i>View Appointments
                                    </a>
                                    <a href="motorList" class="btn-luxury">
                                        <i class="fas fa-motorcycle me-2"></i>Browse Motorbikes
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
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

        <%-- Chat Widget HTML - ADDED CHAT WIDGET HTML HERE, BEFORE SCRIPT --%>
        <div id="chat-widget-container">
            <button id="chat-button">Chat with AI</button>
            <div id="chat-popup">
                <div id="chat-header">
                    <h5 id="chat-title">MotoVibe AI Assistant</h5>
                    <button id="chat-close-button">x</button>
                </div>
                <div id="chat-body">
                </div>
                <div id="appointment-button-container">
                    <button id="create-appointment-button">Create Appointment</button>
                </div>
                <div id="chat-input-area">
                    <input type="text" id="chat-input" placeholder="Type your question...">
                    <button id="chat-send-button">Send</button>
                </div>
            </div>
        </div>

        <%-- Chat Widget Javascript - ADDED JAVASCRIPT CODE HERE --%>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const chatButton = document.getElementById('chat-button');
                const chatPopup = document.getElementById('chat-popup');
                const chatCloseButton = document.getElementById('chat-close-button');
                const chatBody = document.getElementById('chat-body');
                const chatInput = document.getElementById('chat-input');
                const chatSendButton = document.getElementById('chat-send-button');
                const appointmentButtonContainer = document.getElementById('appointment-button-container');
                const createAppointmentButton = document.getElementById('create-appointment-button');

                let questionCount = 0; // Counter for questions asked
                let isChatOpen = false;

                chatButton.addEventListener('click', () => {
                    chatPopup.style.display = 'flex'; // Use flex to display popup
                    isChatOpen = true;
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

                chatSendButton.addEventListener('click', sendMessage);

                chatInput.addEventListener('keypress', function (event) {
                    if (event.key === 'Enter') {
                        sendMessage();
                        event.preventDefault(); // Prevent default form submission
                    }
                });

                createAppointmentButton.addEventListener('click', function () {
                    // Check if user is logged in (JSP variable passed from server-side)
                    var isLoggedIn = <%= session.getAttribute("user") != null %>; // Correct way to check in JSP
                    if (isLoggedIn) {
                        window.location.href = 'listAppointments'; // Redirect logged-in user
                    } else {
                        window.location.href = 'register.jsp'; // Redirect guest user to register
                    }
                });


                function sendMessage() {
                    const messageText = chatInput.value.trim();
                    if (messageText) {
                        appendMessage(messageText, 'user-message');
                        chatInput.value = '';

                        fetch('ChatServlet', {// Servlet URL - adjust if needed
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/x-www-form-urlencoded',
                            },
                            body: 'message=' + encodeURIComponent(messageText)
                        })
                                .then(response => response.text())
                                .then(aiResponse => {
                                    appendMessage(aiResponse, 'ai-message');
                                    questionCount++;
                                    if (questionCount >= 3) {
                                        appointmentButtonContainer.style.display = 'block'; // Show button after 3 questions
                                    }
                                })
                                .catch(error => {
                                    console.error('Error sending message:', error);
                                    appendMessage('Sorry, I could not process your request.', 'ai-message');
                                });
                    }
                }

                function appendMessage(message, messageClass) {
                    const messageDiv = document.createElement('div');
                    messageDiv.classList.add('message', messageClass);
                    messageDiv.textContent = message;
                    chatBody.appendChild(messageDiv);
                    chatBody.scrollTop = chatBody.scrollHeight; // Scroll to bottom
                }
            });
        </script>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
