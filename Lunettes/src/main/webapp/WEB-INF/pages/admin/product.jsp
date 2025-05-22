<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, com.lunettes.model.Product" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Management</title>
    <link rel="shortcut icon" type="x-icon" href="<%= request.getContextPath() %>/images/logo.png" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/sidebar.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/products.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css" />
    
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="active" value="products" />
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content" style="margin-left:400px;">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="page-title">
                <h1>Product Management</h1>
            </div>
            <div class="actions">
                <a href="<%= request.getContextPath() %>/admin/products?action=add" class="btn btn-primary">
                    <i class="fas fa-plus"></i> Add Product
                </a>
            </div>
        </div>

        <!-- Product Table -->
        <div class="card">
            <div class="card-header">
                <h3>All Products</h3>
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search products...">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div class="card-body">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Image</th>
                            <th>Name</th>
                            <th>Category</th>
                            <th>Price</th>
                            <th>Stock</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Product> products = (List<Product>) request.getAttribute("products");
                            if (products != null) {
                                for (Product product : products) {
                        %>
                            <tr>
                                <td><%= product.getId() %></td>
                                <td class="product-image">
                                    <img src="<%= request.getContextPath() %>/resources/images/<%= product.getImagePath() %>"
                                         alt="<%= product.getName() %>" style="width: 60px; height: auto; border-radius: 6px;" />
                                </td>
                                <td><%= product.getName() %></td>
                                <td><%= product.getCategory() %></td>
                                <td>Rs.<%= product.getPrice() %></td>
                                <td>
                                    <%
                                        int quantity = product.getQuantity();
                                        String stockClass = "out-of-stock";
                                        if (quantity > 10) stockClass = "in-stock";
                                        else if (quantity > 0) stockClass = "low-stock";
                                    %>
                                    <span class="stock-badge <%= stockClass %>">
                                        <%= quantity %>
                                    </span>
                                </td>
                                <td class="actions">
                                    <a href="<%= request.getContextPath() %>/admin/products?action=get&id=<%= product.getId() %>" class="btn-edit">
                                        <i class="fas fa-edit"></i>
                                    </a>
                                    <a href="<%= request.getContextPath() %>/admin/products?action=delete&id=<%= product.getId() %>"
                                       class="btn-delete" onclick="return confirm('Are you sure you want to delete this product?')">
                                        <i class="fas fa-trash-alt"></i>
                                    </a>
                                </td>
                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <div class="card-footer">
                <div class="pagination">
                    <a href="#" class="page-link disabled"><i class="fas fa-angle-left"></i></a>
                    <a href="#" class="page-link active">1</a>
                    <a href="#" class="page-link">2</a>
                    <a href="#" class="page-link">3</a>
                    <a href="#" class="page-link"><i class="fas fa-angle-right"></i></a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
