package com.lunettes.controller;

import java.io.IOException;
import java.time.LocalDate;

import com.lunettes.utils.ValidationUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * @author Asus
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/register"})
@MultipartConfig
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
	        throws ServletException, IOException {

	    request.setCharacterEncoding("UTF-8");

	    String firstName = request.getParameter("firstName");
	    String middleName = request.getParameter("middleName");
	    String lastName = request.getParameter("lastName");
	    String username = request.getParameter("username");
	    String dobStr = request.getParameter("dob");
	    String gender = request.getParameter("gender");
	    String email = request.getParameter("email");
	    String countryCode = request.getParameter("country_code"); // Fixed field name to match JSP
	    String contactNumber = request.getParameter("contactNumber");
	    String address = request.getParameter("address");
	    String password = request.getParameter("password");
	    String retypePassword = request.getParameter("retypePassword");
	    String role = "user";
	    Part profileImage = null;
	    System.out.print(password);
	    // Safely get the profile image part
	    try {
	        profileImage = request.getPart("avatar"); // Fixed to match JSP field name
	    } catch (Exception e) {
	        // Handle case where no file is uploaded
	    }

	    boolean hasError = false;
	    StringBuilder errorMsg = new StringBuilder();

	    // Perform validations
	    if (ValidationUtil.isNullOrEmpty(firstName) || !ValidationUtil.isAlphabetic(firstName)) {
	        hasError = true;
	        errorMsg.append("Invalid First Name. ");
	    }

	    if (!ValidationUtil.isNullOrEmpty(middleName) && !ValidationUtil.isAlphabetic(middleName)) {
	        hasError = true;
	        errorMsg.append("Middle Name must contain only letters. ");
	    }

	    if (ValidationUtil.isNullOrEmpty(lastName) || !ValidationUtil.isAlphabetic(lastName)) {
	        hasError = true;
	        errorMsg.append("Invalid Last Name. ");
	    }

	    if (!ValidationUtil.isAlphanumericStartingWithLetter(username)) {
	        hasError = true;
	        errorMsg.append("Username must start with a letter and contain only letters and digits. ");
	    }

	    LocalDate dob = null;
	    try {
	        dob = LocalDate.parse(dobStr);
	        if (!ValidationUtil.isAgeAtLeast16(dob)) {
	            hasError = true;
	            errorMsg.append("You must be at least 16 years old. ");
	        }
	    } catch (Exception e) {
	        hasError = true;
	        errorMsg.append("Invalid Date of Birth. ");
	    }

	    if (!ValidationUtil.isValidGender(gender)) {
	        hasError = true;
	        errorMsg.append("Invalid Gender. ");
	    }

	    if (!ValidationUtil.isValidEmail(email)) {
	        hasError = true;
	        errorMsg.append("Invalid Email Address. ");
	    }

	    if (!ValidationUtil.isValidPhoneNumber(contactNumber)) {
	        hasError = true;
	        errorMsg.append("Contact Number must start with 98 and be 10 digits long. ");
	    }

	    if (ValidationUtil.isNullOrEmpty(address)) {
	        hasError = true;
	        errorMsg.append("Address is required. ");
	    }

	    if (!ValidationUtil.isValidPassword(password)) {
	        hasError = true;
	        errorMsg.append("Password must have at least 1 uppercase letter, 1 number, and 1 special symbol. ");
	    }

	    if (!ValidationUtil.doPasswordsMatch(password, retypePassword)) {
	        hasError = true;
	        errorMsg.append("Passwords do not match. ");
	    }

	    if (profileImage != null && profileImage.getSize() > 0 && !ValidationUtil.isValidImageExtension(profileImage)) {
	        hasError = true;
	        errorMsg.append("Invalid profile image format. Only JPG, JPEG, PNG, and GIF are allowed. ");
	    }

	    // Set all form values as attributes to preserve them in case of error
	    request.setAttribute("firstName", firstName);
	    request.setAttribute("middleName", middleName);
	    request.setAttribute("lastName", lastName);
	    request.setAttribute("username", username);
	    request.setAttribute("dob", dobStr);
	    request.setAttribute("gender", gender);
	    request.setAttribute("email", email);
	    request.setAttribute("country_code", countryCode);
	    request.setAttribute("contactNumber", contactNumber);
	    request.setAttribute("address", address);

	    if (hasError) {
	        request.setAttribute("error", errorMsg.toString());
	        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	        return;
	    }

	    com.lunettes.service.RegisterService service = new com.lunettes.service.RegisterService();
	    boolean success;
		try {
			success = service.registerUser(
			        firstName, middleName, lastName, username, dobStr, gender,
			        email, countryCode, contactNumber, address, password, role, profileImage
			);
		

	    if (success) {
	        request.setAttribute("message", "Registration successful!");
	    } else {
	        request.setAttribute("error", "Registration failed. Try again.");
	    }

	    request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
	
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	}
}