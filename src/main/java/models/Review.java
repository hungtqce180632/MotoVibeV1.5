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
    
    
    private boolean reviewStatus;
    private int reviewId;
    private int motorId;
    private int customerId;
    private int rating;
    private String reviewText;
    private Date reviewDate;

    public Review() {
    }

    public Review(boolean reviewStatus, int reviewId, int motorId, int customerId, int rating, String reviewText, Date reviewDate) {
        this.reviewStatus = reviewStatus;
        this.reviewId = reviewId;
        this.motorId = motorId;
        this.customerId = customerId;
        this.rating = rating;
        this.reviewText = reviewText;
        this.reviewDate = reviewDate;
    }

    public boolean isReviewStatus() {
        return reviewStatus;
    }

    public void setReviewStatus(boolean reviewStatus) {
        this.reviewStatus = reviewStatus;
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getMotorId() {
        return motorId;
    }

    public void setMotorId(int motorId) {
        this.motorId = motorId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
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

    public Date getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Date reviewDate) {
        this.reviewDate = reviewDate;
    }

    
    
    
    
}
