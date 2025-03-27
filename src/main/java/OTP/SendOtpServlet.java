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

@WebServlet("/sendOtp")
public class SendOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập các thông tin cơ bản cho response
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        // Dùng Gson để parse JSON & trả JSON
        Gson gson = new Gson();
        PrintWriter out = response.getWriter();

        // Đọc JSON từ body request
        BufferedReader br = request.getReader();
        Map<String, Object> requestData = gson.fromJson(br, Map.class);

        // Lấy email từ object JSON (ví dụ { "email":"abc@gmail.com" })
        String emailSendOTP = (String) requestData.get("email");

        // Ví dụ nếu bạn muốn kiểm tra user tồn tại hay chưa:
        // UserAccountDAO accDao = new UserAccountDAO();
        // boolean userExists = accDao.checkUserByEmail(emailSendOTP);
        // if (!userExists) { ... }

        // Generate random 6-digit OTP (100000 -> 999999)
        int otp = new Random().nextInt(900000) + 100000;

        // Gửi mail
        boolean sendSuccess = sendEmail(emailSendOTP, otp);

        // Tạo một Map để chứa response JSON trả về
        Map<String, Object> jsonResponse = new HashMap<>();

        if (sendSuccess) {
            // Lưu OTP vào session
            request.getSession().setAttribute("otp", String.valueOf(otp));
            request.getSession().setAttribute("emailSendOTP", emailSendOTP);

            jsonResponse.put("success", true);
            jsonResponse.put("message", "OTP đã được gửi thành công!");
        } else {
            // Báo lỗi nếu gửi mail thất bại
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
     * Gửi OTP qua Gmail SMTP
     */
    private boolean sendEmail(String toEmail, int otp) {
        final String fromEmail = "motovibe132@gmail.com";
        final String password = "hcgl qqmf orzz nlcz";

        // Cấu hình Gmail SMTP
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Tạo session gửi email
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(toEmail));
            message.setSubject("Your OTP code from MotoVibe");
            message.setText("Hello,\n\nYour OTP code is: " + otp
                    + "\n\nPlease enter this code to verify.\n\nThank you!");

            Transport.send(message);
            return true;

        } catch (MessagingException e) {
            e.printStackTrace();
            return false;
        }
    }
}
