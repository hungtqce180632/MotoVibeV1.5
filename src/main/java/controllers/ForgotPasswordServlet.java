package controllers;

import dao.UserAccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;

/**
 * Controller for handling forgot password requests
 */
@WebServlet(name="ForgotPasswordServlet", urlPatterns={"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("emailTxt");
        
        UserAccountDAO accDAO = new UserAccountDAO();
        if (accDAO.checkEmailExists(email)) {
            // Generate OTP
            String otp = generateOTP();
            
            // Store OTP in session (using the same attribute names as other servlets)
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);  // Changed from "OTP" to "otp" for consistency
            session.setAttribute("emailSendOTP", email);  // Changed from "email" to "emailSendOTP" for consistency
            
            // Send OTP to email (implement sendEmail method in AccountDAO)
            accDAO.SendOTPToEmail(email, otp);
            
            // Redirect to OTP verification page
            response.sendRedirect("resetPassword");  // Changed to go directly to resetPassword
        } else {
            request.setAttribute("error", "Email does not exist. Please try again.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }

    private String generateOTP() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000); // Generate 6-digit OTP
        return String.valueOf(otp);
    }
}
