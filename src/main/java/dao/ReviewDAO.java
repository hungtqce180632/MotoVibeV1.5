/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Review;
import utils.DBContext;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author truon
 */
public class ReviewDAO {

    public boolean createReview(Review review) {
        String sql = "INSERT INTO reviews (customer_id, motor_id, rating, review_text, review_date, review_status) "
                + "VALUES (?, ?, ?, ?, GETDATE(), ?)";

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, review.getCustomerId());
            ps.setInt(2, review.getMotorId());
            ps.setInt(3, review.getRating());
            ps.setString(4, review.getReviewText());
            ps.setBoolean(5, review.isReviewStatus());

            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Review getReviewById(int reviewId) {
        String sql = "SELECT * FROM reviews WHERE review_id = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reviewId);
            try ( ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapReview(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Review> getAllReviewOfCar(int motorId) throws SQLException {
        String sql = "SELECT * FROM reviews WHERE motor_id = ? AND review_status = 1";
        // or remove 'AND review_status=1' if you want to show all
        List<Review> list = new ArrayList<>();

        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, motorId);
            try ( ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    list.add(mapReview(rs));
                }
            }
        }
        return list;
    }

    public boolean updateReview(Review r) {
        String sql = "UPDATE reviews SET rating=?, review_text=?, review_status=? WHERE review_id=?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, r.getRating());
            ps.setString(2, r.getReviewText());
            ps.setBoolean(3, r.isReviewStatus());
            ps.setInt(4, r.getReviewId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        try ( Connection conn = DBContext.getConnection();  PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, reviewId);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Helper to map a row into a Review
    private Review mapReview(ResultSet rs) throws SQLException {
        Review r = new Review();
        r.setReviewId(rs.getInt("review_id"));
        r.setCustomerId(rs.getInt("customer_id"));
        r.setMotorId(rs.getInt("motor_id"));
        r.setRating(rs.getInt("rating"));
        r.setReviewText(rs.getString("review_text"));
        r.setReviewDate(rs.getString("review_date"));
        r.setReviewStatus(rs.getBoolean("review_status"));
        return r;
    }

    public List<Review> getAllReviews() throws SQLException {
        String sql = "SELECT r.*, c.name as customer_name FROM reviews r " +
                    "LEFT JOIN customers c ON r.customer_id = c.customer_id " +
                    "ORDER BY r.review_date DESC";
        
        List<Review> list = new ArrayList<>();
        
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Review r = mapReview(rs);
                r.setCustomer_name(rs.getString("customer_name"));
                list.add(r);
            }
        }
        return list;
    }

    /**
     * Check if a customer has already reviewed a specific motor
     * @param customerId The customer ID
     * @param motorId The motor ID
     * @return true if the customer has already submitted a review for this motor
     */
    public boolean hasAlreadyReviewed(int customerId, int motorId) {
        String sql = "SELECT COUNT(*) FROM reviews WHERE customer_id = ? AND motor_id = ?";
        try (Connection conn = DBContext.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, customerId);
            ps.setInt(2, motorId);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
