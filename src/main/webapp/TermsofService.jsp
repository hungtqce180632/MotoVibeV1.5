<%-- 
    Document   : TermsofService
    Created on : Feb 26, 2025, 3:15:06 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Terms of Service - MotoVibe</title> <!- Title for Terms of Service -->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <style>
            /* css/style.css - Terms of Service with Bulb Decoration Styles (reusing styles from PrivacyPolicy.jsp) */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            html {
                width: 100%;
                height: 100%;
            }

            body {
                background-color: black;
                width: 100%;
                height: 100%;
                display: flex;
                justify-content: center;
                align-items: center;
                flex-direction: column;
                color: #eee;
                font-family: 'Arial', sans-serif;
            }

            .boss {
                margin-top: 20px;
                position: relative;
                display: flex;
                flex-direction: column;
                align-items: center;
            }

            #bulb {
                width: 130px;
                height: 130px;
                border-radius: 50%;
                background-color: grey;
                border: 2px solid rgb(61, 61, 61);
                position: relative;
                z-index: 2;
            }

            button {
                position: relative;
                padding: 15px 20px;
                margin-top: 20px;
                background-color: silver;
                font-size: 1.1rem;
                border: 2px solid gray;
                cursor: pointer;
                border-bottom-left-radius: 15px;
                border-bottom-right-radius: 15px;
                z-index: 2;
            }

            .btn-end {
                margin-top: 30px;
                height: 11px;
                width: 18px;
                border-bottom-left-radius: 8px;
                border-bottom-right-radius: 8px;
                background-color: rgb(63, 63, 61);
                position: relative;
                z-index: 2;
            }

            /* Text Decoration around the Bulb */
            .text-decoration {
                position: absolute;
                color: #fff;
                font-weight: bold;
                text-shadow: 2px 2px 4px #000;
                z-index: 1;
                pointer-events: none;
            }

            #moto-vibe-text {
                top: -50px;
                font-size: 2.2rem;
            }

            #terms-of-service-text {
                bottom: -60px; /* Adjusted ID and text */
                font-size: 1.8rem;
            }

            #tagline-text {
                top: 10px;
                left: -160px;
                width: 150px;
                text-align: right;
                font-size: 1rem;
                font-weight: normal;
                text-shadow: 1px 1px 2px #000;
            }

            #website-link-text {
                bottom: 20px;
                right: -180px;
                width: 170px;
                text-align: left;
                font-size: 1rem;
                font-weight: normal;
                text-shadow: 1px 1px 2px #000;
            }

            /* Content Container for Terms of Service Text (Below Bulb Design) */
            .terms-of-service-content { /* Updated class name */
                background-color: #111;
                color: #ddd;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 0 15px rgba(255, 255, 255, 0.08);
                max-width: 960px;
                margin-top: 80px;
                margin-bottom: 40px;
            }

            .terms-of-service-content h1, .terms-of-service-content h2, .terms-of-service-content h3 {
                color: #fff;
                border-bottom-color: #fff;
            }

            .terms-of-service-content p {
                color: #ddd;
            }

            .tos-container {
                /* Additional styling for terms page */
            }

        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <div class="boss">
            <span id="moto-vibe-text" class="text-decoration">MotoVibe</span>
            <span id="tagline-text" class="text-decoration">Ride with Confidence, <br/> Ride with MotoVibe</span>
            <div class="btn-end"></div>
            <button>ON</button>
            <div id="bulb"></div>
            <span id="terms-of-service-text" class="text-decoration">Terms of Service</span> <!- Updated Text Decoration Text -->
            <span id="website-link-text" class="text-decoration"><a href="home" style="color: #ddd; text-decoration: none;">www.motovibe.com</a></span>
        </div>

        <div class="terms-of-service-content container my-5 tos-container"> <!- Updated class name -->
            <h1 class="text-center mb-4" style="color: var(--primary-gold);">Terms of Service</h1> <!- Updated Heading -->

            <p><strong>Last Updated:</strong> [Insert Date of Last Update]</p>

            <h2>1. Acceptance of Terms</h2>
            <p>By accessing and using the MotoVibe website and services (collectively, the "Services"), you agree to be bound by these Terms of Service ("Terms"). If you do not agree to these Terms, please do not use our Services.</p>

            <h2>2. Use of Services</h2>
            <p>Our Services are provided for your personal and non-commercial use. You may use our Services for lawful purposes only and in accordance with these Terms and all applicable laws and regulations.</p>
            <ul>
                <li>You must be at least [Insert Minimum Age, e.g., 18] years of age to use certain features of our Services, such as making appointments or registering for events.</li>
                <li>You agree not to use our Services in any way that could damage, disable, overburden, or impair our servers or networks, or interfere with any other party's use and enjoyment of our Services.</li>
                <li>You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account.</li>
            </ul>

            <h2>3. User Content</h2>
            <p>Users may be permitted to post, upload, publish, submit, or transmit content and materials through our Services ("User Content"). You retain ownership of your User Content. However, by providing User Content to us, you grant us a worldwide, non-exclusive, royalty-free, transferable, sublicensable license to use, copy, modify, create derivative works, distribute, publicly display, publicly perform, and otherwise exploit in any manner such User Content in all formats and distribution channels now known or hereafter devised (including in connection with the Services and our business and on third-party sites and services), without further notice to or consent from you, and without the requirement of payment to you or any other person or entity.</p>
            <p>You represent and warrant that:</p>
            <ul>
                <li>You either are the sole and exclusive owner of all User Content or you have all rights, licenses, consents, releases, and permissions to grant to us the rights in such User Content, as contemplated under these Terms.</li>
                <li>Neither the User Content, nor your posting, uploading, publication, submission, or transmittal of the User Content or our use of the User Content (or any portion thereof) will infringe, misappropriate, or violate a third party’s patent, copyright, trademark, trade secret, moral rights, or other proprietary or intellectual property rights, or rights of publicity or privacy, or result in the violation of any applicable law or regulation.</li>
            </ul>

            <h2>4. Intellectual Property</h2>
            <p>The Services and their original content (excluding User Content), features, and functionality are owned by [Your Company Name] and are protected by international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.</p>

            <h2>5. Disclaimer of Warranties</h2>
            <p>THE SERVICES ARE PROVIDED ON AN "AS IS" AND "AS AVAILABLE" BASIS. WE DISCLAIM ALL WARRANTIES OF ANY KIND, WHETHER EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, AND NON-INFRINGEMENT. WE MAKE NO WARRANTY THAT THE SERVICES WILL MEET YOUR REQUIREMENTS, OR THAT THE SERVICES WILL BE UNINTERRUPTED, TIMELY, SECURE, OR ERROR-FREE.</p>

            <h2>6. Limitation of Liability</h2>
            <p>TO THE FULLEST EXTENT PERMITTED BY APPLICABLE LAW, IN NO EVENT SHALL [YOUR COMPANY NAME], NOR ITS AFFILIATES, DIRECTORS, EMPLOYEES, PARTNERS, AGENTS, SUPPLIERS, OR LICENSORS, BE LIABLE FOR ANY INDIRECT, INCIDENTAL, SPECIAL, CONSEQUENTIAL OR PUNITIVE DAMAGES, INCLUDING WITHOUT LIMITATION, LOSS OF PROFITS, DATA, USE, GOODWILL, OR OTHER INTANGIBLE LOSSES, RESULTING FROM (I) YOUR ACCESS TO OR USE OF OR INABILITY TO ACCESS OR USE THE SERVICES; (II) ANY CONDUCT OR CONTENT OF ANY THIRD PARTY ON THE SERVICES; (III) ANY CONTENT OBTAINED FROM THE SERVICES; AND (IV) UNAUTHORIZED ACCESS, USE OR ALTERATION OF YOUR TRANSMISSIONS OR CONTENT, WHETHER BASED ON WARRANTY, CONTRACT, TORT (INCLUDING NEGLIGENCE) OR ANY OTHER LEGAL THEORY, WHETHER OR NOT WE HAVE BEEN INFORMED OF THE POSSIBILITY OF SUCH DAMAGE, AND EVEN IF A REMEDY SET FORTH HEREIN IS FOUND TO HAVE FAILED OF ITS ESSENTIAL PURPOSE.</p>

            <h2>7. Governing Law</h2>
            <p>These Terms shall be governed and construed in accordance with the laws of [Your Country/State], without regard to its conflict of law provisions.</p>

            <h2>8. Changes to Terms of Service</h2>
            <p>We reserve the right to modify or replace these Terms at any time. If a revision is material, we will provide at least [Insert Number, e.g., 30] days' notice prior to any new terms taking effect. What constitutes a material change will be determined at our sole discretion. By continuing to access or use our Services after those revisions become effective, you agree to be bound by the revised terms. If you do not agree to the new terms, please stop using the Services.</p>

            <h2>9. Contact Us</h2>
            <p>If you have any questions about these Terms, please contact us at:</p>
            <p>[Your Company Name]<br>
                [Your Company Address - Optional]<br>
                Email: <a href="mailto:[Contact Email]">[Contact Email]</a></p>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

        <script>
            var bulb = document.querySelector("#bulb");
            var switchButton = document.querySelector("button")
            var current = 0;

            switchButton.addEventListener("click", () => {
                if (current == 0) {
                    switchButton.innerHTML = "OFF",
                            switchButton.style.padding = "15px 15.5px"
                    bulb.style.backgroundColor = "yellow"
                    document.querySelector('body').style.backgroundColor = "rgb(250, 252, 234)";
                    current = 1;
                } else {
                    switchButton.innerHTML = "ON",
                            switchButton.style.padding = "15px 20px"
                    bulb.style.backgroundColor = "grey"
                    document.querySelector('body').style.backgroundColor = "black";
                    current = 0;
                }
            })
        </script>
    </body>
</html>
