package com.lunettes.filter;

import java.io.IOException;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AuthenticationFilter {
	
	public static Integer getAuthenticatedUserId(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {
	    HttpSession session = request.getSession(false);
	    if (session == null || session.getAttribute("userId") == null) {
	        request.setAttribute("errorMessage", "Please log in to access this page.");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/pages/login.jsp");
	        dispatcher.forward(request, response);
	        return null;
	    }
	    return (Integer) session.getAttribute("userId");
	}


}
