package com.lunettes.service;

import com.lunettes.model.*;
import com.lunettes.config.DbConfig;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DashboardService {

    public DashboardData getDashboardOverview() throws SQLException, ClassNotFoundException {
        try (Connection conn = DbConfig.getDbConnection()) {
            DashboardStats stats = getDashboardStats(conn);
            List<RecentOrder> recentOrders = getRecentOrders(conn);
            return new DashboardData(stats, recentOrders);
        }
    }

    private DashboardStats getDashboardStats(Connection conn) throws SQLException {
        DashboardStats stats = new DashboardStats();
        
        // Get total users (admin + regular users)
        String usersQuery = "SELECT COUNT(*) as total_users FROM users";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(usersQuery)) {
            if (rs.next()) {
                stats.setTotalUsers(rs.getInt("total_users"));
            }
        }
        
        // Get total sales
        String salesQuery = "SELECT SUM(total_price) as total_sales FROM orders WHERE is_paid = true";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(salesQuery)) {
            if (rs.next()) {
                stats.setTotalSales(rs.getDouble("total_sales"));
            }
        }
        
        // Get total orders
        String ordersQuery = "SELECT COUNT(*) as total_orders FROM orders";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(ordersQuery)) {
            if (rs.next()) {
                stats.setTotalOrders(rs.getInt("total_orders"));
            }
        }
        
        // Get new customers (this month)
        String newCustomersQuery = """
            SELECT COUNT(*) as new_customers 
            FROM users 
            WHERE created_at >= DATE_FORMAT(NOW(), '%Y-%m-01')
        """;
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(newCustomersQuery)) {
            if (rs.next()) {
                stats.setNewCustomers(rs.getInt("new_customers"));
            }
        }
        
        // Get inventory alerts (products with low quantity)
        String inventoryQuery = "SELECT COUNT(*) as low_stock FROM products WHERE quantity < 10";
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(inventoryQuery)) {
            if (rs.next()) {
                stats.setInventoryAlerts(rs.getInt("low_stock"));
            }
        }
        
        // Calculate monthly changes (simplified - in a real app you'd compare with previous month)
        stats.setMonthlySalesChange(12.0); // 12% increase
        stats.setMonthlyOrdersChange(8.0); // 8% increase
        stats.setMonthlyCustomersChange(3.0); // 3% increase
        
        return stats;
    }

    private List<RecentOrder> getRecentOrders(Connection conn) throws SQLException {
        List<RecentOrder> orders = new ArrayList<>();
        
        String query = """
            SELECT o.order_id, CONCAT(u.first_name, ' ', u.last_name) as customer_name, 
                   o.created_at as order_date, o.total_price as amount, 
                   CASE 
                     WHEN o.is_delivered THEN 'Completed'
                     WHEN o.is_paid AND NOT o.is_delivered THEN 'Pending'
                     WHEN NOT o.is_paid THEN 'Canceled'
                   END as status
            FROM orders o
            JOIN users u ON o.user_id = u.id
            ORDER BY o.created_at DESC
            LIMIT 5
        """;
        
        try (Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(query)) {
            while (rs.next()) {
                RecentOrder order = new RecentOrder(
                    "#GL-" + rs.getInt("order_id"),
                    rs.getString("customer_name"),
                    rs.getTimestamp("order_date"),
                    rs.getDouble("amount"),
                    rs.getString("status")
                );
                orders.add(order);
            }
        }
        
        return orders;
    }
}