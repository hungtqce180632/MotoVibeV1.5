package controllers;

import dao.UserAccountDAO;
import models.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.Random;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Render the reset password form
        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");
        String otp = request.getParameter("otp");

        // Retrieve OTP from session
        HttpSession session = request.getSession();
        String sessionOtp = (String) session.getAttribute("otp");

        // Check if OTP matches the one sent to the user's email
        if (otp == null || !otp.equals(sessionOtp)) {
            request.setAttribute("error", "Invalid OTP.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Check if email and passwords are not null or empty
        if (email == null || newPassword == null || confirmPassword == null || email.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Check if the new password and confirm password match
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Check if the user exists in the database
        UserAccountDAO userDao = new UserAccountDAO();
        UserAccount user = userDao.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email does not exist.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Update the password in the database
        boolean isUpdated = userDao.updatePassword(user.getUserId(), newPassword);

        if (isUpdated) {
            // Redirect to the login page after successful password reset
            request.setAttribute("success", "Password reset successfully. Please log in.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }

    // Method to generate a random OTP
    private String generateOtp() {
        Random random = new Random();
        int otp = random.nextInt(999999); // Generate a 6-digit OTP
        return String.format("%06d", otp); // Pad with leading zeros if necessary
    }

}
