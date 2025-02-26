/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author truon
 */
public class Review {
    
  private int reviewId;        // ID of the review
    private int customerId;      // ID of the customer who left the review
    private int motorId;         // ID of the motorbike being reviewed
    private int rating;          // Rating given by the customer (1-5)
    private String reviewText;   // Text of the review
    private String reviewDate;   // Date when the review was written (as a string)
    private boolean reviewStatus; // Status of the review (active/inactive)
    private String customer_name; // Customer's name who wrote the review

    // Default constructor
    public Review() {
    }

    // Constructor with parameters
    public Review(int reviewId, int customerId, int motorId, int rating, String reviewText, String reviewDate, boolean reviewStatus, String customer_name) {
        this.reviewId = reviewId;
        this.customerId = customerId;
        this.motorId = motorId;
        this.rating = rating;
        this.reviewText = reviewText;
        this.reviewDate = reviewDate;
        this.reviewStatus = reviewStatus;
        this.customer_name = customer_name;
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public int getMotorId() {
        return motorId;
    }

    public void setMotorId(int motorId) {
        this.motorId = motorId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public String getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(String reviewDate) {
        this.reviewDate = reviewDate;
    }

    public boolean isReviewStatus() {
        return reviewStatus;
    }

    public void setReviewStatus(boolean reviewStatus) {
        this.reviewStatus = reviewStatus;
    }

    public String getCustomer_name() {
        return customer_name;
    }

    public void setCustomer_name(String customer_name) {
        this.customer_name = customer_name;
    }

    // toString() method for debugging or displaying the Review object
    @Override
    public String toString() {
        return "Review{" +
                "reviewId=" + reviewId +
                ", customerId=" + customerId +
                ", motorId=" + motorId +
                ", rating=" + rating +
                ", reviewText='" + reviewText + '\'' +
                ", reviewDate='" + reviewDate + '\'' +
                ", reviewStatus=" + reviewStatus +
                ", customer_name='" + customer_name + '\'' +
                '}';
    }
    
}
