package com.lunettes.model;

import java.sql.Timestamp;

public class Message {
    private int id;
    private int userId;
    private String imagePath;
    private String username;
    private String name;
    private String email;
    private String subject;
    private String message;
    private boolean isRead;
    private Timestamp createdAt;

    // Default constructor
    public Message() {}

    // Parameterized constructor
    public Message(int id, int userId, String imagePath, String username, String name,
                   String email, String subject, String message,
                   boolean isRead, Timestamp createdAt) {
        this.id = id;
        this.userId = userId;
        this.imagePath = imagePath;
        this.username = username;
        this.name = name;
        this.email = email;
        this.subject = subject;
        this.message = message;
        this.isRead = isRead;
        this.createdAt = createdAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getImagePath() {
        return imagePath;
    }
    public void setImagePath(String imagePath) {
        this.imagePath = imagePath;
    }

    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }
    public void setMessage(String message) {
        this.message = message;
    }

    public boolean isRead() {
        return isRead;
    }
    public void setRead(boolean isRead) {
        this.isRead = isRead;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}
