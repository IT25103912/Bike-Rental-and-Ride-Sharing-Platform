package com.bikerental.model;

import com.bikerental.interfaces.Moderatable;

// Inheritance (Content) saha Polymorphism (Moderatable) dekama thiyenawa
public class Review extends Content implements Moderatable {
    private String bookingId;
    private String bikeId;
    private int rating;
    private String comment;
    private String ownerReply;

    public String getBookingId() { return bookingId; }
    public void setBookingId(String bookingId) { this.bookingId = bookingId; }

    public String getBikeId() { return bikeId; }
    public void setBikeId(String bikeId) { this.bikeId = bikeId; }

    public int getRating() { return rating; }

    // *** Encapsulation Magic Eka ***
    // Rating eka 1th 5th athara witarai denna puluwan!
    public void setRating(int rating) {
        if (rating >= 1 && rating <= 5) {
            this.rating = rating;
        } else {
            throw new IllegalArgumentException("Rating must be between 1 and 5");
        }
    }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public String getOwnerReply() { return ownerReply; }
    public void setOwnerReply(String ownerReply) { this.ownerReply = ownerReply; }

    @Override
    public void flag(String reason) {
        System.out.println("Review " + getContentId() + " flagged: " + reason);
    }

    @Override
    public void remove() {
        System.out.println("Review " + getContentId() + " deleted by admin.");
    }
}