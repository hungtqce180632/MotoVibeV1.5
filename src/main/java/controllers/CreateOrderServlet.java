/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.MotorDAO;
import dao.OrderDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Order;
import models.UserAccount;
import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.sql.Timestamp;
import models.Motor;

/**
 *
 * @author truon
 */
@WebServlet("/createOrder")
public class CreateOrderServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null || !user.getRole().equalsIgnoreCase("Customer")) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get form data
            int motorId = Integer.parseInt(request.getParameter("motorId"));
            String paymentMethod = request.getParameter("paymentMethod");
            boolean hasWarranty = Boolean.parseBoolean(request.getParameter("hasWarranty"));
            boolean depositStatus = Boolean.parseBoolean(request.getParameter("depositStatus"));

            // Create new order
            Order order = new Order();
            order.setCustomerId(user.getUserId());
            order.setMotorId(motorId);
            order.setPaymentMethod(paymentMethod);
            order.setTotalAmount(getMotorPrice(motorId));
            order.setDepositStatus(depositStatus);
            order.setHasWarranty(hasWarranty);
            
            // Note: dates and employee assignment are handled in OrderDAO
            
            OrderDAO orderDAO = new OrderDAO();
            boolean success = orderDAO.createOrder(order);

            if (success) {
                // Update motor quantity
                MotorDAO motorDAO = new MotorDAO();
                motorDAO.decreaseMotorQuantity(motorId, 1);
                
                response.sendRedirect("orderConfirmation.jsp?orderId=" + order.getOrderId());
            } else {
                response.sendRedirect("error.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        }
    }

    private Double getMotorPrice(int motorId) throws SQLException {
        MotorDAO motorDAO = new MotorDAO();
        Motor motor = motorDAO.getMotorById(motorId);
        return motor != null ? motor.getPrice() : 0.0;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null || !user.getRole().equalsIgnoreCase("Customer")) {
            response.sendRedirect("login.jsp");
            return;
        }

        int motorId = Integer.parseInt(request.getParameter("motorId"));
        MotorDAO motorDAO = new MotorDAO();
        Motor motor = motorDAO.getMotorById(motorId);

        if (motor != null) {
            request.setAttribute("motor", motor);
            request.getRequestDispatcher("create_order.jsp").forward(request, response); // Forward to order form
        } else {
            response.sendRedirect("motorList?motorNotFound=true"); // Motor not found
        }

    }
}
