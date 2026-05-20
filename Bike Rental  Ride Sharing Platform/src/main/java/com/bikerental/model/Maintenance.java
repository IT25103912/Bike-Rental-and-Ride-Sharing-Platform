package com.bikerental.model;

public class Maintenance {
    private String maintenanceId;
    private String bikeId;
    private String description;
    private double cost;
    private String date;

    // Default Constructor
    public Maintenance() {}

    // Constructor with parameters
    public Maintenance(String maintenanceId, String bikeId, String description, double cost, String date) {
        this.maintenanceId = maintenanceId;
        this.bikeId = bikeId;
        this.description = description;
        this.cost = cost;
        this.date = date;
    }

    // Getters and Setters (මේවා තමයි දත්ත ලබාගන්න සහ ඇතුළත් කරන්න පාවිච්චි කරන්නේ)
    public String getMaintenanceId() { return maintenanceId; }
    public void setMaintenanceId(String maintenanceId) { this.maintenanceId = maintenanceId; }

    public String getBikeId() { return bikeId; }
    public void setBikeId(String bikeId) { this.bikeId = bikeId; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getCost() { return cost; }
    public void setCost(double cost) { this.cost = cost; }

    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
}