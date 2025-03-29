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
 *
 * @author truon
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
     * Handles the HTTP GET method by calling processRequest.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {

            response.sendRedirect("login.jsp"); // Not logged in -> login
            return;
        }

        CustomerDAO customerDAO = new CustomerDAO();
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        EmployeeDAO employeeDAO = new EmployeeDAO();
        List<Appointment> appointmentList = null;
        Map<Integer, Customer> customerMap = new HashMap<>();

        try {
            String role = user.getRole();
            if (role.equalsIgnoreCase("Customer")) {
                // Customer: get appointments for that customer's ID
                int customerID = customerDAO.getCustomerIdByUserId(user.getUserId());
                appointmentList = appointmentDAO.getAppointmentsByCustomerId(customerID);

                request.setAttribute("userRole", "customer");

            } else if (role.equalsIgnoreCase("Employee")) {

                Employee employee = employeeDAO.getEmployeeByUserId(user.getUserId()); // Assuming user ID is the same as employee ID
                appointmentList = appointmentDAO.getAppointmentsByEmployeeId(employee.getEmployeeId());

                for (Customer customer : customerDAO.getAllCustomers()) {
                    customerMap.put(customer.getCustomerId(), customer);
                }

                request.setAttribute("userRole", "employee");
                request.setAttribute("customerMap", customerMap);

            } else if (role.equalsIgnoreCase("Admin")) {
                // Admin: also get all appointments (if that's your logic)
                appointmentList = appointmentDAO.getAllAppointments();

                request.setAttribute("userRole", "admin");

            } else {
                // Some unexpected role - default to no appointments or treat as employee
                appointmentList = appointmentDAO.getAllAppointments(); // or none, up to you
                request.setAttribute("userRole", "employee"); // or "unknownRole"

            }

        } catch (Exception e) {
            System.err.println("Exception in ListAppointmentServlet: " + e.getMessage());
            e.printStackTrace(); // log full stack trace
        }

        // ✅ Set appointments in request scope
        request.setAttribute("appointments", appointmentList);

        try {
            String successParam = request.getParameter("success");
            String errorParam = request.getParameter("error");

            if (successParam != null) {
                int successCode = Integer.parseInt(successParam);
                if (successCode == 1) {
                    request.setAttribute("success", "Appointment added successfully!");
                } else if (successCode == 2) {
                    request.setAttribute("success", "Appointment cancelled successfully!");
                } else if (successCode == 3) {
                    request.setAttribute("success", "Appointment approved successfully!");
                } else if (successCode == 4) {
                    request.setAttribute("success", "Appointment declined successfully!");
                }
            }

            if (errorParam != null) {
                int errorCode = Integer.parseInt(errorParam);
                if (errorCode == 1) {
                    request.setAttribute("error", "Error adding appointment. Please try again.");
                } else if (errorCode == 2) {
                    request.setAttribute("error", "Failed to cancel appointment.");
                } else if (errorCode == 3) {
                    request.setAttribute("error", "Failed to approve appointment.");
                } else if (errorCode == 4) {
                    request.setAttribute("error", "Failed to decline appointment.");
                }
            }
        } catch (NumberFormatException e) {
            System.err.println("Invalid success/error parameter: " + e.getMessage());
        }

        // ✅ Forward to JSP
        request.getRequestDispatcher("list_appointments.jsp").forward(request, response);

    }

    /**
     * Handles the HTTP POST method by calling processRequest.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getServletPath();
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        try {
            int appointmentId = Integer.parseInt(request.getParameter("appointmentId"));

            if ("/approveAppointment".equals(action)) {
                boolean success = appointmentDAO.updateAppointmentStatus(appointmentId, true);
                if (success) {
                    response.sendRedirect("listAppointments?success=3");
                } else {
                    response.sendRedirect("listAppointments?error=3");
                }
            } else if ("/listAppointments".equals(action)) {
                boolean success = appointmentDAO.deleteAppointment(appointmentId);
                if (success) {
                    response.sendRedirect("listAppointments?success=2");
                } else {
                    response.sendRedirect("listAppointments?error=2");
                }
            }

        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("listAppointments?error=Invalid appointment ID");
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
