package controllers;

import dao.EmployeeDAO;
import dao.UserAccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.UserAccount;

@WebServlet(name = "EditEmployeeServlet", urlPatterns = {"/editEmployee"})
public class EditEmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String userIdParam = request.getParameter("id");
        if (userIdParam != null) {
            int userId = Integer.parseInt(userIdParam);
            UserAccountDAO userAccountDAO = new UserAccountDAO();
            EmployeeDAO ed = new EmployeeDAO();       
            request.setAttribute("user", userAccountDAO.getUserById(userId));
            request.setAttribute("emp", ed.getEmployeeByUserId(userId));
        }
        request.setAttribute("isSuccess", request.getParameter("isSuccess"));
        request.getRequestDispatcher("edit_employee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));
        String email = request.getParameter("email");
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");

        UserAccountDAO userAccountDAO = new UserAccountDAO();
        userAccountDAO.updateUserAccount(userId, email, password);
        userAccountDAO.updateEmployee(userId, name, phoneNumber);

        response.sendRedirect("editEmployee?id=" + userId + "&isSuccess=1");
    }
}
