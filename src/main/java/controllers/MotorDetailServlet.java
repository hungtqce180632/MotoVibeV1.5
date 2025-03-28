/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.BrandDAO;
import dao.FuelDAO;
import dao.ModelDAO;
import dao.MotorDAO;
import dao.ReviewDAO;
import dao.OrderDAO; // Import OrderDAO để kiểm tra xem người dùng đã mua motor hay chưa
import dao.CustomerDAO;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import models.Brand;
import models.Customer;
import models.Fuel;
import models.Model;
import models.Motor;
import models.Review;
import models.UserAccount;

/**
 * Servlet xử lý việc hiển thị chi tiết của một motor.
 * URL mapping: "/motorDetail"
 *
 * Các chức năng của servlet:
 * 1. Lấy motorId từ request và kiểm tra tính hợp lệ.
 * 2. Sử dụng các DAO để tải thông tin motor, brand, model, fuel và các đánh giá liên quan.
 * 3. Kiểm tra xem người dùng đăng nhập có phải là khách hàng (customer) và đã mua motor này chưa.
 *    Nếu khách hàng đã mua và chưa đánh giá, họ sẽ có quyền đánh giá motor.
 * 4. Kiểm tra tình trạng còn hàng của motor.
 * 5. Đưa các thông tin cần thiết lên request và chuyển tiếp sang trang motor_detail.jsp.
 *
 * @author 
 */
@WebServlet(name = "MotorDetailServlet", urlPatterns = {"/motorDetail"})
public class MotorDetailServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        try {
            // Phân tích và lấy motorId từ tham số request
            int motorId = Integer.parseInt(request.getParameter("id"));

            // Khởi tạo các DAO cần thiết
            MotorDAO motorDAO = new MotorDAO();
            BrandDAO brandDAO = new BrandDAO();
            ModelDAO modelDAO = new ModelDAO();
            FuelDAO fuelDAO = new FuelDAO();
            ReviewDAO reviewDAO = new ReviewDAO();
            OrderDAO orderDAO = new OrderDAO();
            CustomerDAO customerDAO = new CustomerDAO();

            // Tải thông tin motor từ database
            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                // Nếu motor không tồn tại, chuyển hướng đến trang lỗi
                response.sendRedirect("error.jsp");
                return;
            }

            // Tải thông tin brand, model và fuel của motor
            Brand brand = brandDAO.getBrandById(motor.getBrandId());
            Model model = modelDAO.getModelById(motor.getModelId());
            Fuel fuel = fuelDAO.getFuelById(motor.getFuelId());

            // Tải danh sách đánh giá cho motor
            List<Review> reviews = reviewDAO.getAllReviewOfCar(motorId);

            // Kiểm tra xem người dùng đăng nhập có phải là khách hàng đã mua motor hay không
            HttpSession session = request.getSession(false);
            UserAccount user = (session != null) ? (UserAccount) session.getAttribute("user") : null;

            // Khởi tạo biến canReview mặc định là false
            boolean canReview = false;

            if (user != null && "customer".equalsIgnoreCase(user.getRole())) {
                // Lấy thông tin khách hàng dựa trên userId
                Customer c = customerDAO.getCustomerByUserId(user.getUserId());
                if (c != null) {
                    // Kiểm tra xem khách hàng đã mua motor (với trạng thái Completed) hay chưa
                    boolean purchased = orderDAO.hasPurchasedMotor(c.getCustomerId(), motorId);
                    // Kiểm tra xem khách hàng đã đánh giá motor này hay chưa
                    boolean alreadyReviewed = reviewDAO.hasAlreadyReviewed(c.getCustomerId(), motorId);
                    
                    // Khách hàng chỉ được đánh giá nếu đã mua motor và chưa đánh giá trước đó
                    canReview = purchased && !alreadyReviewed;
                    
                    // Nếu đã mua nhưng đã đánh giá, thiết lập thông báo cho khách hàng
                    if (purchased && alreadyReviewed) {
                        request.setAttribute("reviewMessage", "You have already submitted a review for this motor.");
                    }
                }
            }

            // Đưa các thông tin cần thiết vào phạm vi request
            request.setAttribute("motor", motor);
            request.setAttribute("brand", brand);
            request.setAttribute("model", model);
            request.setAttribute("fuel", fuel);
            request.setAttribute("reviews", reviews);
            request.setAttribute("canReview", canReview);
            
            // Kiểm tra tình trạng còn hàng: motor có số lượng lớn hơn 0 hay không
            boolean inStock = motor.getQuantity() > 0;
            request.setAttribute("inStock", inStock);

            // Chuyển tiếp yêu cầu sang trang motor_detail.jsp để hiển thị chi tiết motor
            request.getRequestDispatcher("motor_detail.jsp").forward(request, response);

        } catch (NumberFormatException | SQLException e) {
            // Nếu có lỗi trong quá trình lấy dữ liệu, ném ra ServletException
            throw new ServletException("Error retrieving motor details", e);
        }
    }
}
