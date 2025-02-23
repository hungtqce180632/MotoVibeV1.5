/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Order;
import models.Motor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import utils.DBContext;
import models.Warranty;


/**
 *
 * @author truon
 */
public class OrderDAO {

    public boolean createOrder(Order order) {
        String sql = "INSERT INTO orders (customer_id, employee_id, motor_id, create_date, payment_method, total_amount, deposit_status, order_status, date_start, date_end, has_warranty, warranty_id) VALUES (?, ?, ?, GETDATE(), ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBContext.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, order.getCustomerId());
            if (order.getEmployeeId() != null) {
                preparedStatement.setInt(2, order.getEmployeeId());
            } else {
                preparedStatement.setNull(2, java.sql.Types.INTEGER);
            }
            preparedStatement.setInt(3, order.getMotorId());
            preparedStatement.setString(4, order.getPaymentMethod());
            preparedStatement.setDouble(5, order.getTotalAmount());
            preparedStatement.setBoolean(6, order.isDepositStatus());
            preparedStatement.setBoolean(7, order.isOrderStatus());
            preparedStatement.setDate(8, order.getDateStart());
            preparedStatement.setDate(9, order.getDateEnd());
            preparedStatement.setBoolean(10, order.isHasWarranty());
            if (order.getWarrantyId() != null) {
                preparedStatement.setInt(11, order.getWarrantyId());
            } else {
                preparedStatement.setNull(11, java.sql.Types.INTEGER);
            }

            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int orderId = generatedKeys.getInt(1);
                    order.setOrderId(orderId); // Set generated ID back to object
                    return true; // Order created successfully
                }
            }
            return false; // Order creation failed
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Order creation failed due to exception
        }
    }

    public Order getOrderById(int orderId) {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (Connection connection = DBContext.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
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

    // ... Add methods to get orders by customer, etc., if needed ...
    private Order mapOrder(ResultSet resultSet) throws SQLException {
        Order order = new Order();
        order.setOrderId(resultSet.getInt("order_id"));
        order.setCustomerId(resultSet.getInt("customer_id"));
        int employeeId = resultSet.getInt("employee_id");
        if (!resultSet.wasNull()) { // Check if employee_id was NULL in DB
            order.setEmployeeId(employeeId);
        }
        order.setMotorId(resultSet.getInt("motor_id"));
        order.setCreateDate(resultSet.getTimestamp("create_date")); // Use Timestamp for DateTime
        order.setPaymentMethod(resultSet.getString("payment_method"));
        order.setTotalAmount(resultSet.getDouble("total_amount"));
        order.setDepositStatus(resultSet.getBoolean("deposit_status"));
        order.setOrderStatus(resultSet.getBoolean("order_status"));
        order.setDateStart(resultSet.getDate("date_start"));
        order.setDateEnd(resultSet.getDate("date_end"));
        order.setHasWarranty(resultSet.getBoolean("has_warranty"));
        int warrantyId = resultSet.getInt("warranty_id");
        if (!resultSet.wasNull()) { // Check if warranty_id was NULL in DB
            order.setWarrantyId(warrantyId);
        }
        return order;
    }

    public Order getOrderWithWarranty(int orderId) {
        Order order = getOrderById(orderId); // Get basic order info first
        if (order == null) {
            return null;
        }

        Warranty warranty = getWarrantyByOrderId(orderId); // Fetch warranty if exists

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
                return mapWarranty(resultSet); // You'll need to create mapWarranty method or reuse if WarrantyDAO exists
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    private Warranty mapWarranty(ResultSet resultSet) throws SQLException { //Implement or reuse from WarrantyDAO if needed
        Warranty warranty = new Warranty();
        warranty.setWarrantyId(resultSet.getInt("warranty_id"));
        warranty.setOrderId(resultSet.getInt("order_id"));
        warranty.setWarrantyDetails(resultSet.getString("warranty_details"));
        warranty.setWarrantyExpiry(resultSet.getDate("warranty_expiry"));
        return warranty;
    }
}