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
 *
 * @author Jackt
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();
        
        int customerId = customerDAO.getCustomerIdByUserId(user.getUserId());
        List<Employee> employees = employeeDAO.getAllEmployees(); 

        request.setAttribute("customerId", customerId);
        request.setAttribute("employees", employees);

        request.getRequestDispatcher("add_appointment.jsp").forward(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Retrieve form parameters
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String employeeIdStr = request.getParameter("employeeId");
            Integer employeeId = (employeeIdStr != null && !employeeIdStr.isEmpty()) ? Integer.parseInt(employeeIdStr) : null;

            String dateStartStr = request.getParameter("dateStart");
            String dateEndStr = request.getParameter("dateEnd");
            String note = request.getParameter("note");
            boolean appointmentStatus = request.getParameter("appointmentStatus").equals("1");

            // Convert date strings to SQL Timestamp format
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date startDate = formatter.parse(dateStartStr);
            Date endDate = (dateEndStr != null && !dateEndStr.isEmpty()) ? formatter.parse(dateEndStr) : null;

            // Create Appointment object
            Appointment appointment = new Appointment();
            appointment.setCustomerId(customerId);
            appointment.setEmployeeId(employeeId != null ? employeeId : 0); // Default to 0 if null
            appointment.setDateStart(new java.sql.Timestamp(startDate.getTime()));
            appointment.setDateEnd(endDate != null ? new java.sql.Timestamp(endDate.getTime()) : null);
            appointment.setNote(note);
            appointment.setAppointmentStatus(appointmentStatus);

            // Insert into database
            AppointmentDAO appointmentDAO = new AppointmentDAO();
            boolean success = appointmentDAO.createAppointment(appointment);

            if (success) {
                response.sendRedirect("listAppointments?success=1"); // Redirect to list_appointments.jsp
            } else {
                response.sendRedirect("listAppointments?error=1"); // Stay on the form page if failed
            }
        } catch (NumberFormatException | ParseException e) {
            e.printStackTrace();
            response.sendRedirect("add_appointment.jsp?error=1");
        }
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
