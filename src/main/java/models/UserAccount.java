package models;

import java.util.Date;

public class UserAccount {

    private int userId;
    private String email;
    private String password;
    private String role;
    private boolean status;
    private Date dateCreated;

    public UserAccount(int userId, String email, String password, String role, boolean status, Date dateCreated) {
        this.userId = userId;
        this.email = email;
        this.password = password;
        this.role = role;
        this.status = status;
        this.dateCreated = dateCreated;
    }

    public UserAccount(String email, String password) {
        this.email = email;
        this.password = password;
        this.dateCreated = new Date();
    }

    public UserAccount() {
        this.dateCreated = new Date();
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
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

    // Getter and Setter for dateCreated
    public Date getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(Date dateCreated) {
        this.dateCreated = dateCreated;
    }

    // This method is no longer needed since we now have dateCreated field
    public int getId() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
