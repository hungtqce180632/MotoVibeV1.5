package controllers;

import dao.ModelDAO;
import models.Model;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;

@WebServlet(name = "UpdateModelServlet", urlPatterns = {"/updateModelServlet"})
public class UpdateModelServlet extends HttpServlet {
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String modelId = request.getParameter("modelId");
        
        if (modelId != null) {
            try {
                ModelDAO modelDAO = new ModelDAO();
                Model model = modelDAO.getModelById(Integer.parseInt(modelId));
                
                if (model != null) {
                    request.setAttribute("model", model);  // Set model to request
                    request.getRequestDispatcher("edit_model.jsp").forward(request, response);  // Forward to edit page
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Model not found");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving model");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Model ID is required");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String modelId = request.getParameter("modelId");
        String modelName = request.getParameter("modelName");

        if (modelId != null && modelName != null && !modelName.trim().isEmpty()) {
            try {
                ModelDAO modelDAO = new ModelDAO();
                Model model = modelDAO.getModelById(Integer.parseInt(modelId));
                
                if (model != null) {
                    model.setModelName(modelName);
                    modelDAO.updateModel(model);
                    response.sendRedirect("modelslist");
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Model not found");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating model");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Model ID and new name are required");
        }
    }
}
