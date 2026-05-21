package com.bikerental.dao;

import com.bikerental.model.BaseBooking;
import com.bikerental.model.StandardBooking;
import com.bikerental.util.FilePathUtil;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    private static final String FILE_PATH = FilePathUtil.getPath("bookings.txt");


    public void addBooking(BaseBooking booking) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            String line = booking.getBookingId() + "," +
                    booking.getCustomerId() + "," +
                    booking.getBikeId() + "," +
                    booking.getStatus();
            bw.write(line);
            bw.newLine();
            System.out.println("DEBUG: Booking saved to file: " + line);
        } catch (IOException e) {
            System.err.println("Error saving booking: " + e.getMessage());
        }
    }

      public List<BaseBooking> getBookingsByCustomer(String customerId) {
        List<BaseBooking> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] data = line.split(",");
                if (data.length >= 4 && data[1].trim().equalsIgnoreCase(customerId.trim())) {
                    StandardBooking b = new StandardBooking();
                    b.setBookingId(data[0].trim());
                    b.setCustomerId(data[1].trim());
                    b.setBikeId(data[2].trim());
                    b.setStatus(data[3].trim());
                    list.add(b);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        return list;
    }


    public BaseBooking getBookingById(String bookingId) {
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length >= 4 && data[0].trim().equalsIgnoreCase(bookingId.trim())) {
                    StandardBooking b = new StandardBooking();
                    b.setBookingId(data[0].trim());
                    b.setCustomerId(data[1].trim());
                    b.setBikeId(data[2].trim());
                    b.setStatus(data[3].trim());
                    return b;
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        return null;
    }


    public void updateBookingStatus(String bookingId, String newStatus) {
        List<String> lines = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] data = line.split(",");
                if (data.length >= 4 && data[0].trim().equalsIgnoreCase(bookingId.trim())) {
                    lines.add(data[0] + "," + data[1] + "," + data[2] + "," + newStatus);
                } else {
                    lines.add(line);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (String l : lines) {
                bw.write(l);
                bw.newLine();
            }
        } catch (IOException e) { e.printStackTrace(); }
    }
}