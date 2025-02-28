/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Appointment;
import models.UserAccount;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import utils.DBContext;
import models.Appointment;
import utils.DBContext;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

/**
 * khi Decline thÌ admin phải accept mới đc Decline
 *
 * @author truon
 */
public class AppointmentDAO {

    public List<Appointment> getAppointmentsByCustomerId(int customerId) {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT * FROM Appointments WHERE customer_id = ?";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, customerId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                appointments.add(mapAppointment(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public List<Appointment> getAllAppointments() {
        List<Appointment> appointments = new ArrayList<>();
        String sql = "SELECT * FROM Appointments";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                appointments.add(mapAppointment(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return appointments;
    }

    public boolean createAppointment(Appointment appointment) {
        String sql = "INSERT INTO Appointments (customer_id, employee_id, date_start, date_end, note, appointment_status) "
                + "VALUES (?, ?, ?, ?, ?, ?)";

        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setInt(1, appointment.getCustomerId());

            // Allow `null` for employeeId (if not assigned yet)
            if (appointment.getEmployeeId() > 0) {
                preparedStatement.setInt(2, appointment.getEmployeeId());
            } else {
                preparedStatement.setNull(2, java.sql.Types.INTEGER);
            }

            preparedStatement.setTimestamp(3, appointment.getDateStart());
            preparedStatement.setTimestamp(4, appointment.getDateEnd());
            preparedStatement.setString(5, appointment.getNote());
            preparedStatement.setBoolean(6, appointment.isAppointmentStatus());

            int affectedRows = preparedStatement.executeUpdate();

            // Check if insertion was successful
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    appointment.setAppointmentId(generatedKeys.getInt(1)); // Retrieve and set auto-generated ID
                    return true;
                }
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Appointment mapAppointment(ResultSet resultSet) throws SQLException {
        Appointment appointment = new Appointment();
        appointment.setAppointmentId(resultSet.getInt("appointment_id"));
        appointment.setCustomerId(resultSet.getInt("customer_id"));
        appointment.setEmployeeId(resultSet.getInt("employee_id"));
        appointment.setDateStart(resultSet.getTimestamp("date_start"));
        appointment.setDateEnd(resultSet.getTimestamp("date_end"));
        appointment.setNote(resultSet.getString("note"));
        appointment.setAppointmentStatus(resultSet.getBoolean("appointment_status"));
        return appointment;
    }

    public Appointment getAppointmentById(int appointmentId) {
        String sql = "SELECT * FROM Appointments WHERE appointment_id = ?";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, appointmentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapAppointment(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean deleteAppointment(int appointmentId) {
        String sql = "DELETE FROM Appointments WHERE appointment_id = ? AND appointment_status = 0"; // Delete only if Inactive
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, appointmentId);
            int rowsAffected = preparedStatement.executeUpdate();

            return rowsAffected > 0; // Return true if delete was successful
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

}
