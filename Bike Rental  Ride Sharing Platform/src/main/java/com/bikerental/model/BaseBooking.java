package com.bikerental.model;

public abstract class BaseBooking {
    private String bookingId;
    private String customerId;
    private String bikeId;
    private String status; // Pending, Active, Completed, Cancelled


    private int noOfDays;
    private boolean extraHelmet;
    private double totalFare;

    // Getters and Setters
    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getBikeId() { return bikeId; }
    public void setBikeId(String bikeId) { this.bikeId = bikeId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getNoOfDays() { return noOfDays; }
    public void setNoOfDays(int noOfDays) { this.noOfDays = noOfDays; }

    public boolean hasExtraHelmet() { return extraHelmet; }
    public void setExtraHelmet(boolean extraHelmet) { this.extraHelmet = extraHelmet; }

    public double getTotalFare() { return totalFare; }
    public void setTotalFare(double totalFare) { this.totalFare = totalFare; }


    public abstract double calculateTotal(double pricePerDay, int days, double extraPrice);
}