package com.bikerental.dao;

import com.bikerental.model.Admin;
import com.bikerental.model.Customer;
import com.bikerental.model.Person;
import com.bikerental.util.FilePathUtil;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {

    private static final String FILE_PATH = FilePathUtil.getPath("users.txt");

    // 1. REGISTER - දත්ත ලියද්දී කොමා නිවැරදිව තැබීම
    public void registerUser(Person user, String password) {
        try (FileWriter fw = new FileWriter(FILE_PATH, true);
             BufferedWriter bw = new BufferedWriter(fw);
             PrintWriter out = new PrintWriter(bw)) {

            String line = user.getId().trim() + "," +
                    user.getName().trim() + "," +
                    user.getEmail().trim() + "," +
                    password.trim() + "," +
                    user.getRole().trim();

            out.println(line);
            out.flush();
            System.out.println("DEBUG: Successfully registered: " + user.getEmail());

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 2. LOGIN - පේළියෙන් පේළිය නිවැරදිව පරීක්ෂා කිරීම
    public Person loginUser(String email, String password) {

        File file = new File(FILE_PATH);
        System.out.println("DEBUG: File exists: " + file.exists() + " | Path: " + FILE_PATH);
        if (!file.exists()) return null;

        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;

                String[] data = line.split(",");
                if (data.length >= 5) {
                    String fEmail = data[2].trim();
                    String fPassword = data[3].trim();

                    if (fEmail.equalsIgnoreCase(email.trim()) && fPassword.equals(password.trim())) {
                        String fRole = data[4].trim();
                        Person p = fRole.equalsIgnoreCase("Admin") ? new Admin() : new Customer();

                        p.setId(data[0].trim());
                        p.setName(data[1].trim());
                        p.setEmail(fEmail);
                        p.setPassword(fPassword);
                        p.setRole(fRole);

                        System.out.println("DEBUG: Login Success for: " + fEmail + " as " + fRole);
                        return p;
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("DEBUG: Login Failed. Email or Password mismatch.");
        return null;
    }

    // 3. UPDATE - දත්ත Update කිරීමේදී අනුපිළිවෙළ ආරක්ෂා කිරීම
    public void updateUser(Person updatedUser) {
        List<String> lines = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] data = line.split(",");
                // ID එකෙන් සොයා ගැනීම වඩාත් නිවැරදි වේ
                if (data.length >= 5 && data[0].trim().equals(updatedUser.getId().trim())) {
                    String updatedLine = updatedUser.getId().trim() + "," +
                            updatedUser.getName().trim() + "," +
                            updatedUser.getEmail().trim() + "," +
                            updatedUser.getPassword().trim() + "," +
                            updatedUser.getRole().trim();
                    lines.add(updatedLine);
                } else {
                    lines.add(line);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        writeAllLines(lines);
    }

    // 4. READ ALL
    public List<Person> getAllUsers() {
        List<Person> userList = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] data = line.split(",");
                if (data.length >= 5) {
                    Person p = data[4].trim().equalsIgnoreCase("Admin") ? new Admin() : new Customer();
                    p.setId(data[0].trim());
                    p.setName(data[1].trim());
                    p.setEmail(data[2].trim());
                    p.setPassword(data[3].trim());
                    p.setRole(data[4].trim());
                    userList.add(p);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        return userList;
    }

    // 5. DELETE
    public void deleteUser(String userId) {
        List<String> lines = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                if (line.trim().isEmpty()) continue;
                String[] data = line.split(",");
                if (data.length >= 5 && !data[0].trim().equals(userId.trim())) {
                    lines.add(line);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        writeAllLines(lines);
    }

    private void writeAllLines(List<String> lines) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (String l : lines) {
                bw.write(l);
                bw.newLine();
            }
            bw.flush();
        } catch (IOException e) { e.printStackTrace(); }
    }
}