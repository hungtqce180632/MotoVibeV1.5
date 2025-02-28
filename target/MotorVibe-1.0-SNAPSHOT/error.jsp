<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error Page</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="css/luxury-theme.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            min-height: 100vh;
            background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 2rem;
        }
        
        .error-container {
            background: linear-gradient(145deg, var(--rich-black), var(--dark-black));
            border: 1px solid var(--primary-gold);
            border-radius: 15px;
            padding: 3rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            max-width: 600px;
            width: 100%;
            text-align: center;
            position: relative;
            overflow: hidden;
        }
        
        .error-container::before,
        .error-container::after {
            content: '';
            position: absolute;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, var(--primary-gold) 0%, transparent 70%);
            opacity: 0.1;
            border-radius: 50%;
        }
        
        .error-container::before {
            top: -75px;
            left: -75px;
        }
        
        .error-container::after {
            bottom: -75px;
            right: -75px;
        }
        
        .error-icon {
            font-size: 5rem;
            color: var(--primary-gold);
            margin-bottom: 1.5rem;
            text-shadow: 0 0 15px rgba(255, 215, 0, 0.5);
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.1); }
            100% { transform: scale(1); }
        }
        
        h2 {
            color: var(--primary-gold);
            font-size: 2.5rem;
            text-transform: uppercase;
            letter-spacing: 2px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
            margin-bottom: 1.5rem;
        }
        
        .error-message {
            color: var(--text-gold);
            font-size: 1.2rem;
            margin-bottom: 2.5rem;
            padding: 1rem;
            background: rgba(0, 0, 0, 0.2);
            border-left: 3px solid var(--primary-gold);
            text-align: left;
            border-radius: 5px;
        }
        
        .btn-primary {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            border: none;
            color: var(--dark-black);
            font-weight: 600;
            padding: 12px 30px;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            border-radius: 5px;
            font-size: 1.1rem;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(212, 175, 55, 0.4);
        }
        
        .error-bottom-text {
            color: var(--text-gold);
            opacity: 0.7;
            margin-top: 2rem;
            font-size: 0.9rem;
        }
    </style>
</head>
<body>
    <div class="error-container">
        <i class="fas fa-exclamation-triangle error-icon"></i>
        <h2>An Error Occurred</h2>
        
        <div class="error-message">
            ${errorMessage != null ? errorMessage : "An unexpected error has occurred. Please try again or contact support if the problem persists."}
        </div>
        
        <a href="manage_event" class="btn btn-primary">
            <i class="fas fa-home me-2"></i> Return to Event Management
        </a>
        
        <p class="error-bottom-text">
            <i class="fas fa-info-circle me-1"></i>
            Error ID: ${pageContext.errorData.statusCode != null ? pageContext.errorData.statusCode : 'SYSTEM-ERR-' + System.currentTimeMillis()}
        </p>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
