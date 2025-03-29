package controllers;

import dao.MotorDAO;
import dao.BrandDAO;
import dao.ModelDAO;
import dao.FuelDAO;
import models.Motor;
import models.Brand;
import models.Model;
import models.Fuel;
import models.UserAccount;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.File;
import java.sql.SQLException;
import java.util.List;
import java.util.HashMap;
import java.util.Map;
import java.nio.charset.StandardCharsets;

import jakarta.json.Json;
import jakarta.json.JsonArrayBuilder;
import jakarta.json.JsonObjectBuilder;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet that exports motor data to a file for AI chatbot training.
 * Only accessible by admin users.
 * 
 * @author truon
 */
@WebServlet(name = "ExportMotorDataServlet", urlPatterns = {"/exportMotorData"})
public class ExportMotorDataServlet extends HttpServlet {

    private static final String EXPORT_DIRECTORY = "C:\\Users\\truon\\Desktop\\yeah2\\MotoVibeV1.5\\src\\main\\java\\aiData";
    private static final String EXPORT_FILENAME = "MotoVibeListMotor.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Check if user is admin
        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");
        
        if (user == null || !user.getRole().equals("admin")) {
            response.sendRedirect("home");
            return;
        }
        
        try {
            // Get all motor data
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();
            
            List<Motor> motors = motorDAO.getAllMotors();
            
            // Create maps for brand, model, fuel names
            Map<Integer, String> brandMap = new HashMap<>();
            Map<Integer, String> modelMap = new HashMap<>();
            Map<Integer, String> fuelMap = new HashMap<>();
            
            for (Brand brand : brandDAO.getAllBrands()) {
                brandMap.put(brand.getBrandId(), brand.getBrandName());
            }
            
            for (Model model : modelDAO.getAllModels()) {
                modelMap.put(model.getModelId(), model.getModelName());
            }
            
            for (Fuel fuel : fuelDAO.getAllFuels()) {
                fuelMap.put(fuel.getFuelId(), fuel.getFuelName());
            }
            
            // Create directory if it doesn't exist
            File directory = new File(EXPORT_DIRECTORY);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            
            // Create and write to the file
            File outputFile = new File(directory, EXPORT_FILENAME);
            
            // Generate the content in both JSON and human-readable format
            try (PrintWriter writer = new PrintWriter(outputFile, StandardCharsets.UTF_8.name())) {
                // Add a header explaining the format
                writer.println("# MotoVibe Motorcycle Inventory");
                writer.println("# This file contains inventory data for AI training purposes");
                writer.println("# Generated on: " + new java.util.Date());
                writer.println("\n## Available Motorcycles:\n");
                
                // Add human-readable format
                for (Motor motor : motors) {
                    if (motor.isPresent() && motor.getQuantity() > 0) {
                        writer.println("- Model: " + motor.getMotorName());
                        writer.println("  Brand: " + brandMap.get(motor.getBrandId()));
                        writer.println("  Type: " + modelMap.get(motor.getModelId()));
                        writer.println("  Fuel: " + fuelMap.get(motor.getFuelId()));
                        writer.println("  Color: " + motor.getColor());
                        writer.println("  Price: $" + motor.getPrice());
                        writer.println("  Quantity in Stock: " + motor.getQuantity());
                        writer.println("  Description: " + motor.getDescription());
                        writer.println();
                    }
                }
                
                // Add JSON format for machine processing
                writer.println("\n## JSON DATA:");
                
                JsonArrayBuilder motorArrayBuilder = Json.createArrayBuilder();
                
                for (Motor motor : motors) {
                    if (motor.isPresent() && motor.getQuantity() > 0) {
                        JsonObjectBuilder motorBuilder = Json.createObjectBuilder()
                            .add("id", motor.getMotorId())
                            .add("name", motor.getMotorName())
                            .add("brand", brandMap.get(motor.getBrandId()))
                            .add("model", modelMap.get(motor.getModelId()))
                            .add("fuel", fuelMap.get(motor.getFuelId()))
                            .add("color", motor.getColor())
                            .add("price", motor.getPrice())
                            .add("quantity", motor.getQuantity())
                            .add("description", motor.getDescription() != null ? motor.getDescription() : "");
                        
                        motorArrayBuilder.add(motorBuilder);
                    }
                }
                
                writer.println(Json.createObjectBuilder()
                    .add("motors", motorArrayBuilder)
                    .build().toString());
            }
            
            // Set response properties
            response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                out.println("<!DOCTYPE html>");
                out.println("<html>");
                out.println("<head>");
                out.println("<title>Export Successful</title>");
                out.println("<link rel='stylesheet' href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css'>");
                out.println("<style>");
                out.println("body { background-color: #111111; color: #F5E6CC; padding: 2rem; }");
                out.println(".card { background-color: #1A1A1A; border: 1px solid #D4AF37; }");
                out.println(".btn-primary { background-color: #D4AF37; border: none; color: #111111; }");
                out.println(".btn-primary:hover { background-color: #C5A028; color: #111111; }");
                out.println("</style>");
                out.println("</head>");
                out.println("<body>");
                out.println("<div class='container'>");
                out.println("<div class='row justify-content-center'>");
                out.println("<div class='col-md-8'>");
                out.println("<div class='card mt-5'>");
                out.println("<div class='card-body text-center'>");
                out.println("<h2 class='card-title' style='color: #D4AF37;'><i class='fas fa-check-circle'></i> Export Successful!</h2>");
                out.println("<p class='card-text'>AI training data has been exported successfully.</p>");
                out.println("<p class='card-text'>File saved to: " + outputFile.getAbsolutePath() + "</p>");
                out.println("<a href='motorList' class='btn btn-primary mt-3'>Return to Motor List</a>");
                out.println("</div>");
                out.println("</div>");
                out.println("</div>");
                out.println("</div>");
                out.println("</div>");
                out.println("<script src='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js'></script>");
                out.println("<script src='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/js/all.min.js'></script>");
                out.println("</body>");
                out.println("</html>");
            }
            
        } catch (SQLException e) {
            throw new ServletException("Database error while exporting motor data", e);
        }
    }
}
