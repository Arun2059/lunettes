<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
<div class="sidebar">
    <div class="sidebar-header">
        <h3>Glasses<span>Admin</span></h3>
    </div>
    <div class="sidebar-menu">
        <a href="${pageContext.request.contextPath}/admin/dashboard" class="menu-item">
            <i class="fas fa-home"></i>
            <span>Dashboard</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/products?action=list" class="menu-item">
            <i class="fas fa-box"></i>
            <span>Products</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/orders" class="menu-item">
            <i class="fas fa-shopping-cart"></i>
            <span>Orders</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/users" class="menu-item">
            <i class="fas fa-users"></i>
            <span>Customers</span>
        </a>
        <a href="${pageContext.request.contextPath}/admin/analytics" class="menu-item">
            <i class="fas fa-chart-bar"></i>
            <span>Analytics</span>
        </a>
                <a href="${pageContext.request.contextPath}/admin/contact" class="menu-item">
            <i class="fas fa-comments"></i>
            <span>Messages</span>
        </a>
        
        
        <a href="${pageContext.request.contextPath}/admin/settings" class="menu-item">
            <i class="fas fa-cog"></i>
            <span>Settings</span>
        </a>
          <a href="${pageContext.request.contextPath}/logout" class="menu-item">
            <i class="fa fa-sign-out"></i>
            <span>Logout</span>
        </a>
    </div>
</div>