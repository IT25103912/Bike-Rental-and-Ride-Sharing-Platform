package com.bikerental.dao;

import com.bikerental.util.FilePathUtil;
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.File;

public class ReportDAO {

    // ⭐ වැදගත්ම වෙනස: මෙතනදී අපි ගන්නේ ෆෝල්ඩර් එකේ පාර විතරයි
    // FilePathUtil.getPath("") දුන්නම data folder එකේ පාර ලැබෙනවා
    private static final String DATA_FOLDER = FilePathUtil.getPath("");

    public int getTotalUsers() {
        return countLines("users.txt");
    }

    public int getTotalBikes() {
        return countLines("bikes.txt");
    }

    public int getActiveRides() {
        int count = 0;
        // DATA_FOLDER එක පාවිච්චි කරලා පත් එක හදන විදිහ බලන්න
        String filePath = DATA_FOLDER + "bookings.txt";
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.contains("Active")) count++;
            }
        } catch (IOException e) {
            System.out.println("Error reading bookings.txt: " + e.getMessage());
        }
        return count;
    }

    public double getTotalRevenue() {
        double total = 0.0;
        String filePath = DATA_FOLDER + "payments.txt";
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",", -1);
                // ඔයාගේ payments.txt එකේ ඩේටා තියෙන පිළිවෙළ අනුව මේ index මාරු කරන්න
                if (data.length >= 4) { // අවම වශයෙන් පේළියක කෑලි 4ක්වත් තිබිය යුතුයි
                    try {
                        // සාමාන්‍යයෙන් amount එක තියෙන්නේ 1 හෝ 2 index එකේ
                        total += Double.parseDouble(data[1].trim());
                    } catch (NumberFormatException e) { }
                }
            }
        } catch (IOException e) {
            System.out.println("Error reading payments.txt: " + e.getMessage());
        }
        return total;
    }

    public int countLines(String fileName) {
        int lines = 0;
        String filePath = DATA_FOLDER + fileName;
        try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
            while (br.readLine() != null) lines++;
        } catch (IOException e) {
            System.out.println("Error reading " + fileName + ": " + e.getMessage());
        }
        return lines;
    }
}