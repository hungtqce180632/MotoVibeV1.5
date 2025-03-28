/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.BrandDAO;
import dao.FuelDAO;
import dao.ModelDAO;
import dao.MotorDAO;
import dao.ReviewDAO;
import dao.OrderDAO; // Add so we can check if user purchased
import dao.CustomerDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Brand;
import models.Customer;
import models.Fuel;
import models.Model;
import models.Motor;
import models.Review;
import models.UserAccount;

/**
 *
 * @author tiend
 */
@WebServlet(name = "MotorDetailServlet", urlPatterns = {"/motorDetail"})
public class MotorDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // 1) Parse the motorId
            int motorId = Integer.parseInt(request.getParameter("id"));

            // 2) Prepare DAOs
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();
            ReviewDAO reviewDAO = new ReviewDAO();
            OrderDAO orderDAO = new OrderDAO();
            CustomerDAO customerDAO = new CustomerDAO();

            // 3) Load motor
            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            // 4) Load brand/model/fuel
            Brand brand = brandDAO.getBrandById(motor.getBrandId());
            Model model = modelDAO.getModelById(motor.getModelId());
            Fuel fuel = fuelDAO.getFuelById(motor.getFuelId());

            // 5) Load reviews
            List<Review> reviews = reviewDAO.getAllReviewOfCar(motorId);

            // 6) Check if the logged-in user is a CUSTOMER who purchased the motor
            HttpSession session = request.getSession(false);
            UserAccount user = (session != null) ? (UserAccount) session.getAttribute("user") : null;

            // Initialize canReview as false
            boolean canReview = false;

            if (user != null && "customer".equalsIgnoreCase(user.getRole())) {
                // Find the customer's row
                Customer c = customerDAO.getCustomerByUserId(user.getUserId());
                if (c != null) {
                    // Check if they have purchased this motor (with Completed status)
                    boolean purchased = orderDAO.hasPurchasedMotor(c.getCustomerId(), motorId);
                    boolean alreadyReviewed = reviewDAO.hasAlreadyReviewed(c.getCustomerId(), motorId);
                    
                    // Customer can only review if they've purchased the motor AND haven't already reviewed it
                    canReview = purchased && !alreadyReviewed;
                    
                    // If they've purchased but already reviewed, set a message
                    if (purchased && alreadyReviewed) {
                        request.setAttribute("reviewMessage", "You have already submitted a review for this motor.");
                    }
                }
            }

            // 7) Put everything in request scope
            request.setAttribute("motor", motor);
            request.setAttribute("brand", brand);
            request.setAttribute("model", model);
            request.setAttribute("fuel", fuel);
            request.setAttribute("reviews", reviews);
            request.setAttribute("canReview", canReview);
            
            // Add stock availability check
            boolean inStock = motor.getQuantity() > 0;
            request.setAttribute("inStock", inStock);

            // 8) Forward to JSP
            request.getRequestDispatcher("motor_detail.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error retrieving motor details", e);
        }
    }
}
