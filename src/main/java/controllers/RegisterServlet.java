package controllers;

import dao.CustomerDAO;
import dao.EmployeeDAO;
import dao.UserAccountDAO;
import models.UserAccount;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import models.Customer;
import models.Employee;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String emailVerified = request.getParameter("emailVerified");

        // Check if email is verified through OTP
        HttpSession session = request.getSession();
        String verifiedEmail = (String) session.getAttribute("emailSendOTP");
        
        if (!"true".equals(emailVerified) || verifiedEmail == null || !verifiedEmail.equals(email)) {
            request.setAttribute("error", "Email verification failed. Please verify your email first.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Automatically set the role based on the user's context
        String role = "customer"; // Default role set to customer

        if (email == null || password == null || email.isEmpty() || password.isEmpty()) {
            request.setAttribute("error", "Email and password are required.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Check if passwords match
        if (!password.equals(confirmPassword)) {
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Collect customer-specific details if the role is customer
        String name = request.getParameter("name");
        String phoneNumber = request.getParameter("phone_number");
        String address = request.getParameter("address");

        UserAccountDAO userDAO = new UserAccountDAO();

        // Check if email already exists
        if (userDAO.checkEmailExists(email)) {
            request.setAttribute("error", "Email is already registered");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }

        // Create new user account with the automatically assigned role
        UserAccount newUser = new UserAccount();
        newUser.setEmail(email);
        newUser.setPassword(password);
        newUser.setRole(role);  // Set the role automatically
        newUser.setStatus(true); // Assuming the account is active upon registration

        boolean isUserCreated = userDAO.registerUser(newUser);

        if (isUserCreated) {
            // Assign customer/employee roles after registration if needed
            if ("customer".equals(role)) {
                // Create and insert customer details into the database
                CustomerDAO customerDAO = new CustomerDAO();
                Customer customer = new Customer();
                customer.setUserId(newUser.getUserId());
                customer.setName(name);
                customer.setPhoneNumber(phoneNumber);
                customer.setAddress(address);
                boolean isCustomerAdded = customerDAO.insertCustomer(customer); // Add customer to the database
                
                if (isCustomerAdded) {
                    session.setAttribute("customer", customer);
                } else {
                    request.setAttribute("error", "Failed to add customer details.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
            } else if ("employee".equals(role)) {
                EmployeeDAO employeeDAO = new EmployeeDAO();
                Employee employee = new Employee();
                employee.setUserId(newUser.getUserId());
                employee.setName(name); // You may collect more details if necessary
                employee.setPhoneNumber(phoneNumber);
                boolean isEmployeeAdded = employeeDAO.addEmployee(employee); // Add employee to the database
                if (isEmployeeAdded) {
                    session.setAttribute("employee", employee);
                } else {
                    request.setAttribute("error", "Failed to add employee details.");
                    request.getRequestDispatcher("register.jsp").forward(request, response);
                    return;
                }
            }

            // Clean up the verification attributes from session
            session.removeAttribute("emailSendOTP");
            session.removeAttribute("otp");
            
            session.setAttribute("user", newUser);
            session.setAttribute("userRole", role);

            response.sendRedirect("index.jsp"); // Redirect to home page after successful registration
        } else {
            request.setAttribute("error", "Registration failed. Please try again.");
            request.getRequestDispatcher("register.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("register.jsp").forward(request, response);
    }
}