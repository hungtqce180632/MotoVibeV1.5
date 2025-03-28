<%-- 
    Document   : list_appointments
    Created on : Feb 23, 2025, 12:36:57 AM
    Author     : truon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Appointments - MotoVibe</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/luxury-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }

            h1 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                margin-bottom: 0.5rem;
                position: relative;
                display: inline-block;
            }
            
            h1::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 0;
                width: 100%;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }
            
            .lead {
                color: var(--text-gold);
                font-size: 1.1rem;
                margin-bottom: 2rem;
                border-bottom: 1px solid rgba(212, 175, 55, 0.3);
                padding-bottom: 1rem;
                opacity: 0.9;
            }
            
            .appointment-container {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5);
                border: 1px solid var(--primary-gold);
                margin-bottom: 2rem;
            }
            
            .table {
                color: var(--text-gold);
                margin-top: 1.5rem;
            }
            
            .table thead th {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                text-transform: uppercase;
                letter-spacing: 1px;
                font-size: 0.9rem;
                font-weight: 600;
                padding: 1rem;
                vertical-align: middle;
                text-align: center;
            }
            
            .table tbody td {
                padding: 1rem;
                vertical-align: middle;
                border-top: 1px solid rgba(212, 175, 55, 0.2);
                text-align: center;
            }
            
            .table tbody tr {
                transition: all 0.3s ease;
            }
            
            .table tbody tr:hover {
                background: rgba(212, 175, 55, 0.05) !important;
                transform: translateY(-2px);
            }
            
            .badge {
                padding: 0.5rem 0.75rem;
                font-size: 0.8rem;
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 1px;
            }
            
            .bg-success {
                background: linear-gradient(145deg, #28a745, #218838) !important;
                border: none;
                box-shadow: 0 2px 5px rgba(40, 167, 69, 0.3);
            }
            
            .bg-secondary {
                background: linear-gradient(145deg, #6c757d, #5a6268) !important;
                border: none;
                box-shadow: 0 2px 5px rgba(108, 117, 125, 0.3);
            }
            
            .btn {
                font-size: 0.8rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                padding: 0.5rem 1rem;
                transition: all 0.3s ease;
                margin: 0 3px;
            }
            
            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            }
            
            .btn-outline-success {
                color: var(--primary-gold);
                border-color: var(--primary-gold);
                background: transparent;
            }
            
            .btn-outline-success:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
            }
            
            .btn-outline-danger {
                color: #ff6b6b;
                border-color: #ff6b6b;
                background: transparent;
            }
            
            .btn-outline-danger:hover {
                background: #ff6b6b;
                color: var(--dark-black);
            }
            
            .btn-outline-secondary {
                color: var(--text-gold);
                border-color: var (--text-gold);
                background: transparent;
            }
            
            .btn-outline-secondary:hover {
                background: rgba(245, 230, 204, 0.1);
                color: var(--text-gold);
            }
            
            .btn-outline-info {
                color: var(--primary-gold);
                border-color: var(--primary-gold);
                background: transparent;
            }
            
            .btn-outline-info:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
            
            .alert {
                background: linear-gradient(145deg, #1a1a1a, #222) !important;
                border: 1px solid var(--primary-gold) !important;
                color: var(--text-gold) !important;
                position: relative;
                padding: 1rem;
                margin-bottom: 1.5rem;
                border-radius: 10px;
                box-shadow: 0 5px 15px rgba(0, 0, 0, 0.3);
            }
            
            .alert i {
                margin-right: 0.5rem;
                color: var(--primary-gold);
            }
            
            .container {
                padding-top: 80px;
                padding-bottom: 50px;
            }
            
            .action-buttons {
                display: flex;
                justify-content: center;
                gap: 0.5rem;
            }
        </style>
    </head>

    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <div class="container">
            <div class="appointment-container">
                <!-- Success alert -->
                <c:if test="${not empty success}">
                    <div id="successAlert" class="alert alert-success alert-dismissible fade show" role="alert">
                        <i class="fas fa-check-circle"></i> ${success}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <!-- Error alert -->
                <c:if test="${not empty error}">
                    <div id="errorAlert" class="alert alert-danger alert-dismissible fade show" role="alert">
                        <i class="fas fa-exclamation-triangle"></i> ${error}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>

                <c:choose>
                    <c:when test="${userRole == 'customer'}">
                        <h1><i class="fas fa-calendar-check me-2"></i> Your Appointments</h1>
                        <p class="lead">Track and manage your scheduled service appointments with our expert technicians.</p>
                    </c:when>
                    <c:when test="${userRole == 'employee'}">
                        <h1><i class="fas fa-calendar-day me-2"></i> Customer Appointments</h1>
                        <p class="lead">Review and manage service appointments scheduled by our valued customers.</p>
                    </c:when>
                    <c:otherwise>
                        <h1><i class="fas fa-calendar me-2"></i> Service Appointments</h1>
                        <p class="lead">View all scheduled service appointments.</p>
                    </c:otherwise>
                </c:choose>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <c:if test="${userRole == 'employee'}">
                                    <th>Customer Name</th>
                                    <th>Phone Number</th>
                                </c:if>
                                <th>Start Date</th>
                                <th>End Date</th>
                                <th>Notes</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="appointment" items="${appointments}">
                                <tr>
                                    <td>${appointment.appointmentId}</td>
                                    
                                    <c:if test="${userRole == 'employee'}">
                                        <td>${customerMap[appointment.customerId].name}</td>
                                        <td>${customerMap[appointment.customerId].phoneNumber}</td>
                                    </c:if>
                                        
                                    <td><fmt:formatDate value="${appointment.dateStart}" pattern="MMM dd, yyyy" /></td>
                                    <td><fmt:formatDate value="${appointment.dateEnd}" pattern="MMM dd, yyyy" /></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${empty appointment.note}">
                                                <span class="text-muted font-italic">No notes provided</span>
                                            </c:when>
                                            <c:otherwise>
                                                ${appointment.note}
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    
                                    <td>
                                        <c:choose>
                                            <c:when test="${appointment.appointmentStatus}">
                                                <span class="badge bg-success"><i class="fas fa-check-circle me-1"></i> Active</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary"><i class="fas fa-clock me-1"></i> Pending</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    
                                    <td class="action-buttons">
                                        <!-- Employee Actions -->
                                        <c:if test="${userRole == 'employee'}">
                                            <form action="approveAppointment" method="POST" class="d-inline">
                                                <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                                                <button type="submit" class="btn btn-outline-success" 
                                                        title="Approve Appointment" 
                                                        ${appointment.appointmentStatus ? 'disabled' : ''}>
                                                    <i class="fas fa-check"></i> Approve
                                                </button>
                                            </form>
                                        </c:if>

                                        <!-- Customer Actions -->
                                        <c:if test="${userRole == 'customer'}">
                                            <c:choose>
                                                <c:when test="${appointment.appointmentStatus}">
                                                    <button class="btn btn-outline-danger" disabled>
                                                        <i class="fas fa-times"></i> Cancel
                                                    </button>
                                                </c:when>
                                                <c:otherwise>
                                                    <form action="listAppointments" method="POST" onsubmit="return confirmDelete()">
                                                        <input type="hidden" name="appointmentId" value="${appointment.appointmentId}">
                                                        <button type="submit" class="btn btn-outline-danger">
                                                            <i class="fas fa-trash"></i> Cancel
                                                        </button>
                                                    </form>
                                                </c:otherwise>
                                            </c:choose>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
                
                <div class="mt-4 text-center">
                    <a href="home" class="btn btn-outline-secondary">
                        <i class="fas fa-arrow-left me-1"></i> Back to Homepage
                    </a>
                    <c:if test="${userRole == 'customer'}">
                        <a href="appointment" class="btn btn-outline-info">
                            <i class="fas fa-plus me-1"></i> Schedule New Appointment
                        </a>
                    </c:if>
                </div>
            </div>
        </div>
        
        <jsp:include page="footer.jsp"></jsp:include>
        
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Auto-hide alerts after 3 seconds
            setTimeout(function() {
                const successAlert = document.getElementById('successAlert');
                const errorAlert = document.getElementById('errorAlert');
                
                if (successAlert) {
                    successAlert.style.transition = 'opacity 0.5s';
                    successAlert.style.opacity = '0';
                    setTimeout(() => successAlert.style.display = 'none', 500);
                }
                
                if (errorAlert) {
                    errorAlert.style.transition = 'opacity 0.5s';
                    errorAlert.style.opacity = '0';
                    setTimeout(() => errorAlert.style.display = 'none', 500);
                }
            }, 3000);
            
            // Confirmation dialog for appointment cancellation
            function confirmDelete() {
                return confirm('Are you sure you want to cancel this appointment?');
            }
        </script>
    </body>
</html>