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

    private Integer customerId;   // from [customers]
    private Integer userId;       // from [customers], FK to user_account.user_id
    private String name;          // from [customers]
    private String phoneNumber;   // from [customers]
    private String address;       // from [customers]

    // Extra fields from user_account table:
    private String email;         // from user_account.email
    private String role;          // from user_account.role
    private boolean status;

    public Customer() {
    }

    public Customer(Integer customerId, Integer userId, String name, String phoneNumber, String address, String email, String role, boolean status) {
        this.customerId = customerId;
        this.userId = userId;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;
        this.role = role;
        this.status = status;
    }

    public Customer(int customerId, String name, String phoneNumber, String address, String email) {
        this.customerId = customerId;
        this.name = name;
        this.phoneNumber = phoneNumber;
        this.address = address;
        this.email = email;    }



    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
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

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

}
