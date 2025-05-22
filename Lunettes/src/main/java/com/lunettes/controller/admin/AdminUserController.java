package com.lunettes.controller.admin;

import com.lunettes.model.User;
import com.lunettes.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/admin/users")
public class AdminUserController extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<User> users = userService.getAllUsers();
            request.setAttribute("users", users);
            request.getRequestDispatcher("/WEB-INF/pages/admin/user-list.jsp").forward(request, response);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching users.");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            int userId = Integer.parseInt(request.getParameter("id"));
            try {
                boolean deleted = userService.deleteUser(userId);
                if (deleted) {
                    response.sendRedirect(request.getContextPath() + "/admin/users?success=User+deleted");
                } else {
                    response.sendRedirect(request.getContextPath() + "/admin/users?error=Deletion+failed");
                }
            } catch (SQLException | ClassNotFoundException e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/admin/users?error=Server+error");
            }
        }
    }
}
