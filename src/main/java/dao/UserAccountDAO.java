package dao;

import models.UserAccount;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserAccountDAO {

    // Method to authenticate user login
    public UserAccount login(String email, String password) {
        String sql = "SELECT * FROM user_account WHERE email = ? AND password = ? AND status = 1";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
            stmt.setString(2, password);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new UserAccount(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("status")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Method to check if an email already exists in the database
    public boolean checkEmailExists(String email) {
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Get the database connection
            conn = DBContext.getConnection();
            if (conn == null) {
                System.out.println("Database connection failed.");
                return false;
            }

            // SQL query to check if the email already exists
            String sql = "SELECT * FROM user_account WHERE email = ?";
            ps = conn.prepareStatement(sql);
            ps.setString(1, email);

            // Execute query
            rs = ps.executeQuery();

            // If a matching email is found, return true
            if (rs.next()) {
                return true; // Email already exists
            }

        } catch (SQLException e) {
            // Handle SQL exceptions and log them for debugging
            System.out.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Ensure all resources are closed to prevent memory leaks
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

        // Return false if no matching email is found
        return false;
    }

    // Method to register a new user
    public boolean registerUser(UserAccount newUser) {
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBContext.getConnection();

            // Assuming 'role' is a required field, and defaulting it to 'user'
            String sql = "INSERT INTO user_account (email, password, status, role) VALUES (?, ?, ?, ?)";

            ps = conn.prepareStatement(sql);
            ps.setString(1, newUser.getEmail());
            ps.setString(2, newUser.getPassword());
            ps.setBoolean(3, true);
            ps.setString(4, "customer");

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
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
        return false;
    }

    public boolean checkEmailExist(String email) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    public void sendOTPToEmail(String email, String otp) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
