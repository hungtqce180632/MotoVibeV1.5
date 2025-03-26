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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Brand;

/**
 *
 * @author Jackt
 */
@WebServlet(name = "BrandsListServlet", urlPatterns = {"/brandslist", "/deleteBrandServlet"})
public class BrandsListServlet extends HttpServlet {

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
            out.println("<title>Servlet BrandsListServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet BrandsListServlet at " + request.getContextPath() + "</h1>");
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
        String servletPath = request.getServletPath();

        // Deleting the brand
        if ("/deleteBrandServlet".equals(servletPath)) {
            String brandId = request.getParameter("brandId");
            BrandDAO brandDAO = new BrandDAO();
            try {
                brandDAO.deleteBrand(Integer.parseInt(brandId)); // Deleting the brand by ID
                response.sendRedirect("brandslist");  // After deletion, redirect to the brand list page
            } catch (SQLException ex) {
                Logger.getLogger(BrandsListServlet.class.getName()).log(Level.SEVERE, null, ex);

                // Set the error message in the request
                request.setAttribute("errorMessage", "Could not delete the brand. Please try again.");

                // Forward the request back to the brand list page with the error message
                request.getRequestDispatcher("brandslist").forward(request, response);
            }
        } // Displaying the brand list
        else if ("/brandslist".equals(servletPath)) {
            BrandDAO brandDAO = new BrandDAO();
            List<Brand> brands = null;
            try {
                brands = brandDAO.getAllBrands(); // Retrieve brands from DB
            } catch (SQLException ex) {
                Logger.getLogger(BrandsListServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            request.setAttribute("brands", brands);  // Set the brands list as a request attribute
            request.getRequestDispatcher("brand_list.jsp").forward(request, response);  // Forward to brand list JSP page
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
        // Retrieve the parameters from the form
        String brandName = request.getParameter("brandName");
        String countryOfOrigin = request.getParameter("countryOfOrigin");
        String description = request.getParameter("description");

        // Check if the brandName, countryOfOrigin, and description are provided
        if (brandName != null && !brandName.trim().isEmpty()
                && countryOfOrigin != null && !countryOfOrigin.trim().isEmpty()
                && description != null && !description.trim().isEmpty()) {

            // Create a new Brand object
            Brand brand = new Brand();
            brand.setBrandName(brandName);
            brand.setCountryOfOrigin(countryOfOrigin);
            brand.setDescription(description);

            // Use the BrandDAO to add the brand to the database
            BrandDAO brandDAO = new BrandDAO();
            try {
                brandDAO.addBrand(brand);  // Save the new brand to the database
                response.sendRedirect("brandslist");  // Redirect to the brand list page
            } catch (SQLException e) {
                e.printStackTrace();
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error saving brand");
            }
        } else {
            // If any of the required parameters are missing, send a 400 Bad Request response
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
