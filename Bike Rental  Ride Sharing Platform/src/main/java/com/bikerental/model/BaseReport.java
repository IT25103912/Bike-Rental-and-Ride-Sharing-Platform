package com.bikerental.model;

// Inheritance - RevenueReport saha RideReport dekam meken hadenawa
public abstract class BaseReport {
    private String reportId;
    private String type;
    private String generatedDate;

    public String getReportId() { return reportId; }
    public void setReportId(String reportId) { this.reportId = reportId; }

    public String getType() { return type; }
    public void setType(String type) { this.type = type; }

    public String getGeneratedDate() { return generatedDate; }
    public void setGeneratedDate(String generatedDate) { this.generatedDate = generatedDate; }

    // Abstract method eka - Anith classes walin meka liyanna oni
    public abstract void compile();
}