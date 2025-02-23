/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controllers;

import dao.CustomerDAO;
import dao.MotorDAO;
import dao.OrderDAO;
import dao.UserAccountDAO; // Import UserAccountDAO
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import models.Customer;
import models.Motor;
import models.Order;
import models.UserAccount;

/**
 *
 * @author truon
 */
@WebServlet("/confirmOrder")
public class ConfirmOrderServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount loggedInUser = (UserAccount) session.getAttribute("user");

        // 1. Retrieve order data from the form
        int motorId = Integer.parseInt(request.getParameter("motorId"));
        String customerName = request.getParameter("customerName");
        String customerEmail = request.getParameter("customerEmail");
        String customerPhone = request.getParameter("customerPhone");
        String customerIdNumber = request.getParameter("customerIdNumber");
        String customerAddress = request.getParameter("customerAddress");

        // 2. Fetch Motor details
        MotorDAO motorDAO = new MotorDAO();
        Motor motor = motorDAO.getMotorById(motorId);

        if (motor == null) {
            response.sendRedirect("motorList?error=motorNotFound");
            return;
        }

        // 3. Basic Validation
        if (customerName == null || customerName.trim().isEmpty() ||
            customerEmail == null || customerEmail.trim().isEmpty() ||
            customerPhone == null || customerPhone.trim().isEmpty() ||
            customerIdNumber == null || customerIdNumber.trim().isEmpty() ||
            customerAddress == null || customerAddress.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please fill in all required fields.");
            request.setAttribute("motor", motor);
            request.getRequestDispatcher("create_order.jsp").forward(request, response);
            return;
        }

        Customer customerToUse = null;

        if (loggedInUser != null && "customer".equals(loggedInUser.getRole())) {
            // 4a. User is logged in as customer: Fetch existing customer profile by user_id
            CustomerDAO customerDAO = new CustomerDAO();
            Customer loggedInCustomerProfile = customerDAO.getCustomerByUserId(loggedInUser.getUserId()); // **Fetch Customer by user_id**

            if (loggedInCustomerProfile != null) {
                customerToUse = loggedInCustomerProfile;
            } else {
                // Logged-in customer has no customer profile? - Highly unusual, possible data inconsistency
                response.sendRedirect("index.jsp?error=noCustomerProfile");
                return;
            }
        } else {
            // 4b. User is NOT logged in as customer (Guest Checkout - if we want to support it, needs different handling)
            // For now, if NOT logged in as customer, redirect back to login/motor list with an error
            response.sendRedirect("index.jsp?error=loginRequiredForOrder"); // Redirect to login or handle guest checkout properly later
            return; // Stop processing for guest checkout for now, as user_id is required.

            // --- OLD GUEST CHECKOUT LOGIC (REMOVED FOR NOW DUE TO user_id NOT NULL CONSTRAINT) ---
            // Customer customer = new Customer();
            // customer.setName(customerName);
            // customer.setEmail(customerEmail);
            // customer.setPhoneNumber(customerPhone);
            // customer.setCusIdNumber(customerIdNumber);
            // customer.setAddress(customerAddress);
            // customer.setStatus(true);
            // // user_id MUST be provided, but for guest, we don't have one. Problem!
            // // For now, guest checkout with required user_id is NOT directly supported in this code.
            //
            // CustomerDAO customerDAO = new CustomerDAO();
            // Customer existingCustomer = customerDAO.getCustomerByEmail(customerEmail);
            // if (existingCustomer != null) {
            //     customerToUse = existingCustomer;
            // } else {
            //     if (customerDAO.insertCustomer(customer)) {
            //         Customer newCustomer = customerDAO.getCustomerByEmail(customerEmail);
            //         if (newCustomer != null) {
            //             customerToUse = newCustomer;
            //         } else {
            //             response.sendRedirect("motorList?error=customerCreationFailed");
            //             return;
            //         }
            //     } else {
            //         response.sendRedirect("motorList?error=customerCreationFailed");
            //         return;
            //     }
            // }
        }

        // 5. Create Order object (using customerToUse - should now always have a valid user_id from existing customer profile)
        Order order = new Order();
        order.setCustomerId(customerToUse.getCustomerId());
        order.setEmployeeId(null); // **Set employee_id to customer's user_id - Review this Logic!** -  Is employee_id really supposed to be customer's user id? This seems likely incorrect based on typical order systems. It should probably be employee who takes the order. For now, keeping as is based on previous code, but needs clarification.
        order.setMotorId(motorId); // Its "order.setEmployeeId(customerToUse.getUserId());" but i think when cus making it online we should not automatic bring employee to this, admin can manage this, Hung will make it for Dac later
        // order.setCreateDate(Timestamp.valueOf(LocalDateTime.now())); // DB default
        order.setPaymentMethod("Pending");
        order.setTotalAmount(motor.getPrice());
        order.setDepositStatus(false);
        order.setOrderStatus("Pending");

        // 6. Insert Order into database
        OrderDAO orderDAO = new OrderDAO();
        if (orderDAO.createOrder(order)) {
            request.getRequestDispatcher("order_confirmation.jsp").forward(request, response);
        } else {
            response.sendRedirect("motorList?error=orderCreationFailed");
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("index.jsp");
    }
}