/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

import models.Review;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;
import java.util.ArrayList;
import utils.DBContext;

/**
 *
 * @author truon
 */
public class ReviewDAO {

    public boolean createReview(Review review) {
        String sql = "INSERT INTO reviews (customer_id, motor_id, rating, review_text, review_date, review_status) VALUES (?, ?, ?, ?, GETDATE(), ?)";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, review.getCustomerId());
            preparedStatement.setInt(2, review.getMotorId());
            preparedStatement.setInt(3, review.getRating());
            preparedStatement.setString(4, review.getReviewText());
            preparedStatement.setBoolean(5, review.isReviewStatus());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Review getReviewById(int reviewId) {
        String sql = "SELECT * FROM reviews WHERE review_id = ?";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, reviewId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapReview(resultSet);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Review> getReviewsByMotorId(int motorId) {
        List<Review> reviews = new ArrayList<>();
        String sql = "SELECT * FROM reviews WHERE motor_id = ?";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, motorId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                reviews.add(mapReview(resultSet));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return reviews;
    }

    public boolean updateReview(Review review) {
        String sql = "UPDATE reviews SET rating = ?, review_text = ?, review_status = ? WHERE review_id = ?";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, review.getRating());
            preparedStatement.setString(2, review.getReviewText());
            preparedStatement.setBoolean(3, review.isReviewStatus());
            preparedStatement.setInt(4, review.getReviewId());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteReview(int reviewId) {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        try (Connection connection = DBContext.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
            preparedStatement.setInt(1, reviewId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Review mapReview(ResultSet resultSet) throws SQLException {
        Review review = new Review();
        review.setReviewId(resultSet.getInt("review_id"));
        review.setCustomerId(resultSet.getInt("customer_id"));
        review.setMotorId(resultSet.getInt("motor_id"));
        review.setRating(resultSet.getInt("rating"));
        review.setReviewText(resultSet.getString("review_text"));
        review.setReviewDate(resultSet.getDate("review_date"));
        review.setReviewStatus(resultSet.getBoolean("review_status"));
        return review;
    }
}
