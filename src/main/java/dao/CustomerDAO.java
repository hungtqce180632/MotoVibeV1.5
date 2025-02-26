/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Customer;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBContext;

/**
 *
 * @author truon
 */
public class CustomerDAO {

    public boolean insertCustomer(Customer customer) {
        String sql = "INSERT INTO [dbo].[customers] " +
                     "([user_id], [name], [email], [phone_number], [cus_id_number], [address], [status], [picture], [preferred_contact_method]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            if (customer.getUserId() != null) {
                preparedStatement.setInt(1, customer.getUserId());
            } else {
                preparedStatement.setNull(1, java.sql.Types.INTEGER); // Allow null user_id
            }
            preparedStatement.setString(2, customer.getName());
            preparedStatement.setString(3, customer.getEmail());
            preparedStatement.setString(4, customer.getPhoneNumber());
            preparedStatement.setString(5, customer.getCusIdNumber());
            preparedStatement.setString(6, customer.getAddress());
            preparedStatement.setBoolean(7, customer.isStatus());
            preparedStatement.setString(8, customer.getPicture());
            preparedStatement.setString(9, customer.getPreferredContactMethod());

            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int customerId = generatedKeys.getInt(1);
                    customer.setCustomerId(customerId); // Set auto-generated ID back to Customer object
                    return true; // Customer inserted successfully
                }
            }
            return false; // Insertion failed
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Exception during insertion
        }
    }

    public Customer getCustomerByEmail(String email) {
        String sql = "SELECT * FROM [dbo].[customers] WHERE email = ?";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setString(1, email);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapCustomer(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Customer not found or exception
    }

    private Customer mapCustomer(ResultSet resultSet) throws SQLException {
        Customer customer = new Customer();
        customer.setCustomerId(resultSet.getInt("customer_id"));
        int userId = resultSet.getInt("user_id");
        if (!resultSet.wasNull()) { // Check for NULL user_id in DB
            customer.setUserId(userId);
        }
        customer.setName(resultSet.getString("name"));
        customer.setEmail(resultSet.getString("email"));
        customer.setPhoneNumber(resultSet.getString("phone_number"));
        customer.setCusIdNumber(resultSet.getString("cus_id_number"));
        customer.setAddress(resultSet.getString("address"));
        customer.setStatus(resultSet.getBoolean("status"));
        customer.setPicture(resultSet.getString("picture"));
        customer.setPreferredContactMethod(resultSet.getString("preferred_contact_method"));
        return customer;
    }
    
    public Customer getCustomerByUserId(int userId) {
        String sql = "SELECT * FROM [dbo].[customers] WHERE user_id = ?";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapCustomer(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // Customer not found or exception
    }
    
    
    public int getCustomerIdByUserId(int userId) {
        String sql = "SELECT customer_id FROM customers WHERE user_id = ?";  // Assuming 'user_id' in 'customers' table
        int customerId = -1; // Default value if no match is found

        try (Connection connection = DBContext.getConnection(); 
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, userId);  // Set userId parameter in the query
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    customerId = resultSet.getInt("customer_id");  // Retrieve customer_id from the result set
                }
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Handle potential SQL errors
        }

        return customerId; // Return the customerId (or -1 if not found)
    }
}
