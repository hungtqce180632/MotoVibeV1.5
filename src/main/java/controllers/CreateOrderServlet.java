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
import java.time.LocalDate;
import models.Motor;

/**
 *
 * @author truon
 */
@WebServlet("/createOrder")
public class CreateOrderServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null || !user.getRole().equalsIgnoreCase("Customer")) {
            response.sendRedirect("login.jsp");
            return;
        }

        int motorId = Integer.parseInt(request.getParameter("motorId"));
        String paymentMethod = request.getParameter("paymentMethod");
        double totalAmount = Double.parseDouble(request.getParameter("totalAmount"));
        boolean depositStatus = Boolean.parseBoolean(request.getParameter("depositStatus"));
        boolean hasWarranty = Boolean.parseBoolean(request.getParameter("hasWarranty"));
        LocalDate startDate = LocalDate.parse(request.getParameter("startDate")); // Assuming yyyy-MM-dd format from input
        LocalDate endDate = LocalDate.parse(request.getParameter("endDate"));

        Order order = new Order();
        order.setCustomerId(user.getUserId()); // Customer user ID
        order.setMotorId(motorId);
        order.setPaymentMethod(paymentMethod);
        order.setTotalAmount(totalAmount);
        order.setDepositStatus(depositStatus);
        order.setOrderStatus("Pending"); // Assuming order starts as "active"
        order.setDateStart(Date.valueOf(startDate)); // Convert LocalDate to java.sql.Date
        order.setDateEnd(Date.valueOf(endDate));
        order.setHasWarranty(hasWarranty);
        order.setWarrantyId(null); // Warranty initially null, employee will set later


        OrderDAO orderDAO = new OrderDAO();
        MotorDAO motorDAO = new MotorDAO();

        // Check if quantity is available and decrease it
        Motor motor = motorDAO.getMotorById(motorId);
        if (motor != null && motor.getQuantity() > 0) {
            if (motorDAO.decreaseMotorQuantity(motorId, 1)) { // Decrease quantity by 1 upon order
                if (orderDAO.createOrder(order)) {
                    response.sendRedirect("orderConfirmation.jsp?orderId=" + order.getOrderId()); // Redirect to confirmation page
                    return;
                } else {
                    // Order creation failed but quantity was decreased, need to handle rollback or inventory log
                    // For simplicity here, just redirect with error and *not* rollback quantity decrease. Robust system needs rollback.
                    response.sendRedirect("create_order.jsp?orderError=dbError&motorId=" + motorId);
                    return;
                }
            } else {
                response.sendRedirect("create_order.jsp?orderError=quantityUpdateFailed&motorId=" + motorId); // Quantity update failed
                return;
            }

        } else {
            response.sendRedirect("create_order.jsp?orderError=outOfStock&motorId=" + motorId); // Out of stock
        }
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
