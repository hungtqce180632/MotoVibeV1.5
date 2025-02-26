/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.EmployeeDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import models.Customer;
import models.Employee;
import models.UserAccount;

/**
 *
 * @author truon
 */
@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

    private CustomerDAO customerDAO = new CustomerDAO();
    private EmployeeDAO employeeDAO = new EmployeeDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        // Check role from session
        String role = user.getRole();
        if ("customer".equalsIgnoreCase(role)) {
            // Load the Customer (with joined user_account fields)
            Customer customer = customerDAO.getCustomerByUserId(user.getUserId());
            if (customer != null) {
                request.setAttribute("customerProfile", customer);
                request.setAttribute("isCustomer", true);
            } else {
                request.setAttribute("customerNotFound", true);
            }

        } else if ("employee".equalsIgnoreCase(role)) {
            // Load the Employee
            Employee emp = employeeDAO.getEmployeeByUserId(user.getUserId());
            if (emp != null) {
                request.setAttribute("employeeProfile", emp);
                request.setAttribute("isEmployee", true);
            } else {
                request.setAttribute("employeeNotFound", true);
            }

        } else if ("admin".equalsIgnoreCase(role)) {
            // Admin might have no direct row in employees or customers,
            // so you can handle them differently if you want.
            request.setAttribute("isAdmin", true);
        }

        request.getRequestDispatcher("profile.jsp").forward(request, response);
    }

    /**
     * doPost -> Only customers can update [customers], employees cannot update
     * themselves.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        UserAccount user = (UserAccount) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        if ("customer".equalsIgnoreCase(user.getRole())) {
            // Load the existing row
            Customer existingCustomer = customerDAO.getCustomerByUserId(user.getUserId());
            if (existingCustomer == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Customer not found in DB.");
                return;
            }

            // Gather form inputs
            String newName = request.getParameter("name");
            String newPhone = request.getParameter("phone");
            String newAddress = request.getParameter("address");
            // We do NOT update email, role, or status here, because those belong to user_account

            // Update
            existingCustomer.setName(newName);
            existingCustomer.setPhoneNumber(newPhone);
            existingCustomer.setAddress(newAddress);

            boolean updated = customerDAO.updateCustomer(existingCustomer);
            if (!updated) {
                response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Failed to update customer profile.");
                return;
            }
            // Refresh
            response.sendRedirect("profile");

        } else {
            // Employees or Admin can't update themselves here, or use a different logic
            response.sendError(HttpServletResponse.SC_FORBIDDEN, "Only customers can update their profile.");
        }
    }
}
