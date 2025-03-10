/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.EmployeeDAO;
import dao.UserAccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import models.Customer;
import models.Employee;
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
        try {
            String listOf = request.getParameter("listOf");
            if (listOf.equals("emp")) {
                request.setAttribute("list", userDao.getEmployees());
                EmployeeDAO employeeDao = new EmployeeDAO();
                HashMap<Integer, Employee> map = new HashMap<>();
                for (Employee emp : employeeDao.getAllEmployees()) {
                    map.put(emp.getUserId(), emp);
                }
                request.setAttribute("map", map);
                request.setAttribute("listOf", listOf);
                
            } else {
                request.setAttribute("list", userDao.getCustomers());
                CustomerDAO customerDao = new CustomerDAO();
                HashMap<Integer, Customer> map = new HashMap<>();
                for (Customer cus : customerDao.getAllCustomers()) {
                    map.put(cus.getUserId(), cus);
                }
                request.setAttribute("map", map);
            }
        } catch (Exception e) {
            request.setAttribute("list", userDao.getCustomers());
            CustomerDAO customerDao = new CustomerDAO();
            HashMap<Integer, Customer> map = new HashMap<>();
            for (Customer cus : customerDao.getAllCustomers()) {
                map.put(cus.getUserId(), cus);
            }
            request.setAttribute("map", map);
        }
        request.getRequestDispatcher("account_management.jsp").forward(request, response);
        
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String userIdParam = request.getParameter("changeStatusId");
        if (userIdParam != null) {
            int userId = Integer.parseInt(userIdParam);
            UserAccountDAO userDao = new UserAccountDAO();
            userDao.toggleStatus(userId);
        }
         String referer = request.getHeader("referer");
        response.sendRedirect(referer); // Chuyển hướng về trang chính sau khi cập nhật
    }
}
