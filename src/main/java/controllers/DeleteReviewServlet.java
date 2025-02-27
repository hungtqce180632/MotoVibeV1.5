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
@WebServlet("/DeleteReviewServlet")
public class DeleteReviewServlet extends HttpServlet {

    private ReviewDAO reviewDAO = new ReviewDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");
        if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only employees can delete reviews.");
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

        boolean deleted = reviewDAO.deleteReview(reviewId);
        if (!deleted) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to delete review in DB.");
            return;
        }

        // redirect to motorDetail or another page
        response.sendRedirect("motorDetail?id=" + r.getMotorId());
    }
}
