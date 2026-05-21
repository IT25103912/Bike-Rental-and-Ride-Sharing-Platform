package com.bikerental.dao;

import com.bikerental.util.FilePathUtil;
import java.io.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

public class LogDAO {
    private static final String LOG_FILE = FilePathUtil.getPath("logs.txt");

    // 📝 සිදුවීමක් ලොග් කරන මෙතඩ් එක
    public void recordLog(String userEmail, String action) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(LOG_FILE, true))) {
            String timestamp = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            // Format: Timestamp | User | Action
            bw.write(timestamp + " | " + userEmail + " | " + action);
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 📖 ඇඩ්මින් පැනල් එකට ලොග්ස් ටික කියවන මෙතඩ් එක
    public List<String> getAllLogs() {
        List<String> logs = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(LOG_FILE))) {
            String line;
            while ((line = br.readLine()) != null) {
                logs.add(0, line); // අලුත්ම ලොග්ස් ටික උඩටම ගන්නවා
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return logs;
    }
}