/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.AppointmentDAO;
import dao.CustomerDAO;
import dao.EmployeeDAO;
import models.Appointment;
import utils.DBContext;

import java.io.IOException;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.PrintWriter;
import java.util.List;
import models.Employee;
import models.UserAccount;

/**
 * Servlet này xử lý các yêu cầu tạo cuộc hẹn (appointment) mới.
 * Document: AppointmentServlet
 * Created on: Feb 23, 2025, 4:11:08 AM
 * Author: hieunmce181623
 */
@WebServlet(name = "AppointmentServlet", urlPatterns = {"/appointment"})
public class AppointmentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet AppointmentServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AppointmentServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Xử lý yêu cầu GET, dùng để hiển thị trang tạo cuộc hẹn (appointment).
     * Kiểm tra vai trò người dùng và lấy thông tin cần thiết như khách hàng, nhân viên.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        // Kiểm tra nếu người dùng chưa đăng nhập, chuyển hướng về trang đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp"); // Nếu chưa đăng nhập -> chuyển hướng đến login
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();

        // Lấy thông tin khách hàng từ user ID
        int customerId = customerDAO.getCustomerIdByUserId(user.getUserId());
        String customerName = customerDAO.getCustomerNameByUserId(user.getUserId());

        // Lấy danh sách tất cả các nhân viên
        List<Employee> employees = employeeDAO.getAllEmployees();

        // Lấy nhân viên có ít cuộc hẹn nhất
        Employee leastBusyEmployee = getEmployeeWithLeastAppointments();
        int selectedEmployeeId = leastBusyEmployee != null ? leastBusyEmployee.getEmployeeId() : -1;

        // Lưu thông tin vào request để gửi cho JSP
        request.setAttribute("customerId", customerId);
        request.setAttribute("customerName", customerName);
        request.setAttribute("employees", employees);
        request.setAttribute("selectedEmployeeId", selectedEmployeeId);  // Cung cấp ID của nhân viên đã chọn

        request.getRequestDispatcher("add_appointment.jsp").forward(request, response); // Chuyển tiếp yêu cầu đến trang JSP
    }

    /**
     * Xử lý yêu cầu POST, dùng để xử lý thông tin cuộc hẹn người dùng gửi lên.
     * Tạo một cuộc hẹn mới và lưu vào cơ sở dữ liệu.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
         try {
            // Lấy thông tin từ form gửi lên
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String employeeIdStr = request.getParameter("employeeId");

            Integer employeeId = null;

            // Nếu người dùng không chọn nhân viên, tự động gán nhân viên có ít cuộc hẹn nhất
            if (employeeIdStr == null || employeeIdStr.isEmpty()) {
                Employee leastBusyEmployee = getEmployeeWithLeastAppointments();
                employeeId = leastBusyEmployee.getEmployeeId();
                request.setAttribute("selectedEmployeeId", employeeId);  // Set lại ID nhân viên được chọn
            } else {
                employeeId = Integer.parseInt(employeeIdStr);
                request.setAttribute("selectedEmployeeId", employeeId);  // Set lại ID nhân viên được chọn
            }

            // Lấy ngày bắt đầu và ghi chú từ form
            String dateStartStr = request.getParameter("dateStart");
            String note = request.getParameter("note");
            boolean appointmentStatus = request.getParameter("appointmentStatus").equals("1");

            // Chuyển đổi định dạng ngày từ String sang Date
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            Date startDate = formatter.parse(dateStartStr);
            Date endDate = new Date(startDate.getTime() + (2L * 24 * 60 * 60 * 1000)); // Thêm 2 ngày cho ngày kết thúc

            // Tạo đối tượng Appointment và thiết lập các thuộc tính
            Appointment appointment = new Appointment();
            appointment.setCustomerId(customerId);
            appointment.setEmployeeId(employeeId != null ? employeeId : 0);
            appointment.setDateStart(new java.sql.Timestamp(startDate.getTime()));
            appointment.setDateEnd(new java.sql.Timestamp(endDate.getTime()));
            appointment.setNote(note);
            appointment.setAppointmentStatus(appointmentStatus);

            // Lưu cuộc hẹn vào cơ sở dữ liệu
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            boolean success = appointmentDAO.createAppointment(appointment);

            // Nếu thành công, chuyển hướng về trang danh sách cuộc hẹn
            if (success) {
                response.sendRedirect("listAppointments?success=1"); // Thành công
            } else {
                response.sendRedirect("listAppointments?error=1"); // Thất bại
            }
        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            response.sendRedirect("add_appointment.jsp?error=1"); // Xử lý lỗi
        }
    }

    /**
     * Tìm nhân viên có ít cuộc hẹn nhất.
     * @return Nhân viên có ít cuộc hẹn nhất
     */
    private Employee getEmployeeWithLeastAppointments() {
        EmployeeDAO employeeDAO = new EmployeeDAO();
        AppointmentDAO appointmentDAO = new AppointmentDAO();

        // Lấy tất cả nhân viên
        List<Employee> employees = employeeDAO.getAllEmployees();
        Employee leastBusyEmployee = null;
        int minAppointments = Integer.MAX_VALUE;

        // Duyệt qua tất cả nhân viên và tìm nhân viên có ít cuộc hẹn nhất
        for (Employee employee : employees) {
            int appointmentCount = appointmentDAO.getAppointmentsByEmployeeId(employee.getEmployeeId()).size();
            if (appointmentCount < minAppointments) {
                minAppointments = appointmentCount;
                leastBusyEmployee = employee;
            }
        }
        return leastBusyEmployee;
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
