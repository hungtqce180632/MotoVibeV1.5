package controllers;

import dao.CustomerDAO;
import dao.WishlistDAO;
import models.Motor;
import models.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import models.UserAccount;

@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        // If user is not logged in, redirect to the login page
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Get customer information based on logged-in user
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByUserId(user.getUserId());

        // Get the wishlist for the customer
        WishlistDAO wishlistDAO = new WishlistDAO();
        List<Motor> wishlist = wishlistDAO.getWishlistForUser(customer.getCustomerId());

        // Set the wishlist as an attribute for the JSP page
        request.setAttribute("wishlist", wishlist);

        // Forward the request to wishlist.jsp
        request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the current session
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        // If user is not logged in, redirect to the login page
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");

        // Get customer information based on logged-in user
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByUserId(user.getUserId());

        // Get WishlistDAO to manage the wishlist
        WishlistDAO wishlistDAO = new WishlistDAO();

        if ("add".equals(action)) {
            int motorId = Integer.parseInt(request.getParameter("motorId"));

            // Add motor to wishlist
            boolean isAdded = wishlistDAO.addToWishlist(motorId, customer.getCustomerId());

            if (isAdded) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }

        } else if ("remove".equals(action)) {
            int motorId = Integer.parseInt(request.getParameter("motorId"));

            // Remove motor from wishlist
            boolean isRemoved = wishlistDAO.removeMotorFromWishlist(motorId, customer.getCustomerId());

            if (isRemoved) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        }
    }
}
