package controllers;

import dao.EventDAO;
import models.Event;
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
 *
 * @author ACER
 */
@WebServlet(name = "ManageEventServlet", urlPatterns = {"/ManageEventServlet"})
public class ManageEventServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Lấy phiên làm việc hiện tại
        HttpSession session = request.getSession();
        // Lấy thông tin nhân viên đã đăng nhập từ session
        UserAccount admin = (UserAccount) session.getAttribute("user");

        // Kiểm tra xem người dùng có đăng nhập và có vai trò là nhân viên không
        if (admin == null || !"admin".equalsIgnoreCase(admin.getRole())) {
            // Chuyển hướng đến trang đăng nhập nếu không phải nhân viên
            response.sendRedirect("login.jsp");
            return;
        }
        try {
            
            // Fetch all events using EventDAO
            List<Event> events = EventDAO.getAllEvents();

            // Set the events in the request scope to pass them to the JSP page
            request.setAttribute("events", events);

            // Forward the request to manage_event.jsp to display the events
            request.getRequestDispatcher("manage_event.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().write("Error fetching events: " + e.getMessage());
        }
    }
}
