package OTP;

import dao.UserAccountDAO;
import com.google.gson.Gson;
import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Properties;
import java.util.Random;
import java.util.Map;
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

        String emailSendOTP = request.getParameter("email");

        // Kiểm tra email có tồn tại trong database không (nếu cần)
        UserAccountDAO accDao = new UserAccountDAO();
        // boolean userExists = accDao.checkUserByEmail(emailSendOTP);

        // Tạo OTP 6 chữ số
        int otp = 100000 + new Random().nextInt(900000);

        // Gửi email OTP
        boolean sendSuccess = sendEmail(emailSendOTP, otp);

        // Chuẩn bị phản hồi JSON
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();

        if (sendSuccess) {
            request.getSession().setAttribute("otp", otp);
            request.getSession().setAttribute("emailSendOTP", emailSendOTP);

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(gson.toJson(Map.of("success", true, "message", "OTP đã gửi thành công")));
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(Map.of("success", false, "message", "Gửi email thất bại")));
        }
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
