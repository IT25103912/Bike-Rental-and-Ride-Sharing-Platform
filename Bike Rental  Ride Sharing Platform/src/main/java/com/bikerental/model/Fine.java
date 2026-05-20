package com.bikerental.model;

public class Fine extends Transaction {
    private String bookingId;
    private String reason;
    private String status;

    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    // (Polymorphism/Override)
    @Override
    public String toString() {
        return getTransactionId() + "," + getAmount() + "," + getTimestamp() + "," +
                bookingId + "," + reason + "," + status;
    }
}