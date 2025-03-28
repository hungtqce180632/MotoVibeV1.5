<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Contact & FAQ - MotoVibe</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
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
                font-family: 'Montserrat', sans-serif;
                background: var(--dark-black);
                color: var(--text-gold);
                margin: 0;
                padding: 0;
            }
            
            .container {
                max-width: 1200px;
                margin: 0 auto;
                padding: 20px;
            }
            
            .page-header {
                text-align: center;
                margin-bottom: 40px;
                padding-bottom: 20px;
                border-bottom: 1px solid var(--primary-gold);
                position: relative;
            }
            
            .page-header h1 {
                color: var(--primary-gold);
                font-weight: 700;
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 10px;
            }
            
            .page-header p {
                color: var(--text-gold);
                opacity: 0.9;
            }
            
            .page-header::after {
                content: '';
                position: absolute;
                bottom: -1px;
                left: 50%;
                transform: translateX(-50%);
                width: 150px;
                height: 3px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            
            /* Contact Info Section */
            .contact-info {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                transition: transform 0.3s;
            }
            
            .contact-info:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            }
            
            .contact-info h3 {
                color: var(--primary-gold);
                font-weight: 600;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 1px;
                text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
                position: relative;
                padding-bottom: 10px;
            }
            
            .contact-info h3::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 80px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 5px var(--primary-gold);
            }
            
            .contact-item {
                margin-bottom: 20px;
                display: flex;
                align-items: center;
            }
            
            .contact-item i {
                margin-right: 15px;
                font-size: 20px;
                color: var(--primary-gold);
                width: 25px;
                text-align: center;
                text-shadow: 0 0 5px rgba(212, 175, 55, 0.3);
            }
            
            .contact-item a, .contact-item span {
                color: var(--text-gold);
                text-decoration: none;
                transition: all 0.3s;
            }
            
            .contact-item a:hover {
                color: var(--primary-gold);
                text-shadow: 0 0 5px rgba(212, 175, 55, 0.3);
            }
            
            /* Map section */
            .map-section {
                margin-bottom: 30px;
            }
            
            .map-container {
                border-radius: 10px;
                overflow: hidden;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                border: 1px solid var(--primary-gold);
                transition: transform 0.3s;
            }
            
            .map-container:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            }
            
            /* FAQ Section */
            .faq-section {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 25px;
                margin-bottom: 30px;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                transition: transform 0.3s;
            }
            
            .faq-section:hover {
                transform: translateY(-5px);
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.4);
            }
            
            .faq-section h3 {
                color: var(--primary-gold);
                font-weight: 600;
                margin-bottom: 20px;
                text-transform: uppercase;
                letter-spacing: 1px;
                text-shadow: 1px 1px 3px rgba(0,0,0,0.5);
                position: relative;
                padding-bottom: 10px;
            }
            
            .faq-section h3::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 80px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 5px var(--primary-gold);
            }
            
            .faq-category {
                margin-bottom: 30px;
            }
            
            .faq-category h4 {
                color: var(--primary-gold);
                font-weight: 600;
                margin-bottom: 15px;
                padding-bottom: 10px;
                border-bottom: 1px solid rgba(212, 175, 55, 0.2);
                text-shadow: 1px 1px 2px rgba(0,0,0,0.5);
            }
            
            .accordion .card {
                background: transparent;
                border: none;
                margin-bottom: 15px;
                border-radius: 8px;
                overflow: hidden;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
                transition: all 0.3s;
            }
            
            .accordion .card:hover {
                transform: translateY(-3px);
                box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3);
            }
            
            .accordion .card-header {
                background: rgba(26, 26, 26, 0.9);
                border: 1px solid var(--secondary-gold);
                padding: 0;
                cursor: pointer;
                border-radius: 8px;
            }
            
            .accordion .btn-link {
                color: var(--text-gold);
                text-decoration: none;
                font-weight: 500;
                display: block;
                width: 100%;
                text-align: left;
                padding: 15px;
                transition: all 0.3s;
            }
            
            .accordion .btn-link:hover, .accordion .btn-link:focus {
                color: var(--primary-gold);
                text-decoration: none;
                text-shadow: 0 0 5px rgba(212, 175, 55, 0.3);
            }
            
            .accordion .card-body {
                padding: 15px 20px;
                color: var(--text-gold);
                line-height: 1.6;
                background: rgba(17, 17, 17, 0.95);
                border: 1px solid rgba(212, 175, 55, 0.2);
                border-top: none;
            }
            
            /* Support buttons */
            .dv-social-button {
                position: fixed;
                bottom: 20px;
                right: 20px;
                z-index: 9999;
            }
            
            .dv-social-button-content {
                position: absolute;
                bottom: 60px;
                right: 0;
                width: 250px;
                background: var(--rich-black);
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 15px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
                display: none;
            }
            
            .dv-social-button-content a {
                display: flex;
                align-items: center;
                padding: 10px;
                color: var(--text-gold);
                text-decoration: none;
                margin-bottom: 10px;
                border-radius: 5px;
                transition: all 0.3s;
                border: 1px solid transparent;
            }
            
            .dv-social-button-content a:hover {
                background: rgba(212, 175, 55, 0.1);
                border-color: var(--secondary-gold);
                transform: translateX(-3px);
            }
            
            .dv-social-button-content i {
                margin-right: 10px;
                font-size: 20px;
                color: var(--primary-gold);
                text-shadow: 0 0 5px rgba(212, 175, 55, 0.3);
            }
            
            .dv-social-button-content a span {
                font-size: 14px;
            }
            
            .user-support {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold)) !important;
                color: var(--dark-black);
                border-radius: 50%;
                width: 50px;
                height: 50px;
                display: flex;
                align-items: center;
                justify-content: center;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
                cursor: pointer;
                font-size: 22px;
                z-index: 1000;
                transition: all 0.3s ease;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }
            
            .user-support:hover {
                transform: scale(1.1);
                box-shadow: 0 6px 15px rgba(212, 175, 55, 0.4);
            }
            
            .alo-circle, .alo-circle-fill {
                animation-iteration-count: infinite;
                animation-duration: 1s;
                animation-fill-mode: both;
                width: 50px;
                height: 50px;
                top: -5px;
                right: -5px;
                position: absolute;
                border-radius: 100%;
                border: 2px solid var(--primary-gold);
                opacity: 0.5;
                background: var(--primary-gold);
            }
            
            .alo-circle-fill {
                width: 60px;
                height: 60px;
                top: -10px;
                right: -10px;
                opacity: 0.2;
            }
            
            @keyframes pulse {
                0% {transform: scale(0.95); opacity: 1;}
                70% {transform: scale(1.1); opacity: 0.7;}
                100% {transform: scale(0.95); opacity: 1;}
            }
            
            .alo-circle {
                animation-name: pulse;
            }
            
            .alo-circle-fill {
                animation-name: pulse;
            }
            
            /* Back to top button */
            .back-to-top {
                position: fixed;
                bottom: 20px;
                left: 20px;
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                width: 40px;
                height: 40px;
                border-radius: 50%;
                display: flex;
                align-items: center;
                justify-content: center;
                font-size: 18px;
                box-shadow: 0 4px 10px rgba(0, 0, 0, 0.3);
                cursor: pointer;
                opacity: 0;
                transition: all 0.3s;
                z-index: 999;
                border: 1px solid rgba(255, 255, 255, 0.2);
            }
            
            .back-to-top.show {
                opacity: 1;
            }
            
            .back-to-top:hover {
                transform: scale(1.1);
                box-shadow: 0 6px 15px rgba(212, 175, 55, 0.4);
            }

            /* Gold gradient text */
            .gold-text {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                -webkit-background-clip: text;
                -webkit-text-fill-color: transparent;
                text-shadow: none;
                font-weight: 700;
            }
        </style>
    </head>
    <body>
        <!-- Include Header -->
        <jsp:include page="header.jsp" />
        
        <div class="container mt-5">
            <div class="page-header">
                <h1 class="luxury-text">Contact Us & FAQ</h1>
                <p class="lead">Premium Support for MotoVibe Enthusiasts</p>
            </div>
            
            <div class="row">
                <!-- Contact Information -->
                <div class="col-lg-6">
                    <div class="contact-info">
                        <h3>Contact Information</h3>
                        
                        <div class="contact-item">
                            <i class="fa fa-map-marker"></i>
                            <span>600 Nguyễn Văn Cừ Nối Dài, An Bình, Bình Thủy, Cần Thơ 900000, Vietnam</span>
                        </div>
                        
                        <div class="contact-item">
                            <i class="fa fa-phone"></i>
                            <a href="tel:0817771184">0817 771 184</a>
                        </div>
                        
                        <div class="contact-item">
                            <i class="fa fa-envelope"></i>
                            <a href="mailto:support@motovibe.com">support@motovibe.com</a>
                        </div>
                        
                        <div class="contact-item">
                            <i class="fa fa-clock-o"></i>
                            <span>Monday - Saturday: 8:00 AM - 7:00 PM</span>
                        </div>
                        
                        <div class="contact-item">
                            <i class="fa fa-facebook"></i>
                            <a href="https://facebook.com/motovibe" target="_blank">facebook.com/motovibe</a>
                        </div>
                    </div>
                    
                    <!-- Google Map -->
                    <div class="map-section">
                        <div class="map-container">
                            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3929.0533542569992!2d105.72985667461548!3d10.012451790093584!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x31a0882139720a77%3A0x3916a227d0b95a64!2zVHLGsOG7nW5nIMSQ4bqhaSBo4buNYyBGUFQgQ-G6p24gVGjGoQ!5e0!3m2!1sen!2s!4v1743156143757!5m2!1sen!2s" 
                                width="100%" height="300" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
                        </div>
                    </div>
                </div>
                
                <!-- FAQ Section -->
                <div class="col-lg-6">
                    <div class="faq-section">
                        <h3>Frequently Asked Questions</h3>
                        
                        <!-- Account Related FAQs -->
                        <div class="faq-category">
                            <h4>Account & Registration</h4>
                            <div class="accordion" id="accountFaq">
                                <div class="card">
                                    <div class="card-header" id="accountQ1">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#accountA1" aria-expanded="true" aria-controls="accountA1">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                How do I create an account?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="accountA1" class="collapse" aria-labelledby="accountQ1" data-parent="#accountFaq">
                                        <div class="card-body">
                                            To create an account, click on the "Register" button in the top right corner of the website. 
                                            Fill in your email, password, name, phone number and address. 
                                            Your account will be created instantly and you can start browsing motorcycles.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="card">
                                    <div class="card-header" id="accountQ2">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#accountA2" aria-expanded="false" aria-controls="accountA2">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                I forgot my password. How can I reset it?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="accountA2" class="collapse" aria-labelledby="accountQ2" data-parent="#accountFaq">
                                        <div class="card-body">
                                            On the login page, click the "Forgot Password" link. Enter your email address, and we'll send you instructions to reset your password.
                                            If you still have issues, please contact our customer support.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Motorcycle Related FAQs -->
                        <div class="faq-category">
                            <h4>Motorcycles & Browsing</h4>
                            <div class="accordion" id="motorFaq">
                                <div class="card">
                                    <div class="card-header" id="motorQ1">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#motorA1" aria-expanded="true" aria-controls="motorA1">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                Can I schedule a test ride before purchasing?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="motorA1" class="collapse" aria-labelledby="motorQ1" data-parent="#motorFaq">
                                        <div class="card-body">
                                            Yes, we encourage test rides! You can schedule a test ride by visiting our "Book a Test Ride" 
                                            option in the chat assistant or by contacting our showroom directly. 
                                            Please bring your valid driving license on the day of the test ride.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="card">
                                    <div class="card-header" id="motorQ2">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#motorA2" aria-expanded="false" aria-controls="motorA2">
                                                <i class="fa fa-question-circle" style="color: var (--primary-gold); margin-right: 10px;"></i>
                                                Do you offer customization options for motorcycles?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="motorA2" class="collapse" aria-labelledby="motorQ2" data-parent="#motorFaq">
                                        <div class="card-body">
                                            Yes, we offer various customization options for most motorcycle models.
                                            You can discuss your specific requirements with our sales team,
                                            and they will guide you through available customization packages, accessories,
                                            and performance upgrades.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="card">
                                    <div class="card-header" id="motorQ3">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#motorA3" aria-expanded="false" aria-controls="motorA3">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                How do I know which motorcycle is right for me?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="motorA3" class="collapse" aria-labelledby="motorQ3" data-parent="#motorFaq">
                                        <div class="card-body">
                                            Our team can help you choose based on your experience level, intended use, and budget.
                                            We recommend visiting our showroom for personal advice, or you can use our online chat assistant
                                            to get recommendations. We also offer test rides to help you make an informed decision.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Order & Payment FAQs -->
                        <div class="faq-category">
                            <h4>Orders, Payment & Delivery</h4>
                            <div class="accordion" id="orderFaq">
                                <div class="card">
                                    <div class="card-header" id="orderQ1">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#orderA1" aria-expanded="true" aria-controls="orderA1">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                What payment methods do you accept?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="orderA1" class="collapse" aria-labelledby="orderQ1" data-parent="#orderFaq">
                                        <div class="card-body">
                                            We accept various payment methods including cash, bank transfer, credit/debit cards,
                                            and installment options through our partner banks. For specific payment details,
                                            please check with our sales team during the purchase process.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="card">
                                    <div class="card-header" id="orderQ2">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#orderA2" aria-expanded="false" aria-controls="orderA2">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                How long does delivery take after purchase?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="orderA2" class="collapse" aria-labelledby="orderQ2" data-parent="#orderFaq">
                                        <div class="card-body">
                                            For in-stock motorcycles, delivery can be arranged within 1-3 business days.
                                            For custom orders or models that need to be sourced, delivery times may vary from 2-6 weeks.
                                            You'll receive email updates at each stage of your order process.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="card">
                                    <div class="card-header" id="orderQ3">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#orderA3" aria-expanded="false" aria-controls="orderA3">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                Can I cancel or modify my order?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="orderA3" class="collapse" aria-labelledby="orderQ3" data-parent="#orderFaq">
                                        <div class="card-body">
                                            Order modifications or cancellations can be made before the deposit is confirmed.
                                            After deposit confirmation, cancellations may be subject to fees depending on the order status.
                                            Please contact our customer service as soon as possible if you need to make changes.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <!-- Warranty & Service FAQs -->
                        <div class="faq-category">
                            <h4>Warranty & After-Sales Service</h4>
                            <div class="accordion" id="warrantyFaq">
                                <div class="card">
                                    <div class="card-header" id="warrantyQ1">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link" type="button" data-toggle="collapse" data-target="#warrantyA1" aria-expanded="true" aria-controls="warrantyA1">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                What does your warranty cover?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="warrantyA1" class="collapse" aria-labelledby="warrantyQ1" data-parent="#warrantyFaq">
                                        <div class="card-body">
                                            Our standard warranty covers manufacturing defects for 12 months from the date of purchase.
                                            The Premium Protection Plan extends warranty to 36 months and includes additional coverage
                                            for engine, transmission, electrical systems, and selected wear items.
                                            Detailed warranty terms are provided with your purchase documents.
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="card">
                                    <div class="card-header" id="warrantyQ2">
                                        <h2 class="mb-0">
                                            <button class="btn btn-link collapsed" type="button" data-toggle="collapse" data-target="#warrantyA2" aria-expanded="false" aria-controls="warrantyA2">
                                                <i class="fa fa-question-circle" style="color: var(--primary-gold); margin-right: 10px;"></i>
                                                How do I schedule maintenance service?
                                            </button>
                                        </h2>
                                    </div>
                                    <div id="warrantyA2" class="collapse" aria-labelledby="warrantyQ2" data-parent="#warrantyFaq">
                                        <div class="card-body">
                                            You can schedule maintenance by calling our service center or using the online booking system
                                            in your customer account. We recommend following the manufacturer's recommended service intervals
                                            to maintain your warranty validity and ensure optimal performance.
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- Support Button -->
        <div class="dv-social-button">
            <div class="dv-social-button-content">
                <a href="tel:0817771184" class="hotline">
                    <i class="fa fa-phone"></i>
                    <span>Hotline: 0817 771 184</span>
                </a>
                
                <a href="https://facebook.com/motovibe" target="_blank" class="facebook">
                    <i class="fa fa-facebook"></i>
                    <span>Facebook Messenger</span>
                </a>
                
                <a href="http://zalo.me/0817771184" target="_blank" class="zalo">
                    <i class="fa fa-commenting-o"></i>
                    <span>Zalo: 0817 771 184</span>
                </a>
            </div>

            <!-- Main support button -->
            <a class="user-support">
                <i class="fa fa-user-circle-o"></i>
                <div class="animated alo-circle"></div>
                <div class="animated alo-circle-fill"></div>
            </a>
        </div>
        
        <!-- Back to top button -->
        <div class="back-to-top">
            <i class="fa fa-arrow-up"></i>
        </div>
        
        <!-- Include Footer -->
        <jsp:include page="footer.jsp" />
        
        <!-- Scripts -->
        <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        
        <script>
            document.addEventListener("DOMContentLoaded", function () {
                // Support button toggle
                var userSupport = document.querySelector('.user-support');
                var socialButtonContent = document.querySelector('.dv-social-button-content');

                userSupport.addEventListener("click", function (event) {
                    if (window.getComputedStyle(socialButtonContent).display === "none") {
                        socialButtonContent.style.display = "block";
                    } else {
                        socialButtonContent.style.display = "none";
                    }
                });
                
                // Back to top button
                var backToTopButton = document.querySelector('.back-to-top');
                
                window.addEventListener('scroll', function() {
                    if (window.pageYOffset > 300) {
                        backToTopButton.classList.add('show');
                    } else {
                        backToTopButton.classList.remove('show');
                    }
                });
                
                backToTopButton.addEventListener('click', function() {
                    window.scrollTo({
                        top: 0,
                        behavior: 'smooth'
                    });
                });
            });
        </script>
    </body>
</html>
