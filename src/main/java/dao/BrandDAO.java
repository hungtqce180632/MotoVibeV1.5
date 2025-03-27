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
import models.Brand;
import utils.DBContext;

/**
 *
 * @author tiend
 */
public class BrandDAO {

    // Fetch all brands from the database
    public List<Brand> getAllBrands() throws SQLException {
        List<Brand> brands = new ArrayList<>();
        String sql = "SELECT * FROM brands";
        
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql); 
             ResultSet rs = pstmt.executeQuery()) {
            
            while (rs.next()) {
                brands.add(new Brand(rs.getInt("brand_id"), 
                                     rs.getString("brand_name"), 
                                     rs.getString("country_of_origin"), 
                                     rs.getString("description")));
            }
        }
        return brands;
    }

    // Fetch a single brand by its ID
    public Brand getBrandById(int brandId) throws SQLException {
        String sql = "SELECT * FROM brands WHERE brand_id = ?";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, brandId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Brand(rs.getInt("brand_id"), 
                                     rs.getString("brand_name"), 
                                     rs.getString("country_of_origin"), 
                                     rs.getString("description"));
                }
            }
        }
        return null;
    }

    // Add a new brand to the database
    public void addBrand(Brand brand) throws SQLException {
        String sql = "INSERT INTO brands (brand_name, country_of_origin, description) VALUES (?, ?, ?)";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, brand.getBrandName());
            pstmt.setString(2, brand.getCountryOfOrigin());
            pstmt.setString(3, brand.getDescription());
            pstmt.executeUpdate();
        }
    }

    // Update an existing brand's information in the database
    public void updateBrand(Brand brand) throws SQLException {
        String sql = "UPDATE brands SET brand_name = ?, country_of_origin = ?, description = ? WHERE brand_id = ?";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, brand.getBrandName());
            pstmt.setString(2, brand.getCountryOfOrigin());
            pstmt.setString(3, brand.getDescription());
            pstmt.setInt(4, brand.getBrandId());
            pstmt.executeUpdate();
        }
    }

    // Delete a brand from the database by its ID
    public void deleteBrand(int brandId) throws SQLException {
        String sql = "DELETE FROM brands WHERE brand_id = ?";
        try (Connection conn = DBContext.getConnection(); 
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, brandId);
            pstmt.executeUpdate();
        }
    }
}