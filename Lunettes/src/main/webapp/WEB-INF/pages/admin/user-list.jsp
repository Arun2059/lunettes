<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.List, com.lunettes.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Management</title>
    <link rel="shortcut icon" type="x-icon" href="<%= request.getContextPath() %>/images/logo.png" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/sidebar.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/products.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="active" value="users" />
    </jsp:include>

    <!-- Main Content -->
    <div class="main-content" style="margin-left:400px;">
        <!-- Top Bar -->
        <div class="top-bar">
            <div class="page-title">
                <h1>User Management</h1>
            </div>
        </div>

        <!-- User Table -->
        <div class="card">
            <div class="card-header">
                <h3>All Users</h3>
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search users...">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div class="card-body">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Avatar</th>
                            <th>Name</th>
                            <th>Username</th>
                            <th>Email</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<User> users = (List<User>) request.getAttribute("users");
                            if (users != null) {
                                for (User user : users) {
                        %>
                            <tr>
                                <td><%= user.getId() %></td>
                                <td class="product-image">
                                    <img src="<%= request.getContextPath() %>/resources/images/profile/<%= user.getAvatarPath() %>"
                                         alt="<%= user.getFirstName() %>" style="width: 60px; height: auto; border-radius: 6px;" />
                                </td>
                                <td><%= user.getFirstName() %> <%= user.getLastName() %></td>
                                <td><%= user.getUsername() %></td>
                                <td><%= user.getEmail() %></td>
                                <td><%= user.getRole() %></td>
<td class="actions">
    <form action="<%= request.getContextPath() %>/admin/users" method="post" onsubmit="return confirm('Are you sure you want to delete this user?')">
        <input type="hidden" name="action" value="delete" />
        <input type="hidden" name="id" value="<%= user.getId() %>" />
        <button type="submit" class="btn-delete">
            <i class="fas fa-trash-alt"></i>
        </button>
    </form>
</td>

                            </tr>
                        <%
                                }
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
