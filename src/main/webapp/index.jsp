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
                        <p> <a href="login.jsp">Login</a> or <a href="signup.jsp">Register</a> to get started!</p>
                    </c:if>
                    <c:if test="${not empty sessionScope.user}">
                        <p>Welcome back, <c:out value="${sessionScope.user.email}"/>! <a href="listAppointments">View Appointments</a> or <a href="motorList">Browse Motorbikes</a>.</p>
                    </c:if>
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
