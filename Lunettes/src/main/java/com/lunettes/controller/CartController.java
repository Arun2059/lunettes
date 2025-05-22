package com.lunettes.controller;

import com.lunettes.filter.AuthenticationFilter;
import com.lunettes.model.CartItem;
import com.lunettes.service.CartService;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { "/cart/add", "/cart/view", "/cart/fetch_latest", "/cart/update", "/cart/remove" })
public class CartController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private final CartService cartService = new CartService();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
        Integer userId = AuthenticationFilter.getAuthenticatedUserId(request, response);
        if (userId==null)return;

		switch (path) {
		case "/cart/add" -> handleAddToCart(request, response);
		case "/cart/update" -> handleUpdateCartItem(request, response);
		case "/cart/remove" -> handleRemoveFromCart(request, response);
		default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path = request.getServletPath();
        Integer userId = AuthenticationFilter.getAuthenticatedUserId(request, response);
        if (userId==null)return;
		switch (path) {
		case "/cart/view" -> handleCartView(request, response);
		case "/cart/fetch_latest" -> handleFetchLatest(request, response);
		default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
		}
	}

	private void handleAddToCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			HttpSession session = request.getSession(false);
			/*
			 * if (session == null || session.getAttribute("userId") == null) {
			 * request.setAttribute("errorMessage", "User not logged in"); RequestDispatcher
			 * dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
			 * dispatcher.forward(request, response); return; }
			 */

			int userId = (int) session.getAttribute("userId");
			int productId = Integer.parseInt(request.getParameter("productId"));
			int quantity = Integer.parseInt(request.getParameter("quantity"));

			if (quantity <= 0) {
				response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid quantity");
				return;
			}

			boolean success = cartService.addToCart(userId, productId, quantity);
			if (success) {
				response.sendRedirect("view");
			} else {
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to add to cart");
			}
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing cart operation");
		}
	}

	private void handleUpdateCartItem(HttpServletRequest request, HttpServletResponse response) throws IOException {
		HttpSession session = request.getSession(false);
		try {
			// Check authentication
			if (session == null || session.getAttribute("userId") == null) {
				session.setAttribute("errorMessage", "Please login to update your cart");
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}
	        Integer userId = AuthenticationFilter.getAuthenticatedUserId(request, response);
	        if (userId==null)return;

			int cartItemId = Integer.parseInt(request.getParameter("cartItemId"));
			int currentQuantity = Integer.parseInt(request.getParameter("currentQuantity"));
			int productId = Integer.parseInt(request.getParameter("productId"));
			int cartId = Integer.parseInt(request.getParameter("cartId"));

			String action = request.getParameter("action");
			System.out.println("CartItemId" + cartItemId);
			System.out.println("currentQuantity" + currentQuantity);
			System.out.println("productId" + productId);

			int newQuantity = currentQuantity;

			// Determine new quantity based on action
			if ("increase".equals(action)) {

				newQuantity = currentQuantity + 1;
				System.out.print(newQuantity);
			} else if ("decrease".equals(action)) {
				newQuantity = Math.max(1, currentQuantity - 1);
			} else {
				// Handle direct input change
				newQuantity = Integer.parseInt(request.getParameter("newQuantity"));
				if (newQuantity < 1)
					newQuantity = 1;
			}

			// Check product stock if increasing quantity
			if (newQuantity > currentQuantity) {

				int availableStock = cartService.getProductStock(productId);
				if (availableStock < (newQuantity - currentQuantity)) {
					session.setAttribute("errorMessage", "Not enough stock available");
					response.sendRedirect("view");
					return;
				}
			}

			System.out.print("Hereee");
			// Verify item belongs to user's active cart
			/*
			 * if (!cartService.isCartItemOwnedByUser(cartItemId, userId)) {
			 * System.out.print("Cart not found"); session.setAttribute("errorMessage",
			 * "Cart item not found"); response.sendRedirect("view"); return; }
			 */

			// Update quantity
			boolean success = cartService.updateCartItemQuantity(cartId, cartItemId, newQuantity);

			if (success) {
				// Update product stock if quantity changed
				if (newQuantity != currentQuantity) {
					cartService.adjustProductStock(productId, currentQuantity - newQuantity);
				}
				session.setAttribute("successMessage", "Cart updated successfully");
			} else {
				session.setAttribute("errorMessage", "Failed to update cart");
			}

		} catch (NumberFormatException e) {
			session.setAttribute("errorMessage", "Invalid quantity specified");
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("errorMessage", "An error occurred while updating your cart");
		}

		response.sendRedirect("view");
	}

	private void handleRemoveFromCart(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("userId") == null) {
				response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
				return;
			}

			int productId = Integer.parseInt(request.getParameter("productId"));
			int cartId = Integer.parseInt(request.getParameter("cartId"));

			boolean success = cartService.removeFromCart(productId, cartId);
			if (success) {
				response.sendRedirect("view");
			} else {
				response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to remove item from cart");
			}
		} catch (NumberFormatException e) {
			response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid parameters");
		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error removing cart item");
		}
	}

	private void handleCartView(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		try {
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("userId") == null) {
				response.sendRedirect(request.getContextPath() + "/login");
				return;
			}

			int userId = (int) session.getAttribute("userId");
			List<CartItem> cartItems = cartService.getCartItemsForUser(userId);
			request.setAttribute("cartItems", cartItems);
			request.getRequestDispatcher("/WEB-INF/pages/cart.jsp").forward(request, response);

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error loading cart");
		}
	}

	private void handleFetchLatest(HttpServletRequest request, HttpServletResponse response) throws IOException {
		try {
			HttpSession session = request.getSession(false);
			if (session == null || session.getAttribute("userId") == null) {
				response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "User not logged in");
				return;
			}

			int userId = (int) session.getAttribute("userId");
			var latestCartSummary = cartService.getCartSummary(userId);
			response.setContentType("application/json");
			response.getWriter().write(latestCartSummary.toString());

		} catch (Exception e) {
			e.printStackTrace();
			response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Unable to fetch latest cart");
		}
	}
}