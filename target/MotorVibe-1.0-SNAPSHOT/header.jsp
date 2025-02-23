<%-- 
    Document   : header
    Created on : Feb 23, 2025, 4:11:08 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<header>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <div class="container-fluid">
            <a class="navbar-brand" href="index.jsp">MotoVibe</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="motorList">Motorbikes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Services</a>  </li>
                    <li class="nav-item">
                        <a class="nav-link" href="listevents">Events</a>
                    </li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li class="nav-item">
                            <a class="nav-link" href="motorManagement">Manage Motors</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="inventoryLog">Inventory Log</a>
                        </li>
                    </c:if>
                </ul>
                <ul class="navbar-nav">
                    <c:choose>
                        <c:when test="${empty sessionScope.user}">
                            <li class="nav-item">
                                <a class="nav-link" href="login.jsp">Login</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="register.jsp">Register</a>
                            </li>
                        </c:when>
                        <c:otherwise>
                            <li class="nav-item">
                                <span class="nav-link">Welcome, <c:out value="${sessionScope.user.email}"/></span>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="logout">Logout</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </div>
    </nav> </header>