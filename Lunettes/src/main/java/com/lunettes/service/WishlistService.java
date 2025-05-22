package com.lunettes.service;

import com.lunettes.model.Wishlist;
import com.lunettes.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class WishlistService {
    
    // Add product to wishlist
    public boolean addToWishlist(int userId, int productId) {
        try (Connection conn = DbConfig.getDbConnection()) {
            // Check if product already exists in wishlist
            if (isProductInWishlist(userId, productId)) {
                return false;
            }
            
            String sql = "INSERT INTO wishlist (user_id, product_id, added_at) VALUES (?, ?, ?)";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setTimestamp(3, new Timestamp(System.currentTimeMillis()));
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Remove product from wishlist
    public boolean removeFromWishlist(int userId, int productId) {
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "DELETE FROM wishlist WHERE user_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Check if product is in wishlist
    public boolean isProductInWishlist(int userId, int productId) {
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "SELECT COUNT(*) FROM wishlist WHERE user_id = ? AND product_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    // Get all wishlist items for a user
    public List<Wishlist> getUserWishlist(int userId) {
        List<Wishlist> wishlist = new ArrayList<>();
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "SELECT * FROM wishlist WHERE user_id = ? ORDER BY added_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                Wishlist item = new Wishlist();
                item.setId(rs.getInt("id"));
                item.setUserId(rs.getInt("user_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setAddedAt(rs.getTimestamp("added_at"));
                wishlist.add(item);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return wishlist;
    }
    
    // Get wishlist item count for a user
    public int getWishlistCount(int userId) {
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "SELECT COUNT(*) FROM wishlist WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    // Clear user's wishlist
    public boolean clearWishlist(int userId) {
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "DELETE FROM wishlist WHERE user_id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, userId);
            
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }
}