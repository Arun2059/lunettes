package com.lunettes.service;

import com.lunettes.model.Cart;
import com.lunettes.model.CartItem;
import com.lunettes.model.Order;
import com.lunettes.model.OrderDetails;
import com.lunettes.model.Product;
import com.lunettes.config.DbConfig;
import java.sql.*;
import java.time.Instant;
import java.util.ArrayList;
import java.util.List;

public class OrderService {
    private final CartService cartService;

    public OrderService() {
        this.cartService = new CartService();
    }

    public boolean createOrder(Order order) throws ClassNotFoundException {
        try (Connection conn = DbConfig.getDbConnection()) {
            conn.setAutoCommit(false);

            // 1. Create the order
            int orderId = insertOrder(order, conn);
            if (orderId == -1) {
                conn.rollback();
                return false;
            }
            order.setOrderId(orderId);

            // 2. Mark cart as ordered
            if (!markCartAsOrdered(order.getCartId(), conn)) {
                conn.rollback();
                return false;
            }

            // 3. If payment method is not cash on delivery, process payment
            if (!"cashOnDelivery".equals(order.getPaymentMethod())) {
                if (!processPayment(order, conn)) {
                    conn.rollback();
                    return false;
                }
            }

            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Order> getOrdersByUserId(int userId) throws ClassNotFoundException {
        List<Order> orders = new ArrayList<>();

        String sql = """
            SELECT * FROM orders 
            WHERE user_id = ? 
            ORDER BY created_at DESC
        """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public List<Order> getAllOrders() throws ClassNotFoundException {
        List<Order> orders = new ArrayList<>();

        String sql = """
            SELECT * FROM orders 
            ORDER BY created_at DESC
        """;

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Order order = mapResultSetToOrder(rs);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return orders;
    }

    public Order getOrderById(int orderId) throws ClassNotFoundException {
        String sql = "SELECT * FROM orders WHERE order_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updateOrderStatus(int orderId, String status) throws ClassNotFoundException {
        String sql = "UPDATE orders SET is_delivered = ?, updated_at = ? WHERE order_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            boolean isDelivered = "delivered".equals(status);
            stmt.setBoolean(1, isDelivered);
            stmt.setTimestamp(2, Timestamp.from(Instant.now()));
            stmt.setInt(3, orderId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean markOrderAsPaid(int orderId) throws ClassNotFoundException {
        String sql = "UPDATE orders SET is_paid = true, updated_at = ? WHERE order_id = ?";

        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setTimestamp(1, Timestamp.from(Instant.now()));
            stmt.setInt(2, orderId);

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // ========== PRIVATE HELPER METHODS ==========

    private int insertOrder(Order order, Connection conn) throws SQLException {
        String sql = """
            INSERT INTO orders (
                cart_id, user_id, phone, delivery_address, city, 
                zip_code, country, payment_method, is_paid, is_delivered,
                delivery_location, total_price, discount_price, created_at, updated_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
        """;

        try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, order.getCartId());
            stmt.setInt(2, order.getUserId());
            stmt.setString(3, order.getPhone());
            stmt.setString(4, order.getDeliveryAddress());
            stmt.setString(5, order.getCity());
            stmt.setString(6, order.getZipCode());
            stmt.setString(7, order.getCountry());
            stmt.setString(8, order.getPaymentMethod());
            stmt.setBoolean(9, order.isPaid());
            stmt.setBoolean(10, order.isDelivered());
            stmt.setString(11, order.getDeliveryLocation());
            stmt.setDouble(12, order.getTotalPrice());
            stmt.setDouble(13, order.getDiscountPrice());
            stmt.setTimestamp(14, order.getCreatedAt());
            stmt.setTimestamp(15, order.getUpdatedAt());

            stmt.executeUpdate();

            ResultSet keys = stmt.getGeneratedKeys();
            if (keys.next()) {
                return keys.getInt(1);
            }
            return -1;
        }
    }

    private boolean markCartAsOrdered(int cartId, Connection conn) throws SQLException {
        String sql = "UPDATE cart SET is_ordered = true, updated_at = ? WHERE id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.from(Instant.now()));
            stmt.setInt(2, cartId);
            return stmt.executeUpdate() > 0;
        }
    }

    private boolean processPayment(Order order, Connection conn) throws SQLException {
        // In a real application, this would integrate with a payment gateway
        // For now, we'll just mark as paid in the database
        String sql = "UPDATE orders SET is_paid = true, updated_at = ? WHERE order_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setTimestamp(1, Timestamp.from(Instant.now()));
            stmt.setInt(2, order.getOrderId());
            return stmt.executeUpdate() > 0;
        }
    }

    private Order mapResultSetToOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setCartId(rs.getInt("cart_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setPhone(rs.getString("phone"));
        order.setDeliveryAddress(rs.getString("delivery_address"));
        order.setCity(rs.getString("city"));
        order.setZipCode(rs.getString("zip_code"));
        order.setCountry(rs.getString("country"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setPaid(rs.getBoolean("is_paid"));
        order.setDelivered(rs.getBoolean("is_delivered"));
        order.setDeliveryLocation(rs.getString("delivery_location"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setDiscountPrice(rs.getDouble("discount_price"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));
        return order;
    }
    
    public OrderDetails getCompleteOrderDetails(int orderId) throws SQLException, ClassNotFoundException {
        try (Connection conn = DbConfig.getDbConnection()) {
            // 1. Get the order
            Order order = getOrderById(orderId, conn);
            if (order == null) {
                return null;
            }

            // 2. Get the cart
            Cart cart = cartService.getCartById(order.getCartId());
            if (cart == null) {
                return null;
            }

            // 3. Get all cart items with products
            List<CartItem> items = getCartItemsWithProducts(order.getCartId(), conn);

            // 4. Create and return the complete order details
            return new OrderDetails(order, cart, items);
        }
    }

    /**
     * Gets order by ID using an existing connection
     */
    private Order getOrderById(int orderId, Connection conn) throws SQLException {
        String sql = "SELECT * FROM orders WHERE order_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return mapResultSetToOrder(rs);
            }
            return null;
        }
    }

    /**
     * Gets cart items with full product details
     */
    private List<CartItem> getCartItemsWithProducts(int cartId, Connection conn) throws SQLException {
        List<CartItem> items = new ArrayList<>();
        
        String sql = """
            SELECT ci.*, p.* 
            FROM cartitem ci
            JOIN products p ON ci.product_id = p.id
            WHERE ci.cart_id = ?
        """;
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, cartId);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Product product = mapResultSetToProduct(rs);
                CartItem item = mapResultSetToCartItem(rs);
                item.setProduct(product);
                items.add(item);
            }
        }
        
        return items;
    }

    // Helper methods to map ResultSet to models
    private Order mapResultSetToOrder1(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setCartId(rs.getInt("cart_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setPhone(rs.getString("phone"));
        order.setDeliveryAddress(rs.getString("delivery_address"));
        order.setCity(rs.getString("city"));
        order.setZipCode(rs.getString("zip_code"));
        order.setCountry(rs.getString("country"));
        order.setPaymentMethod(rs.getString("payment_method"));
        order.setPaid(rs.getBoolean("is_paid"));
        order.setDelivered(rs.getBoolean("is_delivered"));
        order.setDeliveryLocation(rs.getString("delivery_location"));
        order.setTotalPrice(rs.getDouble("total_price"));
        order.setDiscountPrice(rs.getDouble("discount_price"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        order.setUpdatedAt(rs.getTimestamp("updated_at"));
        return order;
    }

    private Product mapResultSetToProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setId(rs.getInt("id"));
        product.setName(rs.getString("name"));
        product.setCategory(rs.getString("category"));
        product.setQuantity(rs.getInt("quantity"));
        product.setPrice(rs.getDouble("price"));
        product.setImagePath(rs.getString("image_path"));
        product.setDescription(rs.getString("description"));
        return product;
    }

    private CartItem mapResultSetToCartItem(ResultSet rs) throws SQLException {
        CartItem item = new CartItem();
        item.setId(rs.getInt("id"));
        item.setCartId(rs.getInt("cart_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setAddedAt(rs.getTimestamp("added_at"));
        return item;
    }
    
}