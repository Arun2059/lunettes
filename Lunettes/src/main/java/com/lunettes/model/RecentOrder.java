package com.lunettes.model;

import java.sql.Timestamp;

public class RecentOrder {
    private String orderId;
    private String customerName;
    private Timestamp orderDate;
    private double amount;
    private String status;

    // Constructors, Getters and Setters
    public RecentOrder() {}

    public RecentOrder(String orderId, String customerName, Timestamp orderDate, double amount, String status) {
        this.orderId = orderId;
        this.customerName = customerName;
        this.orderDate = orderDate;
        this.amount = amount;
        this.status = status;
    }

    // Getters and Setters
    public String getOrderId() {
        return orderId;
    }

    public void setOrderId(String orderId) {
        this.orderId = orderId;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
}