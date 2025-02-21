/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

/**
 *
 * @author tiend
 */
public class Fuel {

    private int fuelId;
    private String fuelName;

    public Fuel() {
    }

    public Fuel(int fuelId, String fuelName) {
        this.fuelId = fuelId;
        this.fuelName = fuelName;
    }

    public int getFuelId() {
        return fuelId;
    }

    public void setFuelId(int fuelId) {
        this.fuelId = fuelId;
    }

    public String getFuelName() {
        return fuelName;
    }

    public void setFuelName(String fuelName) {
        this.fuelName = fuelName;
    }
}
