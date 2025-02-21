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
import java.sql.SQLException;
import java.time.LocalDate;
import models.Motor;
import models.UserAccount;

/**
 *
 * @author tiend
 */
@WebServlet(name = "AddMotorServlet", urlPatterns = {"/addMotor"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
        maxFileSize = 1024 * 1024 * 10, // 10MB
        maxRequestSize = 1024 * 1024 * 50) // 50MB
public class AddMotorServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final String UPLOAD_DIR = "images";

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
            String motorName = request.getParameter("motorName");
            int brandId = Integer.parseInt(request.getParameter("brandId"));
            int modelId = Integer.parseInt(request.getParameter("modelId"));
            int fuelId = Integer.parseInt(request.getParameter("fuelId"));
            String color = request.getParameter("color");
            double price = Double.parseDouble(request.getParameter("price"));
            String description = request.getParameter("description");
            LocalDate dateStart = LocalDate.now();

            // Handle file upload
            Part filePart = request.getPart("picture");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String newFileName = fileName;
            if (!fileName.isEmpty()) {
                // Rename file with timestamp to prevent duplication
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String baseName = fileName.substring(0, fileName.lastIndexOf("."));
                newFileName = baseName + "_" + System.currentTimeMillis() + extension;
                filePart.write(uploadPath + File.separator + newFileName);
            }

            Motor motor = new Motor(0, brandId, modelId, motorName, dateStart.toString(), color, price, fuelId, true, description, 0, newFileName);
            new MotorDAO().addMotor(motor);

            response.sendRedirect("motorManagement");
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error adding motor", e);
        }
    }
}
