package dao;

import models.UserAccount;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class UserAccountDAO {

    public boolean updateUserAccount(int userId, String email, String password) {
        String sql = "UPDATE user_account SET email = ?, password = ? WHERE user_id = ?";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            stmt.setString(2, password);
            stmt.setInt(3, userId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateEmployee(int userId, String name, String phoneNumber) {
        String sql = "UPDATE employees SET name = ?, phone_number = ? WHERE user_id = ?";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, name);
            stmt.setString(2, phoneNumber);
            stmt.setInt(3, userId);

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public UserAccount getUserById(int userId) {
        String sql = "SELECT * FROM user_account WHERE user_id = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new UserAccount(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("date_created")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

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
                        rs.getBoolean("status"),
                        rs.getTimestamp("date_created")
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

    public void SendOTPToEmail(String email, String otp) {
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
                        rs.getBoolean("status"),
                        rs.getTimestamp("date_created")
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

    public boolean addNewCustomerAccount(int userId, String name, String phoneNumber, String address) {
        Connection conn = null;
        PreparedStatement psCustomer = null;

        try {
            conn = DBContext.getConnection();

            String sqlCustomer = "INSERT INTO customers (user_id, name, phone_number, address) VALUES (?, ?, ?, ?)";
            psCustomer = conn.prepareStatement(sqlCustomer);
            psCustomer.setInt(1, userId);
            psCustomer.setString(2, name);
            psCustomer.setString(3, phoneNumber);
            psCustomer.setString(4, address);

            int customerRowsAffected = psCustomer.executeUpdate();
            if (customerRowsAffected == 0) {
                System.out.println("Failed to insert into customers table.");
                return false;
            }

            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
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

    public boolean registerUser(UserAccount newUser, String name, String phoneNumber, String address) {
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
            ps.setString(4, newUser.getRole() != null ? newUser.getRole() : "customer");
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

    public boolean registerUser(UserAccount newUser) {
        String sql = "INSERT INTO user_account (email, password, status, role, date_created) VALUES (?, ?, ?, ?, ?)";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, newUser.getEmail());
            stmt.setString(2, newUser.getPassword());
            stmt.setBoolean(3, newUser.isStatus());
            stmt.setString(4, newUser.getRole());
            stmt.setTimestamp(5, new Timestamp(System.currentTimeMillis()));

            int affectedRows = stmt.executeUpdate();
            if (affectedRows > 0) {
                // Retrieve the generated user_id from the user_account table
                try ( ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int userId = generatedKeys.getInt(1);
                        newUser.setUserId(userId);  // Set the userId to the newUser object
                        return true; // User created successfully
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if registration failed
    }

    // Method to add customer details after registration
    public boolean addCustomerDetails(UserAccount user, String name, String phoneNumber, String address) {
        String sql = "INSERT INTO customers (user_id, name, phone_number, address) VALUES (?, ?, ?, ?)";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getUserId());
            stmt.setString(2, name);
            stmt.setString(3, phoneNumber);
            stmt.setString(4, address);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0; // Return true if customer details were added successfully
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if adding customer details failed
    }

    // Method to add employee details after registration
    public boolean addEmployeeDetails(UserAccount user, String name, String phoneNumber) {
        String sql = "INSERT INTO employees (user_id, name, phone_number) VALUES (?, ?, ?)";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, user.getUserId());
            stmt.setString(2, name);
            stmt.setString(3, phoneNumber);

            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0; // Return true if employee details were added successfully
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // Return false if adding employee details failed
    }

    public List<UserAccount> getAllUsers() {
        List<UserAccount> users = new ArrayList<>();
        String sql = "SELECT user_id, email, password, role, status, date_created FROM user_account";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(new UserAccount(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("date_created")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public List<UserAccount> getAllAdmin() {
        List<UserAccount> users = new ArrayList<>();
        String sql = "SELECT user_id, email, password, role, status, date_created FROM user_account WHERE role = 'admin'";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(sql);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                users.add(new UserAccount(
                        rs.getInt("user_id"),
                        rs.getString("email"),
                        rs.getString("password"),
                        rs.getString("role"),
                        rs.getBoolean("status"),
                        rs.getTimestamp("date_created")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return users;
    }
    
    public List<UserAccount> getCustomers() {
        List<UserAccount> customers = new ArrayList<>();
        String query = "SELECT * FROM user_account WHERE role = 'customer'";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(query);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                UserAccount user = new UserAccount();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
                user.setDateCreated(rs.getTimestamp("date_created"));

                customers.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public List<UserAccount> getEmployees() {
        List<UserAccount> customers = new ArrayList<>();
        String query = "SELECT * FROM user_account WHERE role = 'employee'";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(query);  ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                UserAccount user = new UserAccount();
                user.setUserId(rs.getInt("user_id"));
                user.setEmail(rs.getString("email"));
                user.setPassword(rs.getString("password"));
                user.setRole(rs.getString("role"));
                user.setStatus(rs.getBoolean("status"));
                user.setDateCreated(rs.getTimestamp("date_created"));

                customers.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }

    public void toggleStatus(int userId) {
        String query = "UPDATE user_account SET status = CASE WHEN status = 1 THEN 0 ELSE 1 END WHERE user_id = ?";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

}
