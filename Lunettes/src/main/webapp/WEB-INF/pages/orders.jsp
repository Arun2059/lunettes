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
    <title>My Orders | Lunettes</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/header.css" />
    <link rel="stylesheet" href="<%= contextPath %>/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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

        /* Main page structure to make footer stick to bottom */
        body {
            display: flex;
            flex-direction: column;
            min-height: 100vh; /* Use viewport height to ensure full height */
        }

        main {
            flex: 1 0 auto; /* This will make main content area expand to fill available space */
        }

        footer {
            flex-shrink: 0; /* Prevent footer from shrinking */
        }

        .orders-container {
            max-width: 1200px;
            margin: 7rem auto 3rem;
            padding: 0 1rem;
        }

        .orders-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .orders-header h1 {
            font-size: 2.5rem;
            font-weight: 600;
            color: var(--primary);
        }

        /* Message styles */
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

        /* Empty orders styles */
        .empty-orders {
            text-align: center;
            padding: 4rem 2rem;
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .empty-orders p {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            color: var(--text-light);
        }

        .continue-shopping {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background: var(--accent);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .continue-shopping:hover {
            background: var(--primary);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Orders table styles */
        .orders-table {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 2rem;
            background-color: white;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        .orders-table th {
            text-align: left;
            padding: 1.2rem 1rem;
            background-color: var(--primary);
            color: white;
            font-weight: 600;
        }

        .orders-table td {
            padding: 1.2rem 1rem;
            border-bottom: 1px solid var(--light);
            vertical-align: middle;
        }

        .orders-table tr:last-child td {
            border-bottom: none;
        }

        .orders-table tr:hover {
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

        .status-delivered {
            background-color: #27ae60;
            color: white;
        }

        .status-cancelled {
            background-color: var(--secondary);
            color: white;
        }

        /* Action buttons */
        .action-btn {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 4px;
            font-size: 0.9rem;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
        }

        .view-btn {
            background-color: var(--accent);
            color: white;
        }

        .view-btn:hover {
            background-color: #2980b9;
        }

        .cancel-btn {
            background-color: var(--light);
            color: var(--secondary);
            border: 1px solid var(--secondary);
            margin-left: 0.5rem;
        }

        .cancel-btn:hover {
            background-color: var(--secondary);
            color: white;
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .orders-table {
                display: block;
                box-shadow: none;
            }

            .orders-table thead {
                display: none;
            }

            .orders-table tbody {
                display: block;
            }

            .orders-table tr {
                display: block;
                margin-bottom: 1.5rem;
                border: 1px solid var(--light);
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            .orders-table td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem;
                border-bottom: 1px solid var(--light);
            }

            .orders-table td:before {
                content: attr(data-label);
                font-weight: 600;
                margin-right: 1rem;
                color: var(--primary);
            }

            .action-btns {
                display: flex;
                justify-content: flex-end;
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <main>
        <div class="orders-container">
            <div class="orders-header">
                <h1>My Orders</h1>
            </div>

            <% if (message != null) { %>
                <div class="message <%= message.toLowerCase().contains("success") ? "success" : "error" %>">
                    <%= message %>
                </div>
                <% request.getSession().removeAttribute("message"); %>
            <% } %>

            <% if (orders == null || orders.isEmpty()) { %>
                <div class="empty-orders">
                    <p>You haven't placed any orders yet.</p>
                    <a href="<%= contextPath %>/products" class="continue-shopping">Browse Products</a>
                </div>
            <% } else { %>
                <table class="orders-table">
                    <thead>
                        <tr>
                            <th>Order #</th>
                            <th>Date</th>
                            <th>Total</th>
                            <th>Status</th>
                            <th>Payment</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Order order : orders) { %>
                        <tr>
                            <td data-label="Order #"><%= order.getOrderId() %></td>
                            <td data-label="Date"><%= order.getCreatedAt().toString().substring(0, 10) %></td>
                            <td data-label="Total">Rs. <%= String.format("%.2f", order.getTotalPrice()) %></td>
                            <td data-label="Status">
                                <% if (order.isDelivered()) { %>
                                    <span class="status-badge status-delivered">Delivered</span>
                                <% } else { %>
                                    <span class="status-badge status-processing">Processing</span>
                                <% } %>
                            </td>
                            <td data-label="Payment">
                                <% if (order.isPaid()) { %>
                                    <span style="color: #27ae60;"><i class="fas fa-check-circle"></i> Paid</span>
                                <% } else { %>
                                    <span style="color: var(--secondary);"><i class="fas fa-clock"></i> Pending</span>
                                <% } %>
                            </td>
                            <td data-label="Actions">
                                <div class="action-btns">
                                    <a href="<%= contextPath %>/orders/view?id=<%= order.getOrderId() %>" 
                                      class="action-btn view-btn">
                                        <i class="fas fa-eye"></i> View
                                    </a>
                                    <% if (!order.isDelivered() && !order.isPaid()) { %>
                                    <a href="#" class="action-btn cancel-btn">
                                        <i class="fas fa-times"></i> Cancel
                                    </a>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>
    </main>

    <jsp:include page="footer.jsp" />

    <script>
        // Add confirmation for cancel action
        document.querySelectorAll('.cancel-btn').forEach(btn => {
            btn.addEventListener('click', function(e) {
                e.preventDefault();
                if (confirm('Are you sure you want to cancel this order?')) {
                    // In a real application, you would make an AJAX call or redirect
                    alert('Order cancellation would be processed here. Backend implementation required.');
                }
            });
        });
    </script>
</body>
</html>