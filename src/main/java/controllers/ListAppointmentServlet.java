/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.AppointmentDAO;
import dao.CustomerDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import models.Appointment;
import models.UserAccount;

/**
 *
 * @author truon
 */
@WebServlet("/listAppointments")
public class ListAppointmentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP GET and POST methods.
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
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
        List<Appointment> appointmentList = null;

        try {
            String role = user.getRole();
            if (role.equalsIgnoreCase("Customer")) {
                // Customer: get appointments for that customer's ID
                int customerID = customerDAO.getCustomerIdByUserId(user.getUserId());
                appointmentList = appointmentDAO.getAppointmentsByCustomerId(customerID);

                request.setAttribute("userRole", "customer");

            } else if (role.equalsIgnoreCase("Employee")) {
                // Employee: get all appointments
                appointmentList = appointmentDAO.getAllAppointments();

                request.setAttribute("userRole", "employee");

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

        // ✅ Handle success/error messages from redirects
        if (request.getParameter("success") != null) {
            request.setAttribute("success", "Appointment added successfully!");
        }
        if (request.getParameter("error") != null) {
            request.setAttribute("error", "Error adding appointment. Please try again.");
        }

        // ✅ Forward to JSP
        request.getRequestDispatcher("list_appointments.jsp").forward(request, response);


    }

    /**
     * Handles the HTTP GET method by calling processRequest.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP POST method by calling processRequest.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     */
    @Override
    public String getServletInfo() {
        return "Servlet to list appointments based on user role";
    }
}
