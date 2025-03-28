package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet for handling contact and FAQ page requests
 * 
 * @author truon
 */
@WebServlet(name = "ContactServlet", urlPatterns = {"/contact-us"})
public class ContactServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Simply forward to the JSP page
        request.getRequestDispatcher("contact-us.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // If you want to implement a contact form submission functionality
        // You can handle it here in the future
        
        // For now, just redirect back to the contact page with a success parameter
        response.sendRedirect("contact-us?success=true");
    }
}
