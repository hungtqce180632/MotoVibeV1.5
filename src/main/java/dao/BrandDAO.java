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

    public List<Brand> getAllBrands() throws SQLException {
        List<Brand> brands = new ArrayList<>();
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "SELECT * FROM brands";
        try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                brands.add(new Brand(rs.getInt("brand_id"), rs.getString("brand_name"), rs.getString("country_of_origin"), rs.getString("description")));
            }
        }
        return brands;
    }

    public Brand getBrandById(int brandId) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "SELECT * FROM brands WHERE brand_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, brandId);
            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Brand(rs.getInt("brand_id"), rs.getString("brand_name"), rs.getString("country_of_origin"), rs.getString("description"));
                }
            }
        }
        return null;
    }

    public void addBrand(Brand brand) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "INSERT INTO brands (brand_name, country_of_origin, description) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, brand.getBrandName());
            pstmt.setString(2, brand.getCountryOfOrigin());
            pstmt.setString(3, brand.getDescription());
            pstmt.executeUpdate();
        }
    }

    public void updateBrand(Brand brand) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "UPDATE brands SET brand_name = ?, country_of_origin = ?, description = ? WHERE brand_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, brand.getBrandName());
            pstmt.setString(2, brand.getCountryOfOrigin());
            pstmt.setString(3, brand.getDescription());
            pstmt.setInt(4, brand.getBrandId());
            pstmt.executeUpdate();
        }
    }

    public void deleteBrand(int brandId) throws SQLException {
        Connection conn = (Connection) DBContext.getConnection();
        String sql = "DELETE FROM brands WHERE brand_id = ?";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, brandId);
            pstmt.executeUpdate();
        }
    }
}
