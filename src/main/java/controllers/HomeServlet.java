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
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import models.Brand;
import models.Fuel;
import models.Model;
import models.Motor;

/**
 *
 * @author tiend
 */
@WebServlet(name="HomeServlet", urlPatterns={"/home"})
public class HomeServlet extends HttpServlet {
   


    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        try {
            // Khởi tạo các DAO để truy cập database.
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();

            // Lấy danh sách tất cả motor từ database.
            List<Motor> motors = motorDAO.getTopMotors();
            // Lấy danh sách tất cả brands, models, fuels để dùng cho filter form trên trang JSP.
            List<Brand> brands = brandDAO.getAllBrands();
            List<Model> models = modelDAO.getAllModels();
            List<Fuel> fuels = fuelDAO.getAllFuels();

            // Tạo HashMaps để map ID với tên của brand, model, fuel để dễ hiển thị trên JSP.
            HashMap<Integer, String> brandMap = new HashMap<>();
            HashMap<Integer, String> modelMap = new HashMap<>();
            HashMap<Integer, String> fuelMap = new HashMap<>();

            for (Brand brand : brands) {
                brandMap.put(brand.getBrandId(), brand.getBrandName());
            }
            for (Model model : models) {
                modelMap.put(model.getModelId(), model.getModelName());
            }
            for (Fuel fuel : fuels) {
                fuelMap.put(fuel.getFuelId(), fuel.getFuelName());
            }

            // Lưu dữ liệu vào request attributes để JSP có thể truy cập.
            request.setAttribute("motors", motors); // Danh sách motor
            request.setAttribute("brands", brands); // Danh sách brands cho filter
            request.setAttribute("models", models); // Danh sách models cho filter
            request.setAttribute("fuels", fuels);   // Danh sách fuels cho filter
            request.setAttribute("brandMap", brandMap); // Map brand ID -> Name
            request.setAttribute("modelMap", modelMap); // Map model ID -> Name
            request.setAttribute("fuelMap", fuelMap);   // Map fuel ID -> Name

            // Chuyển tiếp request và response đến trang JSP "motor_list.jsp" để hiển thị dữ liệu.
            request.getRequestDispatcher("index.jsp").forward(request, response);

        } catch (SQLException e) {
            // Xử lý exception nếu có lỗi database.
            throw new ServletException("Database access error", e);
        }
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
       
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
