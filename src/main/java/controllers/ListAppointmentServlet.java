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

        System.out.println("ListAppointmentServlet - processRequest started"); // DEBUG

        if (user == null) {
            System.out.println("User is null, redirecting to login.jsp"); // DEBUG
            response.sendRedirect("login.jsp"); // Not logged in -> login
            return;
        }

        System.out.println("User Role: " + user.getRole()); // DEBUG

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
                System.out.println("User is Customer. Fetched appointments for customer ID: "
                        + customerID + ", list size: "
                        + (appointmentList != null ? appointmentList.size() : "null"));

            } else if (role.equalsIgnoreCase("Employee")) {
                // Employee: get all appointments
                appointmentList = appointmentDAO.getAllAppointments();

                request.setAttribute("userRole", "employee");
                System.out.println("User is Employee. Fetched all appointments. List size: "
                        + (appointmentList != null ? appointmentList.size() : "null"));

            } else if (role.equalsIgnoreCase("Admin")) {
                // Admin: also get all appointments (if that's your logic)
                appointmentList = appointmentDAO.getAllAppointments();

                request.setAttribute("userRole", "admin");
                System.out.println("User is Admin. Fetched all appointments. List size: "
                        + (appointmentList != null ? appointmentList.size() : "null"));

            } else {
                // Some unexpected role - default to no appointments or treat as employee
                appointmentList = appointmentDAO.getAllAppointments(); // or none, up to you
                request.setAttribute("userRole", "employee"); // or "unknownRole"
                System.out.println("User has unknown role. Fetched all appointments. List size: "
                        + (appointmentList != null ? appointmentList.size() : "null"));
            }

        } catch (Exception e) {
            System.err.println("Exception in ListAppointmentServlet: " + e.getMessage());
            e.printStackTrace(); // log full stack trace
        }

        // Put the list of appointments in request scope, forward to JSP
        request.setAttribute("appointments", appointmentList);
        System.out.println("Setting appointments attribute. List is "
                + (appointmentList != null ? "not null" : "null"));

        request.getRequestDispatcher("list_appointments.jsp").forward(request, response);
        System.out.println("Forwarded to list_appointments.jsp"); // DEBUG
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
