<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.lunettes.model.Wishlist, com.lunettes.model.Product" %>
<% 
    String contextPath = request.getContextPath();
    List<Wishlist> wishlistItems = (List<Wishlist>) request.getAttribute("wishlistItems");
    int wishlistCount = (int) request.getAttribute("wishlistCount");
    String successMessage = (String) request.getSession().getAttribute("successMessage");
    String errorMessage = (String) request.getSession().getAttribute("errorMessage");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Wishlist | Lunettes</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/header.css" />
    <link rel="stylesheet" href="<%= contextPath %>/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        .wishlist-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 1rem;
        }
        .wishlist-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }
        .wishlist-items {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
            gap: 1.5rem;
        }
        .wishlist-item {
            border: 1px solid #eee;
            border-radius: 8px;
            padding: 1rem;
            position: relative;
        }
        .remove-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            background: #f8d7da;
            color: #721c24;
            border: none;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            cursor: pointer;
        }
        .empty-wishlist {
            text-align: center;
            padding: 4rem 0;
        }
        /* Variables */
:root {
  --primary: #2c3e50;
  --secondary: #e74c3c;
  --light: #ecf0f1;
  --dark: #1a252f;
  --accent: #3498db;
  --text: #333;
  --text-light: #7f8c8d;
  --shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
  --border-radius: 8px;
  --transition: all 0.3s ease;
}

/* Page Layout */
body {
  font-family: 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
  color: var(--text);
  background-color: #f8f9fa;
  margin: 0;
  padding: 0;
  line-height: 1.6;
}
footer{
margin-top:400px;
}

.wishlist-container {
  max-width: 1200px;
  margin: 3rem auto;
  padding: 0 1.5rem;
}

/* Wishlist Header */
.wishlist-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 2.5rem;
  border-bottom: 2px solid var(--light);
  padding-bottom: 1rem;
}

.wishlist-header h1 {
  color: var(--primary);
  font-weight: 600;
  margin: 0;
  position: relative;
}

.wishlist-header h1::after {
  content: '';
  position: absolute;
  bottom: -10px;
  left: 0;
  width: 60px;
  height: 3px;
  background-color: var(--secondary);
}

/* Buttons */
.btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  padding: 0.7rem 1.5rem;
  border-radius: var(--border-radius);
  font-weight: 500;
  text-decoration: none;
  transition: var(--transition);
  border: none;
  cursor: pointer;
  font-size: 0.95rem;
}

.btn-primary {
  background-color: var(--accent);
  color: white;
}

.btn-primary:hover {
  background-color: #2980b9;
  transform: translateY(-2px);
  box-shadow: var(--shadow);
}

.btn-danger {
  background-color: var(--secondary);
  color: white;
}

.btn-danger:hover {
  background-color: #c0392b;
  transform: translateY(-2px);
  box-shadow: var(--shadow);
}

/* Wishlist Items Grid */
.wishlist-items {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: 2rem;
}

/* Wishlist Item Card */
.wishlist-item {
  border: 1px solid #e1e5ea;
  border-radius: var(--border-radius);
  padding: 1.5rem;
  position: relative;
  background-color: white;
  transition: var(--transition);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
  display: flex;
  flex-direction: column;
}

.wishlist-item:hover {
  transform: translateY(-5px);
  box-shadow: var(--shadow);
  border-color: #d1d5da;
}

.wishlist-item h3 {
  color: var(--primary);
  margin-top: 0.5rem;
  margin-bottom: 1rem;
  font-size: 1.2rem;
}

.wishlist-item p {
  color: var(--text-light);
  margin-bottom: 1.5rem;
  font-size: 0.9rem;
}

/* Remove Button */
.remove-btn {
  position: absolute;
  top: 15px;
  right: 15px;
  background: rgba(231, 76, 60, 0.1);
  color: var(--secondary);
  border: none;
  width: 35px;
  height: 35px;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: center;
  transition: var(--transition);
}

