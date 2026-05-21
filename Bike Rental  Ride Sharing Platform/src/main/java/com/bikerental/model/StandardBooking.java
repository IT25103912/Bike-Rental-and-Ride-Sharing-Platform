package com.bikerental.model;

public class StandardBooking extends BikeBooking {

    // Add-on options (අමතර දේවල්)
    private boolean hasExtraHelmet;
    private boolean hasRidingGloves;
    private boolean hasPhoneMount;

    // No-argument constructor
    public StandardBooking() {
        super();
    }

    // Getters and Setters
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

    // *** OOP Polymorphism: Method Overriding ***
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

    // =========================================================
    // මෙන්න අලුතින් එකතු කරපු cancel Method එක (Error එක මැකෙන්නේ මේකෙන්)
    // =========================================================
    public void cancel(String reason) {
        // ඔයාගේ කමෙන්ට් එකේ විදිහට Console එකට ප්‍රින්ට් කරනවා
        System.out.println("--------------------------------------------------");
        System.out.println("BOOKING CANCELLED BY CUSTOMER");
        System.out.println("Reason: " + reason);
        System.out.println("--------------------------------------------------");
    }
}