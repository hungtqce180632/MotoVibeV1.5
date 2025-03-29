<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Edit Employee Account</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 1.5rem;
                position: relative;
            }
            h2::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            .form-label {
                color: var(--primary-gold);
                font-weight: 500;
                letter-spacing: 1px;
            }
            .form-control, .form-select {
                background-color: var(--rich-black);
                border: 1px solid var(--secondary-gold);
                color: white;
            }
            .form-control:focus, .form-select:focus {
                background-color: var(--rich-black);
                border-color: var(--primary-gold);
                box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.25);
                color: white;
            }
            form {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                padding: 2rem;
                border-radius: 10px;
                border: 1px solid var(--primary-gold);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                max-width: 800px;
                margin: 0 auto;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>
        <div class="container mt-5 pt-5">
            <div class="form-container">
                <h2 class="text-center mb-4"><i class="fas fa-user-edit me-2"></i>Edit Employee Account</h2>
                <form action="editEmployee" method="post" class="needs-validation">
                    <input type="hidden" name="userId" value="${user.userId}">
                    <div class="mb-3">
                        <label class="form-label">Email</label>
                        <input type="email" class="form-control" name="email" value="${user.email}" required>
                    </div>
                    <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input type="password" class="form-control" name="password" required>
                        </div>
                    <div class="mb-3">
                        <label class="form-label">Full Name</label>
                        <input type="text" class="form-control" name="name" value="${emp.name}" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Phone Number</label>
                       <input type="text" class="form-control" name="phoneNumber" value="${emp.phoneNumber}" pattern="^(0|\+84)[3-9][0-9]{8}$" required>
                    </div>
                    <div class="text-center">
                        <a href="accountManagement?listOf=emp" class="btn btn-secondary me-2">
                            <i class="fas fa-times me-1"></i> Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i> Save Changes
                        </button>
                    </div>
                </form>
            </div>
            <c:if test="${isSuccess eq '1'}">
                <div style="border: 3px solid green; border-radius: 20px; display: flex; align-items: center; justify-content: center;">
                    <p style="color: green; margin: 0; font-size: 20px;">UPDATE SUCCESS</p>
                </div>
            </c:if>
            <c:if test="${isSuccess eq '0'}">
                <div style="border: 3px solid red; border-radius: 20px; display: flex; align-items: center; justify-content: center;">
                    <p style="color: red; margin: 0; font-size: 20px;">EMAIL WAS USED!</p>
                </div>
            </c:if>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