.remove-btn:hover {
  background: var(--secondary);
  color: white;
  transform: rotate(90deg);
}

/* Empty Wishlist */
.empty-wishlist {
  text-align: center;
  padding: 5rem 0;
  background-color: white;
  border-radius: var(--border-radius);
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
}

.empty-wishlist h3 {
  color: var(--primary);
  font-size: 1.5rem;
  margin-bottom: 1rem;
}

.empty-wishlist p {
  color: var(--text-light);
  margin-bottom: 2rem;
  max-width: 400px;
  margin-left: auto;
  margin-right: auto;
}

/* Alert Messages */
.alert {
  padding: 1rem;
  border-radius: var(--border-radius);
  margin-bottom: 2rem;
  font-weight: 500;
}

.alert-success {
  background-color: #d4edda;
  color: #155724;
  border: 1px solid #c3e6cb;
}

.alert-danger {
  background-color: #f8d7da;
  color: #721c24;
  border: 1px solid #f5c6cb;
}

/* View Product Link */
.wishlist-item .btn {
  margin-top: auto;
}

/* Responsive Adjustments */
@media (max-width: 768px) {
  .wishlist-header {
    flex-direction: column;
    align-items: flex-start;
    gap: 1rem;
  }
  
  .wishlist-items {
    grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
    gap: 1.5rem;
  }
}

@media (max-width: 576px) {
  .wishlist-container {
    margin: 2rem auto;
    padding: 0 1rem;
  }
  
  .wishlist-items {
    grid-template-columns: 1fr;
  }
}
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="wishlist-container">
        <div class="wishlist-header">
            <h1>My Wishlist (<%= wishlistCount %>)</h1>
            <% if (wishlistCount > 0) { %>
                <a href="<%= contextPath %>/wishlist/clear" class="btn btn-danger" 
                   onclick="return confirm('Are you sure you want to clear your wishlist?')">
                    Clear Wishlist
                </a>
            <% } %>
        </div>

        <% if (successMessage != null) { %>
            <div class="alert alert-success"><%= successMessage %></div>
            <% request.getSession().removeAttribute("successMessage"); %>
        <% } %>
        
        <% if (errorMessage != null) { %>
            <div class="alert alert-danger"><%= errorMessage %></div>
            <% request.getSession().removeAttribute("errorMessage"); %>
        <% } %>

        <% if (wishlistItems != null && !wishlistItems.isEmpty()) { %>
            <div class="wishlist-items">
                <% for (Wishlist item : wishlistItems) { 
                    // You would typically fetch the product details here
                    // Product product = productService.getProductById(item.getProductId());
                %>
                  <div class="wishlist-item">
    <form action="<%= contextPath %>/wishlist/remove" method="post" style="display: inline;">
        <input type="hidden" name="productId" value="<%= item.getProductId() %>">
        <button type="submit" class="remove-btn" onclick="return confirm('Are you sure you want to remove this item from your wishlist?')">
            <i class="fas fa-times"></i>
        </button>
    </form>
    
    <!-- Product details would go here -->
    <h3>Product ID: <%= item.getProductId() %></h3>
    <p>Added on: <%= item.getAddedAt().toString().substring(0, 10) %></p>
    <div class="wishlist-actions">
        <a href="<%= contextPath %>/product?id=<%= item.getProductId() %>" class="btn btn-primary">
            <i class="fas fa-eye"></i> View Product
        </a>
    </div>
</div>
                <% } %>
            </div>
        <% } else { %>
            <div class="empty-wishlist">
                <h3>Your wishlist is empty</h3>
                <p>Explore our products and add your favorites to your wishlist</p>
                <a href="<%= contextPath %>/products" class="btn btn-primary">
                    Browse Products
                </a>
            </div>
        <% } %>
    </div>

    <jsp:include page="footer.jsp" />
</body>
</html>