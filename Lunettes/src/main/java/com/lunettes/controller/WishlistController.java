package com.lunettes.controller;

import com.lunettes.model.Wishlist;
import com.lunettes.service.WishlistService;
import com.lunettes.filter.AuthenticationFilter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { "/wishlist/add", "/wishlist/remove", "/wishlist", "/wishlist/clear" })
public class WishlistController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final WishlistService wishlistService = new WishlistService();

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        Integer userId = AuthenticationFilter.getAuthenticatedUserId(request, response);
        if (userId == null) return;

        switch (path) {
            case "/wishlist/add" -> handleAddToWishlist(request, response, userId);
            case "/wishlist/remove" -> handleRemoveFromWishlist(request, response, userId);
            case "/wishlist/clear" -> handleClearWishlist(request, response, userId);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        Integer userId = AuthenticationFilter.getAuthenticatedUserId(request, response);
        if (userId == null) return;

        if (path.equals("/wishlist")) {
            handleViewWishlist(request, response, userId);
        } else {
            response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleAddToWishlist(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            HttpSession session = request.getSession();

            boolean success = wishlistService.addToWishlist(userId, productId);
            
            if (success) {
                session.setAttribute("successMessage", "Product added to wishlist successfully!");
            } else {
                session.setAttribute("errorMessage", "Product is already in your wishlist!");
            }
            
            // Redirect back to previous page or product page
            String referer = request.getHeader("referer");
            response.sendRedirect(referer != null ? referer : request.getContextPath() + "/products");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error adding to wishlist");
            response.sendRedirect(request.getContextPath() + "/products");
        }
    }

    private void handleRemoveFromWishlist(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            int productId = Integer.parseInt(request.getParameter("productId"));
            HttpSession session = request.getSession();
            System.out.println("Product iDDDD");
            System.out.println(productId);


            boolean success = wishlistService.removeFromWishlist(userId, productId);
            System.out.println("Is success");

            System.out.println(success);

            
            if (success) {
                session.setAttribute("successMessage", "Product removed from wishlist successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to remove product from wishlist!");
            }
            
            // Redirect back to previous page or wishlist page
            String referer = request.getHeader("referer");
            response.sendRedirect(referer != null ? referer : request.getContextPath() + "/wishlist");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid product ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error removing from wishlist");
            response.sendRedirect(request.getContextPath() + "/wishlist");
        }
    }

    private void handleClearWishlist(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            HttpSession session = request.getSession();

            boolean success = wishlistService.clearWishlist(userId);
            
            if (success) {
                session.setAttribute("successMessage", "Wishlist cleared successfully!");
            } else {
                session.setAttribute("errorMessage", "Failed to clear wishlist!");
            }
            
            response.sendRedirect(request.getContextPath() + "/wishlist");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error clearing wishlist");
            response.sendRedirect(request.getContextPath() + "/wishlist");
        }
    }

    private void handleViewWishlist(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            List<Wishlist> wishlist = wishlistService.getUserWishlist(userId);
            int wishlistCount = wishlistService.getWishlistCount(userId);
            
            request.setAttribute("wishlistItems", wishlist);
            request.setAttribute("wishlistCount", wishlistCount);
            request.getRequestDispatcher("/WEB-INF/pages/wishlist.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("errorMessage", "Error loading wishlist");
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}