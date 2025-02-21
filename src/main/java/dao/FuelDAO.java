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
import models.Fuel;
import utils.DBContext;

/**
 *
 * @author tiend
 */
public class FuelDAO {

    public List<Fuel> getAllFuels() throws SQLException {
        List<Fuel> fuels = new ArrayList<>();
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "SELECT * FROM fuels";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                fuels.add(new Fuel(rs.getInt("fuel_id"), rs.getString("fuel_name")));
            }
        }
        return fuels;
    }

    public Fuel getFuelById(int fuelId) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "SELECT * FROM fuels WHERE fuel_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, fuelId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Fuel(rs.getInt("fuel_id"), rs.getString("fuel_name"));
                }
            }
        }
        return null;
    }

    public void addFuel(Fuel fuel) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "INSERT INTO fuels (fuel_name) VALUES (?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, fuel.getFuelName());
            pstmt.executeUpdate();
        }
    }

    public void updateFuel(Fuel fuel) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "UPDATE fuels SET fuel_name = ? WHERE fuel_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, fuel.getFuelName());
            pstmt.setInt(2, fuel.getFuelId());
            pstmt.executeUpdate();
        }
    }

    public void deleteFuel(int fuelId) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "DELETE FROM fuels WHERE fuel_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, fuelId);
            pstmt.executeUpdate();
        }
    }
}
