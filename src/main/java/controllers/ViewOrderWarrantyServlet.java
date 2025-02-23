/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

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

/**
 *
 * @author truon
 */
@WebServlet("/viewOrderWarranty")
public class ViewOrderWarrantyServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int orderId = Integer.parseInt(request.getParameter("orderId"));
        OrderDAO orderDAO = new OrderDAO();
        Order order = orderDAO.getOrderWithWarranty(orderId);

        if (order != null) {
            // Role-based authorization - Example, adapt to your needs.
            boolean isAuthorized = false;
            if (user.getRole().equalsIgnoreCase("Customer") && order.getCustomerId() == user.getUserId()) { // Customer can view own order warranty
                isAuthorized = true;
            } else if (user.getRole().equalsIgnoreCase("Employee")) { // Employee can view all order warranties
                isAuthorized = true;
            }

            if (isAuthorized) {
                request.setAttribute("order", order);
                request.getRequestDispatcher("view_order_warranty.jsp").forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Not authorized to view this warranty.");
            }
        } else {
            response.sendRedirect("orderList?orderNotFound=true"); // Or wherever order lists are shown
        }
    }
}
