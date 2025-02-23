/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;
import java.sql.Timestamp;

/**
 *
 * @author truon
 */
public class Order {

    private int orderId;
    private int customerId;
    private Integer employeeId; // Nullable
    private int motorId;
    private Timestamp createDate; // Use Timestamp for createDate
    private String paymentMethod;
    private Double totalAmount; // Changed to Double
    private boolean depositStatus;
    private String orderStatus; // **CHANGED to String**
    private Date dateStart;
    private Date dateEnd;
    private boolean hasWarranty;
    private Integer warrantyId; // Nullable
    private Warranty warranty;

    public Order() {
    }

    public Order(int orderId, int customerId, Integer employeeId, int motorId, Timestamp createDate, String paymentMethod, Double totalAmount, boolean depositStatus, String orderStatus, Date dateStart, Date dateEnd, boolean hasWarranty, Integer warrantyId, Warranty warranty) {
        this.orderId = orderId;
        this.customerId = customerId;
        this.employeeId = employeeId;
        this.motorId = motorId;
        this.createDate = createDate;
        this.paymentMethod = paymentMethod;
        this.totalAmount = totalAmount;
        this.depositStatus = depositStatus;
        this.orderStatus = orderStatus;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
        this.hasWarranty = hasWarranty;
        this.warrantyId = warrantyId;
        this.warranty = warranty;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Integer getEmployeeId() {
        return employeeId;
    }

    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }

    public int getMotorId() {
        return motorId;
    }

    public void setMotorId(int motorId) {
        this.motorId = motorId;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public boolean isDepositStatus() {
        return depositStatus;
    }

    public void setDepositStatus(boolean depositStatus) {
        this.depositStatus = depositStatus;
    }

    public String getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(String orderStatus) {
        this.orderStatus = orderStatus;
    }

    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    public Date getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(Date dateEnd) {
        this.dateEnd = dateEnd;
    }

    public boolean isHasWarranty() {
        return hasWarranty;
    }

    public void setHasWarranty(boolean hasWarranty) {
        this.hasWarranty = hasWarranty;
    }

    public Integer getWarrantyId() {
        return warrantyId;
    }

    public void setWarrantyId(Integer warrantyId) {
        this.warrantyId = warrantyId;
    }

    public Warranty getWarranty() {
        return warranty;
    }

    public void setWarranty(Warranty warranty) {
        this.warranty = warranty;
    }

}
