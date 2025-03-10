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
import java.sql.Date;
import java.time.LocalDate;
import java.time.LocalDateTime;
import models.UserAccount;

/**
 *
 * @author tiend
 */
@WebServlet(name = "CreateEmployeeServlet", urlPatterns = {"/createEmployee"})
public class CreateEmployeeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            request.setAttribute("isSuccess", request.getParameter("isSuccess"));
        } catch (Exception e) {

        }
        request.getRequestDispatcher("create_employee.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phoneNumber");
        String role = "employee";
        Date date = Date.valueOf(LocalDate.now());
        boolean status = true;
        UserAccount ac = new UserAccount();
        ac.setDateCreated(date);
        ac.setEmail(email);
        ac.setPassword(password);
        ac.setStatus(status);
        ac.setRole(role);
        UserAccountDAO acd = new UserAccountDAO();
        acd.registerUser(ac);
        acd.addEmployeeDetails(ac, name, phoneNumber);
        response.sendRedirect("createEmployee?isSuccess=1");
    }

}
