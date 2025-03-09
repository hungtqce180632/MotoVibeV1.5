<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="models.UserAccount" %>
<%@ page import="java.util.List" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>
    <head>
        <title>Account Management - MotoVibe</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            .btn {
                text-transform: uppercase;
                letter-spacing: 1px;
                padding: 0.75rem 1.5rem;
                transition: all 0.3s ease;
            }
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                color: var(--text-gold);
                background: var(--dark-black);
            }

            .users-section {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
                border: 1px solid var(--primary-gold);
                margin: 2rem auto;
                max-width: 1200px;

            }

            .section-title {
                color: var(--primary-gold);
                font-size: 2rem;
                font-weight: 700;
                text-transform: uppercase;
                margin-bottom: 2rem;
                text-align: center;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                position: relative;
            }

            .section-title::after {
                content: '';
                position: absolute;
                bottom: -15px;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .table {
                margin-top: 2rem;
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                overflow: hidden;
                color: var(--text-gold);
            }

            .table thead th {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
                border: none;
                padding: 1rem;
                vertical-align: middle;
            }

            .table tbody td {
                color: var(--text-gold);
                border-color: rgba(212, 175, 55, 0.2);
                padding: 1rem;
                vertical-align: middle;
            }

            .table tbody tr {
                transition: all 0.3s ease;
                background: transparent;
            }

            .table tbody tr:hover {
                background: rgba(212, 175, 55, 0.05);
                transform: translateY(-2px);
            }

            .status-active {
                background: linear-gradient(145deg, #28a745, #218838);
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.8rem;
                text-transform: uppercase;
            }

            .status-inactive {
                background: linear-gradient(145deg, #dc3545, #c82333);
                color: white;
                padding: 0.5rem 1rem;
                border-radius: 20px;
                font-weight: 600;
                font-size: 0.8rem;
                text-transform: uppercase;
            }

            .btn-primary {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
                padding: 0.5rem 1rem;
                transition: all 0.3s ease;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }

            .btn-sm {
                padding: 0.4rem 0.8rem;
                font-size: 0.8rem;
            }

            .alert-info {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                color: var(--text-gold);
                padding: 1.5rem;
                border-radius: 10px;
                text-align: center;
                margin-top: 2rem;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"/>

        <div class="container" style="padding-top: 50px">
            <div class="users-section" >
                
                <a href="accountManagement" class="btn btn-primary btn-sm me-1">
                   <i class="fas fa-user me-1"></i> Customer
                </a>
                <a href="accountManagement?listOf=emp" class="btn btn-primary btn-sm me-1">
                   <i class="fas fa-user me-1"></i> Employee
                </a>      
                <h2 class="section-title" ><i class="fas fa-users me-2"></i> ${listOf eq 'emp' ? 'Employee Management' : ' Customer Management'}</h2>
                <c:if test="${listOf eq 'emp'}">
                    <a href="createEmployee" class="btn btn-primary btn-sm me-1">
                   <i class="fas fa-user-plus me-1"></i> Create Employee Account
                </a>  
                </c:if>
                
                <c:if test="${empty list}">
                    <div class="alert alert-info">
                        <i class="fas fa-info-circle me-2"></i> No users found.
                    </div>
                </c:if>

                <c:if test="${not empty list}">
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>User ID</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Phone Number</th>
                                    <th>Create Date</th>
                                    <th>Status</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="user" items="${list}">
                                    <tr>
                                        <td>#${user.userId}</td>
                                        <td>${map[user.userId].name}</td>
                                        <td>${user.email}</td>
                                        <td>${map[user.userId].phoneNumber}</td>
                                        <td><fmt:formatDate value="${user.dateCreated}" pattern="yyyy-MM-dd"/></td>
                                        <td>
                                            <div style="display: flex">
                                                <span class="${user.status ? 'status-active' : 'status-inactive'}">
                                                    <i class="fas ${user.status ? 'fa-check-circle' : 'fa-times-circle'} me-1"></i>
                                                    ${user.status ? 'Active' : 'Inactive'}
                                                </span>
                                            </div>
                                        </td>
                                        <td>
                                            <div style="display: flex">
                                                <c:if test="${listOf eq 'emp'}">
                                                    <a href="editEmployee?id=${user.userId}" class="btn btn-warning">
                                                        <i class="fas fa-edit me-1"></i> Edit
                                                    </a>
                                                </c:if>
                                                <form action="accountManagement?changeStatusId=${user.userId}" method="POST" class="btn ${user.status ? 'btn-danger' : 'btn-success'} btn-sm">
                                                    <button type="submit"  class="btn ${user.status ? 'btn-danger' : 'btn-success'} btn-sm">
                                                        <i class="fas ${user.status ? 'fa-ban' : 'fa-check'} me-1"></i> 
                                                        ${user.status ? 'Disable' : 'Enable'} 
                                                    </button>
                                                </form>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </c:if>
            </div>
        </div>

        <jsp:include page="footer.jsp"/>
    </body>
</html>
