/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.OrderDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.Order;

/**
 *
 * @author ACER
 */
@WebServlet(name = "ConfirmOrderEmployeeServlet", urlPatterns = {"/ConfirmOrderEmployeeServlet"})
public class ConfirmOrderEmployeeServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        // Use orderId to update the order status in the database
        OrderDAO order = new OrderDAO();
        boolean success = order.confirmOrderStatus(orderId);

        if (success) {
            // Redirect or show success message
            response.sendRedirect("adminOrders?status=success");
        } else {
            // Handle error
            response.sendRedirect("adminOrders?status=error");
        }
    }
}