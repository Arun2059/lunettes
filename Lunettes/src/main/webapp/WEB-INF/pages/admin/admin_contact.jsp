<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.lunettes.model.Message" %>
<% 
    String contextPath = request.getContextPath();
    List<Message> messages = (List<Message>) request.getAttribute("messages");
    String message = (String) request.getSession().getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Messages | Lunettes Admin</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/sidebar.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --secondary: #3f37c9;
            --dark: #1b263b;
            --light: #f8f9fa;
            --success: #4cc9f0;
            --warning: #f8961e;
            --danger: #f72585;
            --gray: #adb5bd;
            --text: #1b263b;
            --text-light: #6c757d;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: var(--text);
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
            padding-bottom: 15px;
            border-bottom: 1px solid #e0e0e0;
        }

        .page-title h1 {
            font-size: 24px;
            color: var(--dark);
            margin: 0;
        }

        .card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            margin-bottom: 20px;
            overflow: hidden;
        }

        .card-header {
            padding: 15px 20px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .card-header h3 {
            margin: 0;
            font-size: 18px;
            color: var(--dark);
        }

        .search-box {
            position: relative;
            width: 250px;
        }

        .search-box input {
            width: 100%;
            padding: 8px 15px 8px 35px;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 14px;
        }

        .search-box i {
            position: absolute;
            left: 10px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--gray);
        }

        .card-body {
            padding: 0;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table th, .data-table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #eee;
        }

        .data-table th {
            background-color: var(--primary);
            color: white;
            font-weight: 500;
        }

        .data-table tr:hover {
            background-color: #f9f9f9;
        }

        .message-unread {
            font-weight: 600;
            background-color: rgba(67, 97, 238, 0.05);
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
        }

        .badge {
            display: inline-block;
            padding: 3px 8px;
            border-radius: 12px;
            font-size: 12px;
            font-weight: 500;
        }

        .badge-primary {
            background-color: var(--primary);
            color: white;
        }

        .badge-success {
            background-color: var(--success);
            color: white;
        }

        .badge-warning {
            background-color: var(--warning);
            color: white;
        }

        .badge-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
            border: 1px solid var(--primary);
        }

        .btn-primary:hover {
            background-color: var(--secondary);
            border-color: var(--secondary);
        }

        .btn-view {
            background-color: var(--success);
            color: white;
            border: 1px solid var(--success);
        }

        .btn-view:hover {
            opacity: 0.9;
        }

        .btn-delete {
            background-color: var(--danger);
            color: white;
            border: 1px solid var(--danger);
        }

        .btn-delete:hover {
            opacity: 0.9;
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .message {
            padding: 10px 15px;
            margin-bottom: 20px;
            border-radius: 4px;
        }

        .message-success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .message-error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }

            .data-table {
                display: block;
                overflow-x: auto;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="active" value="contacts" />
    </jsp:include>

    <div class="main-content">
        <div class="top-bar">
            <div class="page-title">
                <h1>Contact Messages</h1>
            </div>
        </div>

        <% if (message != null) { %>
            <div class="message <%= message.toLowerCase().contains("success") ? "message-success" : "message-error" %>">
                <%= message %>
            </div>
            <% request.getSession().removeAttribute("message"); %>
        <% } %>

        <div class="card">
            <div class="card-header">
                <h3>All Messages</h3>
                <div class="search-box">
                    <input type="text" id="searchInput" placeholder="Search messages...">
                    <i class="fas fa-search"></i>
                </div>
            </div>
            <div class="card-body">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>From</th>
                            <th>Email</th>
                            <th>Subject</th>
                            <th>Date</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if (messages != null && !messages.isEmpty()) { %>
                            <% for (Message msg : messages) { %>
                                <tr class="<%= !msg.isRead() ? "message-unread" : "" %>">
                                    <td>
                                        <div style="display: flex; align-items: center; gap: 10px;">
                                            <% if (msg.getImagePath() != null && !msg.getImagePath().isEmpty()) { %>
                                                <img src="<%= contextPath %>/resources/images/profile/<%= msg.getImagePath() %>" 
                                                     alt="<%= msg.getName() %>" class="user-avatar">
                                            <% } else { %>
                                                <div class="user-avatar" style="background-color: #eee; display: flex; align-items: center; justify-content: center;">
                                                    <i class="fas fa-user" style="color: #777;"></i>
                                                </div>
                                            <% } %>
                                            <%= msg.getName() %>
                                        </div>
                                    </td>
                                    <td><%= msg.getEmail() %></td>
                                    <td><%= msg.getSubject() %></td>
                                    <td><%= msg.getCreatedAt().toString().substring(0, 10) %></td>
                                    <td>
                                        <% if (msg.isRead()) { %>
                                            <span class="badge badge-success">Read</span>
                                        <% } else { %>
                                            <span class="badge badge-warning">Unread</span>
                                        <% } %>
                                    </td>
                                    <td class="actions">
                                        <a href="<%= contextPath %>/admin/contact/view?id=<%= msg.getId() %>" class="btn btn-view">
                                            <i class="fas fa-eye"></i> View
                                        </a>
                                        <a href="<%= contextPath %>/admin/contact/delete?id=<%= msg.getId() %>" 
                                           class="btn btn-delete" onclick="return confirm('Are you sure you want to delete this message?')">
                                            <i class="fas fa-trash-alt"></i> Delete
                                        </a>
                                    </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="6" style="text-align: center; padding: 20px;">No messages found</td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script>
        // Simple search functionality
        document.getElementById('searchInput').addEventListener('input', function() {
            const searchTerm = this.value.toLowerCase();
            const rows = document.querySelectorAll('.data-table tbody tr');
            
            rows.forEach(row => {
                const name = row.cells[0].textContent.toLowerCase();
                const email = row.cells[1].textContent.toLowerCase();
                const subject = row.cells[2].textContent.toLowerCase();
                
                if (name.includes(searchTerm) || email.includes(searchTerm) || subject.includes(searchTerm)) {
                    row.style.display = '';
                } else {
                    row.style.display = 'none';
                }
            });
        });
    </script>
</body>
</html>