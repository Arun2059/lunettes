package com.lunettes.service;

import com.lunettes.model.Product;
import com.lunettes.config.DbConfig;
import com.lunettes.utils.ProductValidationUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductService {
    
    public boolean addProduct(Product product) throws ClassNotFoundException {
        if (!ProductValidationUtil.validateProduct(product)) {
            return false;
        }
        
        String sql = "INSERT INTO products (name, category, quantity, price, image_path, description) VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getCategory());
            stmt.setInt(3, product.getQuantity());
            stmt.setDouble(4, product.getPrice());
            stmt.setString(5, product.getImagePath());
            stmt.setString(6, product.getDescription());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        product.setId(generatedKeys.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public Product getProductById(int id) throws ClassNotFoundException {
        if (!ProductValidationUtil.validateProductId(id)) {
            return null;
        }
        
        String sql = "SELECT * FROM products WHERE id = ?";
        Product product = null;
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setQuantity(rs.getInt("quantity"));
                product.setPrice(rs.getDouble("price"));
                product.setImagePath(rs.getString("image_path"));
                product.setDescription(rs.getString("description"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return product;
    }
    
    public List<Product> getAllProducts() throws ClassNotFoundException {
        String sql = "SELECT * FROM products";
        List<Product> products = new ArrayList<>();
        
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setQuantity(rs.getInt("quantity"));
                product.setPrice(rs.getDouble("price"));
                product.setImagePath(rs.getString("image_path"));
                product.setDescription(rs.getString("description"));
                
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }
    
    public boolean updateProduct(Product product) throws ClassNotFoundException {
        if (!ProductValidationUtil.validateProduct(product) || !ProductValidationUtil.validateProductId(product.getId())) {
            return false;
        }
        
        String sql = "UPDATE products SET name = ?, category = ?, quantity = ?, price = ?, image_path = ?, description = ? WHERE id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getCategory());
            stmt.setInt(3, product.getQuantity());
            stmt.setDouble(4, product.getPrice());
            stmt.setString(5, product.getImagePath());
            stmt.setString(6, product.getDescription());
            stmt.setInt(7, product.getId());
            
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public boolean deleteProduct(int id) throws ClassNotFoundException {
        if (!ProductValidationUtil.validateProductId(id)) {
            return false;
        }
        
        String sql = "DELETE FROM products WHERE id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public List<Product> searchProducts(String keyword) throws ClassNotFoundException {
        String sql = "SELECT * FROM products WHERE name LIKE ? OR description LIKE ?";
        List<Product> searchResults = new ArrayList<>();
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            // Use '%' around the keyword to search for products containing the keyword
            String searchKeyword = "%" + keyword + "%";
            stmt.setString(1, searchKeyword);
            stmt.setString(2, searchKeyword);
            
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setCategory(rs.getString("category"));
                product.setQuantity(rs.getInt("quantity"));
                product.setPrice(rs.getDouble("price"));
                product.setImagePath(rs.getString("image_path"));
                product.setDescription(rs.getString("description"));
                
                searchResults.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return searchResults;
    }

}