package com.lunettes.controller;

import java.io.IOException;
import com.lunettes.model.*;
import com.lunettes.model.Message;
import com.lunettes.service.MessageService;
import com.lunettes.utils.SessionUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * @author Asus
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/contact"})
public class ContactController extends HttpServlet {
    private MessageService messageService;

	private static final long serialVersionUID = 1L;
	 @Override
	    public void init() {
	        this.messageService = new MessageService();
	    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(request, response);
	}
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
	        throws ServletException, IOException {

		User user = (User) SessionUtil.getAttribute(req, "user");
		Integer userId = user != null ? user.getId() : 0;
		String username = user != null ? user.getUsername() : "Guest";
		String imagePath = user != null ? user.getAvatarPath() : "";
		if (userId == 0) {
	        req.setAttribute("error", "Please Login First.");
		    req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
			return;
		}
		System.out.println("Outputt in ");
		System.out.println(userId);
		System.out.println(username);
		
		System.out.println(imagePath);



	    String name = req.getParameter("name");
	    String email = req.getParameter("email");
	    String subject = req.getParameter("subject");
	    String messageText = req.getParameter("message");

	    boolean hasError = false;

	    if (name == null || name.trim().isEmpty()) {
	        req.setAttribute("nameError", "Name is required.");
	        hasError = true;
	    }

	    if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) {
	        req.setAttribute("emailError", "Please enter a valid email address.");
	        hasError = true;
	    }

	    if (subject == null || subject.trim().isEmpty()) {
	        req.setAttribute("subjectError", "Subject is required.");
	        hasError = true;
	    }

	    if (messageText == null || messageText.trim().isEmpty()) {
	        req.setAttribute("messageError", "Message cannot be empty.");
	        hasError = true;
	    }

	    if (hasError) {
	        req.setAttribute("name", name);
	        req.setAttribute("email", email);
	        req.setAttribute("subject", subject);
	        req.setAttribute("messageText", messageText);
	        req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
	        return;
	    }

	    Message message = new Message();
	    message.setUserId(userId != null ? userId : 0);
	    message.setUsername(username != null ? username : "Guest");
	    message.setImagePath(imagePath != null ? imagePath : "");
	    message.setName(name);
	    message.setEmail(email);
	    message.setSubject(subject);
	    message.setMessage(messageText);

	    boolean success = messageService.saveMessage(message);

	    if (success) {
	        req.setAttribute("success", "Message submitted successfully!");
	    } else {
	        req.setAttribute("error", "Something went wrong. Please try again.");
	    }

	    req.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(req, resp);
	}

}
