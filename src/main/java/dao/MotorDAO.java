/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Motor;
import utils.DBContext;

/**
 *
 * @author tiend
 */
public class MotorDAO {

    public List<Motor> getAllMotors() throws SQLException {
        List<Motor> motors = new ArrayList<>();
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "SELECT * FROM motors";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                motors.add(new Motor(
                        rs.getInt("motor_id"), rs.getInt("brand_id"), rs.getInt("model_id"), rs.getString("motor_name"),
                        rs.getString("date_start"), rs.getString("color"), rs.getDouble("price"), rs.getInt("fuel_id"),
                        rs.getBoolean("present"), rs.getString("description"), rs.getInt("quantity"), rs.getString("picture")
                ));
            }
        }
        return motors;
    }

    public Motor getMotorById(int motorId) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "SELECT * FROM motors WHERE motor_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, motorId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Motor(
                            rs.getInt("motor_id"), rs.getInt("brand_id"), rs.getInt("model_id"), rs.getString("motor_name"),
                            rs.getString("date_start"), rs.getString("color"), rs.getDouble("price"), rs.getInt("fuel_id"),
                            rs.getBoolean("present"), rs.getString("description"), rs.getInt("quantity"), rs.getString("picture")
                    );
                }
            }
        }
        return null;
    }

    public void addMotor(Motor motor) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "INSERT INTO motors (brand_id, model_id, motor_name, date_start, color, price, fuel_id, present, description, quantity, picture) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, motor.getBrandId());
            pstmt.setInt(2, motor.getModelId());
            pstmt.setString(3, motor.getMotorName());
            pstmt.setString(4, motor.getDateStart());
            pstmt.setString(5, motor.getColor());
            pstmt.setDouble(6, motor.getPrice());
            pstmt.setInt(7, motor.getFuelId());
            pstmt.setBoolean(8, motor.isPresent());
            pstmt.setString(9, motor.getDescription());
            pstmt.setInt(10, motor.getQuantity());
            pstmt.setString(11, motor.getPicture());
            pstmt.executeUpdate();
        }
    }

    public void updateMotor(Motor motor) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "UPDATE motors SET brand_id = ?, model_id = ?, motor_name = ?, date_start = ?, color = ?, price = ?, fuel_id = ?, present = ?, description = ?, quantity = ?, picture = ? WHERE motor_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, motor.getBrandId());
            pstmt.setInt(2, motor.getModelId());
            pstmt.setString(3, motor.getMotorName());
            pstmt.setString(4, motor.getDateStart());
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
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "DELETE FROM motors WHERE motor_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, motorId);
            pstmt.executeUpdate();
        }
    }
}
