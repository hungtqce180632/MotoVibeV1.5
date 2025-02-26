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
            /* css/style.css - Header Styles (you can also put these in your style.css file) */
            header {
                background-color: #222;
                color: #fff;
            }

            .navbar-brand {
                color: #fff !important;
            }

            .navbar-brand:hover {
                color: #eee !important;
            }

            .navbar-nav .nav-link {
                color: rgba(255, 255, 255, 0.8) !important;
                padding: 0.7rem 1.2rem;
                transition: color 0.2s ease-in-out;
            }

            .navbar-nav .nav-link:hover,
            .navbar-nav .nav-link.active {
                color: #fff !important;
            }

            .navbar-toggler {
                border-color: rgba(255, 255, 255, 0.1) !important;
            }

            .navbar-toggler-icon {
                background-image: url("data:image/svg+xml,%3csvg viewBox='0 0 30 30' xmlns='http://www.w3.org/2000/svg'%3e%3cpath stroke='rgba(255, 255, 255, 0.7)' stroke-linecap='round' stroke-miterlimit='10' stroke-width='2' d='M4 7h22M4 15h22M4 23h22'/%3e%3c/svg%3e") !important;
            }

            .navbar {
                padding-top: 0.7rem;
                padding-bottom: 0.7rem;
            }

            /* Mobile Specific Styles (Media Query) */
            @media (max-width: 768px) {
                .navbar-brand {
                    font-size: 1.3rem !important;
                }

                .navbar-nav .nav-link {
                    padding: 0.5rem 0.8rem !important;
                    font-size: 0.9rem !important;
                    text-align: center; /* Center align menu links in collapsed menu */
                }

                .navbar {
                    padding-top: 0.5rem;
                    padding-bottom: 0.5rem;
                }

                .navbar-brand {
                    margin-right: 0.5rem;
                }

                .navbar-collapse {
                    text-align: center; /* Center align collapsed menu content */
                }

                .navbar-nav {
                    margin-top: 0.5rem;
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
                                        <span class="nav-link"><i class="fas fa-user me-1"></i> Welcome, <c:out value="${sessionScope.user.email}"/></span>
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