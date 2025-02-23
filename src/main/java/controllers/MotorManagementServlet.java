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
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import models.Brand;
import models.Fuel;
import models.Model;
import models.Motor;
import models.UserAccount;

/**
 *
 *  * Servlet này quản lý trang quản lý motor cho admin. Đường dẫn URL mapping
 * là "/motorManagement". Chỉ có admin mới có quyền truy cập trang này.
 *
 *
 * @author tiend - upgrade hưng
 */
@WebServlet(name = "MotorManagementServlet", urlPatterns = {"/motorManagement"})
public class MotorManagementServlet extends HttpServlet {

    /**
     * Phương thức doGet được gọi khi admin truy cập trang quản lý motor. Phương
     * thức này kiểm tra quyền admin, lấy dữ liệu motor, brands, models, fuels
     * từ database và chuyển tiếp đến trang JSP motor_list.jsp để hiển thị.
     *
     * @param request HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy session hiện tại từ request.
        HttpSession session = request.getSession();
        // 2. Lấy đối tượng UserAccount từ session attribute "user".
        UserAccount user = (UserAccount) session.getAttribute("user");

        // 3. Kiểm tra nếu user chưa đăng nhập hoặc không phải admin.
        if (user == null || !user.getRole().equals("admin")) {
            // 4. Nếu không phải admin, chuyển hướng (redirect) về trang chủ "index.jsp".
            // Corrected line: sendRedirect to "index.jsp"
            response.sendRedirect("index.jsp"); // Chuyển hướng về trang chủ (index.jsp)
            return; // 5. **Quan trọng:** Kết thúc phương thức tại đây để ngăn chặn forward sau redirect.
            // Giải thích: Khi đã gọi sendRedirect, response đã được commit và gửi header về client.
            // Gọi forward sau sendRedirect sẽ gây ra lỗi "Cannot forward after response has been committed".
        }

        // 6. Nếu là admin, tiếp tục lấy dữ liệu từ database.
        try {
            // 7. Khởi tạo các DAO cần thiết để truy cập database: MotorDAO, BrandDAO, ModelDAO, FuelDAO.
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();

            // 8. Lấy danh sách tất cả motors từ database.
            List<Motor> motors = motorDAO.getAllMotors();
            // 9. Tạo HashMaps để lưu trữ tên brands, models, fuels theo ID để dễ dàng truy xuất trong JSP.
            HashMap<Integer, String> brandMap = new HashMap<>();
            HashMap<Integer, String> modelMap = new HashMap<>();
            HashMap<Integer, String> fuelMap = new HashMap<>();

            // 10. Lặp qua danh sách brands và đưa vào brandMap (brandId -> brandName).
            for (Brand brand : brandDAO.getAllBrands()) {
                brandMap.put(brand.getBrandId(), brand.getBrandName());
            }

            // 11. Lặp qua danh sách models và đưa vào modelMap (modelId -> modelName).
            for (Model model : modelDAO.getAllModels()) {
                modelMap.put(model.getModelId(), model.getModelName());
            }

            // 12. Lặp qua danh sách fuels và đưa vào fuelMap (fuelId -> fuelName).
            for (Fuel fuel : fuelDAO.getAllFuels()) {
                fuelMap.put(fuel.getFuelId(), fuel.getFuelName());
            }

            // 13. Lưu các dữ liệu cần thiết vào request attributes để JSP có thể truy cập và hiển thị.
            request.setAttribute("motors", motors); // Danh sách motors
            request.setAttribute("brandMap", brandMap); // HashMap brands
            request.setAttribute("modelMap", modelMap); // HashMap models
            request.setAttribute("fuelMap", fuelMap); // HashMap fuels

            // 14. Chuyển tiếp (forward) request và response đến trang JSP "motor_list.jsp" để hiển thị dữ liệu quản lý motor.
            request.getRequestDispatcher("motor_list.jsp").forward(request, response);

        } catch (SQLException e) {
            // 15. Bắt lỗi SQLException nếu có lỗi truy vấn database trong quá trình lấy dữ liệu.
            throw new ServletException("Database access error", e); // Ném ServletException để container xử lý lỗi.
        }
    }
}
