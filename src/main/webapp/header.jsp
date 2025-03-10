<%-- 
    Document   : header
    Created on : Feb 23, 2025, 4:11:08 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">


        <link rel="stylesheet" href="css/luxury-theme.css">
        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
            }

            header {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
            }

            .navbar {
                padding: 1rem 0;
                box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
                backdrop-filter: blur(10px);
                border-bottom: 1px solid var(--primary-gold);
            }

            .navbar-brand {
                color: var(--primary-gold) !important;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3),
                    0 0 10px rgba(212, 175, 55, 0.3);
                font-size: 1.8rem;
                position: relative;
                transition: all 0.3s ease;
                font-weight: 700;
                letter-spacing: 1px;
            }

            .navbar-brand:hover {
                color: var(--secondary-gold) !important;
                transform: translateY(-2px);
                text-shadow: 0 0 15px rgba(212, 175, 55, 0.5);
            }

            /* Enhanced nav links with gold hover effect */
            .navbar-nav .nav-link {
                color: #fff !important;
                padding: 0.7rem 1.2rem;
                position: relative;
                transition: all 0.3s ease;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
                font-weight: 500;
            }

            .navbar-nav .nav-link::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                width: 0;
                height: 2px;
                background: var(--primary-gold);
                transition: all 0.3s ease;
                transform: translateX(-50%);
                box-shadow: 0 0 5px var(--primary-gold);
                opacity: 0;
            }

            .navbar-nav .nav-link:hover::after,
            .navbar-nav .nav-link.active::after {
                width: 70%;
                opacity: 1;
            }

            .navbar-nav .nav-link:hover,
            .navbar-nav .nav-link.active {
                color: var(--primary-gold) !important;
                transform: translateY(-2px);
            }

            /* Add a glow to icons */
            .navbar-nav .nav-link i {
                margin-right: 5px;
                transition: all 0.3s ease;
            }

            .navbar-nav .nav-link:hover i {
                text-shadow: 0 0 10px var(--primary-gold);
            }

            /* Enhanced dropdown menu */
            .dropdown-menu {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
            }

            .dropdown-item {
                color: var(--text-gold);
                transition: all 0.3s ease;
            }

            .dropdown-item:hover,
            .dropdown-item:focus {
                background: rgba(212, 175, 55, 0.1);
                color: var(--primary-gold);
                transform: translateX(5px);
            }

            /* Enhanced toggler button */
            .navbar-toggler {
                border: 1px solid var(--primary-gold) !important;
                padding: 0.5rem;
                transition: all 0.3s ease;
                position: relative;
                overflow: hidden;
            }

            .navbar-toggler:hover {
                background: rgba(212, 175, 55, 0.1);
                box-shadow: 0 0 15px rgba(212, 175, 55, 0.3);
            }

            .navbar-toggler:after {
                content: '';
                position: absolute;
                top: 0;
                left: -100%;
                width: 100%;
                height: 100%;
                background: rgba(212, 175, 55, 0.2);
                transition: all 0.5s ease;
            }

            .navbar-toggler:hover:after {
                left: 100%;
            }

            .navbar-toggler-icon {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' width='30' height='30' viewBox='0 0 30 30'%3e%3cpath stroke='%23D4AF37' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e") !important;
            }

            /* Update existing media query styles */
            @media (max-width: 768px) {
                .navbar-brand {
                    font-size: 1.5rem !important;
                }

                .navbar-nav .nav-link {
                    text-align: center;
                    margin: 0.3rem 0;
                }

                .navbar-collapse {
                    background: rgba(0, 0, 0, 0.95);
                    border-radius: 10px;
                    padding: 1rem;
                    margin-top: 1rem;
                }
            }





            @keyframes slide-out {
                from {
                    transform: translateX(-28%);
                }
                to {
                    transform: translateX(27%);
                }
            }

            /* Định nghĩa animation cho phần tử đầu tiên */
            .collapse {
   
                animation:
                    /*3s linear 1s slide-in infinite alternate,  animation đầu tiên chạy qua lại liên tục */
                    3s ease-out 5s slide-out infinite alternate; /* animation thứ hai chạy qua lại liên tục */
            }

        </style>
    </head>
    <body>
        <header>
            <nav class="navbar navbar-expand-lg navbar-dark bg-dark shadow-sm fixed-top">
                <div class="container-fluid d-flex justify-content-between align-items-center">
                    <a class="navbar-brand fw-bold fa-solid fa-motorcycle" href="index.jsp" style="font-size: 1.7rem;">MotoVibe</a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav"
                            aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse justify-content-center" id="navbarNav">
                        <ul class="navbar-nav">
                            <li class="nav-item">
                                <a class="nav-link active" aria-current="page" href="index.jsp"><i class="fas fa-home me-1"></i> Home</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="motorList"><i class="fas fa-motorcycle me-1"></i> Motorbikes</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="listevents"><i class="fas fa-calendar-alt me-1"></i> Events</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="listAppointments"><i class="fas fa-calendar-check me-1"></i> Appointments</a>
                            </li>
                            <c:if test="${sessionScope.user.role == 'admin'}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fa fa-cog fa-spin fa-1x fa-fw" aria-hidden="true"></i> Admin Tools
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="adminDropdown">
                                        <li><a class="dropdown-item" href="inventoryLog"><i class="fas fa-clipboard-list me-2"></i> Inventory Log</a></li>
                                        <li><a class="dropdown-item" href="revenueStatistic"><i class="fa fa-bar-chart me-2"></i> View Revenue</a></li>
                                        <li><a class="dropdown-item" href="motorbikeStatistics"><i class="fas fa-chart-line me-2"></i> MotoBike Statistics</a></li>
                                        <li><a class="dropdown-item" href="modelslist"><i class="fas fa-list me-2"></i> Model List</a></li>
                                        <li><a class="dropdown-item" href="adminOrders"><i class="fas fa-shopping-cart me-2"></i> List Order</a></li>
                                        <li><a class="dropdown-item" href="accountManagement"><i class="fas fa-list me-2"></i> Account Management</a></li>

                                    </ul>
                                </li>
                            </c:if>
                            <c:if test="${sessionScope.user.role == 'employee'}">
                                <li class="nav-item dropdown">
                                    <a class="nav-link dropdown-toggle" href="#" id="adminDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
                                        <i class="fas fa-cogs"></i> Employee Tools
                                    </a>
                                    <ul class="dropdown-menu dropdown-menu-dark" aria-labelledby="adminDropdown">
                                        <li><a class="dropdown-item" href="adminOrders"><i class="fas fa-shopping-cart me-2"></i> List Order</a></li>

                                    </ul>
                                </li>
                            </c:if>


                        </ul>
                    </div>
                    <div class="d-flex">
                        <ul class="navbar-nav">
                            <c:choose>
                                <c:when test="${empty sessionScope.user}">
                                    <li class="nav-item">
                                        <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt me-1"></i> Login</a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="register.jsp"><i class="fas fa-user-plus me-1"></i> Register</a>
                                    </li>
                                </c:when>
                                <c:otherwise>
                                    <li class="nav-item">
                                        <a class="nav-link" href="profile"><i class="fas fa-user me-1"></i> Welcome, <c:out value="${sessionScope.user.email}"/></a>
                                    </li>
                                    <li class="nav-item">
                                        <a class="nav-link" href="logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a>
                                    </li>
                                </c:otherwise>
                            </c:choose>
                        </ul>
                    </div>
                </div>
            </nav>
        </header>
    </body>

</html>