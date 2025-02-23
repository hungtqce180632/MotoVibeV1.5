/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Timestamp;

/**
 *
 * @author truon
 */
public class Appointment {
    private int appointmentId;
    private int customerId; // For Employee View
    private Timestamp dateStart;
    private Timestamp dateEnd;
    private String note;
    private boolean appointmentStatus;

    public Appointment() {
    }

    public Appointment(int appointmentId, int customerId, Timestamp dateStart, Timestamp dateEnd, String note, boolean appointmentStatus) {
        this.appointmentId = appointmentId;
        this.customerId = customerId;
        this.dateStart = dateStart;
        this.dateEnd = dateEnd;
        this.note = note;
        this.appointmentStatus = appointmentStatus;
    }

    public int getAppointmentId() {
        return appointmentId;
    }

    public void setAppointmentId(int appointmentId) {
        this.appointmentId = appointmentId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public Timestamp getDateStart() {
        return dateStart;
    }

    public void setDateStart(Timestamp dateStart) {
        this.dateStart = dateStart;
    }

    public Timestamp getDateEnd() {
        return dateEnd;
    }

    public void setDateEnd(Timestamp dateEnd) {
        this.dateEnd = dateEnd;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }

    public boolean isAppointmentStatus() {
        return appointmentStatus;
    }

    public void setAppointmentStatus(boolean appointmentStatus) {
        this.appointmentStatus = appointmentStatus;
    }
    
    
}
