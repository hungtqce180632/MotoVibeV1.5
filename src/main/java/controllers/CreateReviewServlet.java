/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.OrderDAO;
import dao.ReviewDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import models.Customer;
import models.Review;
import models.UserAccount;

/**
 *
 * @author truon
 */
@WebServlet("/createReview")
public class CreateReviewServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Check if user is logged in
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Only customers can create reviews
        if (!"Customer".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only customers can create reviews.");
            return;
        }

        // Get parameters from form
        String motorIdStr = request.getParameter("motorId");
        String ratingStr = request.getParameter("rating");
        String reviewText = request.getParameter("reviewText");

        if (motorIdStr == null || motorIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing motorId parameter.");
            return;
        }

        int motorId = Integer.parseInt(motorIdStr);

        int rating = 0; // default if rating is optional
        if (ratingStr != null && !ratingStr.isEmpty()) {
            try {
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                rating = 0; // or handle error
            }
        }

        // Check if customer has actually purchased this motor
        CustomerDAO customerDAO = new CustomerDAO();
        Customer c = customerDAO.getCustomerByUserId(user.getUserId());
        if (c == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer profile not found.");
            return;
        }

        OrderDAO orderDAO = new OrderDAO();
        boolean hasPurchased = orderDAO.hasPurchasedMotor(c.getCustomerId(), motorId);
        if (!hasPurchased) {
            // They haven't purchased, so they cannot review
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You haven't purchased this motor, so you cannot review it.");
            return;
        }

        // Build the Review object
        Review review = new Review();
        review.setCustomerId(c.getCustomerId());
        review.setMotorId(motorId);
        review.setRating(rating);
        review.setReviewText(reviewText);
        review.setReviewStatus(true);  // or false if you want employees to approve
        // reviewDate is handled by the DB with GETDATE() or you can set it here

        // Insert the review
        ReviewDAO reviewDAO = new ReviewDAO();
        boolean success = reviewDAO.createReview(review);

        if (success) {
            // Redirect back to motor detail or a success page
            // e.g. "MotorDetailServlet?id=" + motorId
            response.sendRedirect("motorDetail?id=" + motorId);
        } else {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create review.");
        }
    }
}
