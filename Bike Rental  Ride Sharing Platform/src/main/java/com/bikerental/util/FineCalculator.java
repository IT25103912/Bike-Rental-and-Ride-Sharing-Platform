package com.bikerental.util;

public class FineCalculator {

    // Encapsulation
    private static final double LATE_FEE_PER_DAY = 500.0;
    private static final double DAMAGE_FEE = 2000.0;


    public static double calculateLateFine(int daysLate) {
        if (daysLate <= 0) return 0.0;
        return daysLate * LATE_FEE_PER_DAY;
    }

    public static double calculateDamageFine() {
        return DAMAGE_FEE;
    }
}