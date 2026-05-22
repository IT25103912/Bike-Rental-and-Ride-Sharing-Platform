package com.bikerental.model;

// Inheritance - Payment and Fine
public abstract class Transaction {
    private String transactionId;
    private double amount;
    private String timestamp;

    // Getters and Setters (Encapsulation)
    public String getTransactionId() { return transactionId; }
    public void setTransactionId(String transactionId) { this.transactionId = transactionId; }

    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }

    public String getTimestamp() { return timestamp; }
    public void setTimestamp(String timestamp) { this.timestamp = timestamp; }
}