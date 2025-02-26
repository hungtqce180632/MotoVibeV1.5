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

    public boolean createOrder(Order order) {
        String sql = "INSERT INTO [dbo].[Orders] "
                + "([customer_id], [employee_id], [motor_id], [payment_method], [total_amount], "
                + "[deposit_status], [order_status], [date_start], [date_end], [has_warranty], [warranty_id]) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

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
            preparedStatement.setString(7, order.getOrderStatus());
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
                    order.setOrderId(orderId);
                    return true;
                }
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
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
}
