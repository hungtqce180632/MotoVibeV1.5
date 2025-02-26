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
public class Warranty {

    private int warrantyId;
    private int orderId;
    private String warrantyDetails;
    private Date warrantyExpiry;

    public Warranty() {
    }

    public Warranty(int warrantyId, int orderId, String warrantyDetails, Date warrantyExpiry) {
        this.warrantyId = warrantyId;
        this.orderId = orderId;
        this.warrantyDetails = warrantyDetails;
        this.warrantyExpiry = warrantyExpiry;
    }

    public int getWarrantyId() {
        return warrantyId;
    }

    public void setWarrantyId(int warrantyId) {
        this.warrantyId = warrantyId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getWarrantyDetails() {
        return warrantyDetails;
    }

    public void setWarrantyDetails(String warrantyDetails) {
        this.warrantyDetails = warrantyDetails;
    }

    public Date getWarrantyExpiry() {
        return warrantyExpiry;
    }

    public void setWarrantyExpiry(Date warrantyExpiry) {
        this.warrantyExpiry = warrantyExpiry;
    }

}
