/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.BrandDAO;
import dao.FuelDAO;
import dao.ModelDAO;
import dao.MotorDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Brand;
import models.Fuel;
import models.Model;
import models.Motor;
import java.io.IOException;
import java.util.List;
import java.sql.SQLException;

/**
 *
 * @author truon
 */
@WebServlet("/filterMotors")
public class FilterMotorServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Integer brandId = null;
        Integer fuelId = null;
        Integer modelId = null;

        if (request.getParameter("brandId") != null && !request.getParameter("brandId").isEmpty()) {
            brandId = Integer.parseInt(request.getParameter("brandId"));
        }
        if (request.getParameter("fuelId") != null && !request.getParameter("fuelId").isEmpty()) {
            fuelId = Integer.parseInt(request.getParameter("fuelId"));
        }
        if (request.getParameter("modelId") != null && !request.getParameter("modelId").isEmpty()) {
            modelId = Integer.parseInt(request.getParameter("modelId"));
        }

        MotorDAO motorDAO = new MotorDAO();
        List<Motor> motors = motorDAO.getMotorsByFilters(brandId, fuelId, modelId);

        try { // Add try block to catch SQLException
            BrandDAO brandDAO = new BrandDAO();
            List<Brand> brands = brandDAO.getAllBrands();
            FuelDAO fuelDAO = new FuelDAO();
            List<Fuel> fuels = fuelDAO.getAllFuels();
            ModelDAO modelDAO = new ModelDAO();
            List<Model> models = modelDAO.getAllModels();

            request.setAttribute("brands", brands);
            request.setAttribute("fuels", fuels);
            request.setAttribute("models", models);

        } catch (SQLException e) { // Catch SQLException
            e.printStackTrace(); // Log the error (for debugging)
            throw new ServletException("Database error occurred while fetching brands, fuels, and models.", e); // Re-throw as ServletException
            // In a real app, you might redirect to an error page or set an error attribute in the request.
        }


        request.setAttribute("motors", motors);
        request.getRequestDispatcher("motor_list.jsp").forward(request, response);
    }
}