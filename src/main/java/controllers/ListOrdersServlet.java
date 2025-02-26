/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.OrderDAO;
import models.Order;
import models.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 *
 * @author truon
 */
@WebServlet("/listOrders")
public class ListOrdersServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private OrderDAO orderDAO = new OrderDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            // Not logged in, redirect
            System.out.println("[ListOrdersServlet] user is null -> redirecting to login.");
            response.sendRedirect("login.jsp");
            return;
        }

        // Debug prints to confirm role and userId
        System.out.println("[ListOrdersServlet] user.getEmail()   = " + user.getEmail());
        System.out.println("[ListOrdersServlet] user.getRole()   = " + user.getRole());
        System.out.println("[ListOrdersServlet] user.getUserId() = " + user.getUserId());

        List<Order> orders = null;
        String userRole = user.getRole() == null ? "" : user.getRole().trim().toLowerCase();

        try {
            if ("customer".equalsIgnoreCase(userRole)) {
                // If user is recognized as a customer, fetch their orders
                int customerId = customerDAO.getCustomerIdByUserId(user.getUserId());
                System.out.println("[ListOrdersServlet] Resolved customerId from userId "
                        + user.getUserId() + " => " + customerId);

                orders = orderDAO.getOrdersByCustomerId(customerId);
                request.setAttribute("userRole", "customer");

                if (orders != null) {
                    System.out.println("[ListOrdersServlet] Found " + orders.size()
                            + " orders for customerId=" + customerId);
                } else {
                    System.out.println("[ListOrdersServlet] orders was null for customerId=" + customerId);
                }

            } else if ("employee".equalsIgnoreCase(userRole) || "admin".equalsIgnoreCase(userRole)) {
                // Employees or admins see all orders
                orders = orderDAO.getAllOrders();
                request.setAttribute("userRole", userRole);

                if (orders != null) {
                    System.out.println("[ListOrdersServlet] Found " + orders.size() + " total orders.");
                } else {
                    System.out.println("[ListOrdersServlet] orders was null when fetching all orders.");
                }
            } else {
                // Some other role or unknown string => fallback
                System.out.println("[ListOrdersServlet] Unknown role => defaulting to getAllOrders.");
                orders = orderDAO.getAllOrders();
                request.setAttribute("userRole", userRole);

                if (orders != null) {
                    System.out.println("[ListOrdersServlet] (Fallback) Found " + orders.size() + " total orders.");
                } else {
                    System.out.println("[ListOrdersServlet] (Fallback) orders was null.");
                }
            }

        } catch (Exception e) {
            System.err.println("[ListOrdersServlet] Exception: " + e.getMessage());
            e.printStackTrace();
        }

        // Put the orders into request scope
        request.setAttribute("orders", orders);

        // Forward to JSP
        request.getRequestDispatcher("list_orders.jsp").forward(request, response);
        System.out.println("[ListOrdersServlet] Forwarded to list_orders.jsp\n");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
