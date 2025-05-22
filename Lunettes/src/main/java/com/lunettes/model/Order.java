package com.lunettes.model;
import java.sql.Timestamp;

public class Order {
    private int orderId;
    private int cartId;
    private int userId;
    private String phone;
    private String deliveryAddress;
    private String city;
    private String zipCode;
    private String country;
    private String paymentMethod;
    private boolean isPaid;
    private boolean isDelivered;
    private String deliveryLocation;
    private double totalPrice;
    private double discountPrice;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    // Constructors
    public Order() {}

    public Order(int orderId, int cartId, int userId, String phone, String deliveryAddress, String city,
                 String zipCode, String country, String paymentMethod, boolean isPaid, boolean isDelivered,
                 String deliveryLocation, double totalPrice, double discountPrice,
                 Timestamp createdAt, Timestamp updatedAt) {
        this.orderId = orderId;
        this.cartId = cartId;
        this.userId = userId;
        this.phone = phone;
        this.deliveryAddress = deliveryAddress;
        this.city = city;
        this.zipCode = zipCode;
        this.country = country;
        this.paymentMethod = paymentMethod;
        this.isPaid = isPaid;
        this.isDelivered = isDelivered;
        this.deliveryLocation = deliveryLocation;
        this.totalPrice = totalPrice;
        this.discountPrice = discountPrice;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    // Getters and Setters
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCartId() {
        return cartId;
    }
    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public int getUserId() {
        return userId;
    }
    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getPhone() {
        return phone;
    }
    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }
    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getCity() {
        return city;
    }
    public void setCity(String city) {
        this.city = city;
    }

    public String getZipCode() {
        return zipCode;
    }
    public void setZipCode(String zipCode) {
        this.zipCode = zipCode;
    }

    public String getCountry() {
        return country;
    }
    public void setCountry(String country) {
        this.country = country;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }
    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public boolean isPaid() {
        return isPaid;
    }
    public void setPaid(boolean paid) {
        isPaid = paid;
    }

    public boolean isDelivered() {
        return isDelivered;
    }
    public void setDelivered(boolean delivered) {
        isDelivered = delivered;
    }

    public String getDeliveryLocation() {
        return deliveryLocation;
    }
    public void setDeliveryLocation(String deliveryLocation) {
        this.deliveryLocation = deliveryLocation;
    }

    public double getTotalPrice() {
        return totalPrice;
    }
    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public double getDiscountPrice() {
        return discountPrice;
    }
    public void setDiscountPrice(double discountPrice) {
        this.discountPrice = discountPrice;
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
}
