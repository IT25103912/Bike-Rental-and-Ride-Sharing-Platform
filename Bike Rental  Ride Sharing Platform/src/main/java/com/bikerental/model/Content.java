package com.bikerental.model;

// Inheritance - Review saha OwnerReply dekam meken hadenawa
public abstract class Content {
    private String contentId;
    private String authorId;
    private String timestamp;

    // Getters and Setters
    public String getContentId() { return contentId; }
    public void setContentId(String contentId) { this.contentId = contentId; }

    public String getAuthorId() { return authorId; }
    public void setAuthorId(String authorId) { this.authorId = authorId; }

    public String getTimestamp() { return timestamp; }
    public void setTimestamp(String timestamp) { this.timestamp = timestamp; }
}