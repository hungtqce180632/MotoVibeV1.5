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

        // Example: your DAO usage, if you need to check something about the user
        UserAccountDAO accDao = new UserAccountDAO();
        // boolean userExists = accDao.checkUserByEmail(emailSendOTP); // your code, if needed

        // Generate random 6-digit OTP
        int otp = new Random().nextInt(999999); // range 0-999999
        if (otp < 100000) {
            otp += 100000; // ensure it's always 6 digits (e.g., 012345 -> 12345)
        }

        // Attempt to send email
        boolean sendSuccess = sendEmail(emailSendOTP, otp);

        // JSON response setup
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();

        // If successful, store OTP in session and return success = true
        if (sendSuccess) {
            request.getSession().setAttribute("otp", otp);
            request.getSession().setAttribute("emailSendOTP", emailSendOTP);

            response.setStatus(HttpServletResponse.SC_OK);
            response.getWriter().write(gson.toJson(true));
        } else {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write(gson.toJson(false));
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
