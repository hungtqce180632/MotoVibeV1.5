<%-- 
    Document   : inventory_log
    Created on : Feb 21, 2025
    Author     : tiend
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Inventory Log</title>
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
                text-align: center;
            }

            h2::after {
                content: '';
                position: absolute;
                bottom: -10px;
                left: 50%;
                transform: translateX(-50%);
                width: 80px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .container {
                padding-top: 80px;
            }

            .table-container {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                border: 1px solid var(--primary-gold);
                border-radius: 10px;
                padding: 1.5rem;
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.3);
                margin-bottom: 2rem;
                overflow-x: auto;
            }

            .table {
                margin-bottom: 0;
                color: var(--text-gold) !important;
            }

            .table thead th {
                color: var(--primary-gold) !important;
                text-transform: uppercase;
                font-size: 0.9rem;
                letter-spacing: 1px;
                border-bottom: 2px solid var(--primary-gold) !important;
                padding: 1rem 0.75rem;
                vertical-align: middle;
            }

            .table tbody tr {
                border-bottom: 1px solid rgba(212, 175, 55, 0.2);
                transition: all 0.3s ease;
            }

            .table tbody tr:hover {
                background: rgba(212, 175, 55, 0.05) !important;
                transform: translateY(-1px);
            }

            .table tbody tr:last-child {
                border-bottom: none;
            }

            .table td {
                padding: 1rem 0.75rem;
                vertical-align: middle;
                color: var(--text-gold);
            }

            .text-success {
                color: #6eff7a !important;
                font-weight: bold;
            }

            .text-danger {
                color: #ff6e6e !important;
                font-weight: bold;
            }

            .btn-secondary {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
                transition: all 0.3s ease;
                padding: 0.5rem 1.5rem;
                text-transform: uppercase;
                letter-spacing: 1px;
                font-size: 0.9rem;
                margin-top: 1rem;
            }

            .btn-secondary:hover {
                background: var(--primary-gold);
                color: var(--dark-black);
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }

            .icon-action {
                margin-right: 5px;
                font-size: 0.9rem;
            }

            .log-id {
                font-weight: 600;
                color: var(--primary-gold);
            }

            /* Custom pagination styling */
            .pagination-container {
                display: flex;
                justify-content: center;
                margin-top: 1.5rem;
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="container mt-4">
                <h2 class="mb-4"><i class="fas fa-history me-2"></i>Inventory Log</h2>

                <div class="table-container">
                    <table class="table table-responsive">
                        <thead>
                            <tr>
                                <th>Log ID</th>
                                <th>Motor ID</th>
                                <th>Previous Quantity</th>
                                <th>Change Amount</th>
                                <th>Action Type</th>
                                <th>Modified By</th>
                                <th>Modified At</th>
                                <th>Note</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="log" items="${logs}">
                            <tr>
                                <td class="log-id">#${log.logId}</td>
                                <td>${log.motorId}</td>
                                <td>${log.previousQuantity}</td>
                                <td>${log.changeAmount}</td>
                                <td>
                                    <c:choose>
                                        <c:when test="${log.actionType eq 'increase'}">
                                            <span class="text-success"><i class="fas fa-arrow-up icon-action"></i>Increase</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-danger"><i class="fas fa-arrow-down icon-action"></i>Decrease</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:forEach var="admin" items="${admins}">
                                        <c:if test="${admin.userId eq log.userIdModifiedBy}">
                                            ${admin.email}
                                        </c:if>
                                    </c:forEach>
                                </td>
                                <td>${log.modifiedAt}</td>
                                <td>${log.note}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>

            <!-- Add pagination if needed -->
            <c:if test="${totalPages > 1}">
                <div class="pagination-container">
                    <ul class="pagination">
                        <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                            <a class="page-link" href="inventoryLog?page=${currentPage - 1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                        <c:forEach begin="1" end="${totalPages}" var="i">
                            <li class="page-item ${currentPage == i ? 'active' : ''}">
                                <a class="page-link" href="inventoryLog?page=${i}">${i}</a>
                            </li>
                        </c:forEach>
                        <li class="page-item ${currentPage == totalPages ? 'disabled' : ''}">
                            <a class="page-link" href="inventoryLog?page=${currentPage + 1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </c:if>

            <div class="text-center">
                <a href="motorManagement" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-1"></i> Back to Motor List
                </a>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
