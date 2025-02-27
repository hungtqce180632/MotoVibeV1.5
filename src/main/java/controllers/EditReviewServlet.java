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
import models.Review;
import models.UserAccount;

/**
 *
 * @author truon
 */
@WebServlet("/EditReviewServlet")
public class EditReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only employees can edit reviews.");
            return;
        }

        String reviewIdStr = request.getParameter("reviewId");
        if (reviewIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing reviewId");
            return;
        }
        int reviewId = Integer.parseInt(reviewIdStr);

        Review r = reviewDAO.getReviewById(reviewId);
        if (r == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Review not found.");
            return;
        }

        // Show an edit form (or forward to a JSP for editing)
        request.setAttribute("review", r);
        request.getRequestDispatcher("edit_review.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only employees can edit reviews.");
            return;
        }

        String reviewIdStr = request.getParameter("reviewId");
        String ratingStr = request.getParameter("rating");
        String reviewText = request.getParameter("reviewText");

        if (reviewIdStr == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing reviewId");
            return;
        }

        int reviewId = Integer.parseInt(reviewIdStr);
        int rating = 0;
        if (ratingStr != null && !ratingStr.trim().isEmpty()) {
            rating = Integer.parseInt(ratingStr);
        }

        Review r = reviewDAO.getReviewById(reviewId);
        if (r == null) {
            response.sendError(HttpServletResponse.SC_NOT_FOUND, "Review not found in DB.");
            return;
        }

        r.setRating(rating);
        r.setReviewText(reviewText);
        // r.setReviewStatus(...) // if employees can toggle active/inactive

        boolean updated = reviewDAO.updateReview(r);
        if (!updated) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update review in DB.");
            return;
        }

        // Redirect or forward somewhere, e.g. back to the motor detail
        response.sendRedirect("motorDetail?id=" + r.getMotorId());
    }
}
