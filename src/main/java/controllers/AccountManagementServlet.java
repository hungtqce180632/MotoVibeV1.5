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
@WebServlet(name = "AccountManagementServlet", urlPatterns = {"/accountManagement"})
public class AccountManagementServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        UserAccountDAO userDao = new UserAccountDAO();
        List<UserAccount> users = userDao.getAllUsers();

        request.setAttribute("users", users);
        request.getRequestDispatcher("account_management.jsp").forward(request, response);
    }
}
