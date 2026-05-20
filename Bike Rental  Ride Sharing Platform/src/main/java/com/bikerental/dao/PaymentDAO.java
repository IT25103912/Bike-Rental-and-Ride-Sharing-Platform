package com.bikerental.dao;

import com.bikerental.model.Fine;
import com.bikerental.model.Payment;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class PaymentDAO {


    private static final String PAYMENT_FILE = "C:\\Users\\Sachindu\\Desktop\\Bike Rental  Ride Sharing Platform\\src\\main\\webapp\\data\\payments.txt";
    private static final String FINE_FILE = "C:\\Users\\Sachindu\\Desktop\\Bike Rental  Ride Sharing Platform\\src\\main\\webapp\\data\\fines.txt";


    public void recordPayment(Payment payment) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(PAYMENT_FILE, true))) {
            // Format: TransactionID, Amount, Timestamp, BookingID, Method, Status
            String line = payment.getTransactionId() + "," + payment.getAmount() + "," +
                    payment.getTimestamp() + "," + payment.getBookingId() + "," +
                    payment.getMethod() + "," + payment.getStatus();
            bw.write(line);
            bw.newLine();
            System.out.println("Payment recorded successfully!");
        } catch (IOException e) { e.printStackTrace(); }
    }


    public void recordFine(Fine fine) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FINE_FILE, true))) {

            bw.write(fine.toString());
            bw.newLine();
            System.out.println("Fine recorded successfully!");
        } catch (IOException e) { e.printStackTrace(); }
    }


    public List<Payment> getAllPayments() {
        List<Payment> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(PAYMENT_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if(data.length >= 6) {
                    Payment p = new Payment();
                    p.setTransactionId(data[0]);
                    p.setAmount(Double.parseDouble(data[1]));
                    p.setTimestamp(data[2]);
                    p.setBookingId(data[3]);
                    p.setMethod(data[4]);
                    p.setStatus(data[5]);
                    list.add(p);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        return list;
    }


    public void deletePayment(String txnId) {
        List<String> lines = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(PAYMENT_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Makanna oni ID eka nemei nam witarak aluth list ekata danawa
                if (!line.startsWith(txnId + ",")) {
                    lines.add(line);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(PAYMENT_FILE))) {
            for (String l : lines) {
                bw.write(l);
                bw.newLine();
            }
        } catch (IOException e) { e.printStackTrace(); }
    }



}