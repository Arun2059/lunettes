<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.Map, java.util.List, com.lunettes.model.Product" %>
<% 
    String contextPath = request.getContextPath();
    Map<String, List<Product>> productsByCategory = (Map<String, List<Product>>) request.getAttribute("productsByCategory");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
    
    // Check if there are any products
    boolean hasProducts = false;
    if (productsByCategory != null && !productsByCategory.isEmpty()) {
        for (List<Product> products : productsByCategory.values()) {
            if (products != null && !products.isEmpty()) {
                hasProducts = true;
                break;
            }
        }
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Our Product Collection | Premium Eyewear</title>
    <link rel="shortcut icon" type="x-icon" href="resources/images/logo.png" />
    <link rel="stylesheet" href="<%= contextPath %>/css/header.css" />
    <link rel="stylesheet" href="<%= contextPath %>/css/products.css" />
    <link rel="stylesheet" href="<%= contextPath %>/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
            margin: 0;
        }
        
        main {
            flex: 1;
        }
        
        .product-card {
            min-width: 250px;
            margin: 0 10px;
        }
        
        .products-grid {
            display: flex;
            overflow-x: auto;
            scroll-behavior: smooth;
            padding: 20px 0;
            gap: 20px;
        }
        
        .products-grid::-webkit-scrollbar {
            display: none;
        }
        
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px;
            border-radius: 5px;
            color: white;
            z-index: 1000;
            display: none;
        }
        
        .success {
            background-color: #4CAF50;
        }
        
        .error {
            background-color: #f44336;
        }
        
        .no-products-message {
            text-align: center;
            padding: 50px 20px;
            background-color: #f9f9f9;
            border-radius: 8px;
            margin: 40px auto;
            max-width: 800px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        
        .no-products-message h2 {
            color: #333;
            margin-bottom: 15px;
        }
        
        .no-products-message p {
            color: #666;
            font-size: 18px;
            margin-bottom: 25px;
        }
        
        .continue-shopping-btn {
            display: inline-block;
            background-color: #4CAF50;
            color: white;
            padding: 12px 24px;
            border-radius: 4px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }
        
        .continue-shopping-btn:hover {
            background-color: #388e3c;
        }
    </style>
</head>

<body>
    <jsp:include page="header.jsp" />
    
    <!-- Notification messages -->
    <% if (successMessage != null) { %>
        <div class="notification success" id="successNotification">
            <%= successMessage %>
        </div>
    <% } %>
    <% if (errorMessage != null) { %>
        <div class="notification error" id="errorNotification">
            <%= errorMessage %>
        </div>
    <% } %>
    
    <main>
        <!-- Main Banner Section -->
        <section class="main-banner">
            <div class="section-container">
                <h1 class="main-title">Discover Our Premium Collection</h1>
                <p class="subtitle">Eyewear products for style and comfort</p>
            </div>
        </section>
        
        <!-- No Products Message -->
        <% if (!hasProducts) { %>
            <div class="no-products-message">
                <h2>No Products Available</h2>
                <p>We're currently updating our inventory. Please check back soon for our latest collection of premium eyewear.</p>
                <a href="<%= contextPath %>/home" class="continue-shopping-btn">Return to Homepage</a>
            </div>
        <% } %>
        
        <!-- Dynamic Product Sections by Category -->
        <% if (productsByCategory != null) {
            for (Map.Entry<String, List<Product>> categoryEntry : productsByCategory.entrySet()) { 
                if (categoryEntry.getValue() != null && !categoryEntry.getValue().isEmpty()) { %>
                <section class="product-section">
                    <div class="section-container">
                        <div class="section-header">
                            <h2 class="section-title"><%= categoryEntry.getKey() %></h2>
                        </div>
                        <div class="products-slider">
                            <button class="slider-btn prev"><i class="fas fa-chevron-left"></i></button>
                            <button class="slider-btn next"><i class="fas fa-chevron-right"></i></button>
                            <div class="products-grid">
                                <% for (Product product : categoryEntry.getValue()) { %>
                                    <div class="product-card fade-in">
<img src="resources/images/<%= product.getImagePath() %>" 
     alt="<%= product.getName() %>" 
     class="product-image" 
     style="cursor: pointer;"
     onclick="window.location.href='/Lunettes/product?id=<%= product.getId() %>'">
                                        <div class="product-info">
                                            <h3><%= product.getName() %></h3>
                                            <div class="product-price">Rs.<%= product.getPrice() %></div>
                                            <div class="product-actions">
                                                <form action="<%= contextPath %>/cart/add" method="post">
                                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                                    <input type="hidden" name="quantity" value="1">
                                                    <button type="submit" class="add-to-cart">Add to Cart</button>
                                                </form>
                                                <form action="<%= contextPath %>/wishlist/add" method="post" style="display: inline;">
                                                    <input type="hidden" name="productId" value="<%= product.getId() %>">
                                                    <button type="submit" class="wishlist">🤍</button>
                                                </form>
                                            </div>
                                        </div>
                                    </div>
                                <% } %>
                            </div>
                        </div>
                    </div>
                </section>
            <% }
            }
        } %>
    </main>
    
    <jsp:include page="footer.jsp" />
    
    <script>
        // Slider functionality
        document.querySelectorAll('.products-slider').forEach(slider => {
            const productsGrid = slider.querySelector('.products-grid');
            const prevBtn = slider.querySelector('.prev');
            const nextBtn = slider.querySelector('.next');
            
            let scrollAmount = 0;
            const scrollStep = 300;
            const maxScroll = productsGrid.scrollWidth - productsGrid.clientWidth;
            
            prevBtn.addEventListener('click', () => {
                scrollAmount = Math.max(scrollAmount - scrollStep, 0);
                productsGrid.scrollTo({
                    left: scrollAmount,
                    behavior: 'smooth'
                });
            });
            
            nextBtn.addEventListener('click', () => {
                scrollAmount = Math.min(scrollAmount + scrollStep, maxScroll);
                productsGrid.scrollTo({
                    left: scrollAmount,
                    behavior: 'smooth'
                });
            });
        });

        // Show notifications if they exist
        window.onload = function() {
            const successNotification = document.getElementById('successNotification');
            const errorNotification = document.getElementById('errorNotification');
            
            if (successNotification) {
                successNotification.style.display = 'block';
                setTimeout(() => {
                    successNotification.style.display = 'none';
                }, 3000);
            }
            
            if (errorNotification) {
                errorNotification.style.display = 'block';
                setTimeout(() => {
                    errorNotification.style.display = 'none';
                }, 3000);
            }
        };
    </script>
</body>
</html>