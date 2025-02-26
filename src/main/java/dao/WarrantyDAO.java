/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Warranty;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import utils.DBContext;

/**
 *
 * @author truon
 */
public class WarrantyDAO {

    public boolean createWarranty(Warranty warranty) {
        String sql = "INSERT INTO warranty (order_id, warranty_details, warranty_expiry) VALUES (?, ?, ?)";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, warranty.getOrderId());
            preparedStatement.setString(2, warranty.getWarrantyDetails());
            preparedStatement.setDate(3, warranty.getWarrantyExpiry());
            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Warranty getWarrantyById(int warrantyId) {
        String sql = "SELECT * FROM warranty WHERE warranty_id = ?";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, warrantyId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapWarranty(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean updateWarranty(Warranty warranty) {
        String sql = "UPDATE warranty SET warranty_details = ?, warranty_expiry = ? WHERE warranty_id = ?";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, warranty.getWarrantyDetails());
            preparedStatement.setDate(2, warranty.getWarrantyExpiry());
            preparedStatement.setInt(3, warranty.getWarrantyId());
            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteWarranty(int warrantyId) {
        String sql = "DELETE FROM warranty WHERE warranty_id = ?";
        try ( Connection connection = DBContext.getConnection();  PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setInt(1, warrantyId);
            return preparedStatement.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Warranty mapWarranty(ResultSet resultSet) throws SQLException {
        Warranty warranty = new Warranty();
        warranty.setWarrantyId(resultSet.getInt("warranty_id"));
        warranty.setOrderId(resultSet.getInt("order_id"));
        warranty.setWarrantyDetails(resultSet.getString("warranty_details"));
        warranty.setWarrantyExpiry(resultSet.getDate("warranty_expiry"));
        return warranty;
    }
}
