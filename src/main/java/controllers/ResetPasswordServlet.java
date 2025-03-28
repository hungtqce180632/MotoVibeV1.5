package controllers;

import dao.UserAccountDAO;
import models.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.security.MessageDigest;
import java.util.Random;

/**
 * Servlet xử lý việc đặt lại mật khẩu cho người dùng.
 * URL mapping: "/resetPassword"
 * 
 * Quá trình đặt lại mật khẩu bao gồm:
 * 1. Hiển thị form reset password qua phương thức GET.
 * 2. Kiểm tra OTP đã được xác thực hay chưa.
 * 3. Kiểm tra các trường nhập liệu không được để trống.
 * 4. Xác nhận mật khẩu mới và mật khẩu xác nhận phải khớp nhau.
 * 5. Kiểm tra sự tồn tại của email trong cơ sở dữ liệu.
 * 6. Mã hoá mật khẩu mới (sử dụng thuật toán MD5) trước khi lưu vào DB.
 * 7. Cập nhật mật khẩu mới trong cơ sở dữ liệu.
 * 8. Chuyển hướng người dùng về trang đăng nhập nếu đặt lại mật khẩu thành công.
 */
@WebServlet("/resetPassword")
public class ResetPasswordServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Phương thức hashPassword dùng để mã hoá mật khẩu sử dụng MD5.
     * Đây là phiên bản được copy từ RegisterServlet.
     *
     * @param password Mật khẩu cần mã hoá.
     * @return Mật khẩu đã được mã hoá dưới dạng chuỗi hex, hoặc null nếu có lỗi.
     */
    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            // Chuyển từng byte của mật khẩu đã mã hoá thành chuỗi hex
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Phương thức doGet hiển thị trang resetPassword.jsp.
     *
     * @param request  HttpServletRequest chứa yêu cầu từ client.
     * @param response HttpServletResponse gửi phản hồi về client.
     * @throws ServletException Nếu có lỗi trong quá trình xử lý servlet.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Chuyển tiếp yêu cầu đến trang resetPassword.jsp để hiển thị form đặt lại mật khẩu.
        request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
    }

    /**
     * Phương thức doPost xử lý việc đặt lại mật khẩu.
     * 
     * Quá trình xử lý bao gồm:
     * 1. Lấy thông tin từ form: email, mật khẩu mới, xác nhận mật khẩu, OTP và kết quả xác thực OTP.
     * 2. Kiểm tra xem OTP đã được xác thực thành công hay chưa.
     * 3. Kiểm tra các trường nhập liệu không được để trống.
     * 4. Kiểm tra mật khẩu mới và xác nhận mật khẩu có khớp nhau hay không.
     * 5. Kiểm tra sự tồn tại của email trong cơ sở dữ liệu.
     * 6. Mã hoá mật khẩu mới trước khi cập nhật vào DB.
     * 7. Cập nhật mật khẩu của người dùng trong cơ sở dữ liệu.
     * 8. Nếu cập nhật thành công, chuyển hướng về trang đăng nhập và hiển thị thông báo thành công.
     *
     * @param request  HttpServletRequest chứa yêu cầu từ client.
     * @param response HttpServletResponse gửi phản hồi về client.
     * @throws ServletException Nếu có lỗi trong quá trình xử lý servlet.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy các thông tin từ form đặt lại mật khẩu
        String email = request.getParameter("emailTxt");
        String newPassword = request.getParameter("pwdTxt");
        String confirmPassword = request.getParameter("confirmPassword");
        String otp = request.getParameter("otp");
        String verificationResult = request.getParameter("OTPResult");

        // Kiểm tra nếu OTP chưa được xác thực thành công
        if (!"Success".equals(verificationResult)) {
            request.setAttribute("error", "Vui lòng xác thực OTP trước khi đặt lại mật khẩu.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra các trường email và mật khẩu không được để trống
        if (email == null || newPassword == null || confirmPassword == null || 
            email.isEmpty() || newPassword.isEmpty() || confirmPassword.isEmpty()) {
            request.setAttribute("error", "Tất cả các trường đều là bắt buộc.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xem mật khẩu mới và mật khẩu xác nhận có khớp nhau hay không
        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Kiểm tra xem email có tồn tại trong cơ sở dữ liệu hay không
        UserAccountDAO userDao = new UserAccountDAO();
        UserAccount user = userDao.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("error", "Email không tồn tại.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Mã hoá mật khẩu mới trước khi lưu vào cơ sở dữ liệu
        String hashedPassword = hashPassword(newPassword);
        if (hashedPassword == null) {
            request.setAttribute("error", "Lỗi khi xử lý mật khẩu. Vui lòng thử lại.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
            return;
        }

        // Cập nhật mật khẩu mới vào cơ sở dữ liệu cho người dùng tương ứng
        boolean isUpdated = userDao.updatePassword(user.getUserId(), hashedPassword);

        if (isUpdated) {
            // Nếu cập nhật thành công, lưu thông báo thành công vào session
            HttpSession session = request.getSession();
            session.setAttribute("success", "Đặt lại mật khẩu thành công. Vui lòng đăng nhập bằng mật khẩu mới.");
            // Chuyển hướng về trang đăng nhập (login.jsp)
            response.sendRedirect("login.jsp");
        } else {
            // Nếu cập nhật thất bại, hiển thị thông báo lỗi và quay lại trang resetPassword.jsp
            request.setAttribute("error", "Đặt lại mật khẩu thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("resetPassword.jsp").forward(request, response);
        }
    }
}
