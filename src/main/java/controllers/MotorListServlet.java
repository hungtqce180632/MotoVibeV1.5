/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.BrandDAO;
import dao.FuelDAO;
import dao.ModelDAO;
import dao.MotorDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import models.Brand;
import models.Fuel;
import models.Model;
import models.Motor;

/**
 * Servlet này xử lý trang danh sách motor (motor list). URL mapping: "/motorList"
 * 
 * Các chức năng chính của servlet:
 * 1. Lấy danh sách tất cả motor từ database.
 * 2. Lấy danh sách các thương hiệu (brands), mẫu xe (models) và loại nhiên liệu (fuels) từ database.
 * 3. Tạo các HashMap để ánh xạ ID của brand, model, fuel với tên tương ứng nhằm thuận tiện hiển thị trên JSP.
 * 4. Lưu các dữ liệu này vào request attributes và chuyển tiếp sang trang JSP "motor_list.jsp" để hiển thị.
 * 
 * Servlet này sử dụng phương thức doGet để lấy dữ liệu và hiển thị, và doPost gọi doGet để đảm bảo rằng
 * mọi yêu cầu POST cũng được xử lý giống như GET.
 *
 * @author truon
 */
@WebServlet(name = "MotorListServlet", urlPatterns = {"/motorList"})
public class MotorListServlet extends HttpServlet {

    /**
     * Phương thức doGet xử lý các yêu cầu GET đến "/motorList".
     * Nó lấy dữ liệu motor, brands, models, fuels từ database và lưu các dữ liệu này vào request attributes.
     * Sau đó, chuyển tiếp request và response đến trang JSP "motor_list.jsp" để hiển thị danh sách motor.
     *
     * @param request  HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse dùng để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Khởi tạo các DAO để truy cập dữ liệu từ database
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();

            // Lấy danh sách tất cả motor từ database
            List<Motor> motors = motorDAO.getAllMotors();
            // Lấy danh sách tất cả brands, models, fuels để dùng cho form lọc trên trang JSP
            List<Brand> brands = brandDAO.getAllBrands();
            List<Model> models = modelDAO.getAllModels();
            List<Fuel> fuels = fuelDAO.getAllFuels();

            // Tạo các HashMap để map ID với tên của brand, model, fuel nhằm thuận tiện hiển thị trên JSP
            HashMap<Integer, String> brandMap = new HashMap<>();
            HashMap<Integer, String> modelMap = new HashMap<>();
            HashMap<Integer, String> fuelMap = new HashMap<>();

            // Map brand ID -> brand name
            for (Brand brand : brands) {
                brandMap.put(brand.getBrandId(), brand.getBrandName());
            }
            // Map model ID -> model name
            for (Model model : models) {
                modelMap.put(model.getModelId(), model.getModelName());
            }
            // Map fuel ID -> fuel name
            for (Fuel fuel : fuels) {
                fuelMap.put(fuel.getFuelId(), fuel.getFuelName());
            }

            // Lưu các dữ liệu vào request attributes để JSP có thể truy cập và hiển thị
            request.setAttribute("motors", motors);     // Danh sách motor
            request.setAttribute("brands", brands);       // Danh sách brands cho form lọc
            request.setAttribute("models", models);       // Danh sách models cho form lọc
            request.setAttribute("fuels", fuels);         // Danh sách fuels cho form lọc
            request.setAttribute("brandMap", brandMap);   // Map brand ID -> tên
            request.setAttribute("modelMap", modelMap);   // Map model ID -> tên
            request.setAttribute("fuelMap", fuelMap);     // Map fuel ID -> tên

            // Chuyển tiếp request và response đến trang "motor_list.jsp" để hiển thị dữ liệu motor
            request.getRequestDispatcher("motor_list.jsp").forward(request, response);

        } catch (SQLException e) {
            // Nếu có lỗi truy cập database, ném ra ServletException
            throw new ServletException("Database access error", e);
        }
    }

    /**
     * Phương thức doPost xử lý các yêu cầu POST.
     * Trong trường hợp này, doPost chỉ gọi doGet để xử lý yêu cầu giống như GET.
     *
     * @param request  HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse dùng để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
