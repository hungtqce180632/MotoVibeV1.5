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

        // Thiết lập encoding cho request và response để hỗ trợ tiếng Việt
        request.setCharacterEncoding("UTF-8");  // Đặt mã hóa ký tự cho request là UTF-8
        response.setContentType("application/json");  // Đặt kiểu dữ liệu của response là JSON
        response.setCharacterEncoding("UTF-8");  // Đặt mã hóa ký tự cho response là UTF-8

        // Khởi tạo đối tượng Gson để chuyển đổi dữ liệu JSON
        Gson gson = new Gson();  // Tạo instance của Gson
        PrintWriter out = response.getWriter();  // Lấy đối tượng PrintWriter để ghi dữ liệu vào response

        // Đọc dữ liệu JSON từ body của request
        BufferedReader br = request.getReader();  // Tạo BufferedReader để đọc dữ liệu từ request
        Map<String, Object> requestData = gson.fromJson(br, Map.class);  // Chuyển đổi JSON thành Map

        // Lấy OTP và email do người dùng nhập từ Map
        String enteredOtp = (String) requestData.get("otp");  // Lấy OTP người dùng nhập vào
        String email = (String) requestData.get("email");  // Lấy email từ JSON

        // Lấy session hiện tại
        HttpSession session = request.getSession();  // Lấy đối tượng HttpSession của người dùng

        // Lấy OTP và email đã được lưu trong session
        String sessionOtp = (String) session.getAttribute("otp");  // Lấy OTP đã lưu trong session
        String sessionEmail = (String) session.getAttribute("emailSendOTP");  // Lấy email đã lưu trong session

        // So sánh OTP và email người dùng nhập với OTP và email đã lưu trong session
        boolean match = enteredOtp != null && sessionOtp != null && 
                      enteredOtp.equals(sessionOtp) && 
                      email != null && email.equals(sessionEmail);  // Kết quả so sánh

        // Tạo Map để chứa dữ liệu phản hồi dạng JSON
        Map<String, Object> jsonResponse = new HashMap<>();  // Tạo một HashMap để lưu trữ kết quả

        if (match) {  // Nếu OTP và email khớp
            // Lưu trạng thái OTP đã xác thực vào session
            session.setAttribute("otpVerified", true);  // Đánh dấu OTP đã được xác thực
            session.setAttribute("verifiedEmail", email);  // Lưu email đã xác thực vào session
            // Xóa OTP khỏi session để bảo mật
            session.removeAttribute("otp");  // Xóa thuộc tính OTP khỏi session

            jsonResponse.put("success", true);  // Đánh dấu thành công trong phản hồi JSON
            jsonResponse.put("message", "OTP verification successful.");  // Thông điệp thành công
        } else {
            jsonResponse.put("success", false);  // Đánh dấu thất bại trong phản hồi JSON
            jsonResponse.put("message", "Invalid OTP or OTP has expired.");  // Thông điệp lỗi
        }

        // Chuyển đổi Map phản hồi sang JSON và gửi về cho client
        out.write(gson.toJson(jsonResponse));  // Ghi dữ liệu JSON vào response
        out.flush();  // Đẩy dữ liệu ra client
        out.close();  // Đóng PrintWriter
    }

    @Override
    public String getServletInfo() {
        // Trả về thông tin mô tả về servlet
        return "VerifyOtpServlet - verifies the OTP code user entered matches the session OTP";
    }
}
