package dao;

import models.Motor;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBContext;

public class WishlistDAO {

    // Method to fetch the user's wishlist from the database using customer_id
    public List<Motor> getWishlistForUser(int customerId) {
        List<Motor> wishlist = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            conn = DBContext.getConnection();
            String sql = "SELECT m.motor_id, m.brand_id, m.model_id, m.motor_name, m.color, m.price, m.fuel_id, m.present, m.description, m.quantity, m.picture, m.date_start, "
                    + "b.brand_name, mo.model_name, f.fuel_name "
                    + "FROM wishlist w "
                    + "JOIN motors m ON w.motor_id = m.motor_id "
                    + "JOIN brands b ON m.brand_id = b.brand_id "
                    + "JOIN models mo ON m.model_id = mo.model_id "
                    + "JOIN fuels f ON m.fuel_id = f.fuel_id "
                    + "WHERE w.customer_id = ?";

            ps = conn.prepareStatement(sql);
            ps.setInt(1, customerId); // Use customer_id to fetch wishlist for a user
            rs = ps.executeQuery();

            while (rs.next()) {
                // Create Motor object and populate its properties from ResultSet
                Motor motorbike = new Motor();
                motorbike.setMotorId(rs.getInt("motor_id"));
                motorbike.setBrandId(rs.getInt("brand_id"));
                motorbike.setModelId(rs.getInt("model_id"));
                motorbike.setMotorName(rs.getString("motor_name"));
                motorbike.setColor(rs.getString("color"));
                motorbike.setPrice(rs.getDouble("price"));
                motorbike.setFuelId(rs.getInt("fuel_id"));
                motorbike.setPresent(rs.getBoolean("present"));
                motorbike.setDescription(rs.getString("description"));
                motorbike.setQuantity(rs.getInt("quantity"));
                motorbike.setPicture(rs.getString("picture"));
                motorbike.setDateStart(rs.getDate("date_start"));

                // Add motorbike to the wishlist
                wishlist.add(motorbike);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) {
                    rs.close();
                }
                if (ps != null) {
                    ps.close();
                }
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return wishlist;
    }

    public boolean removeMotorFromWishlist(int motorId, int customerId) {
        String sql = "DELETE FROM wishlist WHERE motor_id = ? AND customer_id = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, motorId);
            stmt.setInt(2, customerId);
            int row = stmt.executeUpdate();
            return row > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean addToWishlist(int motorId, int customerId) {
    // First, check if the motor already exists in the wishlist
    if (checkHaveWish(motorId, customerId)) {
        return false; // If motor already in wishlist, return false
    }

    String sql = "INSERT INTO wishlist (motor_id, customer_id) VALUES (?, ?)";
    try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
        stmt.setInt(1, motorId);  // Set motorId
        stmt.setInt(2, customerId);  // Set customerId

        int row = stmt.executeUpdate();  // Execute the insertion query
        return row > 0; // Returns true if the insertion was successful
    } catch (SQLException e) {
        e.printStackTrace();  // Log the error for debugging
        return false;  // Return false if insertion fails
    }
}

    public boolean checkHaveWish(int motorId, int customerId) {
        String sql = "SELECT * FROM wishlist WHERE motor_id = ? AND customer_id = ?";  // Updated to motor_id
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, motorId);
            stmt.setInt(2, customerId);
            try ( ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}
