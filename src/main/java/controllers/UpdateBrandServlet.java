/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.BrandDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import models.Brand;

/**
 *
 * @author Jackt
 */
@WebServlet(name = "UpdateBrandServlet", urlPatterns = {"/updateBrandServlet"})
public class UpdateBrandServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try ( PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet UpdateBrandServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateBrandServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String brandId = request.getParameter("brandId");

        if (brandId != null) {
            try {
                BrandDAO brandDAO = new BrandDAO();
                Brand brand = brandDAO.getBrandById(Integer.parseInt(brandId));

                if (brand != null) {
                    request.setAttribute("brand", brand);  // Set the brand object to request
                    request.getRequestDispatcher("edit_brand.jsp").forward(request, response);  // Forward to edit page
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Brand not found");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving brand");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Brand ID is required");
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String brandId = request.getParameter("brandId");
        String brandName = request.getParameter("brandName");
        String countryOfOrigin = request.getParameter("countryOfOrigin");
        String description = request.getParameter("description");

        if (brandId != null && brandName != null && !brandName.trim().isEmpty()
                && countryOfOrigin != null && !countryOfOrigin.trim().isEmpty()
                && description != null && !description.trim().isEmpty()) {

            try {
                BrandDAO brandDAO = new BrandDAO();
                Brand brand = brandDAO.getBrandById(Integer.parseInt(brandId));

                if (brand != null) {
                    // Update the brand object with new details
                    brand.setBrandName(brandName);
                    brand.setCountryOfOrigin(countryOfOrigin);
                    brand.setDescription(description);

                    // Call the DAO to update the brand in the database
                    brandDAO.updateBrand(brand);
                    response.sendRedirect("brandslist");  // Redirect to brand list page after updating
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "Brand not found");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error updating brand");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "All fields are required");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
