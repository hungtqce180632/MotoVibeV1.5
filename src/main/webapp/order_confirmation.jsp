<%-- 
    Document   : order_confirmation
    Created on : Feb 24, 2025, 4:50:55 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Order Confirmation - MotoVibe</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/luxury-theme.css">
    <style>
        :root {
            --primary-gold: #D4AF37;
            --secondary-gold: #C5A028;
            --dark-black: #111111;
            --rich-black: #1A1A1A;
            --text-gold: #F5E6CC;
        }
        
        .confirmation-container {
            background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            border: 1px solid var(--primary-gold);
            border-radius: 15px;
            padding: 3rem;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
            margin: 3rem auto;
            max-width: 800px;
            position: relative;
            overflow: hidden;
        }
        
        .confirmation-container::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, var(--primary-gold) 0%, transparent 70%);
            opacity: 0.1;
        }
        
        .alert-success {
            background: transparent !important;
            border: none;
            border-bottom: 1px solid var(--primary-gold);
            color: var(--text-gold) !important;
            padding-bottom: 2rem;
            border-radius: 0;
        }
        
        .alert-heading {
            color: var(--primary-gold);
            font-size: 2rem;
            margin-bottom: 1.5rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            display: flex;
            align-items: center;
        }
        
        .alert-heading i {
            font-size: 2.5rem;
            margin-right: 15px;
            color: var(--primary-gold);
            text-shadow: 0 0 10px rgba(212, 175, 55, 0.5);
        }
        
        .alert p {
            color: var(--text-gold);
            font-size: 1.1rem;
            line-height: 1.6;
        }
        
        .btn-primary {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            border: none;
            color: var(--dark-black);
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
            margin-right: 1rem;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(212, 175, 55, 0.3);
        }
        
        .btn-secondary {
            background: transparent;
            border: 1px solid var(--primary-gold);
            color: var(--primary-gold);
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            transition: all 0.3s ease;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        .btn-secondary:hover {
            background: rgba(212, 175, 55, 0.1);
            transform: translateY(-3px);
        }
        
        hr {
            border-top: 1px solid rgba(212, 175, 55, 0.3) !important;
            margin: 1.5rem 0;
        }
        
        .order-details {
            background: rgba(0, 0, 0, 0.2);
            padding: 1.5rem;
            border-radius: 10px;
            margin-top: 2rem;
            border-left: 3px solid var(--primary-gold);
        }
        
        .order-details h5 {
            color: var(--primary-gold);
            font-size: 1.2rem;
            margin-bottom: 1rem;
        }
        
        .order-details p {
            margin-bottom: 0.5rem;
        }
        
        .order-number {
            font-family: 'Courier New', monospace;
            background: rgba(0, 0, 0, 0.3);
            padding: 0.5rem 1rem;
            border-radius: 5px;
            display: inline-block;
            margin-top: 0.5rem;
            color: var(--primary-gold);
            border: 1px dashed var(--secondary-gold);
        }
        
        .actions-container {
            margin-top: 2rem;
            display: flex;
            justify-content: center;
            gap: 1rem;
        }
        
        .container {
            padding-top: 80px;
        }
        
        /* Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .animated {
            animation: fadeIn 0.8s ease-out forwards;
        }
        
        .delay-1 {
            animation-delay: 0.3s;
            opacity: 0;
        }
        
        .delay-2 {
            animation-delay: 0.6s;
            opacity: 0;
        }
        
        .delay-3 {
            animation-delay: 0.9s;
            opacity: 0;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    
    <div class="container">
        <div class="confirmation-container">
            <div class="alert alert-success animated" role="alert">
                <h4 class="alert-heading"><i class="fas fa-check-circle"></i> Order Placed Successfully!</h4>
                <p>Thank you for your order with MotoVibe. Your order has been received and is being processed by our team.</p>
                <hr>
                <p class="mb-0">You will receive an email confirmation shortly with your complete order details.</p>
            </div>
            
            <div class="order-details animated delay-1">
                <h5><i class="fas fa-file-invoice me-2"></i>Order Summary</h5>
                <p><strong>Order ID:</strong> ${requestScope.orderId}</p>
                <p><strong>Order Code:</strong> <span class="order-number">${requestScope.orderCode}</span></p>
                <p><strong>Order Date:</strong> ${requestScope.orderDate}</p>
                <p><strong>Payment Method:</strong> ${param.paymentMethod}</p>
                <p><strong>Warranty:</strong> ${requestScope.hasWarranty ? 'Yes (+10%)' : 'No'}</p>
                <p><strong>Total Amount:</strong> $${requestScope.totalAmount} (${requestScope.totalAmountVND} VND)</p>
            </div>
            
            <div class="actions-container animated delay-2">
                <a href="motorList" class="btn btn-primary"><i class="fas fa-motorcycle me-2"></i>Continue Shopping</a>
                <a href="listOrders" class="btn btn-secondary"><i class="fas fa-list-alt me-2"></i>View My Orders</a>
            </div>
            
            <div class="text-center mt-4 animated delay-3">
                <a href="home" class="btn btn-link text-gold">
                    <i class="fas fa-home me-1"></i> Return to Home
                </a>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
