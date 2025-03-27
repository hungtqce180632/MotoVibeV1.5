package controllers;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import dao.CustomerDAO;
import dao.MotorDAO;
import dao.OrderDAO;
import dao.UserAccountDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Customer;
import models.Motor;
import models.Order;
import models.UserAccount;

/**
 * Servlet for handling orders for new customers who don't have accounts yet.
 * Creates both customer account and order in one process.
 *
 * @author ACER
 */
@WebServlet(name = "OrderNewCustomerServlet", urlPatterns = {"/orderNewCustomer"})
public class OrderNewCustomerServlet extends HttpServlet {

    private static final Logger LOGGER = Logger.getLogger(OrderNewCustomerServlet.class.getName());

    /**
     * Handles the HTTP GET request - displays form for creating a new customer
     * order
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();
            UserAccount user = (UserAccount) session.getAttribute("user");

            // Check if logged in user is an employee
            if (user == null || !"employee".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect("login.jsp");
                return;
            }

            String motorIdParam = request.getParameter("motorId");
            if (motorIdParam != null) {
                int motorId = Integer.parseInt(motorIdParam);
                MotorDAO motorDAO = new MotorDAO();
                Motor motor = motorDAO.getMotorById(motorId);
                if (motor != null) {
                    request.setAttribute("motor", motor);
                }
            }

            // Get all motors to populate the dropdown
            MotorDAO motorDAO = new MotorDAO();
            List<Motor> motors = motorDAO.getAllMotors();
            request.setAttribute("motors", motors);

            // Forward to the JSP page
            request.getRequestDispatcher("order_new_customer.jsp").forward(request, response);
        } catch (SQLException ex) {
            LOGGER.log(Level.SEVERE, "Error fetching motors", ex);
            request.getSession().setAttribute("errorMessage", "Error loading the form: " + ex.getMessage());
            response.sendRedirect("adminOrders");
        }
    }

    /**
     * Handles the HTTP POST request - processes the form submission
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserAccount employee = (UserAccount) session.getAttribute("user");

        // Check if logged in user is an employee
        if (employee == null || !"employee".equalsIgnoreCase(employee.getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get new customer details from form
            String fullName = request.getParameter("fullName");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String address = request.getParameter("address");

            // Get order details from form
            int motorId = Integer.parseInt(request.getParameter("motorId"));
            String paymentMethod = request.getParameter("paymentMethod");
            
            // Get warranty selection - must check for "true" string value from radio button
            boolean hasWarranty = "true".equals(request.getParameter("hasWarranty"));
            
            // Get deposit status
            boolean depositStatus = (request.getParameter("depositStatus") != null);

            // Enhanced validation
            if (fullName == null || fullName.trim().isEmpty()
                    || email == null || email.trim().isEmpty()
                    || phone == null || phone.trim().isEmpty()) {
                session.setAttribute("errorMessage", "All customer fields marked with * are required");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Phone number validation - must be exactly 10 digits
            if (!phone.matches("\\d{10}")) {
                session.setAttribute("errorMessage", "Phone number must be exactly 10 digits");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Validate order data
            if (motorId <= 0 || paymentMethod == null || paymentMethod.trim().isEmpty()) {
                session.setAttribute("errorMessage", "All order fields are required");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Check if motor exists and is in stock
            MotorDAO motorDAO = new MotorDAO();
            Motor motor = motorDAO.getMotorById(motorId);
            if (motor == null) {
                session.setAttribute("errorMessage", "Selected motor does not exist");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            if (motor.getQuantity() <= 0) {
                session.setAttribute("errorMessage", "Selected motor is out of stock");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Check if email already exists in the system
            UserAccountDAO userAccountDAO = new UserAccountDAO();
            if (userAccountDAO.checkEmailExists(email)) {
                session.setAttribute("errorMessage", "Email already exists. Please use a different email or create an order for an existing customer.");
                response.sendRedirect("orderNewCustomer");
                return;
            }

            // Step 1: Create user account with password "123"
            UserAccount newUserAccount = new UserAccount();
            newUserAccount.setEmail(email);
            newUserAccount.setPassword("123"); // Default password
            newUserAccount.setRole("customer");
            newUserAccount.setStatus(true);

            boolean userCreated = userAccountDAO.registerUser(newUserAccount);

            if (!userCreated || newUserAccount.getUserId() <= 0) {
                session.setAttribute("errorMessage", "Failed to create user account");
                response.sendRedirect("orderNewCustomer");
                return;
            }
            
            // Log the created user ID for debugging
            LOGGER.log(Level.INFO, "Created user account with ID: " + newUserAccount.getUserId());

            // Step 2: Create customer record
            Customer newCustomer = new Customer();
            newCustomer.setUserId(newUserAccount.getUserId());  // Use the newly created user ID
            newCustomer.setName(fullName);
            newCustomer.setPhoneNumber(phone);
            newCustomer.setAddress(address);

            CustomerDAO customerDAO = new CustomerDAO();
            boolean customerCreated = customerDAO.insertCustomer(newCustomer);
            
            if (!customerCreated) {
                session.setAttribute("errorMessage", "Failed to create customer record");
                response.sendRedirect("orderNewCustomer");
                return;
            }
            
            // Get the customer ID
            int customerId = customerDAO.getCustomerIdByUserId(newUserAccount.getUserId());
            
            if (customerId <= 0) {
                session.setAttribute("errorMessage", "Failed to retrieve customer ID");
                response.sendRedirect("orderNewCustomer");
                return;
            }
            
            // Log the customer ID for debugging
            LOGGER.log(Level.INFO, "Created customer with ID: " + customerId);

            // Step 3: Create order
            Order order = new Order();
            order.setCustomerId(customerId); // Use the actual customer ID
            order.setMotorId(motorId);
            order.setEmployeeId(employee.getUserId());
            order.setPaymentMethod(paymentMethod);
            
            // Calculate total amount with warranty if applicable
            double basePrice = motor.getPrice();
            double totalAmount = basePrice;
            
            if (hasWarranty) {
                totalAmount = basePrice * 1.10; // Add 10% warranty fee
                LOGGER.log(Level.INFO, "Adding warranty: Base price=" + basePrice + ", Total=" + totalAmount);
            }
            
            order.setTotalAmount(totalAmount);
            order.setDepositStatus(depositStatus);
            order.setHasWarranty(hasWarranty);
            order.setOrderStatus("Processing"); // Initial status for employee-created orders

            // Generate unique order code
            String orderCode = "MV-" + System.currentTimeMillis() % 100000;
            order.setOrderCode(orderCode);

            // Save order
            OrderDAO orderDAO = new OrderDAO();
            boolean orderCreated = orderDAO.createOrder(order);
            
            if (!orderCreated) {
                session.setAttribute("errorMessage", "Failed to create the order");
                response.sendRedirect("orderNewCustomer");
                return;
            }
            
            // If order is created successfully, decrease the motor quantity
            motorDAO.decreaseMotorQuantity(motorId, 1);
            
            session.setAttribute("successMessage", "Order created successfully. Order code: " + orderCode);
            response.sendRedirect("adminOrders");

        } catch (NumberFormatException e) {
            LOGGER.log(Level.SEVERE, "Invalid number format", e);
            session.setAttribute("errorMessage", "Invalid numeric input: " + e.getMessage());
            response.sendRedirect("orderNewCustomer");
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error creating customer or order", e);
            session.setAttribute("errorMessage", "Error: " + e.getMessage());
            response.sendRedirect("orderNewCustomer");
        }
    }
}
