<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.lunettes.model.Order" %>
<% 
    String contextPath = request.getContextPath();
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String message = (String) request.getSession().getAttribute("message");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Manage Orders | Lunettes</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/header.css" />
    <link rel="stylesheet" href="<%= contextPath %>/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
        <link rel="stylesheet" href="<%= request.getContextPath() %>/css/sidebar.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/products.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/products.css" />
    <style>
        :root {
            --primary: #2c3e50;
            --secondary: #e74c3c;
            --light: #ecf0f1;
            --dark: #1a252f;
            --accent: #3498db;
            --text: #333;
            --text-light: #7f8c8d;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        html, body {
            height: 100%;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text);
            background-color: var(--light);
        }

        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        main {
            flex: 1 0 auto;
        }

        footer {
            flex-shrink: 0;
        }

        .admin-container {
            max-width: 1400px;
            margin: 7rem auto 3rem;
            padding: 0 1rem;
        }

        .admin-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .admin-header h1 {
            font-size: 2.5rem;
            font-weight: 600;
            color: var(--primary);
        }

        .message {
            padding: 1rem;
            margin: 1.5rem 0;
            border-radius: 6px;
            text-align: center;
            font-size: 1rem;
            font-weight: 500;
        }

        .success {
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #d6e9c6;
        }

        .error {
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #ebccd1;
        }

        /* Admin controls */
        .admin-controls {
            display: flex;
            justify-content: space-between;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .search-filter {
            display: flex;
            gap: 1rem;
        }

        .search-filter input, .search-filter select {
            padding: 0.5rem 1rem;
            border: 1px solid #ddd;
            border-radius: 4px;
            font-size: 1rem;
        }

        .search-filter button {
            padding: 0.5rem 1.5rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        /* Orders table styles */
        .admin-orders-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 2rem;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        .admin-orders-table th {
            text-align: left;
            padding: 1.2rem 1rem;
            background-color: var(--primary);
            color: white;
            font-weight: 600;
        }

        .admin-orders-table td {
            padding: 1.2rem 1rem;
            border-bottom: 1px solid var(--light);
            vertical-align: middle;
        }

        .admin-orders-table tr:last-child td {
            border-bottom: none;
        }

        .admin-orders-table tr:hover {
            background-color: rgba(0, 0, 0, 0.02);
        }

        /* Status badges */
        .status-badge {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.85rem;
            font-weight: 600;
        }

        .status-pending {
            background-color: #f39c12;
            color: white;
        }

        .status-processing {
            background-color: var(--accent);
            color: white;
        }

        .status-shipped {
            background-color: #9b59b6;
            color: white;
        }

        .status-delivered {
            background-color: #27ae60;
            color: white;
        }

        .status-cancelled {
            background-color: var(--secondary);
            color: white;
        }

        .status-returned {
            background-color: #95a5a6;
            color: white;
        }

        /* Action buttons and dropdown */
        .action-btns {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
        }

        .action-btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            font-size: 0.9rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
        }

        .view-btn {
            background-color: var(--accent);
            color: white;
        }

        .view-btn:hover {
            background-color: #2980b9;
        }

        .status-select {
            padding: 0.5rem;
            border-radius: 4px;
            border: 1px solid #ddd;
            font-size: 0.9rem;
            background-color: white;
            cursor: pointer;
        }

        .status-select:focus {
            outline: none;
            border-color: var(--accent);
        }

        .update-status-btn {
            background-color: #27ae60;
            color: white;
            border: none;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            cursor: pointer;
            font-size: 0.9rem;
        }

        .update-status-btn:hover {
            background-color: #219653;
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .admin-orders-table {
                display: block;
                box-shadow: none;
            }

            .admin-orders-table thead {
                display: none;
            }

            .admin-orders-table tbody {
                display: block;
            }

            .admin-orders-table tr {
                display: block;
                margin-bottom: 1.5rem;
                border: 1px solid var(--light);
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            .admin-orders-table td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem;
                border-bottom: 1px solid var(--light);
            }

            .admin-orders-table td:before {
                content: attr(data-label);
                font-weight: 600;
                margin-right: 1rem;
                color: var(--primary);
            }

            .action-btns {
                justify-content: flex-end;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="sidebar.jsp">
        <jsp:param name="active" value="order" />
    </jsp:include>    
    <main>
        <div class="admin-container">
            <div class="admin-header">
                <h1>Manage Orders</h1>
            </div>

            <% if (message != null) { %>
                <div class="message <%= message.toLowerCase().contains("success") ? "success" : "error" %>">
                    <%= message %>
                </div>
                <% request.getSession().removeAttribute("message"); %>
            <% } %>

            <div class="admin-controls">
                <div class="search-filter">
                    <input type="text" id="searchInput" placeholder="Search orders...">
                    <select id="statusFilter">
                        <option value="">All Statuses</option>
                        <option value="pending">Pending</option>
                        <option value="processing">Processing</option>
                        <option value="shipped">Shipped</option>
                        <option value="delivered">Delivered</option>
                        <option value="cancelled">Cancelled</option>
                    </select>
                    <button id="filterBtn">Filter</button>
                </div>
            </div>

            <% if (orders == null || orders.isEmpty()) { %>
                <div class="empty-orders">
                    <p>No orders found.</p>
                </div>
            <% } else { %>
                <table class="admin-orders-table">
                    <thead>
                        <tr>
                            <th>Order #</th>
                            <th>Customer</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Payment</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order order : orders) { %>
                        <tr>
                            <td data-label="Order #"><%= order.getOrderId() %></td>
                            <td data-label="Customer">User #<%= order.getUserId() %></td>
                            <td data-label="Date"><%= order.getCreatedAt().toString().substring(0, 10) %></td>
                            <td data-label="Total">Rs. <%= String.format("%.2f", order.getTotalPrice()) %></td>
                            <td data-label="Payment">
                                <% if (order.isPaid()) { %>
                                    <span style="color: #27ae60;"><i class="fas fa-check-circle"></i> Paid</span>
                                <% } else { %>
                                    <span style="color: var(--secondary);"><i class="fas fa-clock"></i> Pending</span>
                                <% } %>
                            </td>
                            <td data-label="Status">
                                <form class="status-form" action="<%= contextPath %>/admin/orders/update-status" method="post">
                                    <input type="hidden" name="orderId" value="<%= order.getOrderId() %>">
                                    <select name="status" class="status-select" onchange="this.form.submit()">
                                        
                                    </select>
                                </form>
                            </td>
                            <td data-label="Actions">
                                <div class="action-btns">
                                    <a href="<%= contextPath %>/admin/orders?id=<%= order.getOrderId() %>" 
                                      class="action-btn view-btn">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </main>


    <script>
        // Simple client-side filtering
        document.getElementById('filterBtn').addEventListener('click', function() {
            const searchTerm = document.getElementById('searchInput').value.toLowerCase();
            const statusFilter = document.getElementById('statusFilter').value.toLowerCase();
            
            document.querySelectorAll('.admin-orders-table tbody tr').forEach(row => {
                const orderId = row.cells[0].textContent.toLowerCase();
                const customerId = row.cells[1].textContent.toLowerCase();
                const status = row.querySelector('.status-select').value.toLowerCase();
                
                const matchesSearch = orderId.includes(searchTerm) || customerId.includes(searchTerm);
                const matchesStatus = statusFilter === '' || status === statusFilter;
                
                row.style.display = (matchesSearch && matchesStatus) ? '' : 'none';
            });
        });

        // Initialize with any URL parameters
        window.addEventListener('DOMContentLoaded', function() {
            const urlParams = new URLSearchParams(window.location.search);
            const statusParam = urlParams.get('status');
            
            if (statusParam) {
                document.getElementById('statusFilter').value = statusParam;
                document.getElementById('filterBtn').click();
            }
        });
    </script>
</body>
</html>