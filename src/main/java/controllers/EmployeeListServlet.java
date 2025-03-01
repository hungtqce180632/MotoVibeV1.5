/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.UserAccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import models.UserAccount;

/**
 *
 * @author tiend
 */
@WebServlet(name = "EmployeeListServlet", urlPatterns = {"/employeeList"})
public class EmployeeListServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserAccountDAO userDao = new UserAccountDAO();
        List<UserAccount> employees = userDao.getEmployees();

        request.setAttribute("employees", employees);
        request.getRequestDispatcher("employee_list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int userId = Integer.parseInt(request.getParameter("userId"));

        UserAccountDAO userDao = new UserAccountDAO();

        // Chuyển đổi trạng thái
        userDao.toggleStatus(userId);

        // Quay lại danh sách khách hàng
        response.sendRedirect("employeeList");
    }

}
