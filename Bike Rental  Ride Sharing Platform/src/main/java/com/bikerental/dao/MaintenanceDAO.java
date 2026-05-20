package com.bikerental.dao;

import com.bikerental.model.Maintenance;
import com.bikerental.util.FilePathUtil;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class MaintenanceDAO {
    // අපි කලින් හදපු FilePathUtil එකෙන් path එක ගමු
    private static final String FILE_PATH = FilePathUtil.getPath("maintenance.txt");

    // 1. අලුත් නඩත්තු වාර්තාවක් සේව් කිරීම (Create)
    public void addMaintenanceRecord(Maintenance record) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            String data = record.getMaintenanceId() + "," +
                    record.getBikeId() + "," +
                    record.getDescription() + "," +
                    record.getCost() + "," +
                    record.getDate();
            bw.write(data);
            bw.newLine();
        } catch (IOException e) {
            System.out.println("Maintenance record save karද්දී අවුලක්: " + e.getMessage());
        }
    }

    // 2. සියලුම නඩත්තු වාර්තා කියවීම (Read)
    public List<Maintenance> getAllRecords() {
        List<Maintenance> records = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 5) {
                    records.add(new Maintenance(parts[0], parts[1], parts[2],
                            Double.parseDouble(parts[3]), parts[4]));
                }
            }
        } catch (IOException e) {
            System.out.println("Maintenance records kiyawද්දී අවුලක්: " + e.getMessage());
        }
        return records;
    }
}