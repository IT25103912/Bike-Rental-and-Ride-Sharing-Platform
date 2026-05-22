package com.bikerental.model;

import com.bikerental.interfaces.Cancellable;

public class GroupRideBooking extends BaseBooking implements Cancellable {

    @Override
    public double calculateTotal(double pricePerDay, int days, double extraPrice) {
        double baseFare = pricePerDay * days;

        double discountedFare = baseFare - (baseFare * 0.10);

        
        double total = discountedFare + extraPrice;

        this.setTotalFare(total);

        return total;
    }

    @Override
    public void cancel(String reason) {
        this.setStatus("Cancelled");
        System.out.println("Group Booking Cancelled. Reason: " + reason + " (Group penalty applies)");
    }
}
