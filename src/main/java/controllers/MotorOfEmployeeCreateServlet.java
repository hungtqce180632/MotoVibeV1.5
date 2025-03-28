/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import dao.CustomerDAO;
import dao.MotorDAO;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import models.Motor;
import models.Order;
import models.UserAccount;

/**
 *
 * @author ACER
 */
@WebServlet(name = "MotorOfEmployeeCreateServlet", urlPatterns = {"/MotorOfEmployeeCreateServlet"})
public class MotorOfEmployeeCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy các tham số từ URL
            String motorIdParam = request.getParameter("motorId");
            String customerIdParam = request.getParameter("customerId");

            // Nếu có tham số motorId, lấy thông tin xe máy từ cơ sở dữ liệu
            if (motorIdParam != null) {
                int motorId = Integer.parseInt(motorIdParam);
                MotorDAO motorDAO = new MotorDAO();
                Motor motor = motorDAO.getMotorById(motorId);

                if (motor != null) {
                    // Thêm thông tin xe máy vào request để hiển thị
                    request.setAttribute("motor", motor);
                }
            }
            
            // Nếu có tham số customerId, lấy thông tin khách hàng cụ thể
            if (customerIdParam != null) {
                int customerId = Integer.parseInt(customerIdParam);
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = customerDAO.getCustomerById(customerId);

                if (customer != null) {
                    request.setAttribute("customer", customer);
                }
            }

            // Lấy danh sách tất cả khách hàng để hiển thị trong dropdown
            CustomerDAO customerDAO = new CustomerDAO();
            List<Customer> customers = customerDAO.getAllCustomersFD();
            request.setAttribute("customers", customers);

            // Lấy danh sách tất cả xe máy để hiển thị trong dropdown
            MotorDAO motorDAO = new MotorDAO();
            List<Motor> motors = motorDAO.getAllMotors();
            request.setAttribute("motors", motors);

            // Chuyển hướng request đến trang JSP để hiển thị thông tin
            request.getRequestDispatcher("order_by_employee.jsp").forward(request, response);
        } catch (SQLException ex) {
            // Ghi log lỗi nếu có
            Logger.getLogger(MotorOfEmployeeCreateServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Lấy session và thông tin người dùng hiện tại
            HttpSession session = request.getSession();
            UserAccount user = (UserAccount) session.getAttribute("user");

            // Kiểm tra xem người dùng đăng nhập có phải là nhân viên không
            if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
                // Nếu không phải nhân viên, chuyển hướng về trang đăng nhập
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy các tham số từ form
            int motorId = Integer.parseInt(request.getParameter("motorId"));
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String paymentMethod = request.getParameter("paymentMethod");
            boolean hasWarranty = "true".equals(request.getParameter("hasWarranty"));
            boolean depositStatus = "on".equals(request.getParameter("depositStatus"));

            // Kiểm tra các trường bắt buộc đã được điền đầy đủ chưa
            if (motorId <= 0 || customerId <= 0 || paymentMethod == null || paymentMethod.trim().isEmpty()) {
                session.setAttribute("errorMessage", "All required fields must be filled out");
                response.sendRedirect("MotorOfEmployeeCreateServlet?motorId=" + motorId + "&customerId=" + customerId);
                return;
            }

            // Lấy thông tin chi tiết xe máy để tính tổng số tiền
            MotorDAO motorDAO = new MotorDAO();
            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                // Nếu xe máy không tồn tại, hiển thị lỗi
                session.setAttribute("errorMessage", "Selected motor does not exist");
                response.sendRedirect("MotorOfEmployeeCreateServlet");
                return;
            }

            // Kiểm tra xem xe máy còn hàng không
            if (motor.getQuantity() <= 0) {
                session.setAttribute("errorMessage", "Selected motor is out of stock");
                response.sendRedirect("MotorOfEmployeeCreateServlet?motorId=" + motorId + "&customerId=" + customerId);
                return;
            }

            // Tạo đơn hàng mới
            Order order = new Order();
            order.setCustomerId(customerId);
            order.setMotorId(motorId);
            order.setEmployeeId(user.getUserId()); // Đặt nhân viên tạo đơn hàng
            order.setPaymentMethod(paymentMethod);
            
            // Tính tổng số tiền với bảo hành nếu có
            double basePrice = motor.getPrice();
            double totalAmount = basePrice;
            if (hasWarranty) {
                totalAmount = basePrice * 1.10; // Thêm phí bảo hành 10%
            }
            order.setTotalAmount(totalAmount);
            
            order.setDepositStatus(depositStatus);
            order.setHasWarranty(hasWarranty);
            order.setOrderStatus("Pending"); // Trạng thái ban đầu cho đơn hàng do nhân viên tạo

            // Tạo mã đơn hàng
            String orderCode = "MV-" + System.currentTimeMillis() % 100000;
            order.setOrderCode(orderCode);

            // Lưu đơn hàng vào cơ sở dữ liệu
            OrderDAO orderDAO = new OrderDAO();
            orderDAO.createOrder(order);
            
            // Chuyển hướng đến trang quản lý đơn hàng
            response.sendRedirect("adminOrders");

        } catch (NumberFormatException e) {
            // Ghi log lỗi định dạng số
            Logger.getLogger(MotorOfEmployeeCreateServlet.class.getName())
                    .log(Level.SEVERE, "Invalid number format in order creation", e);

            // Đặt thông báo lỗi và chuyển hướng trở lại
            request.getSession().setAttribute("errorMessage", "Invalid numeric input: " + e.getMessage());
            response.sendRedirect("MotorOfEmployeeCreateServlet");
        } catch (Exception e) {
            // Ghi log lỗi khác
            Logger.getLogger(MotorOfEmployeeCreateServlet.class.getName())
                    .log(Level.SEVERE, "Error creating order", e);

            // Đặt thông báo lỗi và chuyển hướng trở lại
            request.getSession().setAttribute("errorMessage", "Error creating order: " + e.getMessage());
            response.sendRedirect("MotorOfEmployeeCreateServlet");
        }
    }
}
