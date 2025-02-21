/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.BrandDAO;
import dao.FuelDAO;
import dao.ModelDAO;
import dao.MotorDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import models.Brand;
import models.Fuel;
import models.Model;
import models.Motor;
import models.UserAccount;

/**
 *
 * @author tiend
 */
@WebServlet(name = "MotorManagementServlet", urlPatterns = {"/motorManagement"})
public class MotorManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("home.jsp"); // Chuyển hướng về home nếu không phải admin
        }
        try {
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();

            List<Motor> motors = motorDAO.getAllMotors();
            HashMap<Integer, String> brandMap = new HashMap<>();
            HashMap<Integer, String> modelMap = new HashMap<>();
            HashMap<Integer, String> fuelMap = new HashMap<>();

            for (Brand brand : brandDAO.getAllBrands()) {
                brandMap.put(brand.getBrandId(), brand.getBrandName());
            }

            for (Model model : modelDAO.getAllModels()) {
                modelMap.put(model.getModelId(), model.getModelName());
            }

            for (Fuel fuel : fuelDAO.getAllFuels()) {
                fuelMap.put(fuel.getFuelId(), fuel.getFuelName());
            }

            request.setAttribute("motors", motors);
            request.setAttribute("brandMap", brandMap);
            request.setAttribute("modelMap", modelMap);
            request.setAttribute("fuelMap", fuelMap);

            request.getRequestDispatcher("motor_list.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Database access error", e);
        }
    }
}
