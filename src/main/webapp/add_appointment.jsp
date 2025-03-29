<%-- 
    Document   : Add Appointment Page
    Created on : Feb 23, 2025, 4:11:08 AM
    Author     : hieunmce181623
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Appointment</title>
        <!-- Thêm các link CSS từ CDN để tạo giao diện đẹp và dễ sử dụng -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="css/luxury-theme.css"> <!-- CSS tùy chỉnh cho giao diện -->
        <style>
            /* Định dạng tiêu đề */
            h2 {
                color: var(--primary-gold); /* Màu vàng */
                text-transform: uppercase; /* Chữ in hoa */
                letter-spacing: 2px; /* Khoảng cách giữa các chữ */
                text-shadow: 2px 2px 4px rgba(0,0,0,0.5); /* Đổ bóng cho chữ */
                margin-bottom: 0.5rem;
            }

            h2 .fas {
                margin-right: 10px;
                color: var(--primary-gold);
            }

            .lead {
                color: var(--text-gold);
                font-size: 1.1rem;
                margin-bottom: 2rem;
                border-bottom: 1px solid var(--secondary-gold);
                padding-bottom: 1rem;
            }

            /* Định dạng cho container chính */
            .container {
                background: linear-gradient(145deg, var(--dark-black), var(--rich-black)); /* Màu nền gradient */
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 15px 35px rgba(0, 0, 0, 0.5); /* Đổ bóng cho container */
                border: 1px solid var(--primary-gold);
                margin-top: 80px;
                max-width: 900px;
            }

            /* Định dạng cho label và các trường nhập liệu */
            .form-label {
                color: var(--primary-gold);
                font-weight: 500;
                text-transform: uppercase;
                font-size: 0.9rem;
                letter-spacing: 1px;
            }

            .form-control, .form-select {
                background-color: rgba(0, 0, 0, 0.2) !important; /* Nền đen */
                border: 1px solid var(--secondary-gold); /* Viền vàng */
                color: white !important;
                padding: 10px;
                border-radius: 5px;
            }

            .form-control:focus, .form-select:focus {
                background-color: rgba(0, 0, 0, 0.3) !important;
                border-color: var(--primary-gold); /* Viền khi focus */
                box-shadow: 0 0 0 0.25rem rgba(218, 165, 32, 0.25);
            }

            .form-control::placeholder {
                color: rgba(255, 255, 255, 0.5); /* Màu placeholder */
            }

            /* Định dạng cho nút */
            .btn {
                text-transform: uppercase;
                letter-spacing: 1px;
                padding: 10px 20px;
                transition: all 0.3s ease;
                margin: 0 5px;
            }

            /* Định dạng cho các nút chính */
            .btn-primary {
                background: linear-gradient(145deg, var(--primary-gold), var(--secondary-gold));
                border: none;
                color: var(--dark-black);
                font-weight: 600;
            }

            .btn-primary:hover {
                transform: translateY(-2px);
                box-shadow: 0 5px 15px rgba(212, 175, 55, 0.3);
            }

            .btn-secondary {
                background: transparent;
                border: 1px solid var(--primary-gold);
                color: var(--primary-gold);
            }

            .btn-secondary:hover {
                background: rgba(212, 175, 55, 0.1);
                color: var(--primary-gold);
                box-shadow: 0 0 15px rgba(212, 175, 55, 0.2);
            }

            .luxury-icon {
                position: absolute;
                top: 20px;
                right: 20px;
                font-size: 60px;
                opacity: 0.1;
                color: var(--primary-gold);
            }

            /* Định dạng cho input date */
            input[type="date"] {
                background-color: rgba(0, 0, 0, 0.7) !important; /* Nền đen cho input ngày */
                color: white !important;
                border: 1px solid var(--secondary-gold);
                padding-right: 0px; /* Tạo không gian cho biểu tượng */
                position: relative;
                cursor: pointer;
            }

            /* Thêm biểu tượng lịch vào input date */
            input[type="date"]::after {
                content: '\f073'; /* Font Awesome calendar icon */
                font-family: 'Font Awesome 5 Free';
                position: absolute;
                right: 10px;
                top: 50%;
                transform: translateY(-50%);
                font-size: 18px;
                color: white;
                pointer-events: none; /* Không cho phép click vào icon */
            }
        </style>
    </head>
    <body>
        <jsp:include page="header.jsp"></jsp:include>

        <!-- Container chứa form tạo cuộc hẹn -->
        <div class="container mt-4">
            <div class="form-container">
                <i class="fas fa-calendar-check luxury-icon"></i>
                <h2><i class="fas fa-calendar-plus"></i> Schedule an Appointment</h2>
                <p class="lead">Fill out the form below to schedule a premium motorbike service appointment.</p>

                <!-- Form nhập liệu cuộc hẹn -->
                <form action="appointment" method="POST" class="mt-4">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="customerId" class="form-label">Customer Name</label>
                            <!-- Ẩn trường customerId -->
                            <input type="hidden" class="form-control" id="customerId" name="customerId" value="${customerId}" readonly>
                            <input type="text" class="form-control" id="customerId" name="customerId" value="${customerName}" readonly>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="employeeId" class="form-label">Assign Technician</label>
                            <!-- Dropdown chọn nhân viên -->
                            <select class="form-control form-select" id="employeeId" name="employeeId">
                                <option value="">-- Automatically Assign a Technician --</option>
                                <c:forEach var="employee" items="${employees}">
                                    <option value="${employee.employeeId}" 
                                            <c:if test="${employee.employeeId == selectedEmployeeId}">
                                                selected
                                            </c:if> >
                                        ${employee.name}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label for="dateStart" class="form-label">Appointment Date</label>
                            <!-- Input ngày bắt đầu -->
                            <input type="date" class="form-control" id="dateStart" name="dateStart" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label for="estimatedCompletion" class="form-label">Estimated Completion</label>
                            <!-- Input ngày kết thúc, chỉ đọc -->
                            <input type="date" class="form-control" id="estimatedCompletion" readonly>
                            <input type="hidden" id="dateEnd" name="dateEnd">
                        </div>
                    </div>

                    <div class="mb-3">
                        <label for="note" class="form-label">Service Details</label>
                        <!-- Input ghi chú mô tả dịch vụ -->
                        <textarea required class="form-control" id="note" name="note" rows="3" placeholder="Please describe the service needed or any special instructions..."></textarea>
                    </div>

                    <div class="mb-3">
                        <label for="appointmentStatus" class="form-label">Appointment Status</label>
                        <!-- Trạng thái cuộc hẹn, mặc định là Pending -->
                        <input type="hidden" name="appointmentStatus" value="0">
                        <select class="form-control form-select" id="appointmentStatus" disabled>
                            <option value="1">Active</option>
                            <option value="0" selected>Pending</option>
                        </select>
                        <small class="text-muted" style="color: var(--text-gold) !important; opacity: 0.7;">The appointment will be set to pending until confirmed by staff.</small>
                    </div>
                    <button type="submit" class="btn btn-primary"><i class="fas fa-save"></i> Save Appointment</button>
                    <a href="listAppointments" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Back</a>
                </form>
            </div>
        </div>

        <jsp:include page="footer.jsp"></jsp:include>

        <!-- Bootstrap JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script>
            // Khi ngày bắt đầu thay đổi, tính toán và gán giá trị cho ngày kết thúc
            document.getElementById("dateStart").addEventListener("change", function () {
                let startDate = new Date(this.value);
                if (!isNaN(startDate.getTime())) {
                    startDate.setDate(startDate.getDate() + 2); // Cộng 2 ngày
                    let formattedDate = startDate.toISOString().slice(0, 10); // Định dạng yyyy-MM-dd
                    document.getElementById("dateEnd").value = formattedDate; // Gán giá trị vào input hidden
                    document.getElementById("estimatedCompletion").value = formattedDate; // Gán giá trị vào input readonly
                }
            });

            // Đặt ngày tối thiểu là ngày hiện tại
            const today = new Date();
            today.setDate(today.getDate());
            const tomorrow = today.toISOString().split('T')[0];
            document.getElementById('dateStart').setAttribute('min', tomorrow); // Cập nhật thuộc tính min cho input ngày
        </script>
    </body>
</html>
