/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author sang
 */
public class Wishlist {
    private int wishlist_id;
    private int customer_id;
    private int motor_id;

    public Wishlist() {
    }

    public Wishlist(int wishlist_id, int customer_id, int motor_id) {
        this.wishlist_id = wishlist_id;
        this.customer_id = customer_id;
        this.motor_id = motor_id;
    }

    public int getWishlist_id() {
        return wishlist_id;
    }

    public void setWishlist_id(int wishlist_id) {
        this.wishlist_id = wishlist_id;
    }

    public int getCustomer_id() {
        return customer_id;
    }

    public void setCustomer_id(int customer_id) {
        this.customer_id = customer_id;
    }

    public int getMotor_id() {
        return motor_id;
    }

    public void setMotor_id(int motor_id) {
        this.motor_id = motor_id;
    }

    @Override
    public String toString() {
        return "WishlistModel{" + "wishlist_id=" + wishlist_id + ", customer_id=" + customer_id + ", motor_id=" + motor_id + '}';
    }
        
}
