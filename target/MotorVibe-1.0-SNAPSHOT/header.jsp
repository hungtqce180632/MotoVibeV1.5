<%-- 
    Document   : header
    Created on : Feb 23, 2025, 4:11:08 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" integrity="..." crossorigin="anonymous" referrerpolicy="no-referrer" />
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm"> <!- Added shadow for subtle depth -->
        <div class="container-fluid">
            <a class="navbar-brand fw-bold fa-solid fa-motorcycle" href="index.jsp" style="font-size: 1.5rem; margin-left: 30px">MotoVibe</a> <!-  Bigger, bolder brand -->
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse d-flex justify-content-center" id="navbarNav">

                <div>
                    <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <a class="nav-link active" aria-current="page" href="index.jsp"><i class="fas fa-home me-1"></i> Home</a> <!- Added home icon -->
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="motorList"><i class="fas fa-motorcycle me-1"></i> Motorbikes</a> <!- Motorbike icon -->
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listevents"><i class="fas fa-calendar-alt me-1"></i> Events</a> <!- Event icon -->
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="listAppointments"><i class="fas fa-calendar-check me-1"></i> Appointments</a> <!- Appointment icon -->
                        </li>
                        <c:if test="${sessionScope.user.role == 'admin'}">
                            <li class="nav-item">
                                <a class="nav-link" href="inventoryLog"><i class="fas fa-clipboard-list me-1"></i> Inventory Log</a> <!- Inventory icon -->
                            </li>
                        </c:if>
                    </ul>
                </div>




            </div>

            <div style="margin-right: 30px">
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp"><i class="fas fa-sign-in-alt me-1"></i> Login</a> <!- Login icon -->
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="register.jsp"><i class="fas fa-user-plus me-1"></i> Register</a> <!- Register icon -->
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <span class="nav-link"><i class="fas fa-user me-1"></i> Welcome, <c:out value="${sessionScope.user.email}"/></span> <!- Welcome with user icon -->
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="logout"><i class="fas fa-sign-out-alt me-1"></i> Logout</a> <!- Logout icon -->
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav>
</header>