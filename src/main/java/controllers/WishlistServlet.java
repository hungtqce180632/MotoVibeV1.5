package controllers;

import dao.CustomerDAO;
import dao.WishlistDAO;
import models.Motor;
import models.Customer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import models.UserAccount;

/**
 * Servlet xử lý danh sách yêu thích (wishlist) của người dùng.
 * URL mapping: "/wishlist"
 *
 * Servlet này hỗ trợ hai phương thức:
 * - doGet: Hiển thị danh sách yêu thích của khách hàng
 * - doPost: Thêm hoặc xoá motor khỏi danh sách yêu thích dựa trên action được gửi từ client.
 */
@WebServlet(name = "WishlistServlet", urlPatterns = {"/wishlist"})
public class WishlistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * Phương thức doGet xử lý yêu cầu GET.
     * - Kiểm tra xem người dùng đã đăng nhập chưa, nếu chưa chuyển hướng đến trang đăng nhập.
     * - Lấy thông tin khách hàng dựa trên userId.
     * - Lấy danh sách wishlist của khách hàng và chuyển tiếp sang trang JSP hiển thị.
     *
     * @param request  HttpServletRequest chứa yêu cầu từ client.
     * @param response HttpServletResponse dùng để gửi phản hồi về client.
     * @throws ServletException Nếu có lỗi xảy ra trong quá trình xử lý servlet.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy session hiện tại
        HttpSession session = request.getSession();
        // Lấy đối tượng UserAccount từ session
        UserAccount user = (UserAccount) session.getAttribute("user");

        // Nếu người dùng chưa đăng nhập, chuyển hướng đến trang đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Lấy thông tin khách hàng dựa trên userId
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByUserId(user.getUserId());

        // Lấy danh sách wishlist của khách hàng từ WishlistDAO
        WishlistDAO wishlistDAO = new WishlistDAO();
        List<Motor> wishlist = wishlistDAO.getWishlistForUser(customer.getCustomerId());

        // Đưa danh sách wishlist vào attribute của request để JSP có thể hiển thị
        request.setAttribute("wishlist", wishlist);

        // Chuyển tiếp yêu cầu đến trang wishlist.jsp để hiển thị danh sách yêu thích
        request.getRequestDispatcher("wishlist.jsp").forward(request, response);
    }

    /**
     * Phương thức doPost xử lý yêu cầu POST.
     * - Kiểm tra người dùng đã đăng nhập hay chưa.
     * - Xử lý các action "add" (thêm motor vào wishlist) và "remove" (xoá motor khỏi wishlist).
     * - Trả về kết quả thông qua response writer.
     *
     * @param request  HttpServletRequest chứa yêu cầu từ client.
     * @param response HttpServletResponse dùng để gửi phản hồi về client.
     * @throws ServletException Nếu có lỗi xảy ra trong quá trình xử lý servlet.
     * @throws IOException      Nếu có lỗi I/O xảy ra.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy session hiện tại
        HttpSession session = request.getSession();
        // Lấy đối tượng UserAccount từ session
        UserAccount user = (UserAccount) session.getAttribute("user");

        // Nếu người dùng chưa đăng nhập, trả về thông báo "notLoggedIn" thay vì chuyển hướng
        if (user == null) {
            response.getWriter().write("notLoggedIn");
            return;
        }

        // Lấy tham số action từ request để xác định hành động (add hoặc remove)
        String action = request.getParameter("action");

        // Lấy thông tin khách hàng dựa trên userId
        CustomerDAO customerDAO = new CustomerDAO();
        Customer customer = customerDAO.getCustomerByUserId(user.getUserId());

        // Khởi tạo đối tượng WishlistDAO để quản lý danh sách yêu thích
        WishlistDAO wishlistDAO = new WishlistDAO();

        if ("add".equals(action)) {
            // Nếu action là "add", lấy motorId từ request
            int motorId = Integer.parseInt(request.getParameter("motorId"));

            // Thêm motor vào danh sách yêu thích của khách hàng
            boolean isAdded = wishlistDAO.addToWishlist(motorId, customer.getCustomerId());

            // Trả về kết quả: "success" nếu thêm thành công, "error" nếu thất bại
            if (isAdded) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }

        } else if ("remove".equals(action)) {
            // Nếu action là "remove", lấy motorId từ request
            int motorId = Integer.parseInt(request.getParameter("motorId"));

            // Xoá motor khỏi danh sách yêu thích của khách hàng
            boolean isRemoved = wishlistDAO.removeMotorFromWishlist(motorId, customer.getCustomerId());

            // Trả về kết quả: "success" nếu xoá thành công, "error" nếu thất bại
            if (isRemoved) {
                response.getWriter().write("success");
            } else {
                response.getWriter().write("error");
            }
        }
    }
}
