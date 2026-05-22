package com.bikerental.model;

public class StandardBooking extends BikeBooking {

    private boolean hasExtraHelmet;
    private boolean hasRidingGloves;
    private boolean hasPhoneMount;

    public StandardBooking() {
        super();
    }

    public boolean isHasExtraHelmet() {
        return hasExtraHelmet;
    }

    public void setHasExtraHelmet(boolean hasExtraHelmet) {
        this.hasExtraHelmet = hasExtraHelmet;
    }

    public boolean isHasRidingGloves() {
        return hasRidingGloves;
    }

    public void setHasRidingGloves(boolean hasRidingGloves) {
        this.hasRidingGloves = hasRidingGloves;
    }

    public boolean isHasPhoneMount() {
        return hasPhoneMount;
    }

    public void setHasPhoneMount(boolean hasPhoneMount) {
        this.hasPhoneMount = hasPhoneMount;
    }

    @Override
    public double calculateTotal(double pricePerDay) {
        double total = getNumberOfDays() * pricePerDay;

        if (hasExtraHelmet) {
            total += 500.0;
        }
        if (hasRidingGloves) {
            total += 200.0;
        }
        if (hasPhoneMount) {
            total += 100.0;
        }

        return total;
    }

    public void cancel(String reason) {
        System.out.println("--------------------------------------------------");
        System.out.println("BOOKING CANCELLED BY CUSTOMER");
        System.out.println("Reason: " + reason);
        System.out.println("--------------------------------------------------");
    }
}
