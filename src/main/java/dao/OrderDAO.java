/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Order;
import models.Warranty;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBContext;

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

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("employee_id");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 1; // Default to first employee if error occurs
    }

    public boolean createOrder(Order order) {
        String sql = "INSERT INTO Orders (customer_id, employee_id, motor_id, create_date, "
                + "payment_method, total_amount, deposit_status, order_status, "
                + "date_start, date_end, has_warranty) "
                + "VALUES (?, ?, ?, GETDATE(), ?, ?, ?, ?, "
                + "GETDATE(), DATEADD(day, 2, GETDATE()), ?)";

        try ( Connection connection = DBContext.getConnection();  PreparedStatement ps = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            // Assign employee with fewest orders
            int employeeId = getEmployeeWithFewestOrders();

            ps.setInt(1, order.getCustomerId());
            ps.setInt(2, employeeId);
            ps.setInt(3, order.getMotorId());
            ps.setString(4, order.getPaymentMethod());
            ps.setDouble(5, order.getTotalAmount());
            ps.setBoolean(6, order.isDepositStatus());
            ps.setString(7, "Pending");
            ps.setBoolean(8, order.isHasWarranty());

            int affectedRows = ps.executeUpdate();

            if (affectedRows > 0) {
                try ( ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        order.setOrderId(rs.getInt(1));
                        return true;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM [dbo].[Orders] WHERE order_id = ?";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

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
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

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
        String sql = "SELECT COUNT(*) AS cnt "
                + "FROM Orders "
                + "WHERE customer_id = ? AND motor_id = ? AND order_status = 'Completed'";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, customerId);
            ps.setInt(2, motorId);

            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt("cnt");
                    return count > 0;
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

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql);  ResultSet rs = ps.executeQuery()) {

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

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customerId);

            try ( ResultSet rs = ps.executeQuery()) {
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
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            // Set parameters for the query
            stmt.setBoolean(1, true); // Set deposit_status to true
            stmt.setString(2, "Processing"); // Set order_status to "Processing"
            stmt.setString(3, orderId); // Bind the order_id to the query

            // Execute the update
            int rowsUpdated = stmt.executeUpdate();

            // If at least one row is updated, return true
            if (rowsUpdated > 0) {
                isUpdated = true;
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
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, "Completed"); // Set order_status to "Completed"
            stmt.setString(2, orderId); // Bind the order_id to the query

            // Execute the update
            int rowsUpdated = stmt.executeUpdate();

            if (rowsUpdated > 0) {
                isUpdated = true;
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Log the exception
        }
        return isUpdated;
    }

}
