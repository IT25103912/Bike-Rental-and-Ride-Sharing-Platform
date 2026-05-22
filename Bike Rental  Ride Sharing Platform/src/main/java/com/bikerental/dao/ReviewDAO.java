package com.bikerental.dao;

import com.bikerental.model.Review;
import com.bikerental.util.FilePathUtil;

import java.io.*;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    // METHANATA OYAGE DATA FOLDER EKE PATH EKA DANNA!
    private static final String FILE_PATH = FilePathUtil.getPath("reviews.txt");

    // 1. CREATE - Aluth review ekak file ekata liyana method eka
    public void addReview(Review review) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH, true))) {
            // Format: reviewId, bookingId, authorId(Customer), bikeId, rating, comment, ownerReply, timestamp
            String line = review.getContentId() + "," + review.getBookingId() + "," +
                    review.getAuthorId() + "," + review.getBikeId() + "," +
                    review.getRating() + "," + review.getComment() + "," +
                    review.getOwnerReply() + "," + review.getTimestamp();
            bw.write(line);
            bw.newLine();
        } catch (IOException e) { e.printStackTrace(); }
    }

    // 2. READ - Bike ekakata adala reviews tika witarak thorala ganna method eka
    public List<Review> getReviewsByBike(String bikeId) {
        List<Review> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                // -1 damme anthimata thiyena OwnerReply eka his wunath array eka hariyata hadenna
                String[] data = line.split(",", -1);
                if (data.length >= 8 && data[3].equals(bikeId)) {
                    Review r = new Review();
                    r.setContentId(data[0]);
                    r.setBookingId(data[1]);
                    r.setAuthorId(data[2]);
                    r.setBikeId(data[3]);
                    r.setRating(Integer.parseInt(data[4]));
                    r.setComment(data[5]);
                    r.setOwnerReply(data[6]);
                    r.setTimestamp(data[7]);
                    list.add(r);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        return list;
    }

    // 3. READ - Customer kenekge okkoma reviews ganna method eka (My Reviews page ekata)
    public List<Review> getReviewsByUser(String userId) {
        List<Review> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",", -1);
                if (data.length >= 8 && data[2].equals(userId)) {
                    Review r = new Review();
                    r.setContentId(data[0]);
                    r.setBookingId(data[1]);
                    r.setAuthorId(data[2]);
                    r.setBikeId(data[3]);
                    r.setRating(Integer.parseInt(data[4]));
                    r.setComment(data[5]);
                    r.setOwnerReply(data[6]);
                    r.setTimestamp(data[7]);
                    list.add(r);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        return list;
    }

    // 4. READ (Admin) - System eke thiyena okkoma reviews ganna method eka
    public List<Review> getAllReviews() {
        List<Review> list = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",", -1);
                if (data.length >= 8) {
                    Review r = new Review();
                    r.setContentId(data[0]);
                    r.setBookingId(data[1]);
                    r.setAuthorId(data[2]);
                    r.setBikeId(data[3]);
                    r.setRating(Integer.parseInt(data[4]));
                    r.setComment(data[5]);
                    r.setOwnerReply(data[6]);
                    r.setTimestamp(data[7]);
                    list.add(r);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }
        return list;
    }

    // 5. UPDATE - Admin ge reply eka text file ekata update karana method eka (ALUTHIN DAMME!)
    public void updateReviewReply(String reviewId, String replyMessage) {
        List<String> lines = new ArrayList<>();

        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] data = line.split(",", -1);
                // Review ID eka match wenawada balanawa
                if (data.length >= 8 && data[0].equals(reviewId)) {
                    // index 6 kiyanne Owner Reply eka thiyena thana. Eka aluthin replace karanawa.
                    data[6] = replyMessage;

                    // Ayeth liyanna puluwan widihata array eka line ekak karanawa
                    String updatedLine = String.join(",", data);
                    lines.add(updatedLine);
                } else {
                    // Match wenne nathi ewa parana widihatama thiyanawa
                    lines.add(line);
                }
            }
        } catch (IOException e) { e.printStackTrace(); }

        // Update karapu loku list eka ayeth text file ekata liyanawa (Overwrite karanawa)
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(FILE_PATH))) {
            for (String l : lines) {
                bw.write(l);
                bw.newLine();
            }
        } catch (IOException e) { e.printStackTrace(); }
    }

    // 6. DELETE - Admin ta naraka reviews makanna method eka
    public void deleteReview(String reviewId) {
        List<String> lines = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(FILE_PATH))) {
            String line;
            while ((line = br.readLine()) != null) {
                // Makanna oni ID eka nemei nam witarak aluth list ekata danawa
                if (!line.startsWith(reviewId + ",")) {
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
