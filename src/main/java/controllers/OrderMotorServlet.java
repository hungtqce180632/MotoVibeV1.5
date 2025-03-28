/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.MotorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import models.Motor;
import models.UserAccount;

/**
 *
 * @author truon
 */
@WebServlet("/orderMotor")
public class OrderMotorServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp"); // Redirect to login if not logged in
            return;
        }

        int motorId = Integer.parseInt(request.getParameter("id")); // Get motorId from request
        MotorDAO motorDAO = new MotorDAO();
        Motor motor = motorDAO.getMotorById(motorId);

        if (motor == null) {
            response.sendRedirect("motorList"); // Redirect to motor list if motor not found
            return;
        }
        
        // Check if motor is in stock
        if (motor.getQuantity() <= 0) {
            response.sendRedirect("motorDetail?id=" + motorId + "&error=outOfStock");
            return;
        }

        request.setAttribute("motor", motor);
        request.getRequestDispatcher("create_order.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // For now, handle both GET and POST the same way for order initiation
    }
}
