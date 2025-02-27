/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.OrderDAO;
import dao.ReviewDAO;
import dao.CustomerDAO;
import models.Customer;
import models.Review;
import models.UserAccount;
import models.Motor;
import java.io.IOException;
import java.sql.Date;
import java.time.LocalDate;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

/**
 *
 * @author truon
 */
@WebServlet("/CreateReviewServlet")
public class CreateReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO = new ReviewDAO();
    private OrderDAO orderDAO = new OrderDAO();
    private CustomerDAO customerDAO = new CustomerDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Only customers can create reviews
        if (!"customer".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only customers can create reviews.");
            return;
        }

        // Parse parameters
        String motorIdStr = request.getParameter("motorId");
        String ratingStr = request.getParameter("rating");
        String reviewText = request.getParameter("reviewText");

        if (motorIdStr == null || motorIdStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing motorId.");
            return;
        }

        int motorId = Integer.parseInt(motorIdStr);
        int rating = 0;
        if (ratingStr != null && !ratingStr.trim().isEmpty()) {
            try {
                rating = Integer.parseInt(ratingStr);
            } catch (NumberFormatException e) {
                // If invalid, keep rating = 0
            }
        }

        // Check if the user purchased this motor
        Customer c = customerDAO.getCustomerByUserId(user.getUserId());
        if (c == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer not found for user.");
            return;
        }

        boolean purchased = orderDAO.hasPurchasedMotor(c.getCustomerId(), motorId);
        if (!purchased) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "You haven't purchased this motor, so you can't review it.");
            return;
        }

        // Build the new review object
        Review review = new Review();
        review.setCustomerId(c.getCustomerId());
        review.setMotorId(motorId);
        review.setRating(rating);
        review.setReviewText(reviewText);
        review.setReviewDate(LocalDate.now().toString()); // or format how you like
        review.setReviewStatus(true); // or false if employees must approve

        // Insert
        boolean success = reviewDAO.createReview(review);
        if (!success) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to create review in DB.");
            return;
        }

        // SIMPLE NOTIFICATION for employees, store in session (example)
        String notif = "User " + user.getEmail() + " has reviewed motor ID " + motorId;
        session.setAttribute("employeeNotification", notif);

        // Redirect back to motor detail page
        response.sendRedirect("motorDetail?id=" + motorId);
    }
}