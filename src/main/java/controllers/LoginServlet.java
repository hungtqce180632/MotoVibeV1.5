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
import models.Customer;
import models.Employee;

/**
 * 
 * @author sanghtpce181720
 */

/**
 * LoginServlet chịu trách nhiệm xử lý yêu cầu đăng nhập (Login) của người dùng.
 * Sử dụng DAO để kiểm tra thông tin đăng nhập và chuyển hướng theo vai trò
 * (customer, employee, admin).
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    
    /**
     * Phương thức doPost xử lý khi người dùng gửi yêu cầu đăng nhập (phương thức POST).
     * @param request  Yêu cầu từ client
     * @param response Phản hồi sẽ gửi về client
     * @throws ServletException
     * @throws IOException 
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Lấy email và password từ form đăng nhập
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
        // Tạo một instance của UserAccountDAO để gọi phương thức login
        UserAccountDAO userDAO = new UserAccountDAO();

        // Gọi phương thức login trong DAO (DAO sẽ tự xử lý việc mã hoá/kiểm tra mật khẩu)
        UserAccount user = userDAO.login(email, password);

        // Tạo hoặc lấy session hiện tại
        HttpSession session = request.getSession();
        
        // Kiểm tra xem thông tin user có tồn tại và account còn hoạt động hay không
        if (user != null && user.isStatus()) { 
            // Lưu đối tượng user vào session
            session.setAttribute("user", user);
            
            // Kiểm tra vai trò (role) của user và thiết lập session phù hợp
            if ("customer".equals(user.getRole())) {
                CustomerDAO customerDAO = new CustomerDAO();
                // Lấy thông tin khách hàng (customer) từ userId
                Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
                session.setAttribute("customer", customer);
                session.setAttribute("userRole", "customer");
                // Điều hướng đến trang "home" dành cho customer
                response.sendRedirect("home");
                return;
            } else if ("employee".equals(user.getRole())) {
                EmployeeDAO employeeDAO = new EmployeeDAO();
                // Lấy thông tin nhân viên (employee) từ userId
                Employee employee = employeeDAO.getEmployeeByUserId(user.getUserId());
                session.setAttribute("employee", employee);
                session.setAttribute("userRole", "employee");
                // Điều hướng đến trang "home" dành cho employee
                response.sendRedirect("home");
                return;
            } else if ("admin".equals(user.getRole())) {
                // Thiết lập vai trò admin trong session
                session.setAttribute("userRole", "admin");
                // Điều hướng đến trang "home" dành cho admin
                response.sendRedirect("home");
                return;
            }
        } else {
            // Nếu thông tin đăng nhập không hợp lệ hoặc tài khoản không hoạt động
            request.setAttribute("error", "Wrong email or password");
            // Quay lại trang login.jsp để hiển thị thông báo lỗi
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
    }

    /**
     * Phương thức doGet xử lý khi người dùng truy cập trang login (phương thức GET).
     * Thường dùng để hiển thị trang đăng nhập.
     * @param request  Yêu cầu từ client
     * @param response Phản hồi sẽ gửi về client
     * @throws ServletException
     * @throws IOException 
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Chuyển tiếp đến trang login.jsp
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
