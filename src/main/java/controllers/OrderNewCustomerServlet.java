package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import dao.CustomerDAO;
import dao.MotorDAO;
import dao.OrderDAO;
import dao.UserAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import models.Motor;
import models.Order;
import models.UserAccount;

/**
 *
 * @author ACER
 */
@WebServlet(name = "OrderNewCustomerServlet", urlPatterns = {"/orderNewCustomer"})
public class OrderNewCustomerServlet extends HttpServlet {

    // Đối tượng Logger để ghi log lỗi và thông tin
    private static final Logger LOGGER = Logger.getLogger(OrderNewCustomerServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Lấy thông tin hiện tại
            HttpSession session = request.getSession();
            // Lấy thông tin người dùng đã đăng nhập từ session
            UserAccount user = (UserAccount) session.getAttribute("user");

            // Kiểm tra xem người dùng có đăng nhập và có vai trò là nhân viên không
            if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
                // Chuyển hướng đến trang đăng nhập nếu không phải nhân viên
                response.sendRedirect("login.jsp");
                return;
            }

            // Lấy motorId gán cho motorIdParam
            String motorIdParam = request.getParameter("motorId");
            if (motorIdParam != null) {
                int motorId = Integer.parseInt(motorIdParam);
                MotorDAO motorDAO = new MotorDAO();
                // Lấy thông tin xe máy theo ID
                Motor motor = motorDAO.getMotorById(motorId);
                if (motor != null) {
                    // Đặt thông tin xe máy vào thuộc tính request để JSP sử dụng
                    request.setAttribute("motor", motor);
                }
            }

            // Lấy danh sách tất cả xe máy để hiển thị trong dropdown
            MotorDAO motorDAO = new MotorDAO();
            List<Motor> motors = motorDAO.getAllMotors();
            // Đặt danh sách xe máy vào thuộc tính request để JSP sử dụng
            request.setAttribute("motors", motors);

