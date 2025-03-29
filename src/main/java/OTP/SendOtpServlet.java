package OTP;

import com.google.gson.Gson;
import dao.UserAccountDAO;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * 
 * @author sanghtpce181720
 */


/**
 * Servlet gửi OTP qua email. 
 * Khi client gửi một request POST chứa email, servlet sẽ:
 * 1. Tạo một OTP ngẫu nhiên gồm 6 chữ số.
 * 2. Gửi OTP này qua Gmail SMTP cho email được chỉ định.
 * 3. Lưu OTP và email vào session.
 * 4. Trả về kết quả dưới dạng JSON.
 */
@WebServlet("/sendOtp")
public class SendOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập encoding cho request và response để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Sử dụng Gson để parse JSON từ request và trả về JSON cho client
        Gson gson = new Gson();
        PrintWriter out = response.getWriter();

        // Đọc JSON từ body request
        BufferedReader br = request.getReader();
        Map<String, Object> requestData = gson.fromJson(br, Map.class);

        // Lấy email từ JSON (vd: { "email": "abc@gmail.com" })
        String emailSendOTP = (String) requestData.get("email");

        // Tạo OTP ngẫu nhiên gồm 6 chữ số
        int otp = new Random().nextInt(900000) + 100000;

        // Gửi OTP qua Gmail SMTP
        boolean sendSuccess = sendEmail(emailSendOTP, otp);

        // Tạo Map để trả về dữ liệu JSON cho client
        Map<String, Object> jsonResponse = new HashMap<>();

        if (sendSuccess) {
            // Lưu OTP và email vào session để xác thực sau này
            request.getSession().setAttribute("otp", String.valueOf(otp));
            request.getSession().setAttribute("emailSendOTP", emailSendOTP);

            jsonResponse.put("success", true);
            jsonResponse.put("message", "OTP đã được gửi thành công!");
        } else {
            // Nếu gửi mail thất bại, trả về mã lỗi 500 và thông báo lỗi
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Gửi OTP thất bại. Vui lòng thử lại.");
        }

        // Chuyển Map sang JSON và trả về cho client
        out.write(gson.toJson(jsonResponse));
        out.flush();
        out.close();
    }

    /**
     * Phương thức gửi OTP qua Gmail SMTP.
     *
     * @param toEmail Email người nhận.
     * @param otp     Mã OTP cần gửi.
     * @return true nếu gửi mail thành công, false nếu thất bại.
     */
    private boolean sendEmail(String toEmail, int otp) {
        // Thông tin tài khoản Gmail dùng để gửi mail
        final String fromEmail = "motovibe132@gmail.com";
        final String password = "hcgl qqmf orzz nlcz";

        // Cấu hình thông số SMTP cho Gmail
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Tạo session gửi mail với Authenticator cung cấp thông tin đăng nhập
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Tạo đối tượng message và thiết lập các thông tin cần thiết
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Your OTP code from MotoVibe");
            message.setText("Hello,\n\nYour OTP code is: " + otp
                    + "\n\nPlease enter this code to verify.\n\nThank you!");

            // Gửi mail
            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
