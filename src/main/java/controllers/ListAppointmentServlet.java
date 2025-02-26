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
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if a input/output error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        System.out.println("ListAppointmentServlet - processRequest started"); // DEBUG

        if (user == null) {
            System.out.println("User is null, redirecting to login.jsp"); // DEBUG
            response.sendRedirect("login.jsp"); // Redirect to login if not logged in
            return;
        }
        CustomerDAO customerDAO = new CustomerDAO();
        AppointmentDAO appointmentDAO = new AppointmentDAO();
        List<Appointment> appointmentList = null; // Initialize to null for debugging
        int customerID;

        System.out.println("User Role: " + user.getRole()); // DEBUG

        try {
            if (user.getRole().equalsIgnoreCase("Customer")) {
                // Customer: Get appointments for the logged-in customer
                customerID = customerDAO.getCustomerIdByUserId(user.getUserId());
                appointmentList = appointmentDAO.getAppointmentsByCustomerId(customerID);
                request.setAttribute("userRole", "customer"); // Indicate role for JSP
                System.out.println("User is Customer. Fetched appointments for customer ID: " + user.getUserId() + ", List size: " + (appointmentList != null ? appointmentList.size() : "null")); // DEBUG
            } else if (user.getRole().equalsIgnoreCase("Employee")) {
                // Employee: Get all appointments
                appointmentList = appointmentDAO.getAllAppointments();
                request.setAttribute("userRole", "employee"); // Indicate role for JSP
                System.out.println("User is Employee. Fetched all appointments. List size: " + (appointmentList != null ? appointmentList.size() : "null")); // DEBUG
            } else {
                // Admin or unexpected role - for now, treat as employee (can adjust if needed)
                appointmentList = appointmentDAO.getAllAppointments();
                request.setAttribute("userRole", "employee"); // Or "admin" if you want different admin view
                System.out.println("User is Admin/Other. Fetched all appointments. List size: " + (appointmentList != null ? appointmentList.size() : "null")); // DEBUG
            }
        } catch (Exception e) {
            System.err.println("Exception in ListAppointmentServlet: " + e.getMessage()); // DEBUG - Print exception message
            e.printStackTrace(); // DEBUG - Print full stack trace to server log
        }

        
        request.setAttribute("appointments", appointmentList);
        System.out.println("Setting appointments attribute. List is " + (appointmentList != null ? "not null" : "null")); // DEBUG
        request.getRequestDispatcher("list_appointments.jsp").forward(request, response); // Forward to JSP for display
        System.out.println("Forwarded to list_appointments.jsp"); // DEBUG
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an input/output error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Servlet to list appointments based on user role";
    }

}