            // Chuyển tiếp yêu cầu đến trang JSP để hiển thị
            request.getRequestDispatcher("order_new_customer.jsp").forward(request, response);
        } catch (SQLException ex) {
            // Ghi log lỗi SQL
            LOGGER.log(Level.SEVERE, "Error when getting motorbike list", ex);
            // Đặt thông báo lỗi vào session và chuyển hướng đến trang quản lý đơn hàng
            request.getSession().setAttribute("errorMessage", "Error loading form: " + ex.getMessage());
            response.sendRedirect("adminOrders");
        }
    }

    /**
     * Xử lý yêu cầu HTTP POST - xử lý dữ liệu gửi từ form
     *
     * @param request yêu cầu từ servlet
     * @param response phản hồi từ servlet
     * @throws ServletException nếu xảy ra lỗi liên quan đến servlet
     * @throws IOException nếu xảy ra lỗi I/O
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Lấy phiên làm việc hiện tại
        HttpSession session = request.getSession();
        // Lấy thông tin nhân viên đã đăng nhập từ session
        UserAccount employee = (UserAccount) session.getAttribute("user");

        // Kiểm tra xem người dùng có đăng nhập và có vai trò là nhân viên không
        if (employee == null || !"employee".equalsIgnoreCase(employee.getRole())) {
            // Chuyển hướng đến trang đăng nhập nếu không phải nhân viên
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Lấy thông tin khách hàng mới từ form
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            // Lấy thông tin đơn hàng từ form
            int motorId = Integer.parseInt(request.getParameter("motorId"));
            String paymentMethod = request.getParameter("paymentMethod");
            
            // Kiểm tra lựa chọn bảo hành (radio button trả về "true" dưới dạng chuỗi)
            boolean hasWarranty = "true".equals(request.getParameter("hasWarranty"));
            
            // Kiểm tra trạng thái đặt cọc (checkbox trả về null nếu không được chọn)
            boolean depositStatus = (request.getParameter("depositStatus") != null);

            // Kiểm tra dữ liệu đầu vào của khách hàng
            if (fullName == null || fullName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()) {
                // Đặt thông báo lỗi và chuyển hướng nếu các trường bắt buộc bị thiếu
                session.setAttribute("errorMessage", "All customer fields marked with * are required");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Kiểm tra số điện thoại (phải là 10 chữ số)
            if (!phone.matches("\\d{10}")) {
                session.setAttribute("errorMessage", "Phone number must consist of exactly 10 digits");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Kiểm tra dữ liệu đơn hàng
            if (motorId <= 0 || paymentMethod == null || paymentMethod.trim().isEmpty()) {
                // Đặt thông báo lỗi và chuyển hướng nếu dữ liệu đơn hàng không hợp lệ
                session.setAttribute("errorMessage", "All order information is required");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Kiểm tra xem xe máy có tồn tại và còn hàng không
            MotorDAO motorDAO = new MotorDAO();
            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                // Đặt thông báo lỗi nếu xe máy không tồn tại
                session.setAttribute("errorMessage", "The selected motorcycle does not exist.");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            if (motor.getQuantity() <= 0) {
                // Đặt thông báo lỗi nếu xe máy hết hàng
                session.setAttribute("errorMessage", "Xe máy được chọn đã hết hàng");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Kiểm tra xem email đã tồn tại trong hệ thống chưa
            UserAccountDAO userAccountDAO = new UserAccountDAO();
            if (userAccountDAO.checkEmailExists(email)) {
                // Đặt thông báo lỗi nếu email đã được đăng ký
                session.setAttribute("errorMessage", "Email already exists. Please use another email or create an order for an existing customer..");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Bước 1: Tạo tài khoản người dùng mới với mật khẩu mặc định
            UserAccount newUserAccount = new UserAccount();
            newUserAccount.setEmail(email);
            newUserAccount.setPassword("202cb962ac59075b964b07152d234b70"); // Mật khẩu mặc định cho khách hàng mới "123"
            newUserAccount.setRole("customer");
            newUserAccount.setStatus(true);

            // Đăng ký tài khoản người dùng mới
            boolean userCreated = userAccountDAO.registerUser(newUserAccount);

            if (!userCreated || newUserAccount.getUserId() <= 0) {
                // Đặt thông báo lỗi nếu tạo tài khoản thất bại
                session.setAttribute("errorMessage", "Unable to create user account");
                response.sendRedirect("orderNewCustomer");
                return;
            }
            
            // Ghi log ID của tài khoản vừa tạo để kiểm tra
            LOGGER.log(Level.INFO, "Created user account with ID: " + newUserAccount.getUserId());

            // Bước 2: Tạo thông tin khách hàng liên kết với tài khoản mới
            Customer newCustomer = new Customer();
            newCustomer.setUserId(newUserAccount.getUserId());  // Liên kết với tài khoản vừa tạo
            newCustomer.setName(fullName);
            newCustomer.setPhoneNumber(phone);
            newCustomer.setAddress(address);

            CustomerDAO customerDAO = new CustomerDAO();
            // Thêm thông tin khách hàng vào cơ sở dữ liệu
            boolean customerCreated = customerDAO.insertCustomer(newCustomer);
            
            if (!customerCreated) {
                // Đặt thông báo lỗi nếu tạo thông tin khách hàng thất bại
                session.setAttribute("errorMessage", "Unable to create customer information");
                response.sendRedirect("orderNewCustomer");
                return;
            }
            
            // Lấy ID của khách hàng dựa trên userId
            int customerId = customerDAO.getCustomerIdByUserId(newUserAccount.getUserId());
            
            if (customerId <= 0) {
                // Đặt thông báo lỗi nếu không lấy được ID khách hàng
                session.setAttribute("errorMessage", "Unable to get customer ID");
                response.sendRedirect("orderNewCustomer");
                return;
            }
            
            // Ghi log ID của khách hàng vừa tạo để kiểm tra
            LOGGER.log(Level.INFO, "Created customer with ID: " + customerId);

            // Bước 3: Tạo đơn hàng
            Order order = new Order();
            order.setCustomerId(customerId); // Liên kết với khách hàng vừa tạo
            order.setMotorId(motorId);
            order.setEmployeeId(employee.getUserId()); // Nhân viên tạo đơn hàng
            order.setPaymentMethod(paymentMethod);
            
            // Tính tổng số tiền dựa trên lựa chọn bảo hành
            double basePrice = motor.getPrice();
            double totalAmount = basePrice;
            
            if (hasWarranty) {
                // Thêm 10% phí bảo hành vào giá gốc
                totalAmount = basePrice * 1.10;
                LOGGER.log(Level.INFO, "add warranty: basePrice=" + basePrice + ", totalAmount=" + totalAmount);
            }
            
            order.setTotalAmount(totalAmount);
            order.setDepositStatus(depositStatus);
            order.setHasWarranty(hasWarranty);
            order.setOrderStatus("Pending"); // Trạng thái ban đầu cho đơn hàng do nhân viên tạo

            // Tạo mã đơn hàng duy nhất dựa trên thời gian
            String orderCode = "MV-" + System.currentTimeMillis() % 100000;
            order.setOrderCode(orderCode);

            // Lưu đơn hàng vào cơ sở dữ liệu
            OrderDAO orderDAO = new OrderDAO();
            boolean orderCreated = orderDAO.createOrder(order);
            
            if (!orderCreated) {
                // Đặt thông báo lỗi nếu tạo đơn hàng thất bại (Không thể tạo đơn hàng)
                session.setAttribute("errorMessage", "Unable to create order");
                response.sendRedirect("orderNewCustomer");
                return;
            }
            
            // Đặt thông báo thành công và chuyển hướng đến trang quản lý đơn hàng (Đơn hàng đã được tạo thành công. Mã đơn hàng)
            session.setAttribute("successMessage", "Order has been created successfully. Order ID: " + orderCode);
            response.sendRedirect("adminOrders");

        } catch (NumberFormatException e) {
            // Xử lý lỗi định dạng số không hợp lệ 
            LOGGER.log(Level.SEVERE, "Invalid number format", e);
            //Dữ liệu số không hợp lệ
            session.setAttribute("errorMessage", "Invalid numeric data: " + e.getMessage());
            response.sendRedirect("orderNewCustomer");
        } catch (Exception e) {
            // Xử lý các lỗi bất ngờ khác
            LOGGER.log(Level.SEVERE, "Error creating customer or order", e);
            session.setAttribute("errorMessage", "error: " + e.getMessage());
            response.sendRedirect("orderNewCustomer");
        }
    }
}