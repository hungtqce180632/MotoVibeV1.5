<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Footer</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

        <style>
            /* css/style.css - Footer Styles (you can also put these in your style.css file) */
            footer {
                background-color: #222; /* Dark background for footer */
                color: #eee; /* Light grey text for better contrast on dark background */
                padding: 2rem 0; /* Increased vertical padding */
                margin-top: 5rem; /* Increased margin top to separate from content */
            }

            footer p {
                margin-bottom: 0.5rem; /* Spacing between footer paragraphs */
                font-size: 0.9rem; /* Slightly smaller font size for footer text */
            }

            footer a {
                color: #fff; /* White links in footer */
                text-decoration: none; /* Remove underlines from links */
                transition: color 0.2s ease-in-out; /* Smooth color transition on hover */
            }

            footer a:hover {
                color: #bbb; /* Slightly darker grey on link hover */
            }

            .footer-section {
                margin-bottom: 1.5rem; /* Spacing between footer sections */
            }

            .footer-heading {
                font-size: 1.1rem;
                font-weight: bold;
                color: #fff; /* White heading text */
                margin-bottom: 1rem;
                border-bottom: 1px solid rgba(255, 255, 255, 0.2); /* Subtle bottom border for headings */
                padding-bottom: 0.5rem;
            }

            .footer-list {
                list-style: none; /* Remove list bullets */
                padding-left: 0;
            }

            .footer-list-item {
                margin-bottom: 0.5rem;
            }

            .footer-social-icons a {
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 2.5rem;
                height: 2.5rem;
                border-radius: 50%; /* Circular social icons */
                background-color: rgba(255, 255, 255, 0.1); /* Subtle background for icons */
                color: #fff;
                font-size: 1.1rem;
                margin-right: 0.5rem;
                transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
            }

            .footer-social-icons a:hover {
                background-color: rgba(255, 255, 255, 0.3); /* Slightly brighter background on hover */
                color: #ddd;
            }

            .copyright-section {
                border-top: 1px solid rgba(255, 255, 255, 0.2); /* Subtle top border for copyright */
                padding-top: 1.5rem;
                margin-top: 2rem;
                text-align: center; /* Center align copyright text */
            }

            /* Responsive adjustments - optional for a basic footer, but good practice */
            @media (max-width: 768px) {
                footer {
                    padding: 1.5rem 0; /* Slightly reduced padding on smaller screens */
                    margin-top: 3rem; /* Adjust margin top on smaller screens */
                    text-align: center; /* Center align all text on smaller screens */
                }

                .footer-section {
                    margin-bottom: 1rem; /* Reduced section spacing on smaller screens */
                }

                .footer-heading {
                    font-size: 1rem; /* Slightly smaller headings on smaller screens */
                }

                .footer-social-icons {
                    text-align: center; /* Center social icons on smaller screens */
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