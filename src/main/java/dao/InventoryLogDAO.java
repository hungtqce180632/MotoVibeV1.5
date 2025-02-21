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
import models.InventoryLog;
import utils.DBContext;

/**
 *
 * @author tiend
 */
public class InventoryLogDAO {

    public List<InventoryLog> getAllLogs() {
        List<InventoryLog> logs = new ArrayList<>();
        String sql = "SELECT * FROM inventory_log ORDER BY modified_at DESC";

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                logs.add(new InventoryLog(
                        rs.getInt("log_id"),
                        rs.getInt("motor_id"),
                        rs.getInt("previous_quantity"),
                        rs.getInt("change_amount"),
                        rs.getString("action_type"),
                        rs.getInt("user_id_modified_by"),
                        rs.getTimestamp("modified_at").toLocalDateTime(),
                        rs.getString("note")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }

    public void addLog(InventoryLog log) {
        String sql = "INSERT INTO inventory_log (motor_id, previous_quantity, change_amount, action_type, user_id_modified_by, note) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBContext.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, log.getMotorId());
            stmt.setInt(2, log.getPreviousQuantity());
            stmt.setInt(3, log.getChangeAmount());
            stmt.setString(4, log.getActionType());
            stmt.setInt(5, log.getUserIdModifiedBy());
            stmt.setString(6, log.getNote());

            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
