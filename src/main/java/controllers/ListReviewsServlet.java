/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import models.Review;
import models.UserAccount;


/*
 * Servlet to list all reviews in the database for employees to view
 * author: truon
 */
@WebServlet(name = "ListReviewsServlet", urlPatterns = {"/listReviews"})
public class ListReviewsServlet extends HttpServlet {
    
    private ReviewDAO reviewDAO = new ReviewDAO();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");
        
        // Check if user is employee
        if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Access denied");
            return;
        }
        
        try {
            // Get all reviews
            List<Review> reviews = reviewDAO.getAllReviews();
            request.setAttribute("reviews", reviews);
            request.getRequestDispatcher("list_reviews.jsp").forward(request, response);
            
        } catch (SQLException e) {
            throw new ServletException("Error loading reviews", e);
        }
    }
}
