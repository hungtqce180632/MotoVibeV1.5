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
                <form id="resetForm" action="sendOtp" method="POST" onsubmit="return validateForm()">

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
                        <button type="button" class="btn btn-success" onclick="verifyOtp()">
                            Verify OTP
                        </button>
                    </div>

                    <!-- Thông báo success OTP -->
                    <p 
                        id="OTPSuccess"
                        class="text-success fw-bold mt-2"
                        style="display: none;"
                        >
                        OTP verified successfully!
                    </p>

                    <!-- Hidden input lưu kết quả verify OTP -->
                    <input 
                        type="hidden" 
                        id="verificationResult" 
                        name="OTPResult"
                        value=""
                        />

                    <!-- 
                       Nút Submit form (đặt lại password).
                       Sẽ bị chặn nếu OTPResult != "Success". 
                    -->
                    <button 
                        type="submit" 
                        class="btn btn-dark w-100 mt-3"
                        >
                        Confirm Reset
                    </button>
                </form>

                <!-- Nút quay lại Login (tuỳ ý) -->
                <button 
                    type="button" 
                    class="btn btn-secondary w-100 mt-3"
                    onclick="redirectToLogin()"
                    >
                    Back to Login
                </button>
            </div>
        </div>
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

            $(document).ready(function () {
                $("#emailForm").submit(function (event) {
                    event.preventDefault();
                    $("#emailError").text("");    // clear lỗi cũ

                    // Lấy giá trị email
                    let emailVal = $("#email").val().trim();

                    // Kiểm tra email tối thiểu ở client (nếu cần)
                    if (!emailVal) {
                        $("#emailError").text("Vui lòng nhập email.");
                        return;
                    }

                    // AJAX gửi JSON { "email": emailVal } đến /sendOtp
                    $.ajax({
                        url: "sendOtp",
                        type: "POST",
                        contentType: "application/json; charset=utf-8", // Gửi dạng JSON
                        dataType: "json", // Kỳ vọng nhận JSON
                        data: JSON.stringify({email: emailVal}),
                        success: function (response) {
                            // response = { success: true/false, message: "..." }
                            if (response.success) {
                                // Hiển thị form OTP
                                $("#emailForm").hide();
                                $("#otpForm").show();

                                // Thông báo
                                Swal.fire({
                                    icon: "success",
                                    title: "OTP sent",
                                    text: response.message || "OTP has been sent to your email."
                                });
                            } else {
                                // Nếu success = false
                                Swal.fire({
                                    icon: "error",
                                    title: "Failed",
                                    text: response.message || "Send OTP failed."
                                });
                            }
                        },
                        error: function () {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                text: "Có lỗi xảy ra khi gửi OTP. Vui lòng thử lại."
                            });
                        }
                    });
                });


                $("#otpForm").submit(function (event) {
                    event.preventDefault();
                    $("#otpError").text("");

                    let otpVal = $("#otp").val().trim();
                    if (!otpVal) {
                        $("#otpError").text("Vui lòng nhập OTP.");
                        return;
                    }

                    // Gửi JSON { "otp": otpVal } đến /verifyOtp
                    $.ajax({
                        url: "verifyOtp",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        data: JSON.stringify({otp: otpVal}),
                        success: function (response) {
                            // { success: true/false, message: "..." }
                            if (response.success) {
                                Swal.fire({
                                    icon: "success",
                                    title: "Verified",
                                    text: response.message || "OTP verified successfully."
                                }).then(() => {
                                    // Thông thường, sau khi xác thực, bạn có thể chuyển sang trang reset password
                                    // Hoặc hiển thị form đặt lại mật khẩu 
                                    // Ở đây tạm ẩn OTP form & in ra msg
                                    $("#otpForm").hide();
                                    $("#messageArea").html(
                                            '<div class="alert alert-success">OTP xác thực thành công! Hãy tiếp tục...</div>'
                                            );
                                });
                            } else {
                                Swal.fire({
                                    icon: "error",
                                    title: "Failed",
                                    text: response.message || "OTP is invalid or expired."
                                });
                            }
                        },
                        error: function () {
                            Swal.fire({
                                icon: "error",
                                title: "Error",
                                text: "Có lỗi xảy ra khi xác thực OTP. Vui lòng thử lại."
                            });
                        }
                    });
                });
            });

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
    </body>
</html>