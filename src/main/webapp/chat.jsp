<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MotoVibe Chat</title>
    <style>
        /* Chat Container Styling */
        #chat-container {
            width: 350px;
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.2);
            overflow: hidden;
            font-family: Arial, sans-serif;
            margin: 20px auto;
        }
        
        /* Chat Header */
        #chat-header {
            background-color: #1a73e8;
            color: white;
            padding: 15px;
            font-weight: bold;
            font-size: 18px;
            text-align: center;
        }
        
        /* Chat Body - Where Messages Appear */
        #chat-body {
            height: 400px;
            padding: 15px;
            overflow-y: auto;
            background-color: #f4f7f9;
        }
        
        /* Message Styling */
        .message {
            margin-bottom: 15px;
            padding: 10px 15px;
            border-radius: 18px;
            max-width: 70%;
            word-wrap: break-word;
            clear: both;
            line-height: 1.4;
        }
        
        /* User Message Styling */
        .user-message {
            background-color: #e3f2fd;
            color: #000;
            float: right;
            border-bottom-right-radius: 5px;
        }
        
        /* AI Message Styling */
        .ai-message {
            background-color: #fff;
            color: #000;
            float: left;
            box-shadow: 0 1px 2px rgba(0,0,0,0.1);
            border-bottom-left-radius: 5px;
        }
        
        /* Chat Input Area */
        #chat-input-container {
            display: flex;
            padding: 10px;
            background-color: #fff;
            border-top: 1px solid #e0e0e0;
        }
        
        #chat-input {
            flex-grow: 1;
            border: none;
            padding: 10px;
            border-radius: 20px;
            background-color: #f4f7f9;
            outline: none;
        }
        
        #chat-send-button {
            background-color: #1a73e8;
            color: white;
            border: none;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            margin-left: 10px;
            cursor: pointer;
            font-size: 18px;
            transition: background-color 0.2s;
        }
        
        #chat-send-button:hover {
            background-color: #1669d6;
        }
        
        /* Appointment Button Container */
        #appointment-button-container {
            text-align: center;
            padding: 10px;
            display: none;
            background-color: #f4f7f9;
        }
        
        #create-appointment-button {
            background-color: #4CAF50;
            color: white;
            border: none;
            padding: 10px 15px;
            border-radius: 5px;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.2s;
        }
        
        #create-appointment-button:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <div id="chat-container">
        <div id="chat-header">MotoVibe AI Assistant</div>
        <div id="chat-body">
            <div class="message ai-message">Hello! How can I help you with motorcycles today?</div>
        </div>
        <div id="chat-input-container">
            <input type="text" id="chat-input" placeholder="Ask me about motorcycles...">
            <button id="chat-send-button">➤</button>
        </div>
        <div id="appointment-button-container">
            <button id="create-appointment-button">Book a Test Ride</button>
        </div>
        <div class="text-center mt-2">
            <button id="reset-chat-button" class="btn btn-sm" style="background-color: transparent; color: #999; border: 1px solid #ddd; font-size: 0.8rem;">
                <i class="fas fa-redo-alt"></i> Reset Conversation
            </button>
        </div>
    </div>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            // DOM Elements
            const chatBody = document.getElementById('chat-body');
            const chatInput = document.getElementById('chat-input');
            const chatSendButton = document.getElementById('chat-send-button');
            const appointmentButtonContainer = document.getElementById('appointment-button-container');
            const createAppointmentButton = document.getElementById('create-appointment-button');
            const resetChatButton = document.getElementById('reset-chat-button');
            
            // Track question count
            let questionCount = 0;
            
            // Event Listeners
            chatSendButton.addEventListener('click', sendMessage);
            
            chatInput.addEventListener('keypress', function(event) {
                if (event.key === 'Enter') {
                    sendMessage();
                    event.preventDefault();
                }
            });
            
            resetChatButton.addEventListener('click', function() {
                // Clear chat messages except the initial greeting
                while (chatBody.children.length > 1) {
                    chatBody.removeChild(chatBody.lastChild);
                }
                
                // Reset question count
                questionCount = 0;
                
                // Reset conversation in the session
                fetch('ResetChatServlet', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded',
                    }
                }).catch(error => {
                    console.error('Error resetting chat:', error);
                });
                
                // Hide appointment button
                appointmentButtonContainer.style.display = 'none';
            });
            
            createAppointmentButton.addEventListener('click', function() {
                // Check if user is logged in (this should be dynamic based on your session)
                <% boolean isLoggedIn = (session.getAttribute("user") != null); %>
                var isLoggedIn = <%= isLoggedIn %>;
                
                if (isLoggedIn) {
                    window.location.href = 'listAppointments';
                } else {
                    window.location.href = 'register.jsp';
                }
            });
            
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
</body>
</html>
