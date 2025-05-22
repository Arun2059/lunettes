<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.lunettes.model.User, com.lunettes.model.Order,com.lunettes.model.OrderDetails, com.lunettes.model.CartItem, java.util.List, java.text.SimpleDateFormat" %>
<% 
    String contextPath = request.getContextPath();
    OrderDetails orderDetails = (OrderDetails) request.getAttribute("order");
    Order order = orderDetails.getOrder();
    List<CartItem> orderItems = orderDetails.getItems();
    User currentUser = (User) session.getAttribute("user");

   
    String message = (String) request.getSession().getAttribute("message");
    SimpleDateFormat dateFormat = new SimpleDateFormat("MMM d, yyyy");
    boolean isLoggedIn = (currentUser != null);
    boolean isAdmin = isLoggedIn && "admin".equals(currentUser.getRole());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order #<%= order != null ? order.getOrderId() : "" %> | Lunettes</title>
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
            --success: #27ae60;
            --warning: #f39c12;
            --text: #333;
            --text-light: #7f8c8d;
            --border: #ddd;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text);
            background-color: #f9f9f9;
        }

        .order-details-container {
            max-width: 1200px;
            margin: 7rem auto 3rem;
            padding: 0 1.5rem;
        }

        .order-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .order-header h1 {
            font-size: 2rem;
            color: var(--primary);
        }

        .order-id {
            font-weight: 600;
            color: var(--text-light);
        }

        .order-status {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            background-color: var(--light);
            color: var(--primary);
        }

        .order-status.completed {
            background-color: #e8f5e9;
            color: var(--success);
        }

        .order-status.processing {
            background-color: #fff8e1;
            color: var(--warning);
        }

        .order-status.shipped {
            background-color: #e3f2fd;
            color: var(--accent);
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

        /* Order layout */
        .order-layout {
            display: grid;
            grid-template-columns: 2fr 1fr;
            gap: 2rem;
        }

        @media (max-width: 768px) {
            .order-layout {
                grid-template-columns: 1fr;
            }
        }

        /* Order sections */
        .order-section {
            background-color: white;
            border-radius: 8px;
            box-shadow: 0 2px 15px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .order-section h2 {
            margin-bottom: 1.5rem;
            color: var(--primary);
            font-size: 1.5rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--border);
        }

        /* Order items */
        .order-item {
            display: flex;
            gap: 1.5rem;
            padding: 1.5rem 0;
            border-bottom: 1px solid var(--border);
            align-items: center;
        }

        .order-item:last-child {
            border-bottom: none;
        }

        .order-item-img-container {
            width: 100px;
            height: 100px;
            flex-shrink: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: var(--light);
            border-radius: 6px;
            overflow: hidden;
        }

        .order-item-img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
        }

        .order-item-details {
            flex-grow: 1;
        }

        .order-item-name {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: var(--primary);
            font-size: 1.1rem;
        }

        .order-item-category {
            display: inline-block;
            font-size: 0.8rem;
            color: var(--text-light);
            margin-bottom: 0.5rem;
            background-color: var(--light);
            padding: 0.2rem 0.5rem;
            border-radius: 4px;
        }

        .order-item-price {
            color: var(--text);
            font-weight: 500;
            margin-bottom: 0.5rem;
        }

        .order-item-qty {
            color: var(--text-light);
            font-size: 0.9rem;
        }

        .order-item-subtotal {
            font-weight: 600;
            color: var(--primary);
            min-width: 100px;
            text-align: right;
        }

        /* Order summary */
        .summary-section {
            margin-bottom: 1.5rem;
        }

        .summary-section h3 {
            margin-bottom: 1rem;
            color: var(--primary);
            font-size: 1.1rem;
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.75rem;
            font-size: 0.95rem;
        }

        .summary-row.total {
            font-weight: 600;
            font-size: 1.1rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border);
        }

        .summary-row.discount {
            color: var(--success);
        }

        /* Delivery info */
        .info-row {
            margin-bottom: 1rem;
        }

        .info-label {
            font-weight: 600;
            color: var(--primary);
            margin-bottom: 0.3rem;
            font-size: 0.9rem;
        }

        .info-value {
            padding-left: 0.5rem;
        }

        /* Status timeline */
        .timeline-item {
            position: relative;
            padding-left: 2.5rem;
            margin-bottom: 1.5rem;
            min-height: 40px;
        }

        .timeline-item:before {
            content: '';
            position: absolute;
            left: 0;
            top: 0;
            width: 20px;
            height: 20px;
            border-radius: 50%;
            background-color: var(--light);
            border: 3px solid var(--text-light);
            z-index: 2;
        }

        .timeline-item.active:before {
            border-color: var(--accent);
            background-color: white;
        }

        .timeline-item.completed:before {
            background-color: var(--accent);
            border-color: var(--accent);
        }

        .timeline-item:not(:last-child):after {
            content: '';
            position: absolute;
            left: 9px;
            top: 20px;
            width: 2px;
            height: calc(100% + 1.5rem);
            background-color: var(--text-light);
            z-index: 1;
        }

        .timeline-item.completed:after {
            background-color: var(--accent);
        }

        .timeline-date {
            font-size: 0.85rem;
            color: var(--text-light);
            margin-bottom: 0.3rem;
        }

        .timeline-status {
            font-weight: 600;
        }

        /* Action buttons */
        .action-btns {
            display: flex;
            gap: 1rem;
            margin-top: 3rem;
            flex-wrap: wrap;
        }

        .action-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 0.5rem;
            padding: 0.8rem 1.5rem;
            border-radius: 6px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.2s ease;
            cursor: pointer;
            border: none;
            font-size: 0.95rem;
        }

        .back-btn {
            background-color: var(--light);
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .back-btn:hover {
            background-color: var(--primary);
            color: white;
        }

        .print-btn {
            background-color: white;
            color: var(--primary);
            border: 1px solid var(--primary);
        }

        .print-btn:hover {
            background-color: var(--primary);
            color: white;
        }

        .help-btn {
            background-color: var(--secondary);
            color: white;
        }

        .help-btn:hover {
            background-color: #c0392b;
        }

        /* Empty state */
        .empty-state {
            text-align: center;
            padding: 2rem;
            color: var(--text-light);
        }

        /* Print styles */
        @media print {
            body * {
                visibility: hidden;
            }
            .order-details-container, .order-details-container * {
                visibility: visible;
            }
            .order-details-container {
                position: absolute;
                left: 0;
                top: 0;
                width: 100%;
                margin: 0;
                padding: 1cm;
            }
            .action-btns {
                display: none;
            }
            .order-section {
                box-shadow: none;
                border: 1px solid var(--border);
                page-break-inside: avoid;
            }
        }
    </style>
</head>
<body>
 <% if (!isAdmin) { %>
    <jsp:include page="header.jsp" />
                <% } %>
                 <% if (isAdmin) { %>
    <jsp:include page="admin/sidebar.jsp">
        <jsp:param name="active" value="order" />
    </jsp:include>                <% } %>
    
    <div class="order-details-container">
        <% if (message != null) { %>
            <div class="message <%= message.toLowerCase().contains("success") ? "success" : "error" %>">
                <%= message %>
            </div>
            <% request.getSession().removeAttribute("message"); %>
        <% } %>

        <% if (order == null) { %>
            <div class="order-section">
                <div class="empty-state">
                    <i class="fas fa-exclamation-circle" style="font-size: 3rem; margin-bottom: 1rem; color: var(--secondary);"></i>
                    <h2>Order Not Found</h2>
                    <p>We couldn't find the order you're looking for.</p>
                    <a href="<%= contextPath %>/orders" class="action-btn back-btn" style="margin-top: 1.5rem;">
                        <i class="fas fa-arrow-left"></i> Back to Orders
                    </a>
                </div>
            </div>
        <% } else { %>
            <div class="order-header">
                <h1>Order Details</h1>
                <div>
                    <span class="order-id">Order #<%= order.getOrderId() %></span>
                    <span class="order-status <%= order.isDelivered() ? "completed" : order.isPaid() ? "shipped" : "processing" %>">
                        <% if (order.isDelivered()) { %>
                            <i class="fas fa-check-circle"></i> Delivered
                        <% } else if (order.isPaid()) { %>
                            <i class="fas fa-truck"></i> Shipped
                        <% } else { %>
                            <i class="fas fa-clock"></i> Processing
                        <% } %>
                    </span>
                </div>
            </div>

            <div class="order-layout">
                <div>
                    <div class="order-section">
                        <h2>Order Items</h2>
                        <% if (orderItems == null || orderItems.isEmpty()) { %>
                            <div class="empty-state">
                                <i class="fas fa-shopping-cart" style="font-size: 2rem; margin-bottom: 1rem; color: var(--text-light);"></i>
                                <p>No items found in this order.</p>
                            </div>
                        <% } else { 
                            for (CartItem item : orderItems) { 
                                if (item != null && item.getProduct() != null) { %>
                                <div class="order-item">
                                    <div class="order-item-img-container">
                                        <img src="<%= contextPath %>/resources/images/<%= item.getProduct().getImagePath() != null ? item.getProduct().getImagePath() : "default-product.png" %>" 
                                             alt="<%= item.getProduct().getName() != null ? item.getProduct().getName() : "Product" %>" 
                                             class="order-item-img">
                                    </div>
                                    <div class="order-item-details">
                                        <h3 class="order-item-name"><%= item.getProduct().getName() != null ? item.getProduct().getName() : "Unnamed Product" %></h3>
                                        <% if (item.getProduct().getCategory() != null && !item.getProduct().getCategory().isEmpty()) { %>
                                            <span class="order-item-category"><%= item.getProduct().getCategory() %></span>
                                        <% } %>
                                        <p class="order-item-price">Rs. <%= String.format("%.2f", item.getProduct().getPrice()) %></p>
                                        <p class="order-item-qty">Quantity: <%= item.getQuantity() %></p>
                                    </div>
                                    <div class="order-item-subtotal">
                                        Rs. <%= String.format("%.2f", item.getProduct().getPrice() * item.getQuantity()) %>
                                    </div>
                                </div>
                            <% } 
                            } 
                        } %>
                    </div>

                    <div class="order-section">
                        <h2>Delivery Information</h2>
                        <div class="info-row">
                            <div class="info-label">Delivery Address</div>
                            <div class="info-value"><%= order.getDeliveryAddress() != null ? order.getDeliveryAddress() : "Not specified" %></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">City</div>
                            <div class="info-value"><%= order.getCity() != null ? order.getCity() : "Not specified" %></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">ZIP Code</div>
                            <div class="info-value"><%= order.getZipCode() != null ? order.getZipCode() : "Not specified" %></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Country</div>
                            <div class="info-value"><%= order.getCountry() != null ? order.getCountry() : "Not specified" %></div>
                        </div>
                        <div class="info-row">
                            <div class="info-label">Phone Number</div>
                            <div class="info-value"><%= order.getPhone() != null ? order.getPhone() : "Not specified" %></div>
                        </div>
                    </div>
                </div>

                <div>
                    <div class="order-section">
                        <h2>Order Summary</h2>
                        
                        <div class="summary-section">
                            <h3>Payment Information</h3>
                            <div class="summary-row">
                                <span>Payment Method:</span>
                                <span>
                                    <% if (order.getPaymentMethod() != null) { 
                                        switch(order.getPaymentMethod()) { 
                                            case "creditCard": %> 
                                                <i class="far fa-credit-card"></i> Credit Card
                                            <% break; 
                                            case "paypal": %> 
                                                <i class="fab fa-paypal"></i> PayPal
                                            <% break; 
                                            case "bankTransfer": %> 
                                                <i class="fas fa-university"></i> Bank Transfer
                                            <% break; 
                                            case "cashOnDelivery": %> 
                                                <i class="fas fa-money-bill-wave"></i> Cash on Delivery
                                            <% break; 
                                            default: %>
                                                <i class="fas fa-question-circle"></i> Unknown
                                        <% } 
                                    } else { %>
                                        <i class="fas fa-question-circle"></i> Not specified
                                    <% } %>
                                </span>
                            </div>
                            <div class="summary-row">
                                <span>Payment Status:</span>
                                <span style="color: <%= order.isPaid() ? "var(--success)" : "var(--secondary)" %>;">
                                    <i class="fas fa-<%= order.isPaid() ? "check-circle" : "times-circle" %>"></i>
                                    <%= order.isPaid() ? "Paid" : "Pending" %>
                                </span>
                            </div>
                            <% if (order.getCreatedAt() != null) { %>
                            <div class="summary-row">
                                <span>Order Date:</span>
                                <span><%= dateFormat.format(order.getCreatedAt()) %></span>
                            </div>
                            <% } %>
                        </div>

                        <div class="summary-section">
                            <h3>Order Total</h3>
                            <div class="summary-row">
                                <span>Subtotal (<%= orderItems != null ? orderItems.size() : 0 %> items):</span>
                                <span>Rs. <%= String.format("%.2f", order.getTotalPrice() - order.getDiscountPrice() - 5.00) %></span>
                            </div>
                            <div class="summary-row">
                                <span>Shipping:</span>
                                <span>Rs. 5.00</span>
                            </div>
                            <% if (order.getDiscountPrice() > 0) { %>
                            <div class="summary-row discount">
                                <span>Discount:</span>
                                <span>- Rs. <%= String.format("%.2f", order.getDiscountPrice()) %></span>
                            </div>
                            <% } %>
                            <div class="summary-row total">
                                <span>Total Amount:</span>
                                <span>Rs. <%= String.format("%.2f", order.getTotalPrice()) %></span>
                            </div>
                        </div>
                    </div>

                    <div class="order-section">
                        <h2>Order Status</h2>
                        <div class="timeline-item <%= order.isPaid() ? "completed" : "active" %>">
                            <div class="timeline-date"><%= order.getCreatedAt() != null ? dateFormat.format(order.getCreatedAt()) : "N/A" %></div>
                            <div class="timeline-status">Order Placed</div>
                        </div>
                        <div class="timeline-item <%= order.isPaid() ? (order.isDelivered() ? "completed" : "active") : "" %>">
                            <div class="timeline-date">
                                <% if (order.isPaid() && order.getUpdatedAt() != null) { %>
                                    <%= dateFormat.format(order.getUpdatedAt()) %>
                                <% } %>
                            </div>
                            <div class="timeline-status">
                                <% if (order.isPaid()) { %>
                                    <%= order.isDelivered() ? "Delivered" : "Shipped" %>
                                <% } else { %>
                                    Processing Payment
                                <% } %>
                            </div>
                        </div>
                        <% if (order.isDelivered() && order.getUpdatedAt() != null) { %>
                        <div class="timeline-item completed">
                            <div class="timeline-date"><%= dateFormat.format(order.getUpdatedAt()) %></div>
                            <div class="timeline-status">Delivered</div>
                        </div>
                        <% } %>
                    </div>
                </div>
            </div>

            <div class="action-btns">
                <a href="<%= contextPath %>/orders" class="action-btn back-btn">
                    <i class="fas fa-arrow-left"></i> Back to Orders
                </a>
                <button class="action-btn print-btn" onclick="window.print()">
                    <i class="fas fa-print"></i> Print Invoice
                </button>
                <a href="<%= contextPath %>/contact" class="action-btn help-btn">
                    <i class="fas fa-question-circle"></i> Need Help?
                </a>
            </div>
        <% } %>
    </div>
 <% if (!isAdmin) { %>
    <jsp:include page="footer.jsp" />
                <% } %>
</body>
</html>