<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lunettes.model.Message" %>
<% 
    String contextPath = request.getContextPath();
    Message message = (Message) request.getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Message Details | Lunettes Admin</title>
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

        .back-link {
            display: inline-block;
            margin-bottom: 20px;
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .back-link:hover {
            text-decoration: underline;
        }

        .message-card {
            background: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            padding: 25px;
            margin-bottom: 20px;
        }

        .message-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .sender-info {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .user-avatar {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            object-fit: cover;
        }

        .sender-details h3 {
            margin: 0 0 5px 0;
            font-size: 18px;
        }

        .sender-details p {
            margin: 0;
            color: var(--text-light);
            font-size: 14px;
        }

        .message-date {
            color: var(--text-light);
            font-size: 14px;
        }

        .message-subject {
            font-size: 20px;
            font-weight: 500;
            margin-bottom: 15px;
            color: var(--dark);
        }

        .message-content {
            line-height: 1.6;
            margin-bottom: 20px;
            white-space: pre-wrap;
        }

        .message-actions {
            display: flex;
            gap: 10px;
            margin-top: 20px;
        }

        .btn {
            display: inline-block;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            transition: all 0.2s;
            border: 1px solid transparent;
        }

        .btn-primary {
            background-color: var(--primary);
            color: white;
        }

        .btn-primary:hover {
            background-color: var(--secondary);
        }

        .btn-danger {
            background-color: var(--danger);
            color: white;
        }

        .btn-danger:hover {
            opacity: 0.9;
        }

        @media (max-width: 768px) {
            .main-content {
                margin-left: 0;
            }

            .message-header {
                flex-direction: column;
                gap: 15px;
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
                <h1>Message Details</h1>
            </div>
        </div>

        <a href="<%= contextPath %>/admin/contact" class="back-link">
            <i class="fas fa-arrow-left"></i> Back to Messages
        </a>

        <% if (message != null) { %>
            <div class="message-card">
                <div class="message-header">
                    <div class="sender-info">
                        <% if (message.getImagePath() != null && !message.getImagePath().isEmpty()) { %>
                            <img src="<%= contextPath %>/resources/images/profile/<%= message.getImagePath() %>" 
                                 alt="<%= message.getName() %>" class="user-avatar">
                        <% } else { %>
                            <div class="user-avatar" style="background-color: #eee; display: flex; align-items: center; justify-content: center;">
                                <i class="fas fa-user" style="font-size: 24px; color: #777;"></i>
                            </div>
                        <% } %>
                        <div class="sender-details">
                            <h3><%= message.getName() %></h3>
                            <p><%= message.getEmail() %></p>
                        </div>
                    </div>
                    <div class="message-date">
                        <%= message.getCreatedAt().toString() %>
                    </div>
                </div>

                <h3 class="message-subject"><%= message.getSubject() %></h3>
                
                <div class="message-content">
                    <%= message.getMessage() %>
                </div>

                <div class="message-actions">
                    <a href="mailto:<%= message.getEmail() %>?subject=Re: <%= message.getSubject() %>" 
                       class="btn btn-primary">
                        <i class="fas fa-reply"></i> Reply
                    </a>
                    <a href="<%= contextPath %>/admin/contact/delete?id=<%= message.getId() %>" 
                       class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this message?')">
                        <i class="fas fa-trash-alt"></i> Delete
                    </a>
                </div>
            </div>
        <% } else { %>
            <div class="message-card">
                <p>Message not found.</p>
            </div>
        <% } %>
    </div>
</body>
</html>