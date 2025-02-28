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
import models.Motor;
import models.UserAccount;

/**
 *
 * @author tiend
 */
@WebServlet(name = "EditMotorServlet", urlPatterns = {"/editMotor"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class EditMotorServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "images/motor_pictures"; // Changed directory path

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("home.jsp"); // Chuyển hướng về home nếu không phải admin
        }
        try {
            int motorId = Integer.parseInt(request.getParameter("id"));
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();

            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                response.sendRedirect("error.jsp");
                return;
            }

            request.setAttribute("motor", motor);
            request.setAttribute("brands", brandDAO.getAllBrands());
            request.setAttribute("models", modelDAO.getAllModels());
            request.setAttribute("fuels", fuelDAO.getAllFuels());

            request.getRequestDispatcher("edit_motor.jsp").forward(request, response);
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error retrieving motor details", e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            int motorId = Integer.parseInt(request.getParameter("motorId"));
            String motorName = request.getParameter("motorName");
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int modelId = Integer.parseInt(request.getParameter("modelId"));
            int fuelId = Integer.parseInt(request.getParameter("fuelId"));
            String color = request.getParameter("color");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");

            MotorDAO motorDAO = new MotorDAO();
            Motor existingMotor = motorDAO.getMotorById(motorId);
            Date dateStart = existingMotor.getDateStart(); // Get Date object directly
            int quantity = existingMotor.getQuantity();

            // Handle file upload
            Part filePart = request.getPart("picture");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            
            // Get both paths - one for webapp and one for source
            String webappPath = getServletContext().getRealPath("/").replace("target\\MotorVibe-1.0-SNAPSHOT\\", "src\\main\\webapp\\");
            String targetPath = getServletContext().getRealPath("/");
            
            // Define uploadPath variables for both source and target
            String sourceUploadPath = webappPath + UPLOAD_DIR;
            String targetUploadPath = targetPath + UPLOAD_DIR;
            
            String picture = request.getParameter("existingPicture"); // Default to existing picture

            if (fileName != null && !fileName.isEmpty()) {
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String newFileName = "motor_" + motorId + "_" + System.currentTimeMillis() + extension;
                
                // Save to webapp source directory
                File uploadDirSource = new File(sourceUploadPath);
                if (!uploadDirSource.exists()) {
                    uploadDirSource.mkdirs();
                }
                filePart.write(sourceUploadPath + File.separator + newFileName);
                
                // Save to target directory
                File uploadDirTarget = new File(targetUploadPath);
                if (!uploadDirTarget.exists()) {
                    uploadDirTarget.mkdirs();
                }
                filePart.write(targetUploadPath + File.separator + newFileName);
                
                picture = "motor_pictures/" + newFileName;
            }

            // Create and update motor object
            Motor motor = new Motor(motorId, brandId, modelId, motorName, dateStart, color, price, 
                                  fuelId, true, description, quantity, picture);
            motorDAO.updateMotor(motor);

            response.sendRedirect("motorDetail?id=" + motorId);
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error updating motor details", e);
        }
    }
}
