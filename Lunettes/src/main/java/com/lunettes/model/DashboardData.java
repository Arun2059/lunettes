package com.lunettes.model;

import java.util.List;

public class DashboardData {
    private DashboardStats stats;
    private List<RecentOrder> recentOrders;

    // Constructors, Getters and Setters
    public DashboardData() {}

    public DashboardData(DashboardStats stats, List<RecentOrder> recentOrders) {
        this.stats = stats;
        this.recentOrders = recentOrders;
    }

    // Getters and Setters
    public DashboardStats getStats() {
        return stats;
    }

    public void setStats(DashboardStats stats) {
        this.stats = stats;
    }

    public List<RecentOrder> getRecentOrders() {
        return recentOrders;
    }

    public void setRecentOrders(List<RecentOrder> recentOrders) {
        this.recentOrders = recentOrders;
    }
}