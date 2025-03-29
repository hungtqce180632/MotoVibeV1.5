package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet to reset chat conversation history
 * 
 * @author truon
 */
@WebServlet(name = "ResetChatServlet", urlPatterns = {"/ResetChatServlet"})
public class ResetChatServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        // Remove conversation history from session
        session.removeAttribute("conversationHistory");
        
        // Reset question count
        session.setAttribute("questionCount", 0);
        
        // Return success response
        response.setStatus(HttpServletResponse.SC_OK);
    }
}
