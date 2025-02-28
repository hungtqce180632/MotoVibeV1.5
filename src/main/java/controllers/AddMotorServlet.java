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
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import models.Motor;
import models.UserAccount;

/**
 *
 * @author tiend - upgrade hưng
 */
@WebServlet(name = "AddMotorServlet", urlPatterns = {"/addMotor"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AddMotorServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "images/motor_pictures";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("home.jsp"); // Chuyển hướng về home nếu không phải admin
        }
        try {
            request.setAttribute("brands", new BrandDAO().getAllBrands());
            request.setAttribute("models", new ModelDAO().getAllModels());
            request.setAttribute("fuels", new FuelDAO().getAllFuels());
            request.getRequestDispatcher("add_motor.jsp").forward(request, response);
        } catch (SQLException e) {
            throw new ServletException("Error retrieving data", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Get form data
            String motorName = request.getParameter("motorName");
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int modelId = Integer.parseInt(request.getParameter("modelId"));
            int fuelId = Integer.parseInt(request.getParameter("fuelId"));
            String color = request.getParameter("color");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            Date dateStart = new Date(System.currentTimeMillis());
            
            // Handle file upload
            Part filePart = request.getPart("picture");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // Get the web app root directory
            String webappPath = getServletContext().getRealPath("/").replace("target\\MotorVibe-1.0-SNAPSHOT\\", "src\\main\\webapp\\");
            String uploadPath = webappPath + UPLOAD_DIR;

            // Create directories if they don't exist
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Generate new filename
            String extension = fileName.substring(fileName.lastIndexOf("."));
            String newFileName = "motor_" + System.currentTimeMillis() + extension;

            // Save file to webapp directory
            filePart.write(uploadPath + File.separator + newFileName);

            // Create new Motor object
            Motor motor = new Motor();
            motor.setMotorName(motorName);
            motor.setBrandId(brandId);
            motor.setModelId(modelId);
            motor.setFuelId(fuelId);
            motor.setColor(color);
            motor.setPrice(price);
            motor.setDescription(description);
            motor.setDateStart(dateStart);
            motor.setPresent(true);
            motor.setQuantity(0); // Initial quantity
            motor.setPicture("motor_pictures/" + newFileName); // Store relative path

            // Save to database
            MotorDAO motorDAO = new MotorDAO();
            motorDAO.addMotor(motor);

            response.sendRedirect("motorList");
        } catch (Exception e) {
            throw new ServletException("Error adding motor", e);
        }
    }
}
