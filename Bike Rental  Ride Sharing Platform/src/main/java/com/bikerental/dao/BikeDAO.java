package com.bikerental.dao;

import com.bikerental.model.Bike;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class BikeDAO {

    // METHANATA OYAGE COMPUTER EKE BIKES.TXT THIYENA HARI PATH EKA DANNA!
    // (Mathaka athuwa ara 'Bike' kiyana nama hariyata thiyenawada kiyala balanna)
    private static final String FILE_PATH = "C:\\Users\\Sachindu\\Desktop\\Bike Rental  Ride Sharing Platform\\src\\main\\webapp\\data\\bikes.txt";

    // 1. Aluth Bike ekak text file ekata save karana eka (Create)
    public void addBike(Bike bike) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            String bikeData = bike.getBikeId() + "," + bike.getBrand() + "," + bike.getModel() + "," +
                    bike.getPricePerDay() + "," + bike.isAvailable() + "," + bike.getOwnerId();
            bw.write(bikeData);
            bw.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 2. Text file eke thiyena bikes okkoma list ekakata ganna eka (Read)
    public List<Bike> getAllBikes() {
        List<Bike> bikeList = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",");
                if (data.length == 6) {
                    Bike bike = new Bike();
                    bike.setBikeId(data[0]);
                    bike.setBrand(data[1]);
                    bike.setModel(data[2]);
                    bike.setPricePerDay(Double.parseDouble(data[3]));
                    bike.setAvailable(Boolean.parseBoolean(data[4]));
                    bike.setOwnerId(data[5]);
                    bikeList.add(bike);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return bikeList;
    }

    // 3. Bike ekak text file eken makala daana eka (Delete)
    public void deleteBike(String bikeId) {
        List<Bike> allBikes = getAllBikes();

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Bike b : allBikes) {
                if (!b.getBikeId().equals(bikeId)) {
                    String bikeData = b.getBikeId() + "," + b.getBrand() + "," + b.getModel() + "," +
                            b.getPricePerDay() + "," + b.isAvailable() + "," + b.getOwnerId();
                    bw.write(bikeData);
                    bw.newLine();
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // 4. Bike ekaka status eka wenas karana eka (Update) - RENT KARANA EKA
    public void updateBikeStatus(String bikeId, boolean isAvailable) {
        List<Bike> allBikes = getAllBikes();

        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (Bike b : allBikes) {
                // Apita oni ID eka thiyena bike eka nam, eke status eka aluth ekata wenas karanawa
                if (b.getBikeId().equals(bikeId)) {
                    b.setAvailable(isAvailable);
                }
                // Ayeth file ekata liyanawa
                String bikeData = b.getBikeId() + "," + b.getBrand() + "," + b.getModel() + "," +
                        b.getPricePerDay() + "," + b.isAvailable() + "," + b.getOwnerId();
                bw.write(bikeData);
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}