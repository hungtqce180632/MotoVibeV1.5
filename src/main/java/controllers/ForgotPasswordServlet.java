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
            
            // Store OTP in session
            HttpSession session = request.getSession();
            session.setAttribute("OTP", otp);
            session.setAttribute("email", email);
            
            // Send OTP to email (implement sendEmail method in AccountDAO)
            accDAO.SendOTPToEmail(email, otp);
            
            // Redirect to OTP verification page
            response.sendRedirect("/MotoVibe/verifyOtp");
        } else {
            request.getSession().setAttribute("message", "Email does not exist. Please try again.");
            response.sendRedirect("/MotoVibe/forgotPassword,jsp");
        }
    }

    private String generateOTP() {
        Random rand = new Random();
        int otp = 100000 + rand.nextInt(900000); // Generate 6-digit OTP
        return String.valueOf(otp);
    }
}
