package OTP;

import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.BufferedReader;
import java.util.HashMap;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/verifyOtp")
public class VerifyOtpServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Thiết lập response trả về JSON
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        Gson gson = new Gson();
        PrintWriter out = response.getWriter();

        // Đọc JSON từ body request
        BufferedReader br = request.getReader();
        Map<String, Object> requestData = gson.fromJson(br, Map.class);

        // Lấy otp user nhập vào và email từ request
        String enteredOtp = (String) requestData.get("otp");
        String email = (String) requestData.get("email");

        // Lấy session
        HttpSession session = request.getSession();
        
        // Lấy otp đã lưu trong session
        String sessionOtp = (String) session.getAttribute("otp");
        String sessionEmail = (String) session.getAttribute("emailSendOTP");

        // Kiểm tra khớp cả OTP và email
        boolean match = enteredOtp != null && sessionOtp != null && 
                      enteredOtp.equals(sessionOtp) && 
                      email != null && email.equals(sessionEmail);

        // Tạo Map response JSON
        Map<String, Object> jsonResponse = new HashMap<>();
        if (match) {
            // Save verification status to session
            session.setAttribute("otpVerified", true);
            session.setAttribute("verifiedEmail", email);
            // Remove OTP from session for security
            session.removeAttribute("otp");
            
            jsonResponse.put("success", true);
            jsonResponse.put("message", "OTP verification successful.");
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Invalid OTP or OTP has expired.");
        }

        // Gửi JSON kết quả
        out.write(gson.toJson(jsonResponse));
        out.flush();
        out.close();
    }

    @Override
    public String getServletInfo() {
        return "VerifyOtpServlet - verifies the OTP code user entered matches the session OTP";
    }
}
