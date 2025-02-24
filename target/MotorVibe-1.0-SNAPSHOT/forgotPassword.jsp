<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Forgot Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://kit.fontawesome.com/a611f8fd5b.js" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.4/dist/sweetalert2.all.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.4/dist/sweetalert2.min.css">
    <style>
        .container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            padding: 0;
        }
        .col-lg-6 {
            max-width: 400px;
        }
        .btn-dark {
            background-color: #050B20;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="col-lg-6">
            <a class="logo text-decoration-none" href="/"><h1 class="mb-3">Forgot Password</h1></a> 

            <form action="sendOtp" method="POST">
                <div class="mb-3">
                    <label for="email" class="form-label">Email address</label>
                    <input name="email" required type="email" class="form-control" id="email" placeholder="Enter your email">
                    <span id="emailError" class="text-danger"></span> <!-- Error message for invalid email -->
                </div>

                <div class="form-check mb-3">
                    <input required type="checkbox" class="form-check-input" id="agree" name="agreeBox">
                    <label class="form-check-label" for="agree">I agree to the <a href="/MotoVibe/Term" target="_blank">terms & policy</a></label>
                </div>

                <button type="submit" class="btn btn-dark w-100 mb-3" name="submit">Send OTP</button>

                <div class="text-center">
                    <p>Remember your password? <a href="/MotoVibe/login.jsp">Login</a></p>
                </div>
            </form>
        </div>
    </div>

    <script>
        function validateForm() {
            var email = document.getElementById("email").value;
            var emailError = document.getElementById("emailError");
            emailError.textContent = "";

            // Regular expression to check email format
            var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(email)) {
                emailError.textContent = "Invalid email format.";
                return false; // Prevent form submission
            }
            return true;
        }

        // Form submission prevention and validation
        document.querySelector("form").addEventListener("submit", function(event) {
            if (!validateForm()) {
                event.preventDefault();
            }
        });
    </script>
</body>
</html>
