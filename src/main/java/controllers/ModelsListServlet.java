/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controllers;

import dao.ModelDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Model;

/**
 *
 * @author Jackt
 */
@WebServlet(name="ModelsListServlet", urlPatterns={"/modelslist", "/deleteModelServlet"})
public class ModelsListServlet extends HttpServlet {

    // GET method to handle model viewing and deletion requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String servletPath = request.getServletPath();
        
        // Deleting the model
        if ("/deleteModelServlet".equals(servletPath)) {
            String modelId = request.getParameter("modelId");
            ModelDAO modelDAO = new ModelDAO();
            try {
                modelDAO.deleteModel(Integer.parseInt(modelId)); // Deleting the model by ID
                response.sendRedirect("modelslist");  // After deletion, redirect to the model list page
            } catch (SQLException ex) {
                Logger.getLogger(ModelsListServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error deleting model");
            }
        } 
        // Displaying the model list
        else if ("/modelslist".equals(servletPath)) {
            ModelDAO modelDAO = new ModelDAO();
            List<Model> models = null;
            try {
                models = modelDAO.getAllModels(); // Retrieve models from DB
            } catch (SQLException ex) {
                Logger.getLogger(ModelsListServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("models", models);
            request.getRequestDispatcher("models_list.jsp").forward(request, response); // Forward to model list JSP page
        }
    }

    // POST method to handle model creation and updates
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Adding a new model to the database
        
            String modelName = request.getParameter("modelName");

            if (modelName != null && !modelName.trim().isEmpty()) {
                Model model = new Model();
                model.setModelName(modelName);

                ModelDAO modelDAO = new ModelDAO();
                try {
                    modelDAO.addModel(model);  // Save the new model to DB
                    response.sendRedirect("modelslist");  // Redirect to models list page
                } catch (SQLException e) {
                    e.printStackTrace();
                    response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving model");
                }
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Model name is required");
            }
        
        
        // Updating an existing model
        
    }

    @Override
    public String getServletInfo() {
        return "Servlet that handles model list operations";
    }
}
