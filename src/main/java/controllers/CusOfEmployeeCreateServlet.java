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
import java.sql.SQLException;

import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import models.Customer;

/**
 *
 * @author ACER
 */
@WebServlet(name = "CusOfEmployeeCreateServlet", urlPatterns = {"/CusOfEmployeeCreateServlet"})
public class CusOfEmployeeCreateServlet extends HttpServlet {


    // This method handles GET requests
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            String customerIdParam = request.getParameter("customerId");
            
            // If a customerId is passed, fetch the specific customer details
            if (customerIdParam != null) {
                int customerId = Integer.parseInt(customerIdParam);
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = customerDAO.getCustomerById(customerId);
                
                if (customer != null) {
                    request.setAttribute("customer", customer);
                }
            }
            
            // Get all customers to populate the dropdown
            CustomerDAO customerDAO = new CustomerDAO();
            List<Customer> customers = customerDAO.getAllCustomersFD();
            request.setAttribute("customers", customers);
            
            // Forward to the JSP page for rendering
            request.getRequestDispatcher("order_by_employee.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(CusOfEmployeeCreateServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
