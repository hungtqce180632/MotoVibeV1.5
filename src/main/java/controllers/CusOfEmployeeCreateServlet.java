/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import jakarta.servlet.RequestDispatcher;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.util.List;


import models.Customer;

/**
 *
 * @author ACER
 */
@WebServlet(name = "CusOfEmployeeCreateServlet", urlPatterns = {"/CusOfEmployeeCreateServlet"})
public class CusOfEmployeeCreateServlet extends HttpServlet {

    // This method handles GET requests
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get all customers to display in the list
        CustomerDAO customerDAO = new CustomerDAO();
        List<Customer> customers = customerDAO.getAllCustomersFD();
        request.setAttribute("customers", customers);

        // Forward to the JSP page for rendering
        request.getRequestDispatcher("order_by_employee.jsp").forward(request, response);
    }
}



