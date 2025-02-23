/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Motor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import models.Brand;
import models.Fuel;
import models.Model;
import utils.DBContext;
import java.sql.Date;

/**
 *
 * @author tiend - upgrade hưng
 */
public class MotorDAO {

    public List<Motor> getAllMotors() throws SQLException {
        List<Motor> motors = new ArrayList<>();
        String sql = "SELECT motor_id, brand_id, model_id, motor_name, date_start, color, price, fuel_id, present, description, quantity, picture FROM motors"; // Include 'picture' in SELECT

        // Get connection within the try-with-resources block
        try ( Connection connection = DBContext.getConnection();  PreparedStatement pstmt = connection.prepareStatement(sql);  ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Motor motor = new Motor();
                motor.setMotorId(rs.getInt("motor_id"));
                motor.setBrandId(rs.getInt("brand_id"));
                motor.setModelId(rs.getInt("model_id"));
                motor.setMotorName(rs.getString("motor_name"));
                motor.setDateStart(rs.getDate("date_start")); // Corrected to getDate for java.sql.Date
                motor.setColor(rs.getString("color"));
                motor.setPrice(rs.getDouble("price"));
                motor.setFuelId(rs.getInt("fuel_id"));
                motor.setPresent(rs.getBoolean("present"));
                motor.setDescription(rs.getString("description"));
                motor.setQuantity(rs.getInt("quantity"));
                motor.setPicture(rs.getString("picture")); // Retrieve and set picture file path

                motors.add(motor);
            }
        }
        return motors;
    }

    public Motor getMotorById(int motorId) {
        // Corrected table name to "motors" (lowercase)
        String sql = "SELECT m.*, b.brand_name, b.country_of_origin, b.description as brand_description, "
                + "         mod.model_name, f.fuel_name "
                + "FROM motors m " // Changed "Motorbikes" to "motors"
                + "JOIN Brands b ON m.brand_id = b.brand_id "
                + "JOIN Models mod ON m.model_id = mod.model_id "
                + "JOIN Fuels f ON m.fuel_id = f.fuel_id "
                + "WHERE m.motor_id = ?";
        try (Connection connection = DBContext.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) { // Corrected - connection obtained here
            preparedStatement.setInt(1, motorId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapMotor(resultSet); // Use mapMotor here
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean addMotor(Motor motor) throws SQLException {
        String sql = "INSERT INTO motors (brand_id, model_id, motor_name, date_start, color, price, fuel_id, present, description, quantity, picture) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"; // Include 'picture' in INSERT

        // Get connection within the try-with-resources block
        try (Connection connection = DBContext.getConnection(); // Corrected - connection obtained here
             PreparedStatement pstmt = connection.prepareStatement(sql)) {
            pstmt.setInt(1, motor.getBrandId());
            pstmt.setInt(2, motor.getModelId());
            pstmt.setString(3, motor.getMotorName());
            pstmt.setDate(4, motor.getDateStart()); // Corrected to setDate for java.sql.Date
            pstmt.setString(5, motor.getColor());
            pstmt.setDouble(6, motor.getPrice());
            pstmt.setInt(7, motor.getFuelId());
            pstmt.setBoolean(8, motor.isPresent());
            pstmt.setString(9, motor.getDescription());
            pstmt.setInt(10, motor.getQuantity());
            pstmt.setString(11, motor.getPicture()); // Set picture file path parameter

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        }
    }

    public void updateMotor(Motor motor) throws SQLException {
        // Get connection within the try-with-resources block
        try (Connection conn = DBContext.getConnection(); // Corrected - connection obtained here
             // (lowercase)
             PreparedStatement pstmt = conn.prepareStatement("UPDATE motors SET brand_id = ?, model_id = ?, motor_name = ?, date_start = ?, color = ?, price = ?, fuel_id = ?, present = ?, description = ?, quantity = ?, picture = ? WHERE motor_id = ?")) { // Changed "Motorbikes" to "motors"
            pstmt.setInt(1, motor.getBrandId());
            pstmt.setInt(2, motor.getModelId());
            pstmt.setString(3, motor.getMotorName());
            pstmt.setDate(4, motor.getDateStart()); 
            pstmt.setString(5, motor.getColor());
            pstmt.setDouble(6, motor.getPrice());
            pstmt.setInt(7, motor.getFuelId());
            pstmt.setBoolean(8, motor.isPresent());
            pstmt.setString(9, motor.getDescription());
            pstmt.setInt(10, motor.getQuantity());
            pstmt.setString(11, motor.getPicture());
            pstmt.setInt(12, motor.getMotorId());
            pstmt.executeUpdate();
        }
    }

    public void deleteMotor(int motorId) throws SQLException {
        // Get connection within the try-with-resources block
        try (Connection conn = DBContext.getConnection(); // Corrected - connection obtained here
             // (lowercase)
             PreparedStatement pstmt = conn.prepareStatement("DELETE FROM motors WHERE motor_id = ?")) { // Changed "Motorbikes" to "motors"
            pstmt.setInt(1, motorId);
            pstmt.executeUpdate();
        }
    }

    //Hưng Đẹp Trai Thêm vào <3
    public List<Motor> getMotorsByFilters(Integer brandId, Integer fuelId, Integer modelId) {
        List<Motor> motors = new ArrayList<>();
        // (lowercase)
        String sql = "SELECT m.*, b.brand_name, b.country_of_origin, b.description as brand_description, "
                + "         mod.model_name, f.fuel_name "
                + "FROM motors m " // "Motorbikes" to "motors"
                + "JOIN Brands b ON m.brand_id = b.brand_id "
                + "JOIN Models mod ON m.model_id = mod.model_id "
                + "JOIN Fuels f ON m.fuel_id = f.fuel_id "
                + "WHERE 1=1 "; // a true condition to easily using filters

        if (brandId != null) {
            sql += " AND m.brand_id = ? ";
        }
        if (fuelId != null) {
            sql += " AND m.fuel_id = ? ";
        }
        if (modelId != null) {
            sql += " AND m.model_id = ? ";
        }

        try (Connection connection = DBContext.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) { // Corrected - connection obtained here

            int paramIndex = 1; // Parameter index counter
            if (brandId != null) {
                preparedStatement.setInt(paramIndex++, brandId);
            }
            if (fuelId != null) {
                preparedStatement.setInt(paramIndex++, fuelId);
            }
            if (modelId != null) {
                preparedStatement.setInt(paramIndex++, modelId);
            }

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                motors.add(mapMotor(resultSet)); // Use mapMotor here
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return motors;
    }

    //Hưng Thêm
    public List<Motor> searchMotorsByName(String searchTerm) {
        List<Motor> motors = new ArrayList<>();
        // Corrected table name to "motors" (lowercase)
        String sql = "SELECT m.*, b.brand_name, b.country_of_origin, b.description as brand_description, "
                + "         mod.model_name, f.fuel_name "
                + "FROM motors m " // Changed "Motorbikes" to "motors"
                + "JOIN Brands b ON m.brand_id = b.brand_id "
                + "JOIN Models mod ON m.model_id = mod.model_id "
                + "JOIN Fuels f ON m.fuel_id = f.fuel_id "
                + "WHERE m.motor_name LIKE ?";
        try (Connection connection = DBContext.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) { // Corrected - connection obtained here
            preparedStatement.setString(1, "%" + searchTerm + "%");
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                motors.add(mapMotor(resultSet)); // Use mapMotor here
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return motors;
    }

    public boolean decreaseMotorQuantity(int motorId, int quantity) {
        // (lowercase)
        String sql = "UPDATE motors SET quantity = quantity - ? WHERE motor_id = ? AND quantity >= ?"; // Changed "Motorbikes" to "motors"
        try (Connection connection = DBContext.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(sql)) { // Corrected - connection obtained here
            preparedStatement.setInt(1, quantity);
            preparedStatement.setInt(2, motorId);
            preparedStatement.setInt(3, quantity); // Ensure quantity is sufficient to decrease

            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0; // Returns true if quantity decreased successfully
        } catch (SQLException e) {
            e.printStackTrace();
            return false; // Returns false if update failed
        }
    }

    private Motor mapMotor(ResultSet resultSet) throws SQLException {
        Motor motor = new Motor();
        motor.setMotorId(resultSet.getInt("motor_id"));
        motor.setMotorName(resultSet.getString("motor_name"));
        motor.setBrandId(resultSet.getInt("brand_id"));
        motor.setModelId(resultSet.getInt("model_id"));
        motor.setFuelId(resultSet.getInt("fuel_id"));
        motor.setColor(resultSet.getString("color"));
        motor.setPrice(resultSet.getDouble("price"));
        motor.setQuantity(resultSet.getInt("quantity"));
        motor.setDateStart(resultSet.getDate("date_start")); // Corrected to getDate for java.sql.Date
        motor.setPicture(resultSet.getString("picture"));
        motor.setDescription(resultSet.getString("description"));
        motor.setPresent(resultSet.getBoolean("present"));

        //Brand Details from Join
        Brand brand = new Brand();
        brand.setBrandId(resultSet.getInt("brand_id")); //Redundant but explicit
        brand.setBrandName(resultSet.getString("brand_name"));
        brand.setCountryOfOrigin(resultSet.getString("country_of_origin"));
        brand.setDescription(resultSet.getString("brand_description"));
        motor.setBrand(brand); // Now you can use setBrand

        //Model Details from Join
        Model model = new Model();
        model.setModelId(resultSet.getInt("model_id"));//Redundant but explicit
        model.setModelName(resultSet.getString("model_name"));
        motor.setModel(model); // Now you can use setModel

        //Fuel Details from Join
        Fuel fuel = new Fuel();
        fuel.setFuelId(resultSet.getInt("fuel_id"));//Redundant but explicit
        fuel.setFuelName(resultSet.getString("fuel_name"));
        motor.setFuel(fuel); // Now you can use setFuel

        return motor;
    }

}
