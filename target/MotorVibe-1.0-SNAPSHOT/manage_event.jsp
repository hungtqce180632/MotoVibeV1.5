<%-- 
    Document   : manage_event
    Created on : Feb 28, 2025, 2:23:46 PM
    Author     : ACER
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Danh sách Sự kiện - MotoVibe</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <style>
            :root {
                --primary-gold: #D4AF37;
                --secondary-gold: #C5A028;
                --dark-black: #111111;
                --rich-black: #1A1A1A;
                --text-gold: #F5E6CC;
            }

            body {
                background: var(--dark-black);
                color: var(--text-gold);
            }

            .container {
                padding-top: 80px;
            }

            h2 {
                color: var(--primary-gold);
                text-transform: uppercase;
                letter-spacing: 2px;
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5);
                position: relative;
                padding-bottom: 15px;
            }

            h2::after {
                content: '';
                position: absolute;
                bottom: 0;
                left: 50%;
                transform: translateX(-50%);
                width: 100px;
                height: 2px;
                background: var(--primary-gold);
                box-shadow: 0 0 10px var(--primary-gold);
            }

            .table {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black));
                color: var(--text-gold);
                border: 1px solid var(--primary-gold);
                border-radius: 15px;
                overflow: hidden;
            }

            .table thead th {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                color: var(--dark-black);
                border: none;
                text-transform: uppercase;
                letter-spacing: 1px;
            }

            .form-control, .form-select {
                background: rgba(26, 26, 26, 0.9);
                border: 1px solid var(--primary-gold);
                color: var(--text-gold);
            }

            .btn {
                text-transform: uppercase;
                letter-spacing: 1px;
                transition: all 0.3s ease;
            }

            .btn:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

            <div class="container mt-4">
                <h2 class="text-center mb-4">Danh sách Sự kiện</h2>

                <div class="d-flex justify-content-between mb-3">
                    <div>
                    <c:if test="${sessionScope.user.role eq 'admin'}">
                        <a href="create_event.jsp" class="btn btn-primary">Thêm Sự kiện mới</a>
                    </c:if>
                </div>
                <form action="searchEvents" method="get" class="d-flex">
                    <input class="form-control me-2" type="search" placeholder="Tìm kiếm theo Tên Sự kiện" name="searchTerm" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">Tìm kiếm</button>
                </form>
            </div>

            <c:choose>
                <c:when test="${sessionScope.user.role eq 'admin'}">
                    <table class="table table-bordered table-hover">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Tên Sự kiện</th>
                                <th>Ngày Bắt đầu</th>
                                <th>Ngày Kết thúc</th>
                                <th>Trạng thái</th>
                                
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="event" items="${events}">
                                <tr>
                                    <td>${event.event_id}</td>
                                    <td>${event.event_name}</td>
                                    <td>${event.date_start}</td>
                                    <td>${event.date_end}</td>
                                    <td>${event.event_status ? 'Hoạt động' : 'Ẩn'}</td>
                                    <td>
                                    <td>
                                        <a href="EditEventServlet?id=${event.event_id}" class="btn btn-warning btn-sm">Chỉnh sửa</a>
                                        <a href="deleteEvent?id=${event.event_id}" class="btn btn-danger btn-sm">Xóa</a>

                                        <!-- Change Status Button -->
                                        <form action="changeEventStatus" method="post" style="display:inline;">
                                            <input type="hidden" name="event_id" value="${event.event_id}">
                                            <button type="submit" class="btn btn-info btn-sm">
                                                ${event.event_status ? 'Deactivate' : 'Activate'}
                                            </button>
                                        </form>
                                    </td>




                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <jsp:include page="event_tags_view.jsp"></jsp:include>
                </c:otherwise>
            </c:choose>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>

