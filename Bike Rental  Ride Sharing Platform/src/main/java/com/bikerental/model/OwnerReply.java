package com.bikerental.model;

import com.bikerental.interfaces.Moderatable;

public class OwnerReply extends Content implements Moderatable {
    private String parentReviewId; // Mon review ekatada reply kale kiyala hoyaganna
    private String replyText;

    public String getParentReviewId() { return parentReviewId; }
    public void setParentReviewId(String parentReviewId) { this.parentReviewId = parentReviewId; }

    public String getReplyText() { return replyText; }
    public void setReplyText(String replyText) { this.replyText = replyText; }

    @Override
    public void flag(String reason) {
        System.out.println("Owner reply flagged: " + reason);
    }

    @Override
    public void remove() {
        System.out.println("Owner reply deleted.");
    }
}