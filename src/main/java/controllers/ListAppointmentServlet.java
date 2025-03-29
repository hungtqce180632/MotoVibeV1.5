/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.AppointmentDAO;
import dao.CustomerDAO;
import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Appointment;
import models.Customer;
import models.Employee;
import models.UserAccount;

/**
 * Servlet này xử lý việc quản lý và hiển thị danh sách các cuộc hẹn
 * (appointments). Tuỳ thuộc vào vai trò của người dùng (Khách hàng, Nhân viên,
 * Quản trị viên), servlet sẽ lấy các cuộc hẹn tương ứng để hiển thị. Author:
 * hieunmce181623 Created on: Feb 23, 2025, 4:11:08 AM
 */
@WebServlet({"/listAppointments", "/approveAppointment"})
public class ListAppointmentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP GET and POST methods.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    /**
     * Phương thức xử lý yêu cầu GET từ client, được gọi khi người dùng truy cập
     * trang hiển thị danh sách cuộc hẹn.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        // Lấy thông tin phiên làm việc của người dùng (session)
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        // Nếu chưa đăng nhập thì chuyển hướng về trang login.jsp
        if (user == null) {
            response.sendRedirect("login.jsp"); // Người dùng chưa đăng nhập -> chuyển hướng đến trang login
            return;
        }
// Khởi tạo các đối tượng DAO để truy vấn cơ sở dữ liệu
        CustomerDAO customerDAO = new CustomerDAO();
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();
        List<Appointment> appointmentList = null;
        Map<Integer, Customer> customerMap = new HashMap<>(); // Bản đồ lưu trữ thông tin khách hàng theo ID và doi tuong empl

        try {
            // Lấy vai trò của người dùng
            String role = user.getRole();
            // Nếu là khách hàng
            if (role.equalsIgnoreCase("Customer")) {
                // Lấy ID khách hàng từ ID người dùng
                int customerID = customerDAO.getCustomerIdByUserId(user.getUserId());
                // Lấy danh sách các cuộc hẹn của khách hàng
                appointmentList = appointmentDAO.getAppointmentsByCustomerId(customerID);
                request.setAttribute("userRole", "customer");

            } else if (role.equalsIgnoreCase("Employee")) {
                // Nếu là nhân viên: Lấy thông tin nhân viên từ ID người dùng
                Employee employee = employeeDAO.getEmployeeByUserId(user.getUserId());
                // Lấy danh sách các cuộc hẹn của nhân viên
                appointmentList = appointmentDAO.getAppointmentsByEmployeeId(employee.getEmployeeId());

                // Lưu trữ thông tin khách hàng vào bản đồ
                for (Customer customer : customerDAO.getAllCustomers()) {
                    customerMap.put(customer.getCustomerId(), customer);
                }

                request.setAttribute("userRole", "employee");
                request.setAttribute("customerMap", customerMap); // Truyền thông tin khách hàng vào request

            } else if (role.equalsIgnoreCase("Admin")) {
                // Nếu là quản trị viên: Lấy tất cả cuộc hẹn trong hệ thống
                appointmentList = appointmentDAO.getAllAppointments();
                request.setAttribute("userRole", "admin");

            } else {
                // Trường hợp vai trò không xác định (thường là lỗi hoặc vai trò không hợp lệ)
                appointmentList = appointmentDAO.getAllAppointments();
                request.setAttribute("userRole", "employee"); // Hoặc có thể set role là "unknownRole"
            }

        } catch (Exception e) {
            // Nếu có lỗi xảy ra trong quá trình truy vấn cơ sở dữ liệu
            System.err.println("Exception in ListAppointmentServlet: " + e.getMessage());
            e.printStackTrace(); // Ghi lỗi vào log
        }

        // Đưa danh sách cuộc hẹn vào trong request để truyền tới JSP
        request.setAttribute("appointments", appointmentList);

        try {
            // Lấy các tham số từ URL để hiển thị thông báo thành công hoặc lỗi
            String successParam = request.getParameter("success");
            String errorParam = request.getParameter("error");

            // Nếu có tham số success, xử lý và hiển thị thông báo thành công
            if (successParam != null) {
                int successCode = Integer.parseInt(successParam);
                if (successCode == 1) {
                    request.setAttribute("success", "Appointment added successfully!"); // Cuộc hẹn đã được thêm thành công
                } else if (successCode == 2) {
                    request.setAttribute("success", "Appointment cancelled successfully!"); // Cuộc hẹn đã bị huỷ
                } else if (successCode == 3) {
                    request.setAttribute("success", "Appointment approved successfully!"); // Cuộc hẹn đã được duyệt
                }
            }

            // Nếu có tham số error, xử lý và hiển thị thông báo lỗi
            if (errorParam != null) {
                int errorCode = Integer.parseInt(errorParam);
                if (errorCode == 1) {
                    request.setAttribute("error", "Error adding appointment. Please try again."); // Lỗi khi thêm cuộc hẹn
                } else if (errorCode == 2) {
                    request.setAttribute("error", "Failed to cancel appointment."); // Lỗi khi huỷ cuộc hẹn
                } else if (errorCode == 3) {
                    request.setAttribute("error", "Failed to approve appointment."); // Lỗi khi duyệt cuộc hẹn
                }
            }
        } catch (NumberFormatException e) {
            // Nếu tham số success hoặc error không hợp lệ
            System.err.println("Invalid success/error parameter: " + e.getMessage());
        }

        // Chuyển hướng dữ liệu đến trang JSP để hiển thị danh sách cuộc hẹn
        request.getRequestDispatcher("list_appointments.jsp").forward(request, response);

    }

    /**
     * Phương thức xử lý yêu cầu POST từ client. Dùng để thực hiện hành động phê
     * duyệt hoặc huỷ cuộc hẹn.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getServletPath();
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        try {
            // Lấy ID cuộc hẹn từ request
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

            // Nếu yêu cầu phê duyệt cuộc hẹn
            if ("/approveAppointment".equals(action)) {
                boolean success = appointmentDAO.updateAppointmentStatus(appointmentId, true);
                if (success) {
                    response.sendRedirect("listAppointments?success=3"); // Chuyển hướng và hiển thị thông báo thành công
                } else {
                    response.sendRedirect("listAppointments?error=3"); // Thất bại khi phê duyệt
                }
            } // Nếu yêu cầu huỷ cuộc hẹn
            else if ("/listAppointments".equals(action)) {
                boolean success = appointmentDAO.deleteAppointment(appointmentId);
                if (success) {
                    response.sendRedirect("listAppointments?success=2"); // Chuyển hướng và hiển thị thông báo huỷ thành công
                } else {
                    response.sendRedirect("listAppointments?error=2"); // Thất bại khi huỷ
                }
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("listAppointments?error=Invalid appointment ID"); // Thông báo lỗi nếu ID cuộc hẹn không hợp lệ
        }
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet to list appointments based on user role";
    }
}
