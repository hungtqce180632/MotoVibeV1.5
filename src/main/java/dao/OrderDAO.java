/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Order;
import models.Warranty;
import models.Motor;
import models.Customer;
import models.UserAccount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import utils.DBContext;

import jakarta.mail.Message;
import jakarta.mail.MessagingException;
import jakarta.mail.PasswordAuthentication;
import jakarta.mail.Session;
import jakarta.mail.Transport;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;

/**
 *
 * @author truon
 */
public class OrderDAO {

    public int getEmployeeWithFewestOrders() {
        String sql = "SELECT TOP 1 e.employee_id, COUNT(o.order_id) as order_count "
                + "FROM employees e "
                + "LEFT JOIN orders o ON e.employee_id = o.employee_id "
                + "GROUP BY e.employee_id "
                + "ORDER BY order_count ASC";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("employee_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1; // Default to first employee if error occurs
    }

    public boolean createOrder(Order order) {
        // Generate a unique order code if one isn't provided
        if (order.getOrderCode() == null || order.getOrderCode().isEmpty()) {
            order.setOrderCode(generateUniqueOrderCode());
        }
        
        // Set the current timestamp before inserting into database
        order.setCreateDate(new Timestamp(System.currentTimeMillis()));
        
        String sql = "INSERT INTO Orders (customer_id, employee_id, motor_id, create_date, "
                + "payment_method, total_amount, deposit_status, order_status, "
                + "date_start, date_end, has_warranty, order_code) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, "
                + "GETDATE(), DATEADD(day, 2, GETDATE()), ?, ?)";

        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            // Assign employee with fewest orders
            int employeeId = getEmployeeWithFewestOrders();

            ps.setInt(1, order.getCustomerId());
            ps.setInt(2, employeeId);
            ps.setInt(3, order.getMotorId());
            ps.setTimestamp(4, order.getCreateDate()); // Use the timestamp we set
            ps.setString(5, order.getPaymentMethod());
            ps.setDouble(6, order.getTotalAmount());
            ps.setBoolean(7, false); // Deposit status false by default
            ps.setString(8, "Pending");
            ps.setBoolean(9, order.isHasWarranty());
            ps.setString(10, order.getOrderCode()); // Add order code to the insert

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int orderId = rs.getInt(1);
                        order.setOrderId(orderId);
                        
                        // If warranty is included, create it automatically
                        if (order.isHasWarranty()) {
                            createWarrantyForOrder(orderId);
                        }
                        
                        // Send email confirmation
                        sendOrderConfirmationEmail(order);
                        
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Generate a unique order code with format "MV-XXXXX"
    private String generateUniqueOrderCode() {
        String prefix = "MV-";
        String sql = "SELECT TOP 1 order_code FROM orders WHERE order_code LIKE ? ORDER BY order_id DESC";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setString(1, prefix + "%");
            try (ResultSet rs = ps.executeQuery()) {
                int lastNumber = 1000; // Start from 1000 if no previous orders
                
                if (rs.next()) {
                    String lastCode = rs.getString("order_code");
                    if (lastCode != null && lastCode.startsWith(prefix)) {
                        try {
                            lastNumber = Integer.parseInt(lastCode.substring(prefix.length())) + 1;
                        } catch (NumberFormatException e) {
                            // If parsing fails, use current timestamp
                            lastNumber = (int)(System.currentTimeMillis() % 100000);
                        }
                    }
                }
                return prefix + lastNumber;
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Fallback to timestamp if database query fails
            return prefix + (int)(System.currentTimeMillis() % 100000);
        }
    }

    // New method to automatically create warranty when an order with warranty is created
    private void createWarrantyForOrder(int orderId) {
        String sql = "INSERT INTO warranty (order_id, warranty_details, warranty_expiry) VALUES (?, ?, DATEADD(YEAR, 2, GETDATE()))";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            ps.setInt(1, orderId);
            ps.setString(2, "Standard 2-year manufacturer warranty covering parts and service.");
            
            int affectedRows = ps.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        int warrantyId = rs.getInt(1);
                        // Update the order with the warranty ID
                        updateOrderWithWarrantyId(orderId, warrantyId);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // New method to update order with warranty ID
    private void updateOrderWithWarrantyId(int orderId, int warrantyId) {
        String sql = "UPDATE orders SET warranty_id = ? WHERE order_id = ?";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, warrantyId);
            ps.setInt(2, orderId);
            
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM [dbo].[Orders] WHERE order_id = ?";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapOrder(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setCustomerId(rs.getInt("customer_id"));

        int empId = rs.getInt("employee_id");
        if (!rs.wasNull()) {
            order.setEmployeeId(empId);
        }

        order.setMotorId(rs.getInt("motor_id"));
        order.setCreateDate(rs.getTimestamp("create_date"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setDepositStatus(rs.getBoolean("deposit_status"));
        order.setOrderStatus(rs.getString("order_status"));
        order.setDateStart(rs.getDate("date_start"));
        order.setDateEnd(rs.getDate("date_end"));
        order.setHasWarranty(rs.getBoolean("has_warranty"));

        int warrantyId = rs.getInt("warranty_id");
        if (!rs.wasNull()) {
            order.setWarrantyId(warrantyId);
        }
        
        // Get the order code if available
        try {
            String orderCode = rs.getString("order_code");
            if (orderCode != null) {
                order.setOrderCode(orderCode);
            }
        } catch (SQLException e) {
            // Column might not exist in older records, handle gracefully
            order.setOrderCode("MV-" + order.getOrderId());
        }

        return order;
    }

    public Order getOrderWithWarranty(int orderId) {
        Order order = getOrderById(orderId);
        if (order == null) {
            return null;
        }
        Warranty warranty = getWarrantyByOrderId(orderId);
        order.setWarranty(warranty);
        return order;
    }

    public Warranty getWarrantyByOrderId(int orderId) {
        String sql = "SELECT * FROM warranty WHERE order_id = ?";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, orderId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapWarranty(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Warranty mapWarranty(ResultSet resultSet) throws SQLException {
        Warranty warranty = new Warranty();
        warranty.setWarrantyId(resultSet.getInt("warranty_id"));
        warranty.setOrderId(resultSet.getInt("order_id"));
        warranty.setWarrantyDetails(resultSet.getString("warranty_details"));
        warranty.setWarrantyExpiry(resultSet.getDate("warranty_expiry"));
        return warranty;
    }

    /**
     * Check if a customer has purchased (Completed) a given motor.
     */
    public boolean hasPurchasedMotor(int customerId, int motorId) {
        String sql = "SELECT COUNT(*) FROM orders WHERE customer_id = ? AND motor_id = ? AND order_status = 'Completed'";
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, customerId);
            ps.setInt(2, motorId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Order> getAllOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Orders]";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Order order = mapOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public List<Order> getOrdersByCustomerId(int customerId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM [dbo].[Orders] WHERE customer_id = ?";

        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Order order = mapOrder(rs);
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }

    public boolean confirmDeposit(String orderId) {
        boolean isUpdated = false;
        String sql = "UPDATE orders SET deposit_status = ?, order_status = ? WHERE order_id = ?";

        // Database connection initialization
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set parameters for the query
            stmt.setBoolean(1, true); // Set deposit_status to true
            stmt.setString(2, "Processing"); // Set order_status to "Processing"
            stmt.setString(3, orderId); // Bind the order_id to the query

            // Execute the update
            int rowsUpdated = stmt.executeUpdate();

            // If at least one row is updated, return true
            if (rowsUpdated > 0) {
                isUpdated = true;
                
                // Get the order and send email notification
                Order order = getOrderById(Integer.parseInt(orderId));
                if (order != null) {
                    sendDepositConfirmationEmail(order);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception (you can add a logger in real applications)
        }
        return isUpdated;
    }

    public boolean confirmOrderStatus(String orderId) {
        boolean isUpdated = false;
        String sql = "UPDATE orders SET order_status = ? WHERE order_id = ?";

        // Database connection initialization
        try (Connection conn = DBContext.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "Completed"); // Set order_status to "Completed"
            stmt.setString(2, orderId); // Bind the order_id to the query

            // Execute the update
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                isUpdated = true;
                
                // Get the order and send email notification
                Order order = getOrderById(Integer.parseInt(orderId));
                if (order != null) {
                    sendOrderDeliveryConfirmationEmail(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
        }
        return isUpdated;
    }
    
    private void sendOrderConfirmationEmail(Order order) {
        // Get customer email
        CustomerDAO customerDAO = new CustomerDAO();
        UserAccountDAO userAccountDAO = new UserAccountDAO();
        
        try {
            // Get customer from database
            Customer customer = customerDAO.getCustomerById(order.getCustomerId());
            if (customer == null) return;
            
            // Get user account to access email
            UserAccount userAccount = userAccountDAO.getUserById(customer.getUserId());
            if (userAccount == null) return;
            
            // Get the motor details
            MotorDAO motorDAO = new MotorDAO();
            Motor motor = motorDAO.getMotorById(order.getMotorId());
            if (motor == null) return;
            
            // Email details
            String toEmail = userAccount.getEmail();
            String subject = "MotoVibe Order Confirmation - " + order.getOrderCode();
            
            // Build email body
            StringBuilder msgBuilder = new StringBuilder();
            msgBuilder.append("Dear ").append(customer.getName()).append(",\n\n");
            msgBuilder.append("Thank you for your order with MotoVibe. Your order has been received and is being processed.\n\n");
            msgBuilder.append("Order Details:\n");
            msgBuilder.append("Order Code: ").append(order.getOrderCode()).append("\n");
            msgBuilder.append("Order ID: ").append(order.getOrderId()).append("\n");
            
            // Format the date properly, handling null case
            if (order.getCreateDate() != null) {
                msgBuilder.append("Date: ").append(order.getCreateDate().toString()).append("\n\n");
            } else {
                msgBuilder.append("Date: ").append(new java.util.Date().toString()).append("\n\n");
            }
            
            msgBuilder.append("Product: ").append(motor.getMotorName()).append("\n");
            msgBuilder.append("Price: $").append(String.format("%.2f", order.getTotalAmount())).append("\n");
            msgBuilder.append("Payment Method: ").append(order.getPaymentMethod()).append("\n\n");
            
            if (order.isHasWarranty()) {
                msgBuilder.append("Your purchase includes our Premium Protection Plan warranty.\n\n");
            }
            
            msgBuilder.append("Order Status: ").append(order.getOrderStatus()).append("\n\n");
            
            msgBuilder.append("For any questions, please contact our customer service at support@motovibe.com.\n\n");
            msgBuilder.append("Thank you for choosing MotoVibe!\n\n");
            msgBuilder.append("Best regards,\nThe MotoVibe Team");
            
            // Send the email
            sendEmail(toEmail, subject, msgBuilder.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void sendDepositConfirmationEmail(Order order) {
        // Get customer email
        CustomerDAO customerDAO = new CustomerDAO();
        UserAccountDAO userAccountDAO = new UserAccountDAO();
        
        try {
            // Get customer from database
            Customer customer = customerDAO.getCustomerById(order.getCustomerId());
            if (customer == null) return;
            
            // Get user account to access email
            UserAccount userAccount = userAccountDAO.getUserById(customer.getUserId());
            if (userAccount == null) return;
            
            // Get the motor details
            MotorDAO motorDAO = new MotorDAO();
            Motor motor = motorDAO.getMotorById(order.getMotorId());
            if (motor == null) return;
            
            // Email details
            String toEmail = userAccount.getEmail();
            String subject = "MotoVibe Deposit Confirmation - " + order.getOrderCode();
            
            // Build email body
            StringBuilder msgBuilder = new StringBuilder();
            msgBuilder.append("Dear ").append(customer.getName()).append(",\n\n");
            msgBuilder.append("Great news! Your deposit for order #").append(order.getOrderCode()).append(" has been confirmed.\n\n");
            msgBuilder.append("Order Details:\n");
            msgBuilder.append("Order Code: ").append(order.getOrderCode()).append("\n");
            msgBuilder.append("Order ID: ").append(order.getOrderId()).append("\n");
            msgBuilder.append("Date: ").append(new java.util.Date().toString()).append("\n\n");
            
            msgBuilder.append("Product: ").append(motor.getMotorName()).append("\n");
            msgBuilder.append("Price: $").append(String.format("%.2f", order.getTotalAmount())).append("\n");
            msgBuilder.append("Payment Method: ").append(order.getPaymentMethod()).append("\n\n");
            
            msgBuilder.append("Your order status has been updated to: Processing\n\n");
            
            msgBuilder.append("Next Steps:\n");
            msgBuilder.append("1. Our team will prepare your motorcycle for delivery\n");
            msgBuilder.append("2. You will receive another email when your order is ready for pickup/delivery\n\n");
            
            msgBuilder.append("For any questions, please contact our customer service at support@motovibe.com.\n\n");
            msgBuilder.append("Thank you for choosing MotoVibe!\n\n");
            msgBuilder.append("Best regards,\nThe MotoVibe Team");
            
            // Send the email
            sendEmail(toEmail, subject, msgBuilder.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    private void sendOrderDeliveryConfirmationEmail(Order order) {
        // Get customer email
        CustomerDAO customerDAO = new CustomerDAO();
        UserAccountDAO userAccountDAO = new UserAccountDAO();
        
        try {
            // Get customer from database
            Customer customer = customerDAO.getCustomerById(order.getCustomerId());
            if (customer == null) return;
            
            // Get user account to access email
            UserAccount userAccount = userAccountDAO.getUserById(customer.getUserId());
            if (userAccount == null) return;
            
            // Get the motor details
            MotorDAO motorDAO = new MotorDAO();
            Motor motor = motorDAO.getMotorById(order.getMotorId());
            if (motor == null) return;
            
            // Email details
            String toEmail = userAccount.getEmail();
            String subject = "MotoVibe Order Completed - " + order.getOrderCode();
            
            // Build email body
            StringBuilder msgBuilder = new StringBuilder();
            msgBuilder.append("Dear ").append(customer.getName()).append(",\n\n");
            msgBuilder.append("Congratulations! Your order #").append(order.getOrderCode()).append(" has been completed and marked as delivered.\n\n");
            msgBuilder.append("Order Details:\n");
            msgBuilder.append("Order Code: ").append(order.getOrderCode()).append("\n");
            msgBuilder.append("Order ID: ").append(order.getOrderId()).append("\n");
            msgBuilder.append("Completion Date: ").append(new java.util.Date().toString()).append("\n\n");
            
            msgBuilder.append("Product: ").append(motor.getMotorName()).append("\n");
            msgBuilder.append("Price: $").append(String.format("%.2f", order.getTotalAmount())).append("\n");
            
            if (order.isHasWarranty()) {
                msgBuilder.append("\nYour purchase includes our Premium Protection Plan warranty. ");
                msgBuilder.append("You can view the warranty details in your account.\n\n");
            }
            
            msgBuilder.append("We hope you enjoy your new motorcycle! If you have any feedback or questions about your purchase, ");
            msgBuilder.append("please don't hesitate to contact us.\n\n");
            
            msgBuilder.append("For any questions, please contact our customer service at support@motovibe.com.\n\n");
            msgBuilder.append("Thank you for choosing MotoVibe!\n\n");
            msgBuilder.append("Best regards,\nThe MotoVibe Team");
            
            // Send the email
            sendEmail(toEmail, subject, msgBuilder.toString());
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void sendEmail(String toEmail, String subject, String messageBody) {
        // Email configuration from SendOtpServlet
        final String fromEmail = "motovibe132@gmail.com";
        final String password = "hcgl qqmf orzz nlcz";

        // Gmail SMTP properties
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true"); 
        props.put("mail.smtp.starttls.enable", "true"); 
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.port", "587");

        // Create mail session with credentials
        Session session = Session.getInstance(props, new jakarta.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(fromEmail, password);
            }
        });

        try {
            // Build the message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toEmail)
            );
            message.setSubject(subject);
            message.setText(messageBody);

            // Send
            Transport.send(message);
        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
