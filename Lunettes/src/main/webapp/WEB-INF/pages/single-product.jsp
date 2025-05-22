<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lunettes.model.Product" %>
<% 
    String contextPath = request.getContextPath();
    Product product = (Product) request.getAttribute("product");
    String successMessage = (String) request.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getName() %> | Lunettes Premium Eyewear</title>
    <link rel="shortcut icon" type="x-icon" href="<%= contextPath %>/resources/images/logo.png" />
    <link rel="stylesheet" href="<%= contextPath %>/css/header.css" />
    <link rel="stylesheet" href="<%= contextPath %>/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #000;
            --primary-hover: #333;
            --secondary-color: #6c757d;
            --secondary-hover: #5a6268;
            --accent-color: #007bff;
            --accent-hover: #0069d9;
            --danger-color: #dc3545;
            --danger-hover: #c82333;
            --light-bg: #f8f9fa;
            --border-color: #eee;
            --text-color: #212529;
            --success-bg: #4CAF50;
            --success-color: #fff;
            --error-bg: #f44336;
            --error-color: #fff;
            --in-stock-color: #28a745;
            --out-stock-color: #dc3545;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
        }

        /* Product Detail Section */
        .product-detail-section {
            padding: 3rem 0;
        }

        .section-container {
            max-width: 1200px;
            margin:  auto;
            padding: 0 1rem;
            margin
        }

        .product-detail-container {
            display: flex;
            flex-wrap: wrap;
            gap: 3rem;
            
        }

        /* Product Image Column */
        .product-image-column {
            flex: 1;
            min-width: 300px;
        }

        .main-image {
            width: 100%;
            text-align: center;
            border-radius: 8px;
            overflow: hidden;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .main-image img {
            width: 100%;
            height: auto;
            object-fit: cover;
            display: block;
            transition: transform 0.3s ease;
            cursor: pointer;
        }

        .main-image img:hover {
            transform: scale(1.03);
        }

        /* Product Info Column */
        .product-info-column {
            flex: 1;
            min-width: 300px;
        }

        .product-title {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--primary-color);
        }

        .product-category {
            font-size: 1rem;
            color: var(--secondary-color);
            text-transform: uppercase;
            margin-bottom: 1rem;
            letter-spacing: 1px;
        }

        .product-price {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
        }

        .product-description {
            margin-bottom: 2rem;
        }

        .product-description h3 {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 0.8rem;
            color: var(--primary-color);
        }

        .product-description p {
            color: var(--text-color);
            font-size: 1rem;
            line-height: 1.8;
        }

        /* Product Actions */
        .product-actions {
            margin-bottom: 2rem;
        }

        .add-to-cart-form {
            margin-bottom: 1rem;
        }

        .quantity-selector {
            display: flex;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .quantity-selector label {
            margin-right: 1rem;
            font-weight: 600;
        }

        .quantity-selector input {
            width: 80px;
            height: 40px;
            padding: 0 0.5rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
            text-align: center;
        }

        .add-to-cart-btn {
            padding: 1rem 2rem;
            background: var(--primary-color);
            color: white;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 4px;
            width: 100%;
            max-width: 400px;
            transition: all 0.3s ease;
        }

        .add-to-cart-btn:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .wishlist-btn {
            padding: 0.8rem 2rem;
            background: transparent;
            color: var(--primary-color);
            border: 1px solid var(--primary-color);
            cursor: pointer;
            font-size: 1rem;
            font-weight: 500;
            border-radius: 4px;
            width: 100%;
            max-width: 400px;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
        }

        .wishlist-btn:hover {
            background: rgba(0, 0, 0, 0.05);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.05);
        }

        .wishlist-btn i {
            font-size: 1.1rem;
        }

        /* Product Meta */
        .product-meta {
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color);
        }

        .stock-status {
            font-size: 1rem;
            font-weight: 500;
        }

        .in-stock {
            color: var(--in-stock-color);
        }

        .out-of-stock {
            color: var(--out-stock-color);
        }

        /* Notification Styles */
        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 6px;
            color: white;
            z-index: 1000;
            display: none;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
            font-weight: 500;
            animation: slideIn 0.3s ease-out forwards;
            max-width: 400px;
        }

        @keyframes slideIn {
            from {
                transform: translateX(100%);
                opacity: 0;
            }
            to {
                transform: translateX(0);
                opacity: 1;
            }
        }

        @keyframes slideOut {
            from {
                transform: translateX(0);
                opacity: 1;
            }
            to {
                transform: translateX(100%);
                opacity: 0;
            }
        }

        .notification.hiding {
            animation: slideOut 0.3s ease-in forwards;
        }

        .success {
            background-color: var(--success-bg);
        }

        .error {
            background-color: var(--error-bg);
        }

        /* Image Modal Styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 1001;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgba(0, 0, 0, 0.9);
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .modal.show {
            opacity: 1;
        }

        .modal-content {
            margin: auto;
            display: block;
            max-width: 90%;
            max-height: 90%;
            position: relative;
            top: 50%;
            transform: translateY(-50%);
            border-radius: 8px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.3);
            animation: zoomIn 0.3s ease-out;
        }

        @keyframes zoomIn {
            from {
                transform: translateY(-50%) scale(0.9);
                opacity: 0;
            }
            to {
                transform: translateY(-50%) scale(1);
                opacity: 1;
            }
        }

        .close {
            position: absolute;
            top: 20px;
            right: 30px;
            color: #f1f1f1;
            font-size: 40px;
            font-weight: bold;
            transition: 0.3s;
            z-index: 1002;
            cursor: pointer;
            padding: 10px;
            line-height: 0.6;
        }

        .close:hover {
            color: #fff;
            transform: scale(1.1);
        }

        /* Responsive Design */
        @media (max-width: 992px) {
            .product-detail-container {
                flex-direction: column;
            }
        }

        @media (max-width: 768px) {
            .product-title {
                font-size: 2rem;
            }
            
            .product-price {
                font-size: 1.8rem;
            }
            
            .modal-content {
                max-width: 95%;
                max-height: 95%;
            }
        }

        @media (max-width: 576px) {
            .product-detail-section {
                padding: 2rem 0;
            }
            
            .product-title {
                font-size: 1.8rem;
            }
            
            .product-price {
                font-size: 1.5rem;
            }
            
            .quantity-selector {
                flex-direction: column;
                align-items: flex-start;
                gap: 0.5rem;
            }
            
            .add-to-cart-btn, .wishlist-btn {
                padding: 0.8rem 1.5rem;
            }
        }
        footer{
        margin-top:120px;
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
    
    <!-- Product Detail Section -->
    <section class="product-detail-section">
        <div class="section-container">
            <div class="product-detail-container">
                <!-- Product Image Column -->
                <div class="product-image-column">
                    <div class="main-image">
                        <img id="expandedImg" src="<%= contextPath %>/resources/images/<%= product.getImagePath() %>" 
                             alt="<%= product.getName() %>" onclick="openModal(this)">
                    </div>
                </div>
                
                <!-- Product Info Column -->
                <div class="product-info-column">
                    <h1 class="product-title"><%= product.getName() %></h1>
                    <div class="product-category"><%= product.getCategory() %></div>
                    <div class="product-price">Rs.<%= String.format("%.2f", product.getPrice()) %></div>
                    
                    <div class="product-description">
                        <h3>Description</h3>
                        <p><%= product.getDescription() %></p>
                    </div>
                    
                    <div class="product-actions">
                        <form action="<%= contextPath %>/cart/add" method="post" class="add-to-cart-form">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <div class="quantity-selector">
                                <label for="quantity">Quantity:</label>
                                <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= product.getQuantity() %>" <%= product.getQuantity() <= 0 ? "disabled" : "" %>>
                            </div>
                            <button type="submit" class="add-to-cart-btn" <%= product.getQuantity() <= 0 ? "disabled" : "" %>>
                                <i class="fas fa-shopping-cart"></i> Add to Cart
                            </button>
                        </form>
                        
                        <form action="<%= contextPath %>/wishlist/add" method="post" class="wishlist-form">
                            <input type="hidden" name="productId" value="<%= product.getId() %>">
                            <button type="submit" class="wishlist-btn">
                                <i class="far fa-heart"></i> Add to Wishlist
                            </button>
                        </form>
                    </div>
                    
                    <div class="product-meta">
                        <div class="stock-status">
                            <% if (product.getQuantity() > 0) { %>
                                <span class="in-stock"><i class="fas fa-check-circle"></i> In Stock (<%= product.getQuantity() %> available)</span>
                            <% } else { %>
                                <span class="out-of-stock"><i class="fas fa-times-circle"></i> Out of Stock</span>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    
    <!-- Image Modal -->
    <div id="imageModal" class="modal">
        <span class="close" onclick="closeModal()">&times;</span>
        <img class="modal-content" id="modalImage">
    </div>
    
    <jsp:include page="footer.jsp" />
    
    <script>
        // Show notifications if they exist
        window.onload = function() {
            const successNotification = document.getElementById('successNotification');
            const errorNotification = document.getElementById('errorNotification');
            
            if (successNotification) {
                successNotification.style.display = 'block';
                setTimeout(() => {
                    successNotification.classList.add('hiding');
                    setTimeout(() => {
                        successNotification.style.display = 'none';
                        successNotification.classList.remove('hiding');
                    }, 300);
                }, 3000);
            }
            
            if (errorNotification) {
                errorNotification.style.display = 'block';
                setTimeout(() => {
                    errorNotification.classList.add('hiding');
                    setTimeout(() => {
                        errorNotification.style.display = 'none';
                        errorNotification.classList.remove('hiding');
                    }, 300);
                }, 3000);
            }
        };
        
        // Image modal functionality
        function openModal(img) {
            const modal = document.getElementById("imageModal");
            const modalImg = document.getElementById("modalImage");
            modal.style.display = "block";
            modalImg.src = img.src;
            
            // Add a small delay before adding the 'show' class for the transition
            setTimeout(() => {
                modal.classList.add('show');
            }, 10);
        }
        
        function closeModal() {
            const modal = document.getElementById("imageModal");
            modal.classList.remove('show');
            
            // Wait for the transition to complete before hiding
            setTimeout(() => {
                modal.style.display = "none";
            }, 300);
        }
        
        // Close modal when clicking outside the image
        window.onclick = function(event) {
            const modal = document.getElementById("imageModal");
            if (event.target == modal) {
                closeModal();
            }
        }
    </script>
</body>
</html>