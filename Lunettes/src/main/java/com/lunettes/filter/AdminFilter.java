package com.lunettes.filter;

import com.lunettes.model.User;
import com.lunettes.utils.SessionUtil;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/admin/*")
public class AdminFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        
        // Check if user is logged in and has admin role
        User user = (User) SessionUtil.getAttribute(httpRequest, "user");
        
        if (user == null) {
            // User not logged in - redirect to login with message
            SessionUtil.setAttribute(httpRequest, "redirectUrl", httpRequest.getRequestURI());
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?message=Please login as admin to access this page");
            return;
        }
        
        if (!"admin".equals(user.getRole())) {
            // User doesn't have admin role - redirect to home with error
            httpResponse.sendRedirect(httpRequest.getContextPath() + "/home?error=Access denied");
            return;
        }
        
        // User is admin - continue with the request
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }

    @Override
    public void destroy() {
        // Cleanup code if needed
    }
}