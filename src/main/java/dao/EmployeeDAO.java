/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Employee;
import utils.DBContext;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import models.Motor;

/**
 *
 * @author truon
 */
public class EmployeeDAO {

    /**
     * Fetch an Employee by userId, joining user_account to get email, role,
     * status.
     */
    public Employee getEmployeeByUserId(int userId) {
        String sql = "SELECT e.employee_id, e.user_id, e.name, e.phone_number, "
                + "       u.email AS user_email, u.role AS user_role, u.status AS user_status "
                + "FROM [dbo].[employees] e "
                + "JOIN [dbo].[user_account] u ON e.user_id = u.user_id "
                + "WHERE e.user_id = ?";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapEmployeeJoined(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null; // not found or error
    }

    /**
     * If you need to create or update employees table, you can add methods. For
     * now, we only read existing rows.
     */
    private Employee mapEmployeeJoined(ResultSet rs) throws SQLException {
        Employee emp = new Employee();
        emp.setEmployeeId(rs.getInt("employee_id"));
        emp.setUserId(rs.getInt("user_id"));
        emp.setName(rs.getString("name"));
        emp.setPhoneNumber(rs.getString("phone_number"));

        // from user_account
        emp.setEmail(rs.getString("user_email"));
        emp.setRole(rs.getString("user_role"));
        emp.setStatus(rs.getBoolean("user_status"));

        return emp;
    }

    public List<Employee> getAllEmployees() {
        List<Employee> employees = new ArrayList<>();
        String sql = "SELECT employee_id, name FROM employees"; // Assuming employees table has these columns

        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql);  ResultSet resultSet = preparedStatement.executeQuery()) {

            while (resultSet.next()) {
                Employee employee = new Employee();
                employee.setEmployeeId(resultSet.getInt("employee_id"));
                employee.setName(resultSet.getString("name"));
                employees.add(employee);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return employees;
    }

}
