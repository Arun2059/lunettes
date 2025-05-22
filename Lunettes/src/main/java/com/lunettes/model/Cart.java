package com.lunettes.model;

import java.sql.Timestamp;

public class Cart {
    private int id;
    private int userId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private boolean isOrdered;

    // Constructors
    public Cart() {}

    public Cart(int id, int userId, Timestamp createdAt, Timestamp updatedAt, boolean isOrdered) {
        this.id = id;
        this.userId = userId;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
        this.isOrdered = isOrdered;
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

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }

    public boolean isOrdered() {
        return isOrdered;
    }

    public void setOrdered(boolean isOrdered) {
        this.isOrdered = isOrdered;
    }
}
