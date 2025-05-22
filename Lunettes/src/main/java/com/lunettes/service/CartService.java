package com.lunettes.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.lunettes.config.DbConfig;
import com.lunettes.model.Cart;
import com.lunettes.model.CartItem;
import com.lunettes.model.Product;

public class CartService {

    // Add item to cart with transaction handling
    public boolean addToCart(int userId, int productId, int quantity) throws ClassNotFoundException {
        try (Connection conn = DbConfig.getDbConnection()) {
            conn.setAutoCommit(false);

            // 1. Get or create cart
            int cartId = getOrCreateCart(userId, conn);
            
            // 2. Check if product exists and has enough stock
            Product product = getProductById(productId, conn);
            if (product == null || product.getQuantity() < quantity) {
                conn.rollback();
                return false;
            }
            
            // 3. Check if item already exists in cart
            CartItem existingItem = getCartItem(cartId, productId, conn);
            if (existingItem != null) {
                // Update existing item
                if (!updateCartItemQuantity(existingItem.getId(), existingItem.getQuantity() + quantity, conn)) {
                    conn.rollback();
                    return false;
                }
            } else {
                // Add new item
                if (!insertCartItem(cartId, productId, quantity, conn)) {
                    conn.rollback();
                    return false;
                }
            }

            // 4. Update product stock
            if (!decreaseProductStock(productId, quantity, conn)) {
                conn.rollback();
                return false;
            }

            // 5. Update cart timestamp
            updateCartTimestamp(cartId, conn);

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Get cart items with full product details
    public List<CartItem> getCartItemsForUser(int userId) throws ClassNotFoundException {
        List<CartItem> items = new ArrayList<>();

        String sql = """
            SELECT ci.id, ci.cart_id, ci.product_id, ci.quantity, ci.added_at,
                   p.id AS p_id, p.name, p.category, p.price, p.image_path, p.description
            FROM cartitem ci
            JOIN cart c ON ci.cart_id = c.id
            JOIN products p ON ci.product_id = p.id
            WHERE c.user_id = ? AND c.is_ordered = false
            ORDER BY ci.added_at DESC
        """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                // Create Product object
                Product product = new Product();
                product.setId(rs.getInt("p_id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setPrice(rs.getDouble("price"));
                product.setImagePath(rs.getString("image_path"));
                product.setDescription(rs.getString("description"));

                // Create CartItem with Product
                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setCartId(rs.getInt("cart_id"));
                item.setProductId(rs.getInt("product_id"));
                item.setProduct(product);
                item.setQuantity(rs.getInt("quantity"));
                item.setAddedAt(rs.getTimestamp("added_at"));

                items.add(item);
                System.out.print("ddddddddddddddddddddd");
                System.out.print(rs.getInt("id"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return items;
    }

    public Map<String, Object> getCartSummary(int userId) throws ClassNotFoundException {
        Map<String, Object> summary = new HashMap<>();

        String sql = """
            SELECT COUNT(ci.id) AS item_count, 
                   SUM(ci.quantity) AS total_quantity,
                   SUM(ci.quantity * p.price) AS total_price
            FROM cartitem ci
            JOIN cart c ON ci.cart_id = c.id
            JOIN products p ON ci.product_id = p.id
            WHERE c.user_id = ? AND c.is_ordered = false
        """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                summary.put("itemCount", rs.getInt("item_count"));
                summary.put("totalQuantity", rs.getInt("total_quantity"));
                summary.put("totalPrice", rs.getDouble("total_price"));
            } else {
                summary.put("itemCount", 0);
                summary.put("totalQuantity", 0);
                summary.put("totalPrice", 0.0);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Return empty summary on error
            summary.put("itemCount", 0);
            summary.put("totalQuantity", 0);
            summary.put("totalPrice", 0.0);
        }

        return summary;
    }

    public boolean updateCartItemQuantity(int cartId, int productId, int newQuantity) throws ClassNotFoundException {
        String sql = "UPDATE cartitem SET quantity = ?, added_at = NOW() WHERE cart_id = ? AND product_id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, cartId);
            stmt.setInt(3, productId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    public void adjustProductStock(int productId, int quantityChange) throws ClassNotFoundException {
        String sql = "UPDATE products SET quantity = quantity + ? WHERE id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantityChange);
            stmt.setInt(2, productId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public boolean isCartItemOwnedByUser(int cartItemId, int userId) throws ClassNotFoundException {
        String sql = "SELECT ci.id FROM cartitem ci JOIN cart c ON ci.cart_id = c.id " +
                     "WHERE ci.id = ? AND c.user_id = ? AND c.is_ordered = false";
        System.out.println(sql);
        System.out.println(cartItemId);
        System.out.println(userId);

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartItemId);
            stmt.setInt(2, userId);
            return stmt.executeQuery().next();
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getProductStock(int productId) throws ClassNotFoundException {
        String sql = "SELECT quantity FROM products WHERE id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            return rs.next() ? rs.getInt("quantity") : 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    // Remove item from cart
    public boolean removeFromCart(int productId, int cartId) throws ClassNotFoundException {
        String sql = "DELETE FROM cartitem WHERE product_id = ? AND cart_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, productId);
            stmt.setInt(2, cartId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


    // ========== PRIVATE HELPER METHODS ==========
    
    private int getOrCreateCart(int userId, Connection conn) throws SQLException {
        String selectSql = "SELECT id FROM cart WHERE user_id = ? AND is_ordered = false";
        try (PreparedStatement stmt = conn.prepareStatement(selectSql)) {
            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }
        }

        String insertSql = "INSERT INTO cart (user_id, created_at, updated_at, is_ordered) VALUES (?, NOW(), NOW(), false)";
        try (PreparedStatement stmt = conn.prepareStatement(insertSql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, userId);
            stmt.executeUpdate();
            ResultSet keys = stmt.getGeneratedKeys();
            if (keys.next()) {
                return keys.getInt(1);
            }
        }

        throw new SQLException("Failed to create new cart");
    }

    private boolean insertCartItem(int cartId, int productId, int quantity, Connection conn) throws SQLException {
        String sql = "INSERT INTO cartitem (cart_id, product_id, quantity, added_at) VALUES (?, ?, ?, NOW())";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            return stmt.executeUpdate() > 0;
        }
    }

    private boolean updateCartItemQuantity(int cartItemId, int newQuantity, Connection conn) throws SQLException {
        String sql = "UPDATE cartitem SET quantity = ? WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, newQuantity);
            stmt.setInt(2, cartItemId);
            return stmt.executeUpdate() > 0;
        }
    }

    private boolean decreaseProductStock(int productId, int quantity, Connection conn) throws SQLException {
        String sql = "UPDATE products SET quantity = quantity - ? WHERE id = ? AND quantity >= ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, quantity);
            stmt.setInt(2, productId);
            stmt.setInt(3, quantity);
            return stmt.executeUpdate() > 0;
        }
    }

    private void updateCartTimestamp(int cartId, Connection conn) throws SQLException {
        String sql = "UPDATE cart SET updated_at = NOW() WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.executeUpdate();
        }
    }

    private CartItem getCartItem(int cartId, int productId, Connection conn) throws SQLException {
        String sql = "SELECT id, quantity FROM cartitem WHERE cart_id = ? AND product_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            stmt.setInt(2, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                CartItem item = new CartItem();
                item.setId(rs.getInt("id"));
                item.setQuantity(rs.getInt("quantity"));
                return item;
            }
        }
        return null;
    }

    private Product getProductById(int productId, Connection conn) throws SQLException {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, productId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                Product product = new Product();
                product.setId(productId);
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setQuantity(rs.getInt("quantity"));
                product.setPrice(rs.getDouble("price"));
                product.setImagePath(rs.getString("image_path"));
                product.setDescription(rs.getString("description"));
                return product;
            }
        }
        return null;
    }
    public Cart getCartById(int cartId) throws ClassNotFoundException {
        String sql = "SELECT id, user_id, created_at, updated_at, is_ordered FROM cart WHERE id = ?";
        Cart cart = null;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int id = rs.getInt("id");
                int userId = rs.getInt("user_id");
                Timestamp createdAt = rs.getTimestamp("created_at");
                Timestamp updatedAt = rs.getTimestamp("updated_at");
                boolean isOrdered = rs.getBoolean("is_ordered");

                cart = new Cart(id, userId, createdAt, updatedAt, isOrdered);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return cart;
    }

}