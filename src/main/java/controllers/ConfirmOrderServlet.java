/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.InventoryLogDAO;
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
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import models.Customer;
import models.InventoryLog;
import models.Motor;
import models.Order;
import models.UserAccount;
import utils.DBContext;

/**
 *
 * @author truon
 */
@WebServlet("/confirmOrder")
public class ConfirmOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount loggedInUser = (UserAccount) session.getAttribute("user");
        
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
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
            
            // Check if motor is still in stock
            if (motor.getQuantity() <= 0) {
                response.sendRedirect("motorDetail?id=" + motorId + "&error=outOfStock");
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
                // Decrease motor quantity by 1
                int previousQuantity = motor.getQuantity();
                motor.setQuantity(previousQuantity - 1);
                try {
                    motorDAO.updateMotor(motor);
                    boolean updated = true; // Assume success if no exception
                    
                    if (!updated) {
                        // If update fails, roll back transaction
                        conn.rollback();
                        response.sendRedirect("motorList?error=quantityUpdateFailed");
                        return;
                    }
                    
                    // Log the inventory change
                    InventoryLogDAO logDAO = new InventoryLogDAO();
                    InventoryLog log = new InventoryLog(
                        0, 
                        motorId, 
                        previousQuantity, 
                        -1, 
                        "decrease", 
                        loggedInUser != null ? loggedInUser.getUserId() : 0, 
                        LocalDateTime.now(), 
                        "Order created: " + order.getOrderCode()
                    );
                    logDAO.addLog(log);
                    
                    // Commit the transaction
                    conn.commit();
                    
                    // Calculate VND amount
                    int exchangeRate = 25700;
                    long totalAmountVND = Math.round(totalAmount * exchangeRate);
                    
                    // Store some order details for the confirmation page
                    request.setAttribute("orderId", order.getOrderId());
                    request.setAttribute("orderCode", order.getOrderCode());
                    request.setAttribute("orderDate", new java.util.Date());
                    request.setAttribute("hasWarranty", hasWarranty);
                    request.setAttribute("totalAmount", totalAmount);
                    request.setAttribute("totalAmountVND", totalAmountVND);
                    
                    request.getRequestDispatcher("order_confirmation.jsp").forward(request, response);
                } catch (SQLException ex) {
                    // If update fails with exception, roll back transaction
                    conn.rollback();
                    ex.printStackTrace();
                    response.sendRedirect("motorList?error=quantityUpdateFailed");
                    return;
                }
            } else {
                conn.rollback();
                response.sendRedirect("motorList?error=orderCreationFailed");
            }
        } catch (SQLException e) {
            // Handle database errors
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
            e.printStackTrace();
            response.sendRedirect("motorList?error=databaseError");
        } finally {
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("home");
    }
}