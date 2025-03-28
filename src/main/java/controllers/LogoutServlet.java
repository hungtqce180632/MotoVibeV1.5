/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 *
 *  * Servlet xử lý đăng xuất người dùng. URL mapping: "/logout"
 *
 * @author truon
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    /**
     * Phương thức doGet xử lý yêu cầu GET để đăng xuất.
     *
     * @param request HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 1. Lấy session hiện tại từ request (getSession(false) không tạo session mới nếu chưa có).
        HttpSession session = request.getSession(false);

        // 2. Kiểm tra nếu session tồn tại.
        if (session != null) {
            // 3. Invalidate session hiện tại, hủy bỏ tất cả dữ liệu session.
            session.invalidate();
        }

        // 4. Chuyển hướng (redirect) người dùng về trang chủ (home) sau khi đăng xuất.
        response.sendRedirect("home");
    }

    /**
     * Phương thức doPost cũng xử lý đăng xuất (có thể sử dụng nếu bạn muốn xử
     * lý đăng xuất qua POST). Trong ví dụ này, chúng ta đơn giản gọi doGet để
     * thực hiện đăng xuất tương tự.
     *
     * @param request HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response); // Gọi doGet để xử lý đăng xuất tương tự cho cả POST request.
    }
}
