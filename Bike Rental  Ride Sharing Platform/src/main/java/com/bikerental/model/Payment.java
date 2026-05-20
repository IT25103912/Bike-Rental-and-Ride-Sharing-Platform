    package com.bikerental.model;

import com.bikerental.interfaces.Payable;

// Inheritance and Polymorphism
public class Payment extends Transaction implements Payable {
    private String bookingId;
    private String method; // Card, Cash
    private String status; // Completed, Pending

    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getMethod() { return method; }
    public void setMethod(String method) { this.method = method; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    @Override
    public void process() {
        // Polymorphism logic
        this.status = "Completed";
        System.out.println("Processing " + method + " payment of Rs." + getAmount());
    }
}