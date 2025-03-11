/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.MotorDAO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Customer;
import models.Motor;

/**
 *
 * @author ACER
 */
@WebServlet(name = "MotorOfEmployeeCreateServlet", urlPatterns = {"/MotorOfEmployeeCreateServlet"})
public class MotorOfEmployeeCreateServlet extends HttpServlet {
@Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String motorIdParam = request.getParameter("motorId");
            String customerIdParam = request.getParameter("customerId");

            if (motorIdParam != null) {
                int motorId = Integer.parseInt(motorIdParam);
                MotorDAO motorDAO = new MotorDAO();
                Motor motor = motorDAO.getMotorById(motorId);

                if (motor != null) {
                    // Add motor details to request scope for display
                    request.setAttribute("motor", motor);
                }
            }
            // If a customerId is passed, fetch the specific customer details
            if (customerIdParam != null) {
                int customerId = Integer.parseInt(customerIdParam);
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = customerDAO.getCustomerById(customerId);

                if (customer != null) {
                    request.setAttribute("customer", customer);
                }
            }

            // Get all customers to populate the dropdown
            CustomerDAO customerDAO = new CustomerDAO();
            List<Customer> customers = customerDAO.getAllCustomersFD();
            request.setAttribute("customers", customers);

            // Get all motor names to populate the dropdown
            MotorDAO motorDAO = new MotorDAO();
            List<Motor> motors = motorDAO.getAllMotors();
            request.setAttribute("motors", motors);

            // Forward the request to the JSP to display the motor info
            request.getRequestDispatcher("order_by_employee.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(MotorOfEmployeeCreateServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
