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
import java.sql.SQLException;
import models.Customer;
import models.Employee;

@WebServlet(name = "LoginServlet", urlPatterns = {"/login"})
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        UserAccountDAO userDAO = new UserAccountDAO();

        UserAccount user = userDAO.login(email, password);
        if (user != null && user.isStatus()) { // Check if account is active
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            
            // Set role-specific attributes
            if ("customer".equals(user.getRole())) {
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
                session.setAttribute("customer", customer);
                response.sendRedirect("index.jsp");
                return;
            } else if ("employee".equals(user.getRole())) {
                EmployeeDAO employeeDAO = new EmployeeDAO();
                Employee employee = employeeDAO.getEmployeeByUserId(user.getUserId());
                session.setAttribute("employee", employee);
                response.sendRedirect("index.jsp");
                return;
            } else if ("admin".equals(user.getRole())) {
                response.sendRedirect("index.jsp");
                return;
            }
        } else {
            request.setAttribute("error", "Invalid email or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
