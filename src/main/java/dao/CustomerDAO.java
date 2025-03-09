/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Customer;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author truon
 */
public class CustomerDAO {

    /**
     * Insert a row into customers table only. (user_account is NOT inserted
     * here).
     */
    // Method to insert customer details into the database
    public boolean insertCustomer(Customer customer) {
        String sql = "INSERT INTO customers (user_id, name, phone_number, address) VALUES (?, ?, ?, ?)";
        
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, customer.getUserId());
            ps.setString(2, customer.getName());
            ps.setString(3, customer.getPhoneNumber());
            ps.setString(4, customer.getAddress());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;  // Return true if insertion was successful
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;  // Return false if insertion failed
    }

    /**
     * Join customers + user_account so we can get email, role, status.
     */
    public Customer getCustomerByUserId(int userId) {
        // We join user_account to get email, role, status from user_account
        String sql = "SELECT c.customer_id, c.user_id, c.name, c.phone_number, c.address, "
                + "       u.email AS user_email, u.role AS user_role, u.status AS user_status "
                + "FROM [dbo].[customers] c "
                + "JOIN [dbo].[user_account] u ON c.user_id = u.user_id "
                + "WHERE c.user_id = ?";

        try ( Connection connection = DBContext.getConnection();  PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapCustomerJoined(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // not found
    }

    /**
     * Update only the [customers] columns. (Does NOT update user_account.)
     */
    public boolean updateCustomer(Customer c) {
        String sql = "UPDATE [dbo].[customers] "
                + "SET name = ?, phone_number = ?, address = ? "
                + "WHERE customer_id = ?";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, c.getName());
            ps.setString(2, c.getPhoneNumber());
            ps.setString(3, c.getAddress());
            ps.setInt(4, c.getCustomerId());

            int rows = ps.executeUpdate();
            return rows > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Helper to map a row with joined columns from user_account.
     */
    private Customer mapCustomerJoined(ResultSet rs) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(rs.getInt("customer_id"));
        customer.setUserId(rs.getInt("user_id"));
        customer.setName(rs.getString("name"));
        customer.setPhoneNumber(rs.getString("phone_number"));
        customer.setAddress(rs.getString("address"));

        // from user_account
        customer.setEmail(rs.getString("user_email"));
        customer.setRole(rs.getString("user_role"));
        customer.setStatus(rs.getBoolean("user_status"));

        return customer;
    }

    public int getCustomerIdByUserId(int userId) {
        String sql = "SELECT customer_id FROM customers WHERE user_id = ?";
        int customerId = -1;

        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, userId);

            try ( ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    customerId = resultSet.getInt("customer_id");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customerId;
    }

    public List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        String sql = "SELECT * FROM customers";

        try (Connection connection = DBContext.getConnection();
             PreparedStatement ps = connection.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Customer customer = new Customer();
                customer.setCustomerId(rs.getInt("customer_id"));
                customer.setUserId(rs.getInt("user_id"));
                customer.setName(rs.getString("name"));
                customer.setPhoneNumber(rs.getString("phone_number"));
                customer.setAddress(rs.getString("address"));
                customers.add(customer);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
}
