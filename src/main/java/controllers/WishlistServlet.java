package controllers;

import dao.WishlistDAO;
import dao.CustomerDAO;
import models.Motor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/wishlist")
public class WishlistServlet extends HttpServlet {

    private WishlistDAO wishlistDAO;
    private CustomerDAO customerDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        wishlistDAO = new WishlistDAO();
        customerDAO = new CustomerDAO();
    }

    // Method to handle GET requests and display the user's wishlist
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");  // Cast to Integer, which is the type stored in session

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = customerDAO.getCustomerIdByUserId(userId); // Get customerId from userId
        List<Motor> wishlist = wishlistDAO.getWishlistForUser(customerId);  // Fetch wishlist from DB

        request.setAttribute("wishlist", wishlist);  // Set wishlist in request for the JSP page
        request.getRequestDispatcher("/wishlist.jsp").forward(request, response);  // Forward to wishlist.jsp
    }

    // Method to handle POST requests for adding/removing items from the wishlist
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("userId");

        if (userId == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int customerId = customerDAO.getCustomerIdByUserId(userId); // Get customerId based on userId

        // Handling the "add" action to add an item to the wishlist
        if ("add".equals(action)) {
            String motorIdStr = request.getParameter("motorId");

            // Check if motorId is valid
            if (motorIdStr == null || motorIdStr.isEmpty()) {
                response.getWriter().write("Invalid motorId.");
                return;
            }

            try {
                int motorId = Integer.parseInt(motorIdStr);  // Parse the motorId as integer

                // Check if the motor is already in the wishlist
                if (!wishlistDAO.checkHaveWish(motorId, customerId)) {
                    boolean added = wishlistDAO.addToWishlist(motorId, customerId);
                    if (added) {
                        response.getWriter().write("success");  // Return success message for AJAX
                    } else {
                        response.getWriter().write("error");  // Return error if add failed
                    }
                } else {
                    response.getWriter().write("This motorbike is already in your wishlist.");
                }
            } catch (NumberFormatException e) {
                response.getWriter().write("Invalid motorId format.");
            }
        } 
        // Handling the "remove" action to remove an item from the wishlist
        else if ("remove".equals(action)) {
            String motorIdStr = request.getParameter("motorId");

            if (motorIdStr == null || motorIdStr.isEmpty()) {
                response.getWriter().write("Invalid motorId.");
                return;
            }

            try {
                int motorId = Integer.parseInt(motorIdStr);  // Parse the motorId as integer

                boolean removed = wishlistDAO.removeCarFromWishlist(motorId, customerId);
                if (removed) {
                    response.getWriter().write("success");  // Return success message for AJAX
                } else {
                    response.getWriter().write("error");  // Return error if remove failed
                }
            } catch (NumberFormatException e) {
                response.getWriter().write("Invalid motorId format.");
            }
        } 
        else {
            response.getWriter().write("Invalid action.");
        }
    }
}
