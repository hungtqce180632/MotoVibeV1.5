package controllers;

import dao.UserAccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.Random;

/**
 * 
 * @author sanghtpce181720
 */

/**
 * Controller xử lý yêu cầu "Quên mật khẩu" (forgot password).
 * Servlet này kiểm tra email có tồn tại trong hệ thống không.
 * Nếu có, nó tạo OTP, lưu OTP và email vào session, sau đó gửi OTP về email và chuyển hướng đến trang resetPassword.
 */
@WebServlet(name="ForgotPasswordServlet", urlPatterns={"/forgotPassword"})
public class ForgotPasswordServlet extends HttpServlet {

    /**
     * Phương thức doPost xử lý yêu cầu POST từ form "Quên mật khẩu".
     * Lấy email từ form, kiểm tra email tồn tại và thực hiện gửi OTP về email đó.
     *
     * @param request  HttpServletRequest chứa yêu cầu từ client.
     * @param response HttpServletResponse gửi phản hồi về client.
     * @throws ServletException Nếu có lỗi trong quá trình xử lý servlet.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy email từ trường emailTxt của form
        String email = request.getParameter("emailTxt");
        
        // Khởi tạo đối tượng UserAccountDAO để làm việc với dữ liệu tài khoản người dùng
        UserAccountDAO accDAO = new UserAccountDAO();
        
        // Kiểm tra xem email có tồn tại trong hệ thống hay không
        if (accDAO.checkEmailExists(email)) {
            // Tạo OTP
            String otp = generateOTP();
            
            // Lưu OTP và email vào session (dùng các tên attribute tương tự như ở các servlet khác)
            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);  // Đặt OTP vào session với key "otp"
            session.setAttribute("emailSendOTP", email);  // Lưu email đã gửi OTP với key "emailSendOTP"
            
            // Gửi OTP về email (phương thức SendOTPToEmail cần được triển khai trong AccountDAO)
            accDAO.SendOTPToEmail(email, otp);
            
            // Chuyển hướng người dùng đến trang resetPassword để xác thực OTP và đặt lại mật khẩu
            response.sendRedirect("resetPassword");
        } else {
            // Nếu email không tồn tại, thiết lập thông báo lỗi và chuyển tiếp về trang forgotPassword.jsp
            request.setAttribute("error", "Email does not exist. Please try again.");
            request.getRequestDispatcher("forgotPassword.jsp").forward(request, response);
        }
    }

    /**
     * Phương thức generateOTP tạo một OTP gồm 6 chữ số.
     *
     * @return Một chuỗi chứa OTP được tạo ra.
     */
    private String generateOTP() {
        Random rand = new Random();
        // Sinh một số ngẫu nhiên từ 100000 đến 999999 (6 chữ số)
        int otp = 100000 + rand.nextInt(900000);
        return String.valueOf(otp);
    }
}
