package com.lunettes.model;

public class DashboardStats {
    private int totalUsers;
    private double totalSales;
    private int totalOrders;
    private int newCustomers;
    private int inventoryAlerts;
    private double monthlySalesChange;
    private double monthlyOrdersChange;
    private double monthlyCustomersChange;

    // Constructors, Getters and Setters
    public DashboardStats() {}

    // Getters and Setters
    public int getTotalUsers() {
        return totalUsers;
    }

    public void setTotalUsers(int totalUsers) {
        this.totalUsers = totalUsers;
    }

    public double getTotalSales() {
        return totalSales;
    }

    public void setTotalSales(double totalSales) {
        this.totalSales = totalSales;
    }

    public int getTotalOrders() {
        return totalOrders;
    }

    public void setTotalOrders(int totalOrders) {
        this.totalOrders = totalOrders;
    }

    public int getNewCustomers() {
        return newCustomers;
    }

    public void setNewCustomers(int newCustomers) {
        this.newCustomers = newCustomers;
    }

    public int getInventoryAlerts() {
        return inventoryAlerts;
    }

    public void setInventoryAlerts(int inventoryAlerts) {
        this.inventoryAlerts = inventoryAlerts;
    }

    public double getMonthlySalesChange() {
        return monthlySalesChange;
    }

    public void setMonthlySalesChange(double monthlySalesChange) {
        this.monthlySalesChange = monthlySalesChange;
    }

    public double getMonthlyOrdersChange() {
        return monthlyOrdersChange;
    }

    public void setMonthlyOrdersChange(double monthlyOrdersChange) {
        this.monthlyOrdersChange = monthlyOrdersChange;
    }

    public double getMonthlyCustomersChange() {
        return monthlyCustomersChange;
    }

    public void setMonthlyCustomersChange(double monthlyCustomersChange) {
        this.monthlyCustomersChange = monthlyCustomersChange;
    }
}