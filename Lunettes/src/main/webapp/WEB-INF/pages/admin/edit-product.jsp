<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lunettes.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Product</title>
    <link rel="shortcut icon" type="image/x-icon" href="${pageContext.request.contextPath}/images/logo.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        /* Same styles as your add-product page */
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --dark: #1b263b;
            --light: #f8f9fa;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #f72585;
            --gray: #adb5bd;
        }
        
        body {
            margin: 0;
            padding: 0;
            background-color: var(--light);
            color: var(--dark);
            line-height: 1.6;
            font-family: Arial, sans-serif;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
            transition: margin-left 0.3s;
        }
        
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        
        .card {
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
            margin-bottom: 30px;
        }
        
        .card-header {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .card-body {
            padding: 20px;
        }
        
        .product-form {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }
        
        .form-group {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
        }
        
        label {
            font-weight: 600;
            color: var(--dark);
        }
        
        input, select, textarea {
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
        }
        
        .btn {
            padding: 10px 15px;
            border-radius: 5px;
            border: none;
            cursor: pointer;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background-color: var(--primary);
            color: white;
        }
        
        .btn-secondary {
            background-color: var(--gray);
            color: white;
        }
        
        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }
            
            .form-row {
                flex-direction: column;
                gap: 20px;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="active" value="products" />
    </jsp:include>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">
                <h1>Edit Product</h1>
            </div>
            <div class="user-profile">
                <img src="https://randomuser.me/api/portraits/women/44.jpg" alt="User">
                <span>Admin User</span>
            </div>
        </div>

        <div class="card">
            <div class="card-header">
                <h3>Product Details</h3>
                <a href="${pageContext.request.contextPath}/admin/products?action=list" class="btn btn-secondary">
                    <i class="fas fa-arrow-left"></i> Back to List
                </a>
            </div>
            
            <div class="card-body">
                <%
                    Product product = (Product) request.getAttribute("product");
                    if (product != null) {
                %>
                <form action="${pageContext.request.contextPath}/admin/products?action=update" 
                      method="post" enctype="multipart/form-data" class="product-form">
                    <input type="hidden" name="id" value="<%= product.getId() %>">
                    
                    <div class="form-group">
                        <label for="name">Product Name</label>
                        <input type="text" id="name" name="name" value="<%= product.getName() %>" required>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="category">Category</label>
                            <select id="category" name="category" required>
                                <option value="">Select Category</option>
                                <option value="Prescription Glasses" <%= "Prescription Glasses".equals(product.getCategory()) ? "selected" : "" %>>Prescription Glasses</option>
                                <option value="Googles" <%= "Googles".equals(product.getCategory()) ? "selected" : "" %>>Googles</option>
                                <option value="Sunglasses" <%= "Sunglasses".equals(product.getCategory()) ? "selected" : "" %>>Sunglasses</option>
                                <option value="Best Sellers" <%= "Best Sellers".equals(product.getCategory()) ? "Best Sellers" : "" %>>Best Sellers</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label for="price">Price ($)</label>
                            <input type="number" id="price" name="price" step="0.01" min="0" value="<%= product.getPrice() %>" required>
                        </div>
                    </div>
                    
                    <div class="form-row">
                        <div class="form-group">
                            <label for="quantity">Quantity in Stock</label>
                            <input type="number" id="quantity" name="quantity" min="0" value="<%= product.getQuantity() %>" required>
                        </div>
                        
                        <div class="form-group">
                            <label for="image">Product Image</label>
                            <input type="file" id="image" name="image" accept="image/*">
                            <% if (product.getImagePath() != null && !product.getImagePath().isEmpty()) { %>
                                <div class="current-image">
                                    <p>Current Image:</p>
                                    <img src="${pageContext.request.contextPath}/resources/images/<%= product.getImagePath() %>" 
                                         alt="Current Product Image" width="100">
                                    <input type="hidden" name="existingImage" value="<%= product.getImagePath() %>">
                                </div>
                            <% } %>
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="description">Description</label>
                        <textarea id="description" name="description" rows="4"><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> Update Product
                        </button>
                        <button type="reset" class="btn btn-secondary">Reset</button>
                    </div>
                </form>
                <% } else { %>
                    <div class="alert alert-danger">
                        Product not found or invalid product ID.
                    </div>
                <% } %>
            </div>
        </div>
    </div>

    <script>
        // Client-side validation can be added here
        document.querySelector('form').addEventListener('submit', function(e) {
            const price = document.getElementById('price').value;
            const quantity = document.getElementById('quantity').value;
            
            if (price <= 0) {
                alert('Price must be greater than 0');
                e.preventDefault();
                return false;
            }
            
            if (quantity < 0) {
                alert('Quantity cannot be negative');
                e.preventDefault();
                return false;
            }
            
            return true;
        });
    </script>
</body>
</html>