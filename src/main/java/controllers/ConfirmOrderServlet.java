/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.MotorDAO;
import dao.OrderDAO;
import dao.UserAccountDAO; // Import UserAccountDAO
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import models.Customer;
import models.Motor;
import models.Order;
import models.UserAccount;

/**
 *
 * @author truon
 */
@WebServlet("/confirmOrder")
public class ConfirmOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount loggedInUser = (UserAccount) session.getAttribute("user");

        // 1. Retrieve order data from the form
        int motorId = Integer.parseInt(request.getParameter("motorId"));
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String customerPhone = request.getParameter("customerPhone");
        String customerIdNumber = request.getParameter("customerIdNumber");
        String customerAddress = request.getParameter("customerAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        String orderCode = request.getParameter("orderCode");
        boolean hasWarranty = "true".equals(request.getParameter("hasWarranty"));

        // 2. Fetch Motor details
        MotorDAO motorDAO = new MotorDAO();
        Motor motor = motorDAO.getMotorById(motorId);

        if (motor == null) {
            response.sendRedirect("motorList?error=motorNotFound");
            return;
        }

        // 3. Basic Validation
        if (customerName == null || customerName.trim().isEmpty() ||
            customerEmail == null || customerEmail.trim().isEmpty() ||
            customerPhone == null || customerPhone.trim().isEmpty() ||
            customerIdNumber == null || customerIdNumber.trim().isEmpty() ||
            customerAddress == null || customerAddress.trim().isEmpty() ||
            paymentMethod == null || paymentMethod.trim().isEmpty()) {
            response.sendRedirect("orderMotor?id=" + motorId + "&error=missingFields");
            return;
        }

        // 4. Process customer data
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customerToUse = null;

        if (loggedInUser != null && "customer".equalsIgnoreCase(loggedInUser.getRole())) {
            // Logged in customer - get their database row
            customerToUse = customerDAO.getCustomerByUserId(loggedInUser.getUserId());
            
            // Update customer information if it has changed
            if (customerToUse != null && (!customerToUse.getName().equals(customerName) || 
                !customerToUse.getPhoneNumber().equals(customerPhone) || 
                !customerToUse.getAddress().equals(customerAddress))) {
                
                customerToUse.setName(customerName);
                customerToUse.setPhoneNumber(customerPhone);
                customerToUse.setAddress(customerAddress);
                customerDAO.updateCustomer(customerToUse);
            }
        }
        
        // If we couldn't find the customer, redirect to login
        if (customerToUse == null) {
            response.sendRedirect("login.jsp?redirect=orderMotor&id=" + motorId);
            return;
        }

        // 5. Create Order object
        Order order = new Order();
        order.setCustomerId(customerToUse.getCustomerId());
        order.setMotorId(motorId);
        order.setPaymentMethod(paymentMethod);
        
        // Calculate total amount including warranty if selected
        double basePrice = motor.getPrice();
        double totalAmount = basePrice;
        
        if (hasWarranty) {
            // Add 10% for warranty
            totalAmount = basePrice * 1.1;
        }
        
        order.setTotalAmount(totalAmount);
        order.setDepositStatus(false); // Default to false - admin will confirm deposit later
        order.setOrderStatus("Pending");
        order.setHasWarranty(hasWarranty);
        order.setOrderCode(orderCode);

        // 6. Insert Order into database
        OrderDAO orderDAO = new OrderDAO();
        if (orderDAO.createOrder(order)) {
            // Store some order details for the confirmation page
            request.setAttribute("orderId", order.getOrderId());
            request.setAttribute("orderCode", order.getOrderCode());
            request.setAttribute("orderDate", new java.util.Date());
            request.setAttribute("hasWarranty", hasWarranty);
            request.setAttribute("totalAmount", totalAmount);
            
            request.getRequestDispatcher("order_confirmation.jsp").forward(request, response);
        } else {
            response.sendRedirect("motorList?error=orderCreationFailed");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}