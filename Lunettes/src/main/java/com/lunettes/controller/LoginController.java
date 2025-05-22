package com.lunettes.controller;
import com.lunettes.model.*;
import java.io.IOException;

import com.lunettes.service.LoginService;
import com.lunettes.utils.CookieUtil;
import com.lunettes.utils.PasswordUtil;
import com.lunettes.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Controller for handling user login requests
 */
@WebServlet(name = "LoginController", urlPatterns = { "/login" })
public class LoginController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Cookie expiration time in seconds (30 days)
    private static final int COOKIE_MAX_AGE = 30 * 24 * 60 * 60;
    
    private LoginService loginService;
    
    @Override
    public void init() throws ServletException {
        loginService = new LoginService();
    }

    /**
     * Handles GET requests to the login page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is already logged in (from session)
        Object userSession = SessionUtil.getAttribute(request, "user");
        if (userSession != null) {
            // User is already logged in
            User user = (User) userSession;
            
            // Redirect based on role
            if (user.getRole() != null && user.getRole().equals("admin")) {
                response.sendRedirect(request.getContextPath() + "/admin/dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }
        
        // Check if "Remember Me" cookie exists
        String rememberedUsername = null;
        if (CookieUtil.getCookie(request, "rememberedUser") != null) {
            rememberedUsername = CookieUtil.getCookie(request, "rememberedUser").getValue();
            request.setAttribute("username", rememberedUsername);
            
        }
        
        // If there's a redirect message (e.g., "Please log in to access that page")
        String message = request.getParameter("message");
        if (message != null && !message.isEmpty()) {
            request.setAttribute("message", message);
        }
        
        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    /**
     * Handles POST requests for login submissions
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rememberMe = request.getParameter("rememberMe");
        
        // Preserve username for form resubmission in case of error
        request.setAttribute("username", username);
        
        // Validate input
        if (username == null || username.trim().isEmpty() || password == null || password.trim().isEmpty()) {
            request.setAttribute("error", "Username and password are required");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }
        
        // Attempt to authenticate user
        User user;
        
        try {
            //String hashPassword = PasswordUtil.encrypt(rememberMe, password)
            
            user = loginService.authenticateUser(username, password);
            
            if (user != null) {
                // Authentication successful
                
                // Store user in session
                SessionUtil.setAttribute(request, "user", user);
                System.out.println(user.getId());
                SessionUtil.setAttribute(request, "userId", user.getId());
                System.out.println(user.getRole());

                
                // If "Remember Me" is checked, store username in cookie
                if (rememberMe != null && rememberMe.equals("on")) {
                    CookieUtil.addCookie(response, "rememberedUser", username, COOKIE_MAX_AGE);
                } else {
                    // If not checked, delete any existing "Remember Me" cookie
                    CookieUtil.deleteCookie(response, "rememberedUser");
                }
                
                // Check redirect URL from session
                String redirectUrl = (String) SessionUtil.getAttribute(request, "redirectUrl");
                
                if (redirectUrl != null) {
                    // If there's a specific redirect URL stored in session, use it
                    SessionUtil.removeAttribute(request, "redirectUrl");
                    response.sendRedirect(redirectUrl);
                } else {
                    // Otherwise redirect based on user role
                    if (user.getRole() != null && user.getRole().equals("admin")) {
                        response.sendRedirect(request.getContextPath() + "/admin/dashboard");
                    } else {
                        response.sendRedirect(request.getContextPath() + "/home");
                    }
                }
            } else {
                // Authentication failed
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            }
        } catch (ClassNotFoundException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
            request.setAttribute("error", "System error occurred. Please try again later.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }
}