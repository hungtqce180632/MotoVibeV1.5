/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author truon
 */
public class Customer {
    private int customerId;
    private Integer userId; // Can be null, using Integer wrapper class
    private String name;
    private String email;
    private String phoneNumber;
    private String cusIdNumber;
    private String address;
    private boolean status; // Assuming status is boolean (e.g., active/inactive)
    private String picture; // Path to picture or BLOB, depending on your DB setup
    private String preferredContactMethod;

    public Customer() {
    }

    public Customer(int customerId, Integer userId, String name, String email, String phoneNumber, String cusIdNumber, String address, boolean status, String picture, String preferredContactMethod) {
        this.customerId = customerId;
        this.userId = userId;
        this.name = name;
        this.email = email;
        this.phoneNumber = phoneNumber;
        this.cusIdNumber = cusIdNumber;
        this.address = address;
        this.status = status;
        this.picture = picture;
        this.preferredContactMethod = preferredContactMethod;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getCusIdNumber() {
        return cusIdNumber;
    }

    public void setCusIdNumber(String cusIdNumber) {
        this.cusIdNumber = cusIdNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public String getPreferredContactMethod() {
        return preferredContactMethod;
    }

    public void setPreferredContactMethod(String preferredContactMethod) {
        this.preferredContactMethod = preferredContactMethod;
    }
    
    
}
