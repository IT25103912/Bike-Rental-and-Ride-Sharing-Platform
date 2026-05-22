package com.bikerental.model;

import com.bikerental.interfaces.Exportable;

// Inheritance (BaseReport) saha Polymorphism (Exportable) dekama pawichi wenawa
public class RevenueReport extends BaseReport implements Exportable {

    // Encapsulation - Report data private karala thiyenne
    private double totalRevenue;
    private int totalTransactions;

    // ✅ අලුතින් එකතු කරපු variables දෙක
    private double totalMaintenanceCost;
    private double netProfit;

    public double getTotalRevenue() { return totalRevenue; }
    public void setTotalRevenue(double totalRevenue) { this.totalRevenue = totalRevenue; }

    public int getTotalTransactions() { return totalTransactions; }
    public void setTotalTransactions(int totalTransactions) { this.totalTransactions = totalTransactions; }

    // ✅ අලුතින් එකතු කරපු Getters and Setters
    public double getTotalMaintenanceCost() { return totalMaintenanceCost; }
    public void setTotalMaintenanceCost(double totalMaintenanceCost) { this.totalMaintenanceCost = totalMaintenanceCost; }

    public double getNetProfit() { return netProfit; }
    public void setNetProfit(double netProfit) { this.netProfit = netProfit; }

    @Override
    public void compile() {
        System.out.println("Compiling revenue data from payments.txt...");
    }

    @Override
    public String export(String format) {
        if ("CSV".equalsIgnoreCase(format)) {
            // CSV එකටත් අලුත් දත්ත දෙක එකතු කළා
            return getReportId() + "," + getType() + "," + getGeneratedDate() + "," + totalRevenue + "," + totalMaintenanceCost + "," + netProfit + "," + totalTransactions;
        } else {
            // ✅ Text file එකට ලියන විදිහ ලස්සනට, පේළියෙන් පේළිය හැදුවා
            return "Report ID: " + getReportId() + " | Type: " + getType() + "\n" +
                    "--------------------------------------------------\n" +
                    "Total Rental Revenue   : Rs. " + String.format("%.2f", totalRevenue) + "\n" +
                    "Total Maintenance Cost : Rs. " + String.format("%.2f", totalMaintenanceCost) + "\n" +
                    "Net Profit             : Rs. " + String.format("%.2f", netProfit) + "\n" +
                    "--------------------------------------------------\n";
        }
    }
}