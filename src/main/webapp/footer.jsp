<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Footer</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }

            footer {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border-top: 2px solid var(--primary-gold);
                color: var(--text-gold);
                padding: 3rem 0;
                position: relative;
                box-shadow: 0 -10px 30px rgba(0, 0, 0, 0.2);
            }

            footer::before {
                content: '';
                position: absolute;
                top: 0;
                left: 0;
                right: 0;
                height: 1px;
                background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
            }

            .footer-heading {
                color: var(--primary-gold);
                font-size: 1.3rem;
                font-weight: 600;
                margin-bottom: 1.5rem;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                position: relative;
                padding-bottom: 0.5rem;
            }

            .footer-heading::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 0;
                width: 60px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .footer-social-icons a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 3rem;
                height: 3rem;
                border-radius: 50%;
                background: linear-gradient(145deg, #1a1a1a, #222);
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                margin: 0.5rem;
                transition: all 0.3s ease;
                box-shadow: 4px 4px 10px rgba(0, 0, 0, 0.3),
                           -4px -4px 10px rgba(255, 255, 255, 0.02);
            }

            .footer-social-icons a:hover {
                transform: translateY(-5px) scale(1.05);
                background: var(--primary-gold);
                color: var(--dark-black);
                box-shadow: 0 10px 20px rgba(212, 175, 55, 0.3);
            }

            .footer-list-item {
                margin-bottom: 1rem;
                transition: all 0.3s ease;
            }

            .footer-list-item a {
                color: var(--text-gold);
                text-decoration: none;
                transition: all 0.3s ease;
                position: relative;
                padding-left: 1.2rem;
            }

            .footer-list-item a::before {
                content: '›';
                position: absolute;
                left: 0;
                color: var(--primary-gold);
                transition: all 0.3s ease;
            }

            .footer-list-item a:hover {
                color: var(--primary-gold);
                transform: translateX(5px);
            }

            .footer-list-item a:hover::before {
                transform: translateX(3px);
            }

            .copyright-section {
                border-top: 1px solid rgba(212, 175, 55, 0.2);
                padding-top: 2rem;
                margin-top: 3rem;
                text-align: center;
                position: relative;
            }

            .copyright-section::before {
                content: '';
                position: absolute;
                top: -1px;
                left: 50%;
                transform: translateX(-50%);
                width: 50%;
                height: 1px;
                background: linear-gradient(90deg, transparent, var(--primary-gold), transparent);
            }

            /* Update existing media query */
            @media (max-width: 768px) {
                footer {
                    padding: 2rem 0;
                }

                .footer-section {
                    text-align: center;
                    margin-bottom: 2rem;
                }

                .footer-heading::after {
                    left: 50%;
                    transform: translateX(-50%);
                }
            }
        </style>
    </head>
    <body>
        <footer>
            <div class="container">
                <div class="row">
                    <div class="col-lg-4 footer-section">
                        <h4 class="footer-heading">About MotoVibe</h4>
                        <p>MotoVibe is your premier online destination for discovering and experiencing the world of motorbikes. We offer a wide selection of motorbikes, events, and services to fuel your passion for riding.</p>
                        <div class="footer-social-icons">
                            <a href="https://www.facebook.com/quochung.truong.1910" title="Facebook" target="_blank" rel="noopener"><i class="fab fa-facebook-f"></i></a>
                            <a href="https://x.com" title="Twitter" target="_blank" rel="noopener"><i class="fab fa-twitter"></i></a> 
                            <a href="https://www.instagram.com" title="Instagram" target="_blank" rel="noopener"><i class="fab fa-instagram"></i></a> 
                            <a href="https://www.linkedin.com/in/smokeyduck132" title="LinkedIn" target="_blank" rel="noopener"><i class="fab fa-linkedin"></i></a>
                            <a href="https://www.google.com/search?sca_esv=7ed8492f06ea75bb&q=fans&udm=2&fbs=ABzOT_AfCikcO6SgGMxZXxAG9tmS8rx53CbgOCSVg3O9Xo5xAK_RXi3VFy8QcDJV9F46BNVgXPVSNLh3EC8UATXqoQIBSA6FFNIPLMxYHHFRyE7wcmKutmRnya8dFuXrMKlslaMSg0PSD-RHrzxr5jD2xk4gJqbKjg8cuQm7NyLR-ch9tdhKN8ZBfmspljZBXQB0nbaLomPI1io-dTHEkKhfDGCJW_9usXtO9NhVLan8usNbMVE7ayw&sa=X&ved=2ahUKEwiTu8uN1N-LAxVqs1YBHSQwDT0QtKgLegQIDhAB&biw=2552&bih=936&dpr=1" title="OnlyFans" target="_blank" rel="noopener"><i class="fas fa-camera-video"></i></a> <!- Symbolic camera-video icon for OnlyFans -->
                        </div>
                    </div>
                    <div class="col-lg-4 footer-section">
                        <h4 class="footer-heading">Quick Links</h4>
                        <ul class="footer-list">
                            <li class="footer-list-item"><a href="index.jsp">Home</a></li>
                            <li class="footer-list-item"><a href="motorList">Motorbikes</a></li>
                            <li class="footer-list-item"><a href="listevents">Events</a></li>
                            <li class="footer-list-item"><a href="listAppointments">Appointments</a></li>
                            <li class="footer-list-item"><a href="#">Contact Us</a></li>
                            <li class="footer-list-item"><a href="PrivacyPolicy.jsp">Privacy Policy</a></li>
                            <li class="footer-list-item"><a href="TermsofService.jsp">Terms of Service</a></li>
                        </ul>
                    </div>
                    <div class="col-lg-4 footer-section">
                        <h4 class="footer-heading">Contact & Support</h4>
                        <ul class="footer-list">
                            <li class="footer-list-item">Email: <a href="mailto:motovibe132@gmail.com">support@motovibe.com</a></li>
                            <li class="footer-list-item">Phone: (+84) 81.777.1184</li>
                            <li class="footer-list-item">Address: Cần Thơ</li>
                        </ul>
                    </div>
                </div>
                <div class="copyright-section">
                    <p>&copy; 2025 MotoVibe. All Rights Reserved.</p>
                    <p class="text-muted">Ride with Confidence, Ride with MotoVibe.</p>
                </div>
            </div>
        </footer>
    </body>
</html>