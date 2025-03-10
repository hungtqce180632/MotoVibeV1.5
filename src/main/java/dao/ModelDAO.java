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
import models.Model;
import utils.DBContext;

/**
 *
 * @author tiend
 */
public class ModelDAO {

     public List<Model> getAllModels() throws SQLException {
        List<Model> models = new ArrayList<>();
        String sql = "SELECT * FROM models";

        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                models.add(new Model(rs.getInt("model_id"), rs.getString("model_name")));
            }
        }
        return models;
    }

    public Model getModelById(int modelId) throws SQLException {
        String sql = "SELECT * FROM models WHERE model_id = ?";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, modelId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Model(rs.getInt("model_id"), rs.getString("model_name"));
                }
            }
        }
        return null;
    }

    public void updateModel(Model model) throws SQLException {
        String sql = "UPDATE models SET model_name = ? WHERE model_id = ?";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, model.getModelName());
            pstmt.setInt(2, model.getModelId());
            pstmt.executeUpdate();
        }
    }

    public void deleteModel(int modelId) throws SQLException {
        String sql = "DELETE FROM models WHERE model_id = ?";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, modelId);
            pstmt.executeUpdate();
        }
    }
    
    public void addModel(Model model) throws SQLException {
        String sql = "INSERT INTO models (model_name) VALUES (?)"; // SQL query to insert the new model

        // Get a connection to the database and prepare the SQL statement
        try (Connection conn = DBContext.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            // Set the parameter for the prepared statement (the model name)
            pstmt.setString(1, model.getModelName());

            // Execute the update to insert the new model
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new SQLException("Error adding model to the database", e);
        }
    }
}
