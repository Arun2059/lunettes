	<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lunettes.model.User,com.lunettes.model.DashboardData, com.lunettes.model.DashboardStats, com.lunettes.model.RecentOrder" %>
<%
    DashboardData dashboardData = (DashboardData) request.getAttribute("dashboardData");
    DashboardStats stats = dashboardData != null ? dashboardData.getStats() : null;
    java.util.List<RecentOrder> recentOrders = dashboardData != null ? dashboardData.getRecentOrders() : new java.util.ArrayList<>();
    User currentUser = (User) session.getAttribute("user");

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard</title>
    <link rel="shortcut icon" type="x-icon" href="images/logo.png" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/css/admindashboard.css" />
    
</head>
<body>

<jsp:include page="sidebar.jsp">
    <jsp:param name="active" value="dashboard" />
</jsp:include>

<div class="main-content" style="margin-left:400px;">
    <div class="top-bar">
        <div class="page-title">
            <h1>Dashboard Overview</h1>
        </div>
        <div class="user-profile">
                                <img src="${pageContext.request.contextPath}/resources/images/profile/<%= currentUser.getAvatarPath() %>" alt="Profile">
        
<%--             <img src="/lunettes/resources/images/profile/<%= currentUser.getAvatarPath() %>" alt="User">
 --%>            <span>            <%= currentUser.getFirstName()%></span>
        </div>
    </div>

    <!-- Stats Cards -->
    <div class="card-grid">
        <div class="card">
            <h3>Total Sales</h3>
            <div class="stat-value">Rs.<%= stats != null ? stats.getTotalSales() : 0 %></div>
            <div class="stat-label">This Month</div>
            <div class="trend up">
                <i class="fas fa-arrow-up"></i> <%= stats != null ? stats.getMonthlySalesChange() : 0 %>% from last month
            </div>
        </div>
        <div class="card">
            <h3>Total Orders</h3>
            <div class="stat-value"><%= stats != null ? stats.getTotalOrders() : 0 %></div>
            <div class="stat-label">This Month</div>
            <div class="trend up">
                <i class="fas fa-arrow-up"></i> <%= stats != null ? stats.getMonthlyOrdersChange() : 0 %>% from last month
            </div>
        </div>
        <div class="card">
            <h3>New Customers</h3>
            <div class="stat-value"><%= stats != null ? stats.getNewCustomers() : 0 %></div>
            <div class="stat-label">This Month</div>
            <div class="trend down">
                <i class="fas fa-arrow-down"></i> <%= stats != null ? stats.getMonthlyCustomersChange() : 0 %>% from last month
            </div>
        </div>
        <div class="card">
            <h3>Inventory Alerts</h3>
            <div class="stat-value"><%= stats != null ? stats.getInventoryAlerts() : 0 %></div>
            <div class="stat-label">Low Stock Items</div>
            <div class="trend up">
                <i class="fas fa-exclamation-triangle"></i> Needs attention
            </div>
        </div>
    </div>

    <!-- Recent Orders -->
    <div class="recent-orders">
        <h3>Recent Orders</h3>
        <table>
            <thead>
                <tr>
                    <th>Order ID</th>
                    <th>Customer</th>
                    <th>Date</th>
                    <th>Amount</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
            <% if (recentOrders != null && !recentOrders.isEmpty()) {
                for (RecentOrder order : recentOrders) {
            %>
                <tr>
                    <td>#<%= order.getOrderId() %></td>
                    <td><%= order.getCustomerName() %></td>
                    <td><%= order.getOrderDate() %></td>
                    <td>Rs.<%= order.getAmount() %></td>
                    <td><span class="status <%= order.getStatus().toLowerCase() %>"><%= order.getStatus() %></span></td>
                    <td><a href="#">View</a></td>
                </tr>
            <%  }
               } else { %>
                <tr><td colspan="6">No recent orders found.</td></tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

</body>
</html>
