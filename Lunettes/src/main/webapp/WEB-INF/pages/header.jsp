<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lunettes.model.User" %>
<% 
   String contextPath = request.getContextPath();
   User currentUser = (User) session.getAttribute("user");
   boolean isLoggedIn = (currentUser != null);
   boolean isAdmin = isLoggedIn && "admin".equals(currentUser.getRole());
   
   // Get user avatar path if logged in
   String avatarPath = isLoggedIn ? (currentUser.getAvatarPath() != null ? currentUser.getAvatarPath() : "images/default-avatar.png") : null;
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css">
    <style>
        .search-container {
            display: flex;
            align-items: center;
        }

        .search-input {
            padding: 5px 10px;
            font-size: 14px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        .search-button {
            margin-left: 5px;
            padding: 5px 10px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            background-color: transparent;
        }
        
        .profile-icon img {
            width: 30px;
            height: 30px;
            border-radius: 50%;
            object-fit: cover;
            border: 1px solid #ddd;
        }
        
        .user-greeting {
            font-size: 12px;
            margin-right: 8px;
            color: #666;
        }
        
        .profile-dropdown {
            display: flex;
            align-items: center;
        }
    </style>
</head>

<body>
<header>
    <div class="header-container">
        <div class="logo">
            <img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="Lunettes Logo" class="logo-icon">
            <span>Lunettes</span>
        </div>

       <%
    String currentPath = request.getContextPath().substring(request.getContextPath().length());
%>

<nav id="main-nav">
    <ul>
        <li><a class="<%= currentPath.equals("/home") ? "active" : "" %>" href="${pageContext.request.contextPath}/home">Home</a></li>
        <li><a class="<%= currentPath.equals("/product") ? "active" : "" %>" href="${pageContext.request.contextPath}/product">Our Products</a></li>
        <li><a class="<%= currentPath.equals("/about") ? "active" : "" %>" href="${pageContext.request.contextPath}/about">About</a></li>
        <li><a class="<%= currentPath.equals("/contact") ? "active" : "" %>" href="${pageContext.request.contextPath}/contact">Contact Us</a></li>
    </ul>
</nav>


        <div class="header-actions">
            <div class="search-container">
                <form action="${pageContext.request.contextPath}/product" method="get">
                    <input type="text" name="search" class="search-input" placeholder="Search products..." required>
                    <button type="submit" class="search-button">🔍</button>
                </form>
            </div>

            <div class="wishlist-icon" id="wishlist-icon">
                <a href="${pageContext.request.contextPath}/wishlist"> <span class="header-icon">❤️</span>
            </div>
          

            <div class="cart-icon" id="cart-icon">
                <a href="${pageContext.request.contextPath}/cart/view"><span class="header-icon">🛍️</span></a>
            </div>

            <div class="profile-dropdown">
                <% if (isLoggedIn) { %>
                    <span class="user-greeting">Hi, <%= currentUser.getFirstName() %>!</span>
                <% } %>
                <div class="profile-icon" id="profile-icon">
                    <% if (isLoggedIn && avatarPath != null) { %>
                        <img src="${pageContext.request.contextPath}/resources/images/profile/<%= avatarPath %>" alt="Profile">
                    <% } else { %>
                        <span class="header-icon">👤</span>
                    <% } %>
                </div>
                <div class="profile-menu" id="profile-menu">
                    <% if (isLoggedIn) { %>
                        <% if (isAdmin) { %>
                            <a href="${pageContext.request.contextPath}/admin/dashboard">Admin Dashboard</a>
                        <% } %>
                        <a href="${pageContext.request.contextPath}/myaccount">My Account</a>
                        <a href="${pageContext.request.contextPath}/orders">My Order</a>
                        
                        <a href="${pageContext.request.contextPath}/logout">Logout</a>
                    <% } else { %>
                        <a href="${pageContext.request.contextPath}/login">Login</a>
                        <a href="${pageContext.request.contextPath}/register">Register</a>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</header>

<!-- Product Details Panel -->
<div class="product-details-panel" id="product-details-panel">
    <div class="product-details-header">
        <div class="product-details-title">Product Details</div>
        <div class="close-details" id="close-details">×</div>
    </div>
    <div class="product-details-content" id="product-details-content">
        <!-- Product details will be populated here -->
    </div>
</div>


<!-- Notification -->
<div class="notification" id="notification">
    Item added to cart!
</div>

<script>
    const contextPath = "<%= contextPath %>";

    const wishlistIcon = document.getElementById('wishlist-icon');
    const wishlistPanel = document.getElementById('wishlist-panel');
    const closeWishlist = document.getElementById('close-wishlist');

    const profileIcon = document.getElementById('profile-icon');
    const profileMenu = document.getElementById('profile-menu');

  

    profileIcon.addEventListener('click', (e) => {
        e.stopPropagation();
        profileMenu.classList.toggle('active');
        wishlistPanel.classList.remove('active');
    });

    document.addEventListener('click', (e) => {
        if (!wishlistPanel.contains(e.target) && !wishlistIcon.contains(e.target)) {
            wishlistPanel.classList.remove('active');
        }
        if (!profileMenu.contains(e.target) && !profileIcon.contains(e.target)) {
            profileMenu.classList.remove('active');
        }
    });
</script>

</body>
</html>