<%-- 
    Document   : resetPWD
    Created on : 17 thg 2, 2025
    Author     : sang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- AE copy từ đây tới title nếu tạo jsp mới thêm các thể khác thì thêm trên <title> -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://kit.fontawesome.com/a611f8fd5b.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <link rel="stylesheet" type="text/css" href="css/font.css"/>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.5/dist/sweetalert2.all.min.js"></script>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.14.5/dist/sweetalert2.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <title>ResetPassword</title>
        <style>
            .logo {
                font-family: "Oswald", sans-serif;
                font-weight: 500;
                color: #050B20;
            }

            a:hover {
                color: inherit;
            }

            .btn-dark{
                background-color: #050B20;
            }
<<<<<<< HEAD

=======
            
>>>>>>> origin/main
            .container-fluid {
                height: 100vh;
            }

            .row {
                height: 100%;
            }

            .col-lg-6 {
                display: flex;
                justify-content: center;
                align-items: center;
            }

            .form-container {
                max-width: 400px;
                width: 100%;
            }

            .d-flex {
                display: flex;
            }

            .mb-3 {
                margin-bottom: 1rem;
            }

            /* Centering the form elements */
            .text-center {
                text-align: center;
            }

            .alert {
                display: none;
            }

            .alert.show {
                display: block;
            }

            .reset-password-form {
                background: var(--rich-black);
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 2rem;
                max-width: 500px;
                margin: 2rem auto;
            }
        </style>
    </head>
    <body>
        <script>
            function redirectToLogin() {
                window.location.href = "login.jsp";
            }
        </script>
        <script>
            function validateForm() {
                var OTPResult = document.getElementById('verificationResult').value; // Lấy giá trị của input hidden
                if (OTPResult !== 'Success') { // Kiểm tra nếu giá trị không phải 'Success'                 
                    var alertOTP = document.getElementById("alertOTP");

                    if (alertOTP) {
                        alertOTP.classList.remove('d-none'); // Hiển thị thông báo OTP
                        alertOTP.classList.add('d-block');
                    }
                    return false; // Ngăn form submit
                }

                console.log("Start validation form");
                var email = document.getElementById("email").value;
                var password = document.getElementById("password").value;
                var confirmPassword = document.getElementById("confirmPassword").value;
                var emailError = document.getElementById("emailError");
                var passwordError = document.getElementById("passwordError");
                var confirmError = document.getElementById("confirmError");

                // Reset thông báo lỗi
                emailError.textContent = "";
                passwordError.textContent = "";
                confirmError.textContent = "";

                // Kiểm tra định dạng email
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(email)) {
                    emailError.textContent = "Invalid email.";
                    event.preventDefault();
                    return false; // Ngăn form submit
                }

                // Kiểm tra mật khẩu
                var passwordRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{6,32}$/;
                if (!passwordRegex.test(password)) {
                    passwordError.textContent = "Password must be 6-32 characters, at least 1 uppercase letter, 1 number and 1 special character.";
                    event.preventDefault();
                    return false; // Ngăn form submit
                }

                // Kiểm tra khớp mật khẩu
                if (password !== confirmPassword) {
                    confirmError.textContent = "Passwords do not match.";
                    event.preventDefault();
                    return false; // Ngăn form submit
                }

                return true; // Cho phép submit nếu hợp lệ
            }

            function checkPasswordsMatch() {
                var password = document.getElementById('password').value;
                var confirmPassword = document.getElementById('confirmPassword').value;
                var confirmError = document.getElementById('confirmError');
                var resetBtn = document.querySelector("button[name='resetPWDBtn']");

                if (password !== confirmPassword) {
                    confirmError.textContent = "Passwords do not match.";
                    resetBtn.disabled = true; // Vô hiệu hóa nút khi mật khẩu không khớp
                } else {
                    confirmError.textContent = ""; // Xóa thông báo lỗi nếu mật khẩu khớp
                    resetBtn.disabled = false; // Kích hoạt lại nút nếu mật khẩu khớp
                }
            }

            function togglePassword() {
                var passwordField = document.getElementById("password");
                var icon = document.getElementById("icon");

                if (passwordField.type === "password") {
                    passwordField.type = "text";
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                } else {
                    passwordField.type = "password";
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }
            }

