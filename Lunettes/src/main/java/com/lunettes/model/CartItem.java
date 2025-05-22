package com.lunettes.model;

import java.sql.Timestamp;

public class CartItem {
    private int id;
    private int cartId;
    private Product product;
    private int quantity;
    private Timestamp addedAt;

    // Constructors
    public CartItem() {
        this.addedAt = new Timestamp(System.currentTimeMillis());
    }

    public CartItem(int cartId, Product product, int quantity) {
        this();
        this.cartId = cartId;
        this.product = product;
        this.quantity = quantity;
    }

    public CartItem(int id, int cartId, Product product, int quantity, Timestamp addedAt) {
        this.id = id;
        this.cartId = cartId;
        this.product = product;
        this.quantity = quantity;
        this.addedAt = addedAt;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getProductId() {
        return product != null ? product.getId() : 0;
    }
    public void setProductId(int id) {
        this.id = id;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Timestamp getAddedAt() {
        return addedAt;
    }

    public void setAddedAt(Timestamp addedAt) {
        this.addedAt = addedAt;
    }

    // Business logic methods
    public double getSubtotal() {
        return product != null ? product.getPrice() * quantity : 0;
    }

    public void increaseQuantity(int amount) {
        if (amount > 0) {
            this.quantity += amount;
        }
    }

    public void decreaseQuantity(int amount) {
        if (amount > 0 && this.quantity >= amount) {
            this.quantity -= amount;
        }
    }

    @Override
    public String toString() {
        return "CartItem{" +
                "id=" + id +
                ", cartId=" + cartId +
                ", product=" + (product != null ? product.getName() : "null") +
                ", quantity=" + quantity +
                ", addedAt=" + addedAt +
                '}';
    }
}