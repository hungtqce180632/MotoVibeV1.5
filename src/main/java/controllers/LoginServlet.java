package controllers;

import dao.UserAccountDAO;
import models.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserAccountDAO userDao = new UserAccountDAO();
        UserAccount user = userDao.login(email, password);

        if (user != null) {
            // Lưu thông tin người dùng vào session
            HttpSession session = request.getSession();
<<<<<<< HEAD
            session.setAttribute("user", user);
            session.setAttribute("userRole", user.getRole()); // Add this line
            response.sendRedirect("motorManagement"); // Chuyển hướng sau khi đăng nhập thành công
=======
            session.setAttribute("user", user); // Lưu đối tượng UserAccount vào session
            session.setAttribute("userId", user.getUserId()); // Lưu ID người dùng vào session
            
            // Chuyển hướng sau khi đăng nhập thành công
            response.sendRedirect("index.jsp");
>>>>>>> origin/main
        } else {
            // Thông báo lỗi nếu đăng nhập không thành công
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
