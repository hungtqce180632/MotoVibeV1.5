/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.MotorDAO;
import dao.OrderDAO;
import dao.WarrantyDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import models.Customer;
import models.Motor;
import models.Order;
import models.UserAccount;
import models.Warranty;

/**
 *
 * @author ACER
 */
@WebServlet(name = "ListOrderCustomerServlet", urlPatterns = {"/listCustomerOrders"})
public class ListOrderCustomerServlet extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();
    private CustomerDAO customerDAO = new CustomerDAO();
    private MotorDAO motorDAO = new MotorDAO();


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Get the logged-in user from session
            HttpSession session = request.getSession();
            UserAccount user = (UserAccount) session.getAttribute("user");
            
            // Check if user is logged in
            if (user == null) {
                response.sendRedirect("login.jsp");
                return;
            }
            
            // Check if user has Customer role
            if (!user.getRole().equalsIgnoreCase("Customer")) {
                response.sendRedirect("home");
                return;
            }
            
            // Get the customer ID for the logged-in user
            Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
            if (customer == null) {
                request.setAttribute("errorMessage", "Customer information not found");
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            
            // Fetch orders for this specific customer
            List<Order> customerOrders = orderDAO.getOrdersByCustomerId(customer.getCustomerId());
            
            // For each order, fetch and set motor details
            for (Order order : customerOrders) {
                // Get motor details
                Motor motor = motorDAO.getMotorById(order.getMotorId());
                if (motor != null) {
                    order.setMotorName(motor.getMotorName());
                }
                
                // Get warranty details if the order has warranty
                if (order.isHasWarranty()) {
                    Warranty warranty = orderDAO.getWarrantyByOrderId(order.getOrderId());
                    if (warranty != null) {
                        order.setWarranty(warranty);
                    }
                }
            }
            
            // Set the orders in the request scope to pass them to the JSP page
            request.setAttribute("orders", customerOrders);
            
            // Forward the request to the JSP page to display the orders
            request.getRequestDispatcher("list_orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error fetching events: " + e.getMessage());
        }
    }
}
