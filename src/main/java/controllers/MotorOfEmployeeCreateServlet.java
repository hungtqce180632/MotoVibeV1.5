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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            UserAccount user = (UserAccount) session.getAttribute("user");

            // Check if logged in user is an employee
            if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("login.jsp");
                return;
            }

            // Get form parameters
            int motorId = Integer.parseInt(request.getParameter("motorId"));
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String paymentMethod = request.getParameter("paymentMethod");
            boolean hasWarranty = "true".equals(request.getParameter("hasWarranty"));
            boolean depositStatus = "on".equals(request.getParameter("depositStatus"));

            // Validate that required fields are present
            if (motorId <= 0 || customerId <= 0 || paymentMethod == null || paymentMethod.trim().isEmpty()) {
                session.setAttribute("errorMessage", "All required fields must be filled out");
                response.sendRedirect("MotorOfEmployeeCreateServlet?motorId=" + motorId + "&customerId=" + customerId);
                return;
            }

            // Get motor details to calculate total amount
            MotorDAO motorDAO = new MotorDAO();
            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                session.setAttribute("errorMessage", "Selected motor does not exist");
                response.sendRedirect("MotorOfEmployeeCreateServlet");
                return;
            }

            // Check if motor is in stock
            if (motor.getQuantity() <= 0) {
                session.setAttribute("errorMessage", "Selected motor is out of stock");
                response.sendRedirect("MotorOfEmployeeCreateServlet?motorId=" + motorId + "&customerId=" + customerId);
                return;
            }

            // Create new order
            Order order = new Order();
            order.setCustomerId(customerId);
            order.setMotorId(motorId);
            order.setEmployeeId(user.getUserId()); // Set the employee who created the order
            order.setPaymentMethod(paymentMethod);
            
            // Calculate total amount with warranty if applicable
            double basePrice = motor.getPrice();
            double totalAmount = basePrice;
            if (hasWarranty) {
                totalAmount = basePrice * 1.10; // Add 10% warranty fee
            }
            order.setTotalAmount(totalAmount);
            
            order.setDepositStatus(depositStatus);
            order.setHasWarranty(hasWarranty);
            order.setOrderStatus("Processing"); // Initial status for employee-created orders

            // Generate order code
            String orderCode = "MV-" + System.currentTimeMillis() % 100000;
            order.setOrderCode(orderCode);

            // Save order to database
            OrderDAO orderDAO = new OrderDAO();
            orderDAO.createOrder(order);
            response.sendRedirect("adminOrders");


        } catch (NumberFormatException e) {
            // Log the error
            Logger.getLogger(MotorOfEmployeeCreateServlet.class.getName())
                    .log(Level.SEVERE, "Invalid number format in order creation", e);

            // Set error message and redirect back
            request.getSession().setAttribute("errorMessage", "Invalid numeric input: " + e.getMessage());
            response.sendRedirect("MotorOfEmployeeCreateServlet");
        } catch (Exception e) {
            // Log the error
            Logger.getLogger(MotorOfEmployeeCreateServlet.class.getName())
                    .log(Level.SEVERE, "Error creating order", e);

            // Set error message and redirect back
            request.getSession().setAttribute("errorMessage", "Error creating order: " + e.getMessage());
            response.sendRedirect("MotorOfEmployeeCreateServlet");
        }
    }
}
