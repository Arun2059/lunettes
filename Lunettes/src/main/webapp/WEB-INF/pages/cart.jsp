<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.lunettes.model.CartItem" %>
<% 
    String contextPath = request.getContextPath();
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    String message = (String) request.getAttribute("message");
    double total = 0.0;
    if (cartItems != null) {
        for (CartItem item : cartItems) {
            total += item.getProduct().getPrice() * item.getQuantity();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Shopping Cart | Lunettes</title>
    <link rel="stylesheet" href="<%= contextPath %>/css/header.css" />
    <link rel="stylesheet" href="<%= contextPath %>/css/footer.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #000;
            --primary-hover: #333;
            --secondary-color: #6c757d;
            --secondary-hover: #5a6268;
            --accent-color: #007bff;
            --accent-hover: #0069d9;
            --danger-color: #dc3545;
            --danger-hover: #c82333;
            --light-bg: #f8f9fa;
            --border-color: #eee;
            --text-color: #212529;
            --success-bg: #dff0d8;
            --success-color: #3c763d;
            --success-border: #d6e9c6;
            --error-bg: #f2dede;
            --error-color: #a94442;
            --error-border: #ebccd1;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            line-height: 1.6;
            color: var(--text-color);
        }
        header{
        top:0;
        }

        .cart-container {
            max-width: 1200px;
            margin: 7rem auto;
            padding: 0 1rem;
        }

        .cart-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .cart-header h1 {
            font-size: 2.5rem;
            font-weight: 600;
            color: var(--primary-color);
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
            background-color: var(--success-bg);
            color: var(--success-color);
            border: 1px solid var(--success-border);
        }

        .error {
            background-color: var(--error-bg);
            color: var(--error-color);
            border: 1px solid var(--error-border);
        }

        /* Empty cart styles */
        .empty-cart {
            text-align: center;
            padding: 4rem 2rem;
            background-color: var(--light-bg);
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .empty-cart p {
            font-size: 1.2rem;
            margin-bottom: 1.5rem;
            color: var(--secondary-color);
        }

        .continue-shopping {
            display: inline-block;
            padding: 0.8rem 1.5rem;
            background: var(--accent-color);
            color: white;
            text-decoration: none;
            border-radius: 4px;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .continue-shopping:hover {
            background: var(--accent-hover);
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Cart table styles */
        .cart-items {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            margin-bottom: 2rem;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            border-radius: 8px;
            overflow: hidden;
        }

        .cart-items th {
            text-align: left;
            padding: 1.2rem 1rem;
            background-color: var(--light-bg);
            font-weight: 600;
            color: var(--primary-color);
            border-bottom: 2px solid var(--border-color);
        }

        .cart-items td {
            padding: 1.2rem 1rem;
            border-bottom: 1px solid var(--border-color);
            vertical-align: middle;
        }

        .cart-items tr:last-child td {
            border-bottom: none;
        }

        /* Product styles */
        .product-container {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .cart-item-image {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease;
        }

        .cart-item-image:hover {
            transform: scale(1.05);
        }

        .product-info {
            flex-grow: 1;
        }

        .product-name {
            font-size: 1.1rem;
            font-weight: 600;
            margin-bottom: 0.3rem;
            color: var(--primary-color);
        }

        .product-price {
            font-weight: 700;
            color: var(--text-color);
            font-size: 1.1rem;
        }

        .subtotal {
            font-weight: 700;
            color: var(--text-color);
            font-size: 1.1rem;
        }

        /* Quantity control styles */
        .quantity-control {
            display: flex;
            align-items: center;
            justify-content: flex-start;
            gap: 0;
        }

        .quantity-btn {
            width: 36px;
            height: 36px;
            background: var(--light-bg);
            border: 1px solid #ddd;
            cursor: pointer;
            font-size: 1.2rem;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: all 0.2s ease;
            border-radius: 0;
        }

        .quantity-btn:first-child {
            border-radius: 4px 0 0 4px;
        }

        .quantity-btn:last-child {
            border-radius: 0 4px 4px 0;
        }

        .quantity-btn:hover:not(:disabled) {
            background: #e9e9e9;
        }

        .quantity-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .quantity-input {
            width: 50px;
            height: 36px;
            text-align: center;
            border: 1px solid #ddd;
            border-left: none;
            border-right: none;
            font-size: 1rem;
            padding: 0 0.5rem;
            -moz-appearance: textfield; /* Firefox */
        }

        .quantity-input::-webkit-outer-spin-button,
        .quantity-input::-webkit-inner-spin-button {
            -webkit-appearance: none;
            margin: 0;
        }

        /* Remove button styles */
        .remove-button {
            background: transparent;
            border: none;
            cursor: pointer;
            color: var(--danger-color);
            font-size: 1.1rem;
            transition: all 0.2s ease;
            padding: 0.5rem;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .remove-button:hover {
            color: var(--danger-hover);
            background-color: rgba(220, 53, 69, 0.1);
        }

        /* Cart summary styles */
        .cart-summary {
            margin-top: 2.5rem;
            text-align: right;
            padding: 2rem;
            background-color: var(--light-bg);
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
        }

        .cart-summary h3 {
            font-size: 1.5rem;
            margin-bottom: 1.5rem;
            color: var(--primary-color);
        }

        .btn-group {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 1rem;
        }

        .checkout-btn {
            padding: 1rem 2rem;
            background: var(--primary-color);
            color: white;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .checkout-btn:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .update-cart {
            padding: 1rem 2rem;
            background: var(--secondary-color);
            color: white;
            border: none;
            cursor: pointer;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 4px;
            transition: all 0.3s ease;
        }

        .update-cart:hover {
            background: var(--secondary-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Checkout Modal Styles */
        .checkout-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
            justify-content: center;
            align-items: center;
        }

        .checkout-modal-content {
            background-color: white;
            padding: 2rem;
            border-radius: 8px;
            width: 90%;
            max-width: 600px;
            max-height: 90vh;
            overflow-y: auto;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.15);
        }

        .checkout-modal-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .checkout-modal-header h2 {
            font-size: 1.8rem;
            color: var(--primary-color);
        }

        .close-modal {
            background: none;
            border: none;
            font-size: 1.5rem;
            cursor: pointer;
            color: var(--secondary-color);
            transition: color 0.2s ease;
        }

        .close-modal:hover {
            color: var(--primary-color);
        }

        .checkout-form {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .form-group {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .form-group label {
            font-weight: 600;
            color: var(--primary-color);
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            padding: 0.8rem;
            border: 1px solid var(--border-color);
            border-radius: 4px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            outline: none;
            border-color: var(--accent-color);
        }

        .form-row {
            display: flex;
            gap: 1rem;
        }

        .form-row .form-group {
            flex: 1;
        }

        .order-summary {
            background-color: var(--light-bg);
            padding: 1.5rem;
            border-radius: 8px;
            margin-top: 1rem;
        }

        .order-summary h3 {
            margin-bottom: 1rem;
            color: var(--primary-color);
        }

        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 0.5rem;
        }

        .summary-row.total {
            font-weight: 700;
            font-size: 1.1rem;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid var(--border-color);
        }

        .payment-options {
            margin-top: 1rem;
        }

        .payment-option {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 0.5rem;
        }

        .submit-order {
            padding: 1rem;
            background: var(--primary-color);
            color: white;
            border: none;
            border-radius: 4px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            margin-top: 1.5rem;
        }

        .submit-order:hover {
            background: var(--primary-hover);
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        /* Responsive styles */
        @media (max-width: 768px) {
            .cart-items {
                display: block;
                box-shadow: none;
            }

            .cart-items thead {
                display: none;
            }

            .cart-items tbody {
                display: block;
            }

            .cart-items tr {
                display: block;
                margin-bottom: 1.5rem;
                border: 1px solid var(--border-color);
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
            }

            .cart-items td {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 1rem;
                border-bottom: 1px solid var(--border-color);
            }

            .cart-items td:before {
                content: attr(data-label);
                font-weight: 600;
                margin-right: 1rem;
            }

            .product-container {
                flex-direction: column;
                gap: 0.5rem;
                align-items: flex-start;
                width: 100%;
            }

            .cart-item-image {
                width: 100%;
                height: auto;
                max-height: 150px;
                object-fit: contain;
            }

            .product-info {
                width: 100%;
                text-align: center;
            }

            .quantity-control {
                justify-content: center;
                width: 100%;
            }

            .btn-group {
                flex-direction: column;
                gap: 1rem;
            }

            .checkout-btn, .update-cart {
                width: 100%;
            }

            .checkout-modal-content {
                width: 95%;
                padding: 1.5rem;
            }

            .form-row {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <jsp:include page="header.jsp" />
    
    <div class="cart-container">
        <div class="cart-header">
            <h1>Your Shopping Cart</h1>
        </div>

        <% if (message != null) { %>
            <div class="message <%= message.toLowerCase().contains("success") ? "success" : "error" %>">
                <%= message %>
            </div>
        <% } %>

        <% if (cartItems == null || cartItems.isEmpty()) { %>
            <div class="empty-cart">
                <p>Your cart is currently empty.</p>
                <a href="<%= contextPath %>/products" class="continue-shopping">Continue Shopping</a>
            </div>
        <% } else { %>
            <table class="cart-items">
                <thead>
                    <tr>
                        <th>Product</th>
                        <th>Price</th>
                        <th>Quantity</th>
                        <th>Subtotal</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CartItem item : cartItems) { %>
                    <tr>
                        <td data-label="Product">
                            <div class="product-container">
                                <img src="/Lunettes/resources/images/<%= item.getProduct().getImagePath() %>" 
                                     alt="<%= item.getProduct().getName() %>" 
                                     class="cart-item-image">
                                <div class="product-info">
                                    <h3 class="product-name"><%= item.getProduct().getName() %></h3>
                                </div>
                            </div>
                        </td>
                        <td data-label="Price" class="product-price">Rs. <%= String.format("%.2f", item.getProduct().getPrice()) %></td>
                        <td data-label="Quantity">
                            <div class="quantity-control">
                                <form action="<%= contextPath %>/cart/update" method="post" class="quantity-form">
                                    <input type="hidden" name="cartItemId" value="<%= item.getId() %>">
                                    <input type="hidden" name="productId" value="<%= item.getProduct().getId() %>">
                                    <input type="hidden" name="cartId" value="<%= item.getCartId() %>">
                                    <input type="hidden" name="currentQuantity" value="<%= item.getQuantity() %>">
                                    
                                    <button type="submit" name="action" value="decrease" class="quantity-btn" 
                                            <%= item.getQuantity() <= 1 ? "disabled" : "" %>>
                                        <i class="fas fa-minus"></i>
                                    </button>
                                    
                                    <input type="number" name="newQuantity" 
                                           class="quantity-input" value="<%= item.getQuantity() %>" min="1"
                                           onchange="this.form.submit()">
                                    
                                    <button type="submit" name="action" value="increase" class="quantity-btn">
                                        <i class="fas fa-plus"></i>
                                    </button>
                                </form>
                            </div>
                        </td>
                        <td data-label="Subtotal" class="subtotal">Rs. <%= String.format("%.2f", item.getProduct().getPrice() * item.getQuantity()) %></td>
                        <td data-label="Action">
                            <form action="<%= contextPath %>/cart/remove" method="post">
                                <input type="hidden" name="productId" value="<%= item.getId() %>">
                                <input type="hidden" name="cartId" value="<%= item.getCartId() %>">
                                
                                <button type="submit" class="remove-button" title="Remove item">
                                    <i class="fas fa-trash"></i>
                                </button>
                            </form>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="cart-summary">
                <h3>Total: Rs. <%= String.format("%.2f", total) %></h3>
                <div class="btn-group">
                    <button id="openCheckoutModal" class="checkout-btn">Proceed to Checkout</button>
                </div>
            </div>
        <% } %>
    </div>

    <!-- Checkout Modal -->
    <div id="checkoutModal" class="checkout-modal">
        <div class="checkout-modal-content">
            <div class="checkout-modal-header">
                <h2>Complete Your Order</h2>
                <button class="close-modal">&times;</button>
            </div>
            
            <form action="<%= contextPath %>/checkout" method="post" class="checkout-form">
                <div class="form-row">
                      <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="tel" id="phone" name="phone" required>
                </div>
                
                <div class="form-group">
                    <label for="address">Delivery Address</label>
                    <textarea id="address" name="address" rows="3" required></textarea>
                </div>
                </div>
                
             
                
                <div class="form-row">
                    <div class="form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" required>
                    </div>
                    <div class="form-group">
                        <label for="zipCode">ZIP Code</label>
                        <input type="text" id="zipCode" name="zipCode" required>
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="country">Country</label>
                    <select id="country" name="country" required>
                        <option value="">Select Country</option>
                        <option value="US">United States</option>
                        <option value="UK">United Kingdom</option>
                        <option value="CA">Canada</option>
                        <option value="AU">Australia</option>
                        <option value="AU">Nepal</option>
                        <!-- Add more countries as needed -->
                    </select>
                </div>
                
                <div class="order-summary">
                    <h3>Order Summary</h3>
                    <div class="summary-row">
                        <span>Subtotal:</span>
                        <span>Rs. <%= String.format("%.2f", total) %></span>
                    </div>
                    <div class="summary-row">
                        <span>Shipping:</span>
                        <span>Rs. 5.00</span>
                    </div>
                    <div class="summary-row">
                        <span>Discount:</span>
                        <span>-Rs. 0.00</span>
                    </div>
                    <div class="summary-row total">
                        <span>Total:</span>
                        <span>Rs. <%= String.format("%.2f", total + 5.00) %></span>
                    </div>
                </div>
                
                <div class="payment-options">
                    <h3>Payment Method</h3>
                    <div class="payment-option">
                        <input type="radio" id="creditCard" name="paymentMethod" value="creditCard" checked>
                        <label for="creditCard">Credit Card</label>
                    </div>
                    <div class="payment-option">
                        <input type="radio" id="paypal" name="paymentMethod" value="paypal">
                        <label for="paypal">PayPal</label>
                    </div>
                    <div class="payment-option">
                        <input type="radio" id="bankTransfer" name="paymentMethod" value="bankTransfer">
                        <label for="bankTransfer">Bank Transfer</label>
                    </div>
                    <div class="payment-option">
                        <input type="radio" id="cashOnDelivery" name="paymentMethod" value="cashOnDelivery">
                        <label for="cashOnDelivery">Cash on Delivery</label>
                    </div>
                </div>                
                
                <input type="hidden" name="totalAmount" value="<%= total + 5.00 %>">
                
                <button type="submit" class="submit-order">Place Order</button>
            </form>
        </div>
    </div>

    <jsp:include page="footer.jsp" />

    <script>
        // Checkout Modal functionality
        const checkoutModal = document.getElementById('checkoutModal');
        const openCheckoutModal = document.getElementById('openCheckoutModal');
        const closeModal = document.querySelector('.close-modal');
        
        if (openCheckoutModal) {
            openCheckoutModal.addEventListener('click', () => {
                checkoutModal.style.display = 'flex';
                document.body.style.overflow = 'hidden';
            });
        }
        
        closeModal.addEventListener('click', () => {
            checkoutModal.style.display = 'none';
            document.body.style.overflow = 'auto';
        });
        
        window.addEventListener('click', (e) => {
            if (e.target === checkoutModal) {
                checkoutModal.style.display = 'none';
                document.body.style.overflow = 'auto';
            }
        });
        
        // Apply discount code functionality (you would need to implement the backend for this)
        document.getElementById('applyDiscount').addEventListener('click', function() {
            const discountCode = document.getElementById('discountCode').value;
            // Here you would typically make an AJAX call to validate the discount code
            // For now, we'll just show a message
            alert('Discount code would be validated here. Backend implementation required.');
        });
    </script>
</body>
</html>