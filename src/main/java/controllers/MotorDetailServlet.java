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
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import models.Brand;
import models.Fuel;
import models.Model;
import models.Motor;
import models.Review;

/**
 *
 * @author tiend
 */
@WebServlet(name = "MotorDetailServlet", urlPatterns = {"/motorDetail"})
public class MotorDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get motorId from the request parameter
            int motorId = Integer.parseInt(request.getParameter("id"));
            
            // Retrieve motor and related data
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();
            ReviewDAO reviewDAO = new ReviewDAO();  // ReviewDAO to fetch reviews
            
            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            // Retrieve related data for motorbike
            Brand brand = brandDAO.getBrandById(motor.getBrandId());
            Model model = modelDAO.getModelById(motor.getModelId());
            Fuel fuel = fuelDAO.getFuelById(motor.getFuelId());
            List<Review> reviews = reviewDAO.getAllReviewOfCar(motorId); // Fetch reviews for motorbike
            
            // Set attributes to be used in the JSP
            request.setAttribute("motor", motor);
            request.setAttribute("brand", brand);
            request.setAttribute("model", model);
            request.setAttribute("fuel", fuel);
            request.setAttribute("reviews", reviews);
            
            // Forward the request to the motor_detail.jsp page
            request.getRequestDispatcher("motor_detail.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error retrieving motor details", e);
        }
    }
}
