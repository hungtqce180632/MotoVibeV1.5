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
import java.security.MessageDigest;
import java.util.Random;

@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // Method to hash password using MD5 - copied from RegisterServlet
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Render the reset password form
        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Updated parameter names to match JSP form field names
        String email = request.getParameter("emailTxt");
        String newPassword = request.getParameter("pwdTxt");
        String confirmPassword = request.getParameter("confirmPassword");
        String otp = request.getParameter("otp");
        String verificationResult = request.getParameter("OTPResult");

        // Check if OTP has been verified successfully
        if (!"Success".equals(verificationResult)) {
            request.setAttribute("error", "Please verify your OTP first.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Check if email and passwords are not null or empty
        if (email == null || newPassword == null || confirmPassword == null || 
            email.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
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

        // Hash the password before saving to the database
        String hashedPassword = hashPassword(newPassword);
        if (hashedPassword == null) {
            request.setAttribute("error", "Error processing password. Please try again.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Update the password in the database with the hashed password
        boolean isUpdated = userDao.updatePassword(user.getUserId(), hashedPassword);

        if (isUpdated) {
            // Set success message in session and redirect to login page
            HttpSession session = request.getSession();
            session.setAttribute("success", "Password reset successfully. Please log in with your new password.");
            response.sendRedirect("login.jsp");
        } else {
            request.setAttribute("error", "Failed to reset password. Please try again.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }
}
