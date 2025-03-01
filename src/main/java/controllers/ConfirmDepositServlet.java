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

/**
 *
 * @author ACER
 */
@WebServlet("/confirmDeposit")
public class ConfirmDepositServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String orderId = request.getParameter("orderId");

        // Use orderId to update the order status in the database
        OrderDAO order = new OrderDAO();
        boolean success = order.confirmDeposit(orderId);

        if (success) {
            // Redirect or show success message
            response.sendRedirect("adminOrders?status=success");
        } else {
            // Handle error
            response.sendRedirect("adminOrders?status=error");
        }
    }
}