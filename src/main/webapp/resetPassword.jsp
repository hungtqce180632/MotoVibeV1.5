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
        <div class="container d-flex justify-content-center align-items-center flex-column">
            <!-- Logo / Title -->
            <a class="logo text-decoration-none mt-4" href="/">
                <h1>MotoVibe</h1>
            </a>

            <!-- Form Reset Password -->
            <div class="reset-password-form w-100">
                <h2 class="mb-4">Reset Password</h2>

                <!-- 
                  Form sẽ submit về "resetPassword" 
                  (bạn tự viết Servlet xử lý khi OTP đã verify). 
                  onsubmit gọi validateForm() => chặn submit nếu chưa verify OTP. 
                -->
                <form id="resetForm" action="resetPassword" method="POST" onsubmit="return validateForm()">

                    <!-- Email -->
                    <div class="mb-3">
                        <label for="email" class="form-label">Email address</label>
                        <input 
                            type="email" 
                            class="form-control" 
                            id="email"
                            name="emailTxt"
                            placeholder="Enter your email"
                            required
                            >
                        <span id="emailError" class="text-danger"></span>
                    </div>

                    <!-- Password mới -->
                    <div class="mb-3">
                        <label for="password" class="form-label">New Password</label>
                        <div class="input-group">
                            <input 
                                type="password"
                                class="form-control"
                                id="password"
                                name="pwdTxt"
                                placeholder="Enter your password"
                                required
                                >
                            <button 
                                type="button" 
                                class="btn btn-outline-dark" 
                                style="width: 50px;"
                                onclick="togglePassword()"
                                >
                                <i class="fa-solid fa-eye" id="icon"></i>
                            </button>
                        </div>
                        <small id="passwordError" class="text-danger"></small>
                    </div>

                    <!-- Confirm Password -->
                    <div class="mb-3">
                        <label for="confirmPassword" class="form-label">Confirm Password</label>
                        <input
                            type="password"
                            class="form-control"
                            id="confirmPassword"
                            name="confirmPassword"
                            placeholder="Re-type your password"
                            required
                            oninput="checkPasswordsMatch()"
                            >
                        <small id="confirmError" class="text-danger"></small>
                    </div>

                    <!-- OTP Section -->
                    <!-- Nút gửi OTP -->
                    <div class="mb-3 d-flex align-items-center">
                        <button 
                            type="button"
                            class="btn btn-outline-primary me-3"
                            id="sendOtpButton"
                            onclick="sendOtp()"
                            >
                            Send OTP
                        </button>
                        <p class="text-danger mb-0" id="otpWarning" style="display:none;">
                            Wait a moment before re-sending!
                        </p>
                    </div>

                    <!-- Nhập OTP -->
                    <div id="otpInput" class="mb-3" style="display: none;">
                        <label for="otp" class="form-label">Enter OTP</label>
                        <input 
                            type="text"
                            class="form-control mb-2"
                            id="otp"
                            name="otp"
                            placeholder="6-digit code"
                            >
                        <span id="otpError" class="text-danger"></span>
                        <button 
                            type="button"
                            class="btn btn-success mt-2"
                            onclick="verifyOtp()"
                            >
                            Verify OTP
                        </button>
                    </div>

                    <!-- Hiển thị khi verify OTP thành công -->
                    <p 
                        id="OTPSuccess"
                        class="text-success fw-bold mt-2"
                        style="display: none;"
                        >
                        OTP verified successfully!
                    </p>

                    <!-- Input ẩn lưu kết quả verify OTP -->
                    <input 
                        type="hidden"
                        id="verificationResult"
                        name="OTPResult"
                        value=""
                        >

                    <!-- Nút submit (đặt lại mật khẩu) -->
                    <button 
                        type="submit" 
                        class="btn btn-dark w-100 mt-3"
                        >
                        Confirm Reset
                    </button>

                    <!-- Nút quay lại Login (tuỳ ý) -->
                    <button 
                        type="button" 
                        class="btn btn-secondary w-100 mt-3"
                        onclick="redirectToLogin()"
                        >
                        Back to Login
                    </button>
                </form>
            </div>
        </div>
        <script>
            function validateForm() {
                // Kiểm tra OTP đã verify chưa
                var ver = document.getElementById("verificationResult").value;
                if (ver !== "Success") {
                    Swal.fire({
                        icon: 'warning',
                        title: 'OTP Required',
                        text: 'Please verify the OTP before resetting password.'
                    });
                    return false;
                }

                // Kiểm tra email
                var emailVal = document.getElementById("email").value.trim();
                var emailError = document.getElementById("emailError");
                emailError.textContent = "";
                var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                if (!emailRegex.test(emailVal)) {
                    emailError.textContent = "Invalid email format.";
                    return false;
                }

                // Kiểm tra password
                var passwordVal = document.getElementById("password").value.trim();
                var passwordError = document.getElementById("passwordError");
                passwordError.textContent = "";
                // Ví dụ: 6-32, có chữ hoa, số, ký tự đặc biệt
                var passRegex = /^(?=.*[A-Z])(?=.*\d)(?=.*[\W_])[A-Za-z\d\W_]{6,32}$/;
                if (!passRegex.test(passwordVal)) {
                    passwordError.textContent =
                            "Password must be 6-32 chars, uppercase, number & special char.";
                    return false;
                }

                // Kiểm tra confirm
                var confirmVal = document.getElementById("confirmPassword").value.trim();
                var confirmError = document.getElementById("confirmError");
                confirmError.textContent = "";
                if (passwordVal !== confirmVal) {
                    confirmError.textContent = "Passwords do not match.";
                    return false;
                }

                return true;
            }

            function sendOtp() {
                // Lấy email
                var emailVal = document.getElementById("email").value.trim();
                // Kiểm tra email
                if (!emailVal) {
                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'Please enter email before sending OTP.'
                    });
                    return;
                }

                // Gửi JSON
                $.ajax({
                    url: "sendOtp",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({email: emailVal}),
                    success: function (response) {
                        if (response.success) {
                            Swal.fire({
                                icon: 'success',
                                title: 'OTP Sent',
                                text: response.message
                            });
                            // Hiển thị ô nhập OTP
                            document.getElementById("otpInput").style.display = "block";
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Failed',
                                text: response.message || 'Send OTP failed.'
                            });
                        }
                    },
                    error: function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An error occurred sending OTP.'
                        });
                    }
                });
            }

            function verifyOtp() {
                var otpVal = document.getElementById("otp").value.trim();
                var otpError = document.getElementById("otpError");
                var verificationResult = document.getElementById("verificationResult");
                var otpSuccessMsg = document.getElementById("otpSuccessMsg");

                otpError.textContent = "";

                if (!otpVal) {
                    otpError.textContent = "Please enter the OTP.";
                    return;
                }

                $.ajax({
                    url: "verifyOtp",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    data: JSON.stringify({otp: otpVal}),
                    success: function (response) {
                        if (response.success) {
                            // OTP đúng
                            verificationResult.value = "Success";
                            otpSuccessMsg.style.display = "block";
                            Swal.fire({
                                icon: 'success',
                                title: 'OTP Verified',
                                text: response.message
                            });
                        } else {
                            Swal.fire({
                                icon: 'error',
                                title: 'Verification Failed',
                                text: response.message || 'OTP invalid or expired.'
                            });
                        }
                    },
                    error: function () {
                        Swal.fire({
                            icon: 'error',
                            title: 'Error',
                            text: 'An error occurred while verifying OTP.'
                        });
                    }
                });
            }
        </script>  
    </body>
</html>