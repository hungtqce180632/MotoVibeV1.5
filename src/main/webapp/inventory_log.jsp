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
    </head>
    <body>
        <div class="container mt-4">
            <h2 class="text-center mb-4">Inventory Log</h2>

            <table class="table table-bordered table-hover">
                <thead class="table-dark">
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
                            <td>${log.logId}</td>
                            <td>${log.motorId}</td>
                            <td>${log.previousQuantity}</td>
                            <td>${log.changeAmount}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${log.actionType eq 'Increase'}">
                                        <span class="text-success fw-bold">Increase</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-danger fw-bold">Decrease</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>${log.userIdModifiedBy}</td>
                            <td>${log.modifiedAt}</td>
                            <td>${log.note}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <a href="motorManagement" class="btn btn-secondary">Back to motor list</a>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
