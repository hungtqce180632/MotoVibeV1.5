/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.time.LocalDateTime;

import dao.InventoryLogDAO;
import dao.MotorDAO;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.InventoryLog;
import models.Motor;
import models.Order;
import models.UserAccount;
import utils.DBContext;

/**
 *
 * @author ACER
 */
@WebServlet("/confirmDeposit")
public class ConfirmDepositServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        // Get the current user from session for logging
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");
        if (user == null || !user.getRole().equalsIgnoreCase("admin")) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        Connection conn = null;
        try {
            conn = DBContext.getConnection();
            conn.setAutoCommit(false);
            
            // Initialize DAOs
            OrderDAO orderDAO = new OrderDAO();
            MotorDAO motorDAO = new MotorDAO();
            InventoryLogDAO inventoryLogDAO = new InventoryLogDAO();
            
            // Get order details
            Order order = orderDAO.getOrderById(Integer.parseInt(orderId));
            if (order == null) {
                throw new ServletException("Order not found");
            }
            
            // Get motor information and check stock
            Motor motor = motorDAO.getMotorById(order.getMotorId());
            if (motor == null) {
                throw new ServletException("Motor not found");
            }
            
            // Check if there is sufficient inventory
            int previousQuantity = motor.getQuantity();
            if (previousQuantity < 1) {
                throw new ServletException("Not enough stock to complete this order");
            }
            
            // Decrease motor quantity by 1
            boolean quantityUpdated = motorDAO.decreaseMotorQuantity(order.getMotorId(), 1);
            if (!quantityUpdated) {
                throw new ServletException("Failed to update motor quantity");
            }
            
            // Create inventory log entry
            InventoryLog log = new InventoryLog(
                0, // logId (auto-generated)
                order.getMotorId(),
                previousQuantity,
                -1, // decrease quantity by 1
                "decrease",
                user.getUserId(),
                LocalDateTime.now(),
                "Deposit confirmed for Order #" + orderId
            );
            inventoryLogDAO.addLog(log);
            
            // Confirm the deposit
            boolean depositConfirmed = orderDAO.confirmDeposit(orderId);
            if (!depositConfirmed) {
                throw new ServletException("Failed to confirm deposit");
            }
            
            // Commit transaction
            conn.commit();
            
            // Redirect with success message
            response.sendRedirect("adminOrders?status=success");
            
        } catch (SQLException | ServletException e) {
            // Roll back transaction on error
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            
            e.printStackTrace();
            response.sendRedirect("adminOrders?status=error&message=" + e.getMessage());
        } finally {
            // Restore auto-commit and close connection
            try {
                if (conn != null) {
                    conn.setAutoCommit(true);
                    conn.close();
                }
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
    }
}