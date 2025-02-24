<%-- 
    Document   : login
    Created on : Feb 21, 2025
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Login</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            .logo {
                font-family: "Oswald", sans-serif;
                font-weight: 500;
                color: #050B20;
            }
            a:hover {
                color: inherit; /* Giữ nguyên màu */
            }
            .btn-dark {
                background-color: #050B20;
            }
            .container-fluid {
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                padding: 0;
            }

            .row {
                display: flex;
                justify-content: center;
                align-items: center;
                width: 100%;
            }

            .col-lg-6 {
                max-width: 400px; /* Set a max width to the form */
                width: 100%;
                margin: 0 auto; /* Center the form horizontally */
            }
        </style>
    </head>
    <body>
        <div class="container-fluid vh-100">
            <div class="row h-100">
                <div class="col-lg-6 d-flex justify-content-center align-items-center">                     
                    <div class="w-100" style="max-width: 400px;">
                        <a class="logo text-decoration-none" href="/"><h1 class="mb-5">MotoVibe</h1></a>   
                        <h2 class="fw-bold">Welcome back!</h2>
                        <%-- Hiển thị lỗi nếu có --%>
                        <c:if test="${not empty error}">
                            <div class="alert alert-danger">${error}</div>
                        </c:if>

                        <form action="login" method="post">
                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" class="form-control" name="email" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input type="password" class="form-control" name="password" required>
                            </div>
                            <div class="text-center mt-3">
                                <a href="/MotoVibe/forgotPassword.jsp">Forgot password?</a>
                            </div>

                            <button type="submit" class="btn btn-primary w-100">Login</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
