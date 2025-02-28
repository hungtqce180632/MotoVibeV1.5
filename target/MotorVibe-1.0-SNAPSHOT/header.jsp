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
                border-bottom: 1px solid rgba(212, 175, 55, 0.1);
            }

            .navbar-brand {
                color: var(--primary-gold) !important;
                text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.3);
                font-size: 1.8rem;
                position: relative;
                transition: all 0.3s ease;
            }

            .navbar-brand:hover {
                color: var(--secondary-gold) !important;
                transform: translateY(-2px);
            }

            .navbar-nav .nav-link {
                color: #fff !important;
                padding: 0.7rem 1.2rem;
                position: relative;
                transition: all 0.3s ease;
                text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
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
            }

            .navbar-nav .nav-link:hover::after,
            .navbar-nav .nav-link.active::after {
                width: 80%;
            }

            .navbar-nav .nav-link:hover,
            .navbar-nav .nav-link.active {
                color: var(--primary-gold) !important;
                transform: translateY(-2px);
            }

            .navbar-toggler {
                border: 1px solid var(--primary-gold) !important;
                padding: 0.5rem;
                transition: all 0.3s ease;
            }

            .navbar-toggler:hover {
                background: rgba(212, 175, 55, 0.1);
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
                                <li class="nav-item">
                                    <a class="nav-link" href="inventoryLog"><i class="fas fa-clipboard-list me-1"></i> Inventory Log</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="revenueStatistic"><i class="fas fa-chart-line"></i> View Revenue</a>
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