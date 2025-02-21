/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.time.LocalDateTime;

/**
 *
 * @author tiend
 */
public class InventoryLog {

    private int logId;
    private int motorId;
    private int previousQuantity;
    private int changeAmount;
    private String actionType;
    private int userIdModifiedBy;
    private LocalDateTime modifiedAt;
    private String note;

    public InventoryLog() {
    }

    public InventoryLog(int logId, int motorId, int previousQuantity, int changeAmount, String actionType, int userIdModifiedBy, LocalDateTime modifiedAt, String note) {
        this.logId = logId;
        this.motorId = motorId;
        this.previousQuantity = previousQuantity;
        this.changeAmount = changeAmount;
        this.actionType = actionType;
        this.userIdModifiedBy = userIdModifiedBy;
        this.modifiedAt = modifiedAt;
        this.note = note;
    }

    public int getLogId() {
        return logId;
    }

    public void setLogId(int logId) {
        this.logId = logId;
    }

    public int getMotorId() {
        return motorId;
    }

    public void setMotorId(int motorId) {
        this.motorId = motorId;
    }

    public int getPreviousQuantity() {
        return previousQuantity;
    }

    public void setPreviousQuantity(int previousQuantity) {
        this.previousQuantity = previousQuantity;
    }

    public int getChangeAmount() {
        return changeAmount;
    }

    public void setChangeAmount(int changeAmount) {
        this.changeAmount = changeAmount;
    }

    public String getActionType() {
        return actionType;
    }

    public void setActionType(String actionType) {
        this.actionType = actionType;
    }

    public int getUserIdModifiedBy() {
        return userIdModifiedBy;
    }

    public void setUserIdModifiedBy(int userIdModifiedBy) {
        this.userIdModifiedBy = userIdModifiedBy;
    }

    public LocalDateTime getModifiedAt() {
        return modifiedAt;
    }

    public void setModifiedAt(LocalDateTime modifiedAt) {
        this.modifiedAt = modifiedAt;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

}
