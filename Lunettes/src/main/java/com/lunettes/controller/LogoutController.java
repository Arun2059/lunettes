package com.lunettes.controller;

import com.lunettes.utils.CookieUtil;
import com.lunettes.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/logout")
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Invalidate the session
        SessionUtil.invalidateSession(request);

        // 2. Optionally remove specific cookies like "user" or "auth" if used
        CookieUtil.deleteCookie(response, "user");
        CookieUtil.deleteCookie(response, "authToken");

        // 3. Redirect to login or home page
        response.sendRedirect(request.getContextPath() + "/login");
    }
}