<<<<<<< HEAD
            function sendOtp() {
                var sendOtpButton = document.getElementById("sendOtpButton");
                var countdown = 60; // 1 minute countdown

                // Disable the Send OTP button
                sendOtpButton.disabled = true;

                // Show the countdown on the button
                sendOtpButton.innerText = `Wait ${countdown} seconds`;

                // Set up the countdown timer
                var interval = setInterval(function () {
                    countdown--;
                    sendOtpButton.innerText = `Wait ${countdown} seconds`;

                    // If countdown reaches zero, re-enable the button
                    if (countdown <= 0) {
                        clearInterval(interval);
                        sendOtpButton.disabled = false;
                        sendOtpButton.innerText = "Send OTP"; // Reset button text
                    }
                }, 1000); // Update every second

                // Send OTP request to the server (use your actual AJAX endpoint here)
                $.ajax({
                    type: "POST",
                    url: "sendOtp", // replace with your server-side logic
                    success: function (response) {
                        // Handle the server's response to OTP request
                        console.log(response);
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'OTP Sent',
                                text: 'An OTP has been sent to your email.'
                            });
                            document.getElementById("otpInput").style.display = "block"; // Show OTP input field
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'OTP Error',
                                text: 'Failed to send OTP. Please try again.'
                            });
                        }
                    },
                    error: function (xhr, status, error) {
                        console.log("Error:", error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An error occurred while sending OTP.'
                        });
                    }
                });
            }

            function verifyOtp() {
                var otp = document.getElementById("otp").value;
                var verificationResult = document.getElementById("verificationResult");

                $.ajax({
                    type: "POST",
                    url: "verifyOtp", // replace with your verification endpoint
                    data: {otp: otp},
                    success: function (response) {
                        if (response.success) {
                            verificationResult.value = "Success";
                            Swal.fire({
                                icon: 'success',
                                title: 'OTP Verified',
                                text: 'OTP verification successful.'
                            });
                            document.getElementById("OTPSuccess").style.display = "block";
                            document.getElementById("loginBtn").disabled = false; // Enable Login button
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Verification Failed',
                                text: 'The OTP entered is incorrect or expired. Please try again.'
=======
            function verifyOtp() {
                const otp = $('#otp').val();
                $.ajax({
                    type: "POST",
                    url: "/VerifyOtpServlet",
                    data: {otp: otp},
                    success: function (response) {
                        if (response === true) {
                            $('#verificationResult').val('Success');
                            $('#otpInput').hide();
                            $('#OTPSuccess').css('display', 'block');
                            $('#loginBtn').prop('disabled', false); // Bật lại nút Login
                            Swal.fire({
                                icon: 'success',
                                title: 'Authentication successful',
                                text: 'OTP verified successfully!'
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Authentication failed',
                                text: 'OTP is incorrect or expired. Please try again.'
>>>>>>> origin/main
                            });
                        }
                    },
                    error: function (xhr, status, error) {
<<<<<<< HEAD
                        console.log("Error:", error);
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An error occurred during OTP verification.'
                        });
=======
                        alert("Lỗi: " + error);
>>>>>>> origin/main
                    }
                });
            }

            function disableButtonWithCountdown() {
                var sendOtpButton = document.getElementById("sendOtpButton");
                var otpSend = document.getElementById("otpSend");
                var alertOTP = document.getElementById("alertOTP");
                var countdown = 60;

                // Vô hiệu hóa nút
                sendOtpButton.disabled = true;

                // Cập nhật nội dung nút với thời gian đếm ngược
                sendOtpButton.innerText = "Wait " + countdown + " second";

                // Tạo bộ đếm ngược
                var interval = setInterval(function () {
                    countdown--;
                    sendOtpButton.innerText = "Wait " + countdown + " second";

                    // Kiểm tra nếu otpSend không có class mb-3 thì dừng bộ đếm                    
                    if (!otpSend.classList.contains('mb-3') || !alertOTP.classList.contains('d-none')) {
                        clearInterval(interval);
                        sendOtpButton.disabled = false;
                        sendOtpButton.innerText = "Send OTP";
                        return; // Thoát khỏi hàm
                    }

                    // Khi hết 60 giây, kích hoạt lại nút
                    if (countdown <= 0) {
                        clearInterval(interval);
                        sendOtpButton.disabled = false;
                        sendOtpButton.innerText = "Send OTP";
                    }
                }, 1000); // Cập nhật mỗi giây
            }

            function checkPasswords() {
                var password = document.getElementById('password').value;
                var confirmPassword = document.getElementById('confirmPassword').value;
                var confirmError = document.getElementById('confirmError');

                if (password !== confirmPassword) {
                    confirmError.textContent = "Passwords do not match.";
                } else {
                    confirmError.textContent = ""; // Xóa thông báo lỗi nếu mật khẩu khớp
                }
            }
            function showNoti() {
                document.getElementById('notificationOtp').removeAttribute('hidden');
            }

            function offNoti() {
                document.getElementById('notificationOtp').hidden;
            }
        </script>       

        <div class="container-fluid">
            <div class="row">
                <div class="col-lg-6 d-flex justify-content-center align-items-center">
                    <div class="form-container reset-password-form">
                        <a class="logo text-decoration-none" href="/"><h1 class="mb-5">MotoVibe</h1></a>   
                        <div class="alert alert-warning d-none" id="alertOTP">Please verify OTP.</div>
                        <c:if test="${not empty message}">
                            <div class="alert alert-warning">${message}</div>
                        </c:if>
                        <%
                            session.removeAttribute("message");
                        %>
                        <h2 class="mb-3">Reset Password</h2>
                        <form onsubmit="return validateForm()" action="ResetPasswordServlet" method="POST">
                            <div class="form-group mb-3">
                                <label for="email" class="form-label">Email address</label>
                                <input name="emailTxt" required type="email" class="form-control" id="email" placeholder="Enter your email">
                                <span id="emailError" class="text-danger"></span> <!-- Thêm thẻ này để hiển thị lỗi -->
                            </div>
                            <label for="password" class="form-label">New Password</label>
                            <div class="mb-3 d-flex form-group">
                                <input required type="password" class="form-control" id="password" name="pwdTxt" placeholder="Enter your password">
                                <button type="button" class="form-control btn btn-outline-dark" id="showPassword" onclick="togglePassword()" style="width: 50px;">
                                    <i class="fa-solid fa-eye p-0 m-0" id="icon"></i>                                    
                                </button>                               
                            </div>
                            <span id="passwordError" class="text-danger mb-3"></span> <!-- Thêm thẻ này để hiển thị lỗi -->                           

                            <div class="form-group mb-3">
                                <label for="confirmPassword">Confirm Password:</label>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required oninput="checkPasswordsMatch()">
                                <small id="confirmError" class="text-danger"></small>
                            </div>

<<<<<<< HEAD
                            <!-- Start OTP Section -->
                            <div class="alert alert-warning alert-dismissible fade d-none" role="alert" id="alertOTP">
                                Please verify OTP before resetting your password.
                                <button type="button" class="btn-close" aria-label="Close" onclick="hideAlert()"></button>
                            </div>
                            <!-- Send OTP Section -->
                            <div class="d-flex mb-3 align-items-center" id="otpSend">
                                <button type="button" class="btn btn-outline-primary me-3" id="sendOtpButton" onclick="sendOtp();">Send OTP</button>
                                <p class="text-danger" hidden id="notificationOtp">Please wait a few seconds before sending another OTP.</p>
                            </div>
                            <!-- OTP Input Section -->
                            <div id="otpInput" style="display: none;" class="mb-3">
                                <label for="otp" class="form-label">Enter OTP</label>
                                <div class="mb-2">
                                    <input type="text" class="form-control" id="otp" name="otp" required>
                                </div>
                                <button type="button" class="btn btn-success" onclick="verifyOtp()">Verify OTP</button>
                            </div>
                            <!-- OTP Success Notification -->
                            <p style="display: none;" class="text-success mb-3 fw-bold" id="OTPSuccess">OTP authentication successful!</p>

                            <input hidden id="verificationResult" class="mt-3" name="OTPResult" value=""/>
                            <!-- End OTP Section -->
=======
                            <!-- Bắt đầu phần OTP -->
                            <div class="alert alert-warning alert-dismissible fade d-none show" role="alert" id="alertOTP">
                                You should enter your email.
                                <button type="button" class="btn-close" aria-label="Close" onclick="hideAlert()"></button>
                            </div>
                            <div class="d-flex mb-3 align-items-center" id="otpSend">
                                <button type="button" class="btn btn-outline-primary me-3" id="sendOtpButton" onclick="sendOtp();">Send OTP</button>
                                <p class="text-danger" hidden id="notificationOtp">Please wait a few seconds.</p>
                            </div>
                            <div id="otpInput" style="display: none;" class="mb-3">
                                <label for="otp" class="form-label">Enter your code</label>
                                <div class="mb-2">
                                    <input type="text" class="form-control" id="otp" name="otp" required>
                                </div>
                                <button type="button" class="btn btn-success" onclick="verifyOtp()">Verification</button>
                            </div>
                            <p style="display: none;" class="text-success mb-3 fw-bold" id="OTPSuccess">OTP authentication successful!</p>
                            <input hidden id="verificationResult" class="mt-3" name="OTPResult" value=""/>
                            <!-- Kết thúc phần OTP -->
>>>>>>> origin/main

                            <button type="button" class="btn btn-dark" id="loginBtn" disabled onclick="redirectToLogin()">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>