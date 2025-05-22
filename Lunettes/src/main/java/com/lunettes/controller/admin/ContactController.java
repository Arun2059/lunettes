package com.lunettes.controller.admin;

import com.lunettes.model.Message;
import com.lunettes.service.MessageService;
import com.lunettes.filter.AuthenticationFilter;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = { "/admin/contact", "/admin/contact/view", "/admin/contact/delete" })
public class ContactController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private final MessageService messageService = new MessageService();

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String path = request.getServletPath();
        Integer userId = AuthenticationFilter.getAuthenticatedUserId(request, response);
        if (userId == null) return;

        // Check if user is admin (you should implement this check)
        // if (!isAdmin(userId)) { ... }

        switch (path) {
            case "/admin/contact" -> handleContactList(request, response);
            case "/admin/contact/view" -> handleContactView(request, response);
            case "/admin/contact/delete" -> handleContactDelete(request, response);
            default -> response.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleContactList(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            List<Message> messages = messageService.getAllMessages();
            request.setAttribute("messages", messages);
            request.getRequestDispatcher("/WEB-INF/pages/admin/admin_contact.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error loading messages");
            response.sendRedirect(request.getContextPath() + "/admin");
        }
    }

    private void handleContactView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int messageId = Integer.parseInt(request.getParameter("id"));
            Message message = messageService.getMessageById(messageId);
            
            if (message != null) {
                // Mark as read when viewed
                messageService.markAsRead(messageId);
            }
            
            request.setAttribute("message", message);
            request.getRequestDispatcher("/WEB-INF/pages/admin/admin_contact_view.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid message ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error loading message details");
            response.sendRedirect(request.getContextPath() + "/admin/contact");
        }
    }

    private void handleContactDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int messageId = Integer.parseInt(request.getParameter("id"));
            boolean success = messageService.deleteMessage(messageId);
            
            if (success) {
                request.getSession().setAttribute("message", "Message deleted successfully");
            } else {
                request.getSession().setAttribute("message", "Failed to delete message");
            }
            
            response.sendRedirect(request.getContextPath() + "/admin/contact");
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid message ID");
        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("message", "Error deleting message");
            response.sendRedirect(request.getContextPath() + "/admin/contact");
        }
    }
}