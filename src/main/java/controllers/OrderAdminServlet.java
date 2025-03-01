package controllers;

import dao.OrderDAO;
import models.Order;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import java.util.List;



@WebServlet(name = "OrderAdminServlet", urlPatterns = {"/adminOrders"})
public class OrderAdminServlet extends HttpServlet {


    OrderDAO orderDAO = new OrderDAO();
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
 try {
            // Fetch all events using EventDAO
            List <Order> orders = orderDAO.getAllOrders();

            // Set the events in the request scope to pass them to the JSP page
            request.setAttribute("orders", orders);

            // Forward the request to manage_event.jsp to display the events
            request.getRequestDispatcher("list_order_admin.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error fetching events: " + e.getMessage());
        }
    }
}
