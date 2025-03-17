package controllers;

import dao.MotorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.DecimalFormat;
import models.Motor;

/**
 *
 * @author truon
 */
@WebServlet("/paymentConfirmation")
public class PaymentConfirmationServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form parameters
        int motorId = Integer.parseInt(request.getParameter("motorId"));
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String customerPhone = request.getParameter("customerPhone");
        String customerIdNumber = request.getParameter("customerIdNumber");
        String customerAddress = request.getParameter("customerAddress");
        String paymentMethod = request.getParameter("paymentMethod");
        boolean hasWarranty = "true".equals(request.getParameter("hasWarranty"));
        
        // Generate an order code
        String orderCode = "MV-" + System.currentTimeMillis() % 10000;
        
        // Get motor details for pricing
        MotorDAO motorDAO = new MotorDAO();
        Motor motor = motorDAO.getMotorById(motorId);
        
        if (motor == null) {
            response.sendRedirect("motorList?error=motorNotFound");
            return;
        }
        
        // Calculate total amount including warranty if selected
        double basePrice = motor.getPrice();
        double totalAmount = basePrice;
        
        if (hasWarranty) {
            // Add 10% for warranty
            totalAmount = basePrice * 1.1;
        }
        
        DecimalFormat df = new DecimalFormat("#.##");
        String formattedTotal = df.format(totalAmount);
        
        // Pass all parameters to the JSP
        request.setAttribute("motorId", motorId);
        request.setAttribute("customerName", customerName);
        request.setAttribute("customerEmail", customerEmail);
        request.setAttribute("customerPhone", customerPhone);
        request.setAttribute("customerIdNumber", customerIdNumber);
        request.setAttribute("customerAddress", customerAddress);
        request.setAttribute("paymentMethod", paymentMethod);
        request.setAttribute("hasWarranty", hasWarranty);
        request.setAttribute("orderCode", orderCode);
        request.setAttribute("totalAmount", formattedTotal);
        request.setAttribute("motor", motor);
        
        // Forward to payment confirmation page
        request.getRequestDispatcher("payment_confirmation.jsp").forward(request, response);
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect GET requests to the home page
        response.sendRedirect("index.jsp");
    }
}
