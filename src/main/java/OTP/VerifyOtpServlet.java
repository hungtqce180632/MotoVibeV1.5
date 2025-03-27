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

        // Lấy otp user nhập vào (VD: { "otp": "123456" })
        String enteredOtp = (String) requestData.get("otp");

        // Lấy otp đã lưu trong session (đặt bởi SendOtpServlet)
        Object otpObj = request.getSession().getAttribute("otp");
        String sessionOtp = (otpObj != null) ? String.valueOf(otpObj) : "";

        // Kiểm tra khớp
        boolean match = enteredOtp != null && enteredOtp.equals(sessionOtp);

        // Xoá OTP khỏi session tránh tái sử dụng
        request.getSession().removeAttribute("otp");

        // Tạo Map response JSON
        Map<String, Object> jsonResponse = new HashMap<>();
        if (match) {
            jsonResponse.put("success", true);
            jsonResponse.put("message", "Xác thực OTP thành công.");
            // Nếu bạn muốn trả về token hoặc param khác cho client:
            // jsonResponse.put("token", "some-random-token");
        } else {
            jsonResponse.put("success", false);
            jsonResponse.put("message", "Mã OTP không hợp lệ hoặc đã hết hạn.");
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
