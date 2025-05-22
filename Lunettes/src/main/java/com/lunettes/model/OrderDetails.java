package com.lunettes.model;

import java.util.List;

public class OrderDetails {
    private Order order;
    private Cart cart;
    private List<CartItem> items;
    private double subtotal;
    private double totalDiscount;
    private double grandTotal;

    // Constructors
    public OrderDetails() {}

    public OrderDetails(Order order, Cart cart, List<CartItem> items) {
        this.order = order;
        this.cart = cart;
        this.items = items;
        calculateTotals();
    }

    // Getters and Setters
    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    public List<CartItem> getItems() {
        return items;
    }

    public void setItems(List<CartItem> items) {
        this.items = items;
        calculateTotals();
    }

    public double getSubtotal() {
        return subtotal;
    }

    public double getTotalDiscount() {
        return totalDiscount;
    }

    public double getGrandTotal() {
        return grandTotal;
    }

    // Helper method to calculate totals
    private void calculateTotals() {
        this.subtotal = items.stream()
            .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
            .sum();
        
        this.totalDiscount = items.stream()
            .mapToDouble(item -> (item.getProduct().getPrice() - order.getDiscountPrice()) * item.getQuantity())
            .sum();
            
        this.grandTotal = subtotal - totalDiscount;
    }
}