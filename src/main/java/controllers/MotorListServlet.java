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
 * Servlet này xử lý trang danh sách motor (motor list). URL mapping:
 * "/motorList" Servlet này chịu trách nhiệm lấy dữ liệu motor từ database và
 * chuyển tiếp đến trang JSP `motor_list.jsp` để hiển thị danh sách motor.
 *
 * @author truon
 */
@WebServlet(name = "MotorListServlet", urlPatterns = {"/motorList"}) // Đúng URL mapping để servlet nhận request "/motorList"
public class MotorListServlet extends HttpServlet {

    /**
     * Phương thức doGet xử lý các yêu cầu GET đến "/motorList".
     * Lấy danh sách motor, brands, models, fuels từ database và
     * chuyển tiếp đến `motor_list.jsp` để hiển thị.
     *
     * @param request  HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Khởi tạo các DAO để truy cập database.
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();

            // Lấy danh sách tất cả motor từ database.
            List<Motor> motors = motorDAO.getAllMotors();
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
            request.getRequestDispatcher("motor_list.jsp").forward(request, response);

        } catch (SQLException e) {
            // Xử lý exception nếu có lỗi database.
            throw new ServletException("Database access error", e);
        }
    }

    /**
     * Phương thức doPost cũng xử lý request giống doGet (trong trường hợp này, trang motor list chủ yếu hiển thị dữ liệu).
     *
     * @param request  HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Gọi doGet để xử lý tương tự cho POST request.
    }
}