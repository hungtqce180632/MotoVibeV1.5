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
 * Servlet xử lý việc đăng xuất (logout) người dùng. 
 * URL mapping: "/logout"
 * 
 * Khi người dùng truy cập servlet này thông qua URL "/logout", 
 * session của họ sẽ bị hủy và họ được chuyển hướng về trang chủ (home).
 * 
 * @author SangCE181720
 */
@WebServlet(name = "LogoutServlet", urlPatterns = {"/logout"})
public class LogoutServlet extends HttpServlet {

    /**
     * Phương thức doGet xử lý yêu cầu GET để đăng xuất.
     *
     * @param request  HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 1. Lấy session hiện tại từ request (sử dụng getSession(false) để không tạo session mới nếu chưa có).
        HttpSession session = request.getSession(false);

        // 2. Kiểm tra xem session có tồn tại hay không.
        if (session != null) {
            // 3. Hủy session hiện tại, xóa bỏ tất cả dữ liệu liên quan trong session.
            session.invalidate();
        }

        // 4. Chuyển hướng (redirect) người dùng về trang "home" sau khi đăng xuất.
        response.sendRedirect("home");
    }

    /**
     * Phương thức doPost cũng xử lý đăng xuất. 
     * Trong trường hợp này, ta chỉ gọi lại doGet để quá trình đăng xuất diễn ra như nhau 
     * cho cả GET và POST.
     *
     * @param request  HttpServletRequest cung cấp thông tin yêu cầu từ client.
     * @param response HttpServletResponse để gửi phản hồi về client.
     * @throws ServletException Nếu servlet gặp lỗi trong quá trình xử lý.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Gọi doGet để tái sử dụng logic đăng xuất
        doGet(request, response);
    }
}
