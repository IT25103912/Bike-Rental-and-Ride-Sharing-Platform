package com.bikerental.model;

public class BikeBooking extends BaseBooking {

    // ප්‍රධාන variables ටික
    private String bookingId;
    private String customerId;
    private String bikeId;
    private String status;
    private int numberOfDays;

    // Default Constructor
    public BikeBooking() {
        super();
    }

    // Getters and Setters
    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getBikeId() { return bikeId; }
    public void setBikeId(String bikeId) { this.bikeId = bikeId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public int getNumberOfDays() { return numberOfDays; }
    public void setNumberOfDays(int numberOfDays) { this.numberOfDays = numberOfDays; }

    // =========================================================
    // 1. Method Overriding (BaseBooking එකෙන් ඉල්ලපු Abstract Method එක)
    // මේකෙන් තමයි ඔය ඇවිත් තියෙන රතු පාට Error එක මැකිලා යන්නේ!
    // =========================================================
    @Override
    public double calculateTotal(double price, int days, double extraCharge) {
        return (price * days) + extraCharge;
    }

    // =========================================================
    // 2. Method Overloading (අපි StandardBooking එකට හදාගත්ත Method එක)
    // =========================================================
    public double calculateTotal(double pricePerDay) {
        return this.numberOfDays * pricePerDay;
    }
}