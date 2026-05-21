package com.bikerental.model;

import com.bikerental.interfaces.Cancellable;

public class GroupRideBooking extends BaseBooking implements Cancellable {

    @Override
    public double calculateTotal(double pricePerDay, int days, double extraPrice) {
        // මූලික ගාණ හදනවා
        double baseFare = pricePerDay * days;

        // Group ride එකක් නිසා Base fare එකෙන් 10% ක Discount එකක් දෙනවා
        double discountedFare = baseFare - (baseFare * 0.10);

        // Discount එක දුන්නට පස්සේ අමතර දේවල් වල ගාණ (හෙල්මට්) එකතු කරනවා
        double total = discountedFare + extraPrice;

        // BaseBooking එකේ method එක Call කරලා අගය සේව් කරනවා
        this.setTotalFare(total);

        return total;
    }

    @Override
    public void cancel(String reason) {
        this.setStatus("Cancelled");
        System.out.println("Group Booking Cancelled. Reason: " + reason + " (Group penalty applies)");
    }
}