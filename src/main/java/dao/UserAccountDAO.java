package dao;

import models.UserAccount;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

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
            String sql = "INSERT INTO user_account (email, password, status, role, date_created) VALUES (?, ?, ?, ?, ?)";

            ps = conn.prepareStatement(sql);
            ps.setString(1, newUser.getEmail());
            ps.setString(2, newUser.getPassword());
            ps.setBoolean(3, true);
            ps.setString(4, "customer");
            ps.setTimestamp(5, new Timestamp(System.currentTimeMillis()));

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

    public UserAccount getUserByEmail(String email) {
        String sql = "SELECT * FROM user_account WHERE email = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, email);
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

    public boolean updatePassword(int userId, String newPassword) {
        String sql = "UPDATE user_account SET password = ? WHERE user_id = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newPassword);
            stmt.setInt(2, userId);
            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean registerNewCustomerAccount(UserAccount newUser, String name, String phoneNumber, String address) {
        Connection conn = null;
        PreparedStatement psUser = null;
        PreparedStatement psCustomer = null;
        ResultSet generatedKeys = null;

        try {
            conn = DBContext.getConnection();

            // Start a transaction by disabling auto-commit
            conn.setAutoCommit(false);

            // Step 1: Insert into the user_account table
            String sqlUser = "INSERT INTO user_account (email, password, status, role) VALUES (?, ?, ?, ?)";
            psUser = conn.prepareStatement(sqlUser, PreparedStatement.RETURN_GENERATED_KEYS);
            psUser.setString(1, newUser.getEmail());
            psUser.setString(2, newUser.getPassword());
            psUser.setBoolean(3, true); // Assume status is active when registering
            psUser.setString(4, newUser.getRole() != null ? newUser.getRole() : "customer"); // Default role is customer

            int rowsAffected = psUser.executeUpdate();
            if (rowsAffected == 0) {
                conn.rollback();
                return false;
            }

            // Retrieve the generated user_id from the user_account table
            generatedKeys = psUser.getGeneratedKeys();
            int userId = 0;
            if (generatedKeys.next()) {
                userId = generatedKeys.getInt(1);
            } else {
                conn.rollback();
                return false;
            }

            // Step 2: Insert into the customer table
            if ("customer".equals(newUser.getRole())) {
                String sqlCustomer = "INSERT INTO customers (user_id, name, phone_number, address) VALUES (?, ?, ?, ?)";
                psCustomer = conn.prepareStatement(sqlCustomer);
                psCustomer.setInt(1, userId);
                psCustomer.setString(2, name);
                psCustomer.setString(3, phoneNumber);
                psCustomer.setString(4, address);

                int customerRowsAffected = psCustomer.executeUpdate();
                if (customerRowsAffected == 0) {
                    conn.rollback();
                    return false;
                }
            }

            // Step 3: Commit the transaction
            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            try {
                if (conn != null) {
                    conn.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
        } finally {
            try {
                if (psUser != null) {
                    psUser.close();
                }
                if (psCustomer != null) {
                    psCustomer.close();
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
}
