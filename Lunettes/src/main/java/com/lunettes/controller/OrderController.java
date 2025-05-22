package com.lunettes.controller;

import com.lunettes.model.CartItem;
import com.lunettes.model.Order;
import com.lunettes.model.OrderDetails;
import com.lunettes.service.OrderService;
import com.lunettes.service.CartService;
import com.lunettes.filter.AuthenticationFilter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Timestamp;
import java.time.Instant;
import java.util.List;

@WebServlet(urlPatterns = { "/checkout", "/orders", "/orders/view", "/admin/orders" })
public class OrderController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final OrderService orderService = new OrderService();
    private final CartService cartService = new CartService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        Integer userId = AuthenticationFilter.getAuthenticatedUserId(request, response);
        if (userId == null) return;

        switch (path) {
            case "/checkout" -> handleCheckout(request, response, userId);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        Integer userId = AuthenticationFilter.getAuthenticatedUserId(request, response);
        if (userId == null) return;

        switch (path) {
            case "/orders" -> handleOrderList(request, response, userId);
            case "/orders/view" -> handleOrderView(request, response, userId);
            case "/admin/orders" -> handleAllOrders(request, response, userId);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleCheckout(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session == null) {
                response.sendRedirect(request.getContextPath() + "/login");
                return;
            }

            // Get cart items to calculate total
            List<CartItem> cartItems = cartService.getCartItemsForUser(userId);
            if (cartItems == null || cartItems.isEmpty()) {
                session.setAttribute("errorMessage", "Your cart is empty");
                response.sendRedirect(request.getContextPath() + "/cart/view");
                return;
            }

            // Calculate total
            double total = cartItems.stream()
                .mapToDouble(item -> item.getProduct().getPrice() * item.getQuantity())
                .sum();

            // Get cart ID (assuming one active cart per user)
            int cartId = cartItems.get(0).getCartId();

            // Create order object from form data
            Order order = new Order();
            order.setCartId(cartId);
            order.setUserId(userId);
            order.setPhone(request.getParameter("phone"));
            order.setDeliveryAddress(request.getParameter("address"));
            order.setCity(request.getParameter("city"));
            order.setZipCode(request.getParameter("zipCode"));
            order.setCountry(request.getParameter("country"));
            order.setPaymentMethod(request.getParameter("paymentMethod"));
            order.setDeliveryLocation(request.getParameter("deliveryLocation"));
            order.setTotalPrice(total);
            order.setDiscountPrice(0.0); // Could be calculated from coupon codes
            order.setCreatedAt(Timestamp.from(Instant.now()));
            order.setUpdatedAt(Timestamp.from(Instant.now()));

            // Set payment status based on payment method
            order.setPaid(!"cashOnDelivery".equals(order.getPaymentMethod()));

            // Create the order
            boolean success = orderService.createOrder(order);

            if (success) {
                session.setAttribute("successMessage", "Order placed successfully!");
                response.sendRedirect(request.getContextPath() + "/orders");
            } else {
                session.setAttribute("errorMessage", "Failed to place order");
                response.sendRedirect(request.getContextPath() + "/cart/view");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error processing your order");
            response.sendRedirect(request.getContextPath() + "/cart/view");
        }
    }

    private void handleOrderList(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            List<Order> orders = orderService.getOrdersByUserId(userId);
            request.setAttribute("orders", orders);
            request.getRequestDispatcher("/WEB-INF/pages/orders.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error loading your orders");
            response.sendRedirect(request.getContextPath() + "/");
        }
    }

    private void handleOrderView(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            int orderId = Integer.parseInt(request.getParameter("id"));
            OrderDetails details = orderService.getCompleteOrderDetails(orderId);

            Order order = orderService.getOrderById(orderId);
            System.out.print(order.getCartId());
            

            // Verify order belongs to user
            if (order == null || order.getUserId() != userId) {
                response.sendError(HttpServletResponse.SC_FORBIDDEN, "Order not found");
                return;
            }

            request.setAttribute("order", details);
            request.getRequestDispatcher("/WEB-INF/pages/order_details.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error loading order details");
            response.sendRedirect(request.getContextPath() + "/orders");
        }
    }

    private void handleAllOrders(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            String orderId = request.getParameter("id");
            
            // If a specific order is requested
            if (orderId != null && !orderId.isEmpty()) {
                int parsedOrderId = Integer.parseInt(orderId);
                OrderDetails details = orderService.getCompleteOrderDetails(parsedOrderId);
                Order order = orderService.getOrderById(parsedOrderId);

                System.out.print(order.getCartId());

                // Verify order belongs to user
                if (order == null || order.getUserId() != userId) {
                    response.sendError(HttpServletResponse.SC_FORBIDDEN, "Order not found");
                    return;
                }

                request.setAttribute("order", details);
                request.getRequestDispatcher("/WEB-INF/pages/order_details.jsp").forward(request, response);
                return; // Prevent continuing to load all orders
            }

            // Load all orders (admin view)
            List<Order> allOrders = orderService.getAllOrders();
            request.setAttribute("orders", allOrders);
            request.getRequestDispatcher("/WEB-INF/pages/admin/orders.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error loading all orders");
            response.sendRedirect(request.getContextPath() + "/admin/dashboard");
        }
    }

}