package com.lunettes.utils;

import com.lunettes.model.Product;

public class ProductValidationUtil {

    public static boolean validateProduct(Product product) {
        if (product == null) {
            return false;
        }
        
        // Validate name
        if (product.getName() == null || product.getName().trim().isEmpty() || product.getName().length() > 100) {
            return false;
        }
        
        // Validate category
        if (product.getCategory() != null && product.getCategory().length() > 50) {
            return false;
        }
        
        // Validate quantity
        if (product.getQuantity() < 0) {
            return false;
        }
        
        // Validate price
        if (product.getPrice() <= 0) {
            return false;
        }
        
        // Validate image path (optional but if present should not be too long)
        if (product.getImagePath() != null && product.getImagePath().length() > 255) {
            return false;
        }
        
        return true;
    }
    
    public static boolean validateProductId(int id) {
        return id > 0;
    }
}