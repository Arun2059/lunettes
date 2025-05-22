package com.lunettes.controller;

import com.lunettes.model.Product;
import com.lunettes.service.ProductService;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(asyncSupported = true, urlPatterns = { "/product" })
public class ProductController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ProductService productService = new ProductService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            // Check if this is a request for single product
            String productId = request.getParameter("id");
            if (productId != null) {
                // Handle single product view
                handleSingleProductView(request, response, productId);
                return;
            }

            // If searching via keyword
            String searchQuery = request.getParameter("search");
            if (searchQuery != null && !searchQuery.trim().isEmpty()) {
                handleProductSearch(request, response, searchQuery.trim());
                return;
            }
            
            // Original product listing code
            handleProductListing(request, response);
            
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving products");
        }
    }
    private void handleProductSearch(HttpServletRequest request, HttpServletResponse response, String keyword)
            throws ServletException, IOException, ClassNotFoundException {

        List<Product> searchResults = productService.searchProducts(keyword);

        Map<String, List<Product>> productsByCategory = new HashMap<>();
        for (Product product : searchResults) {
            String category = product.getCategory();
            productsByCategory.computeIfAbsent(category, k -> new ArrayList<>()).add(product);
        }

        request.setAttribute("productsByCategory", productsByCategory);
        request.setAttribute("searchQuery", keyword); // optional, in case you want to show "Search results for: ..."
        request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
    }


    private void handleProductListing(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException {
        // Get all products
        List<Product> allProducts = productService.getAllProducts();
        
        // Organize products by category
        Map<String, List<Product>> productsByCategory = new HashMap<>();
        
        for (Product product : allProducts) {
            String category = product.getCategory();
            if (!productsByCategory.containsKey(category)) {
                productsByCategory.put(category, new ArrayList<>());
            }
            productsByCategory.get(category).add(product);
        }
        
        // Add to request attributes
        request.setAttribute("productsByCategory", productsByCategory);
        request.getRequestDispatcher("/WEB-INF/pages/product.jsp").forward(request, response);
    }

    private void handleSingleProductView(HttpServletRequest request, HttpServletResponse response, String productIdParam)
            throws ServletException, IOException, ClassNotFoundException {
        try {
            int productId = Integer.parseInt(productIdParam);
            Product product = productService.getProductById(productId);
            
            if (product == null) {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }
            
            // Add product to request attributes
            request.setAttribute("product", product);
            request.getRequestDispatcher("/WEB-INF/pages/single-product.jsp").forward(request, response);
            
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        }
    }
}