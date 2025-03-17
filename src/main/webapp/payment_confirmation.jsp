<%@ page import="models.Motor" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Payment Confirmation - MotoVibe</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link rel="stylesheet" href="css/luxury-theme.css">
    <style>
        :root {
            --primary-gold: #D4AF37;
            --secondary-gold: #CFB53B;
            --dark-black: #121212;
            --rich-black: #1A1A1A;
            --text-gold: #F5E6CC;
        }
        
        .payment-container {
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
        
        .payment-container::before {
            content: '';
            position: absolute;
            top: 0;
            right: 0;
            width: 150px;
            height: 150px;
            background: radial-gradient(circle, var(--primary-gold) 0%, transparent 70%);
            opacity: 0.1;
        }
        
        .payment-header {
            color: var(--primary-gold);
            text-align: center;
            margin-bottom: 2rem;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        .payment-info {
            background: rgba(0,0,0,0.2);
            border: 1px solid var(--secondary-gold);
            border-radius: 10px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }
        
        .qr-container {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            text-align: center;
            margin-bottom: 2rem;
            max-width: 300px;
            margin-left: auto;
            margin-right: auto;
        }
        
        .qr-code {
            max-width: 100%;
            height: auto;
        }
        
        .payment-details {
            background: rgba(0,0,0,0.2);
            border-left: 3px solid var(--primary-gold);
            padding: 1.5rem;
            border-radius: 5px;
            margin-bottom: 2rem;
        }
        
        .payment-details h5 {
            color: var(--primary-gold);
            margin-bottom: 1rem;
        }
        
        .payment-details p {
            margin-bottom: 0.5rem;
            color: var(--text-gold);
        }
        
        .btn-confirm {
            background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
            border: none;
            color: var(--dark-black);
            font-weight: 600;
            transition: all 0.3s ease;
            padding: 0.75rem 2rem;
            font-size: 1.1rem;
        }
        
        .btn-confirm:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
        }
        
        .payment-steps {
            display: flex;
            justify-content: space-between;
            margin-bottom: 2rem;
        }
        
        .step {
            text-align: center;
            position: relative;
            flex: 1;
        }
        
        .step::after {
            content: '';
            position: absolute;
            top: 30px;
            left: 55%;
            width: 90%;
            height: 2px;
            background: var(--primary-gold);
            opacity: 0.5;
            z-index: -1;
        }
        
        .step:last-child::after {
            content: none;
        }
        
        .step-icon {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            background: var(--dark-black);
            border: 2px solid var(--primary-gold);
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            color: var(--primary-gold);
            font-size: 1.5rem;
        }
        
        .step-text {
            color: var(--text-gold);
            font-size: 0.9rem;
        }
        
        .active .step-icon {
            background: var(--primary-gold);
            color: var(--dark-black);
        }
        
        .transfer-details {
            background: rgba(255,255,255,0.05);
            border-radius: 10px;
            padding: 1rem;
            margin-top: 1rem;
        }
        
        .transfer-details .row {
            margin-bottom: 0.5rem;
            padding-bottom: 0.5rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        
        .transfer-details .row:last-child {
            border-bottom: none;
            margin-bottom: 0;
            padding-bottom: 0;
        }
        
        .copy-btn {
            background: transparent;
            border: 1px solid var(--primary-gold);
            color: var(--primary-gold);
            border-radius: 3px;
            padding: 0.2rem 0.5rem;
            font-size: 0.8rem;
            transition: all 0.2s;
        }
        
        .copy-btn:hover {
            background: var(--primary-gold);
            color: var(--dark-black);
        }
        
        .alert-copied {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 10px 20px;
            background: var(--primary-gold);
            color: var(--dark-black);
            border-radius: 5px;
            box-shadow: 0 3px 10px rgba(0,0,0,0.2);
            display: none;
            z-index: 1000;
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp"></jsp:include>
    
    <div class="alert-copied" id="copyAlert">
        <i class="fas fa-check-circle me-2"></i> Copied to clipboard
    </div>
    
    <div class="container">
        <div class="payment-container">
            <h2 class="payment-header"><i class="fas fa-credit-card me-2"></i> Bank Transfer Payment</h2>
            
            <div class="payment-steps">
                <div class="step">
                    <div class="step-icon">
                        <i class="fas fa-shopping-cart"></i>
                    </div>
                    <div class="step-text">Order Created</div>
                </div>
                <div class="step active">
                    <div class="step-icon">
                        <i class="fas fa-money-bill-wave"></i>
                    </div>
                    <div class="step-text">Payment</div>
                </div>
                <div class="step">
                    <div class="step-icon">
                        <i class="fas fa-check"></i>
                    </div>
                    <div class="step-text">Confirmation</div>
                </div>
            </div>
            
            <div class="payment-info">
                <p class="mb-0">Please complete your payment using the details below. Once your payment is completed, click the "Confirm Payment" button.</p>
            </div>
            
            <div class="row">
                <div class="col-md-6">
                    <div class="qr-container">
                        <!-- SePay QR code for Vietnamese banking -->
                        <img src="https://qr.sepay.vn/img?acc=0817771184&bank=MSB&amount=${requestScope.totalAmount}&des=${requestScope.orderCode}&template=compact&download=false" 
                             alt="Payment QR Code" class="qr-code">
                        <p class="mt-2 text-dark">Scan to pay</p>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="payment-details">
                        <h5>Transfer Details</h5>
                        <div class="transfer-details">
                            <div class="row">
                                <div class="col-5">Bank Name:</div>
                                <div class="col-7 d-flex justify-content-between">
                                    <span>MARITIME BANK</span>
                                    <button class="copy-btn" onclick="copyToClipboard('MOTOVIBE BANK')">Copy</button>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-5">Account Number:</div>
                                <div class="col-7 d-flex justify-content-between">
                                    <span>0817771184</span>
                                    <button class="copy-btn" onclick="copyToClipboard('0123456789')">Copy</button>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-5">Account Name:</div>
                                <div class="col-7 d-flex justify-content-between">
                                    <span>MOTOVIBE LTD</span>
                                    <button class="copy-btn" onclick="copyToClipboard('MOTOVIBE LTD')">Copy</button>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-5">Amount:</div>
                                <div class="col-7 d-flex justify-content-between">
                                    <span>$${requestScope.totalAmount}</span>
                                    <button class="copy-btn" onclick="copyToClipboard('${requestScope.totalAmount}')">Copy</button>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-5">Reference:</div>
                                <div class="col-7 d-flex justify-content-between">
                                    <span>${requestScope.orderCode}</span>
                                    <button class="copy-btn" onclick="copyToClipboard('${requestScope.orderCode}')">Copy</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="text-center mt-4">
                <form action="confirmOrder" method="post">
                    <!-- Hidden fields to pass all the order information -->
                    <input type="hidden" name="motorId" value="${requestScope.motorId}">
                    <input type="hidden" name="customerName" value="${requestScope.customerName}">
                    <input type="hidden" name="customerEmail" value="${requestScope.customerEmail}">
                    <input type="hidden" name="customerPhone" value="${requestScope.customerPhone}">
                    <input type="hidden" name="customerIdNumber" value="${requestScope.customerIdNumber}">
                    <input type="hidden" name="customerAddress" value="${requestScope.customerAddress}">
                    <input type="hidden" name="paymentMethod" value="${requestScope.paymentMethod}">
                    <input type="hidden" name="hasWarranty" value="${requestScope.hasWarranty}">
                    <input type="hidden" name="orderCode" value="${requestScope.orderCode}">
                    
                    <button type="submit" class="btn btn-confirm">
                        <i class="fas fa-check-circle me-2"></i> Confirm Payment Completed
                    </button>
                </form>
            </div>
        </div>
    </div>
    
    <jsp:include page="footer.jsp"></jsp:include>
    
    <script>
        function copyToClipboard(text) {
            navigator.clipboard.writeText(text).then(function() {
                // Show the alert
                const copyAlert = document.getElementById('copyAlert');
                copyAlert.style.display = 'block';
                
                // Hide it after 2 seconds
                setTimeout(function() {
                    copyAlert.style.display = 'none';
                }, 2000);
            });
        }
    </script>
</body>
</html>
