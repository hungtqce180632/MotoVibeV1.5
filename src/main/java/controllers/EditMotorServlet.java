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
    private static final String UPLOAD_DIR = "images";

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
            String uploadPath = getServletContext().getRealPath("") + File.separator + UPLOAD_DIR;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }

            String newFileName = fileName;
            if (!fileName.isEmpty()) {
                // Đổi tên file bằng cách thêm timestamp để tránh trùng
                String extension = fileName.substring(fileName.lastIndexOf("."));
                String baseName = fileName.substring(0, fileName.lastIndexOf("."));
                newFileName = baseName + "_" + System.currentTimeMillis() + extension;

                // Lưu file với tên mới
                filePart.write(uploadPath + File.separator + newFileName);
            }

            // Nếu người dùng không upload ảnh mới, giữ nguyên ảnh cũ
            String picture = fileName.isEmpty() ? request.getParameter("existingPicture") : newFileName;

            Motor motor = new Motor(motorId, brandId, modelId, motorName, dateStart, color, price, fuelId, true, description, quantity, picture); // Use java.sql.Date
            motorDAO.updateMotor(motor);

            response.sendRedirect("motorDetail?id=" + motorId);
        } catch (NumberFormatException | SQLException e) {
            throw new ServletException("Error updating motor details", e);
        }
    }
}
