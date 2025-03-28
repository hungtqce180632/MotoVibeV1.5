package controllers;

import dao.CustomerDAO;
import dao.EmployeeDAO;
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
import java.security.NoSuchAlgorithmException;
import models.Customer;
import models.Employee;

/**
 * Servlet xử lý đăng ký người dùng.
 * URL mapping: "/register"
 * 
 * Quá trình đăng ký bao gồm:
 * 1. Xác thực email đã qua OTP.
 * 2. Kiểm tra các thông tin đầu vào như email, mật khẩu, số điện thoại.
 * 3. Mã hoá mật khẩu bằng MD5.
 * 4. Tạo tài khoản người dùng với role mặc định là "customer".
 * 5. Nếu role là customer, lưu thông tin khách hàng vào cơ sở dữ liệu.
 * 6. Xóa các thuộc tính OTP khỏi session và chuyển hướng về trang chủ sau khi đăng ký thành công.
 * 
 * Lưu ý: Trong ví dụ này, role của người dùng được set mặc định là "customer".
 * Nếu có yêu cầu về nhân viên (employee), bạn có thể bổ sung logic để phân biệt.
 */
@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Phương thức hashPassword dùng để mã hoá mật khẩu sử dụng thuật toán MD5.
     *
     * @param password Mật khẩu cần mã hoá.
     * @return Mật khẩu đã được mã hoá dưới dạng chuỗi hex, hoặc null nếu có lỗi.
     */
    private String hashPassword(String password) {
        try {
            // Khởi tạo đối tượng MessageDigest với thuật toán MD5
            MessageDigest md = MessageDigest.getInstance("MD5");
            // Mã hoá password thành mảng byte
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            // Chuyển đổi mảng byte thành chuỗi hex
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
     * Phương thức doPost xử lý yêu cầu đăng ký qua HTTP POST.
     *
     * @param request  HttpServletRequest chứa thông tin yêu cầu từ client.
     * @param response HttpServletResponse dùng để gửi phản hồi về client.
     * @throws ServletException Nếu có lỗi xảy ra trong quá trình xử lý servlet.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Lấy thông tin email, mật khẩu và xác nhận mật khẩu từ form đăng ký
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String emailVerified = request.getParameter("emailVerified");

        // Kiểm tra OTP xác thực email: lấy email đã được gửi OTP từ session
        HttpSession session = request.getSession();
        String verifiedEmail = (String) session.getAttribute("emailSendOTP");

        // Nếu email chưa được xác thực hoặc email không khớp với OTP đã gửi
        if (!"true".equals(emailVerified) || verifiedEmail == null || !verifiedEmail.equals(email)) {
            request.setAttribute("error", "Xác thực email thất bại. Vui lòng xác thực email của bạn trước.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Thiết lập role mặc định là customer
        String role = "customer";

        // Kiểm tra email và password không được null hoặc rỗng
        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email và mật khẩu là bắt buộc.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra mật khẩu và xác nhận mật khẩu có giống nhau hay không
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Mật khẩu và xác nhận mật khẩu không khớp.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Kiểm tra định dạng mật khẩu: phải có ít nhất 1 chữ in hoa, 1 chữ số và 1 ký tự đặc biệt, tối thiểu 8 ký tự
        String passwordPattern = "^(?=.*[A-Z])(?=.*\\d)(?=.*[\\W_]).{8,}$";
        if (!password.matches(passwordPattern)) {
            request.setAttribute("error", "Mật khẩu phải có ít nhất 1 chữ in hoa, 1 số và 1 ký tự đặc biệt.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Mã hoá mật khẩu trước khi lưu vào cơ sở dữ liệu
        String hashedPassword = hashPassword(password);

        if (hashedPassword == null) {
            request.setAttribute("error", "Lỗi khi mã hoá mật khẩu.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Lấy các thông tin cụ thể của khách hàng
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phone_number");
        String address = request.getParameter("address");

        // Kiểm tra số điện thoại: phải là 10 chữ số
        if (phoneNumber == null || !phoneNumber.matches("\\d{10}")) {
            request.setAttribute("error", "Số điện thoại phải đúng 10 chữ số.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Khởi tạo DAO của UserAccount để làm việc với dữ liệu người dùng
        UserAccountDAO userDAO = new UserAccountDAO();

        // Kiểm tra xem email đã tồn tại trong hệ thống hay chưa
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Email đã được đăng ký.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Tạo mới tài khoản người dùng với thông tin đã thu thập
        UserAccount newUser = new UserAccount();
        newUser.setEmail(email);
        newUser.setPassword(hashedPassword); // Lưu mật khẩu đã được mã hoá
        newUser.setRole(role);  // Gán role mặc định là customer
        newUser.setStatus(true); // Tài khoản được kích hoạt ngay sau khi đăng ký

        // Đăng ký tài khoản người dùng vào cơ sở dữ liệu
        boolean isUserCreated = userDAO.registerUser(newUser);

        if (isUserCreated) {
            // Nếu role là customer, lưu thông tin chi tiết của khách hàng
            if ("customer".equals(role)) {
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = new Customer();
                customer.setUserId(newUser.getUserId());
                customer.setName(name);
                customer.setPhoneNumber(phoneNumber);
                customer.setAddress(address);
                // Chèn thông tin khách hàng vào cơ sở dữ liệu
                boolean isCustomerAdded = customerDAO.insertCustomer(customer);

                if (isCustomerAdded) {
                    session.setAttribute("customer", customer);
                } else {
                    request.setAttribute("error", "Thêm thông tin khách hàng thất bại.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
            } else if ("employee".equals(role)) { // Nếu role là employee
                EmployeeDAO employeeDAO = new EmployeeDAO();
                Employee employee = new Employee();
                employee.setUserId(newUser.getUserId());
                employee.setName(name); // Bạn có thể thu thập thêm thông tin nếu cần
                employee.setPhoneNumber(phoneNumber);
                // Thêm thông tin nhân viên vào cơ sở dữ liệu
                boolean isEmployeeAdded = employeeDAO.addEmployee(employee);
                if (isEmployeeAdded) {
                    session.setAttribute("employee", employee);
                } else {
                    request.setAttribute("error", "Thêm thông tin nhân viên thất bại.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
            }

            // Xóa các thuộc tính OTP xác thực khỏi session
            session.removeAttribute("emailSendOTP");
            session.removeAttribute("otp");

            // Lưu thông tin người dùng vào session và gán role
            session.setAttribute("user", newUser);
            session.setAttribute("userRole", role);

            // Chuyển hướng về trang chủ sau khi đăng ký thành công
            response.sendRedirect("home");
        } else {
            // Nếu đăng ký thất bại, chuyển về trang đăng ký với thông báo lỗi
            request.setAttribute("error", "Đăng ký thất bại. Vui lòng thử lại.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    /**
     * Phương thức doGet xử lý yêu cầu GET và chuyển tiếp đến trang đăng ký.
     *
     * @param request  HttpServletRequest chứa thông tin yêu cầu từ client.
     * @param response HttpServletResponse dùng để gửi phản hồi về client.
     * @throws ServletException Nếu có lỗi xảy ra trong quá trình xử lý.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}
