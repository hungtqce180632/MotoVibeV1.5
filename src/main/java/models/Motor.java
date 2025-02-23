/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.Date;

/**
 *
 * @author tiend
 */
public class Motor {

    private int motorId;
    private int brandId;
    private int modelId;
    private String motorName;
    private String color;
    private double price;
    private int fuelId;
    private boolean present;
    private String description;
    private int quantity;
    private String picture;
    private Date dateStart;
    private Brand brand; 
    private Model model; 
    private Fuel fuel;
    private boolean featured; //field for "featured"

    public Motor() {
    }

    public Motor(int motorId, int brandId, int modelId, String motorName, String color, double price, int fuelId, boolean present, String description, int quantity, String picture, Date dateStart, Brand brand, Model model, Fuel fuel, boolean featured) {
        this.motorId = motorId;
        this.brandId = brandId;
        this.modelId = modelId;
        this.motorName = motorName;
        this.color = color;
        this.price = price;
        this.fuelId = fuelId;
        this.present = present;
        this.description = description;
        this.quantity = quantity;
        this.picture = picture;
        this.dateStart = dateStart;
        this.brand = brand;
        this.model = model;
        this.fuel = fuel;
        this.featured = featured;
    }

    public boolean isFeatured() {
        return featured;
    }

    public void setFeatured(boolean featured) {
        this.featured = featured;
    }
    
    
    
    public Motor(int motorId, int brandId, int modelId, String motorName, Date dateStart, String color, double price, int fuelId, boolean present, String description, int quantity, String picture) {
        this.motorId = motorId;
        this.brandId = brandId;
        this.modelId = modelId;
        this.motorName = motorName;
        this.dateStart = dateStart;
        this.color = color;
        this.price = price;
        this.fuelId = fuelId;
        this.present = present;
        this.description = description;
        this.quantity = quantity;
        this.picture = picture;
    }

    public Motor(int motorId, int brandId, int modelId, String motorName, String color, double price, int fuelId, boolean present, String description, int quantity, String picture, Date dateStart, Brand brand, Model model, Fuel fuel) {
        this.motorId = motorId;
        this.brandId = brandId;
        this.modelId = modelId;
        this.motorName = motorName;
        this.color = color;
        this.price = price;
        this.fuelId = fuelId;
        this.present = present;
        this.description = description;
        this.quantity = quantity;
        this.picture = picture;
        this.dateStart = dateStart;
        this.brand = brand;
        this.model = model;
        this.fuel = fuel;
    }

    public int getMotorId() {
        return motorId;
    }

    public void setMotorId(int motorId) {
        this.motorId = motorId;
    }

    public int getBrandId() {
        return brandId;
    }

    public void setBrandId(int brandId) {
        this.brandId = brandId;
    }

    public int getModelId() {
        return modelId;
    }

    public void setModelId(int modelId) {
        this.modelId = modelId;
    }

    public String getMotorName() {
        return motorName;
    }

    public void setMotorName(String motorName) {
        this.motorName = motorName;
    }

    public String getColor() {
        return color;
    }

    public void setColor(String color) {
        this.color = color;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getFuelId() {
        return fuelId;
    }

    public void setFuelId(int fuelId) {
        this.fuelId = fuelId;
    }

    public boolean isPresent() {
        return present;
    }

    public void setPresent(boolean present) {
        this.present = present;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getPicture() {
        return picture;
    }

    public void setPicture(String picture) {
        this.picture = picture;
    }

    public Date getDateStart() {
        return dateStart;
    }

    public void setDateStart(Date dateStart) {
        this.dateStart = dateStart;
    }

    public Brand getBrand() {
        return brand;
    }

    public void setBrand(Brand brand) {
        this.brand = brand;
    }

    public Model getModel() {
        return model;
    }

    public void setModel(Model model) {
        this.model = model;
    }

    public Fuel getFuel() {
        return fuel;
    }

    public void setFuel(Fuel fuel) {
        this.fuel = fuel;
    }

    
}
