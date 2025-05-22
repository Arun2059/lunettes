package com.lunettes.controller;

import java.io.IOException;
import java.io.File;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.time.LocalDate;
import java.time.Period;

import com.lunettes.model.Product;
import com.lunettes.model.User;
import com.lunettes.service.UserService;
import com.lunettes.utils.SessionUtil;
import com.lunettes.utils.ValidationUtil;
import com.lunettes.utils.ImageUtil;
import com.lunettes.utils.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

/**
 * Controller for handling user account management
 * @author Asus
 */
@WebServlet(asyncSupported = true, urlPatterns = { "/myaccount" })
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 5 * 1024 * 1024,    // 5 MB
    maxRequestSize = 10 * 1024 * 1024 // 10 MB
)
public class MyAccountController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ImageUtil imageUtil;

    private UserService userService;
    
    @Override
    public void init() throws ServletException {
        userService = new UserService();
    }
    
    /**
     * Handles GET requests to display the user account page
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        User user = (User) SessionUtil.getAttribute(request, "user");
        if (user == null) {
            // User is not logged in, redirect to login page with message
            SessionUtil.setAttribute(request, "redirectUrl", request.getContextPath() + "/myaccount");
            response.sendRedirect(request.getContextPath() + "/login?message=Please log in to access your account");
            return;
        }
        
        // Retrieve the latest user data from the database
        try {
            User updatedUser = userService.getUserById(user.getId());
            if (updatedUser != null) {
                // Update session with latest user data
                SessionUtil.setAttribute(request, "user", updatedUser);
                request.setAttribute("user", updatedUser);
            } else {
                // Something went wrong with user retrieval
                request.setAttribute("errorMessage", "Failed to retrieve account information. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while loading your account information.");
        }
        
        // Forward to account page
        request.getRequestDispatcher("/WEB-INF/pages/MyAccount.jsp").forward(request, response);
    }
    
    /**
     * Handles POST requests for account updates
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Check if user is logged in
        User currentUser = (User) SessionUtil.getAttribute(request, "user");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login?message=Session expired. Please log in again");
            return;
        }
        
        // Get the action parameter to determine what to update
        String action = request.getParameter("action");
        
        if ("updateProfile".equals(action)) {
            updateProfile(request, response, currentUser);
//        } 
//        else if ("updatePassword".equals(action)) {
//            updatePassword(request, response, currentUser);
        } else if ("updateAvatar".equals(action)) {
           updateAvatar(request, response, currentUser);
        } else {
            // Invalid or missing action parameter
            request.setAttribute("errorMessage", "Invalid request. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/MyAccount.jsp").forward(request, response);
        }
    }
    
    /**
     * Updates the user's profile information
     */
    private void updateProfile(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
    	
        // Get form parameters
        String firstName = request.getParameter("firstName");
        String middleName = request.getParameter("middleName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String dob = request.getParameter("dob");
        String gender = request.getParameter("gender");
        String countryCode = request.getParameter("countryCode");
        String contactNumber = request.getParameter("contactNumber");
        String address = request.getParameter("address");

        // Validate input
        boolean isValid = true;
        StringBuilder errors = new StringBuilder();

        // First Name
        if (ValidationUtil.isNullOrEmpty(firstName) || !ValidationUtil.isAlphabetic(firstName)) {
            isValid = false;
            errors.append("Valid first name is required. ");
        }

        // Middle Name (optional)
        if (!ValidationUtil.isNullOrEmpty(middleName) && !ValidationUtil.isAlphabetic(middleName)) {
            isValid = false;
            errors.append("Middle name must contain only letters. ");
        }

        // Last Name
        if (ValidationUtil.isNullOrEmpty(lastName) || !ValidationUtil.isAlphabetic(lastName)) {
            isValid = false;
            errors.append("Valid last name is required. ");
        }

        // Username
        if (ValidationUtil.isNullOrEmpty(username) || !ValidationUtil.isAlphanumericStartingWithLetter(username)) {
            isValid = false;
            errors.append("Username must start with a letter and contain only letters and numbers. ");
        } else if (!username.equals(currentUser.getUsername())) {
            try {
                if (userService.isUsernameTaken(username)) {
                    isValid = false;
                    errors.append("Username is already taken. ");
                }
            } catch (Exception e) {
                e.printStackTrace();
                isValid = false;
                errors.append("Error checking username availability. ");
            }
        }

        // Email
        if (ValidationUtil.isNullOrEmpty(email) || !ValidationUtil.isValidEmail(email)) {
            isValid = false;
            errors.append("Valid email is required. ");
        } else if (!email.equals(currentUser.getEmail())) {
            try {
                if (userService.isEmailTaken(email)) {
                    isValid = false;
                    errors.append("Email is already registered. ");
                }
            } catch (Exception e) {
                e.printStackTrace();
                isValid = false;
                errors.append("Error checking email availability. ");
            }
        }

        // Gender
        if (!ValidationUtil.isValidGender(gender)) {
            isValid = false;
            errors.append("Gender must be 'Male' or 'Female'. ");
        }

        // Contact Number
        if (!ValidationUtil.isNullOrEmpty(contactNumber) && !ValidationUtil.isValidPhoneNumber(contactNumber)) {
            isValid = false;
            errors.append("Contact number must start with 98 and be 10 digits long. ");
        }

        // Date of Birth
        if (!ValidationUtil.isNullOrEmpty(dob)) {
            try {
                LocalDate birthDate = LocalDate.parse(dob);
                if (Period.between(birthDate, LocalDate.now()).getYears() < 13) {
                    isValid = false;
                    errors.append("You must be at least 13 years old. ");
                }
            } catch (Exception e) {
                isValid = false;
                errors.append("Invalid date of birth format. ");
            }
        }

        // If validation fails
        if (!isValid) {
            request.setAttribute("errorMessage", errors.toString());
            doGet(request, response);
            return;
        }

        // Update user object
        currentUser.setFirstName(firstName);
        currentUser.setMiddleName(middleName);
        currentUser.setLastName(lastName);
        currentUser.setUsername(username);
        currentUser.setEmail(email);
        currentUser.setDob(dob);
        currentUser.setGender(gender);
        currentUser.setCountryCode(countryCode);
        currentUser.setContactNumber(contactNumber);
        currentUser.setAddress(address);

        // Save to database
        try {
            boolean updated = userService.updateUser(currentUser);
            if (updated) {
                SessionUtil.setAttribute(request, "user", currentUser);
                request.setAttribute("successMessage", "Profile updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile. Please try again.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while updating your profile: " + e.getMessage());
        }

        // Redirect back
        doGet(request, response);
    }

    
    /**
     * Updates the user's password
     */
	/*
	 * private void updatePassword(HttpServletRequest request, HttpServletResponse
	 * response, User currentUser) throws ServletException, IOException {
	 * 
	 * String currentPassword = request.getParameter("currentPassword"); String
	 * newPassword = request.getParameter("newPassword"); String confirmPassword =
	 * request.getParameter("confirmPassword");
	 * 
	 * // Validate input boolean isValid = true; StringBuilder errors = new
	 * StringBuilder();
	 * 
	 * if (currentPassword == null || currentPassword.trim().isEmpty()) { isValid =
	 * false; errors.append("Current password is required. "); }
	 * 
	 * if (newPassword == null || newPassword.trim().isEmpty()) { isValid = false;
	 * errors.append("New password is required. "); } else if (newPassword.length()
	 * < 8) { isValid = false;
	 * errors.append("New password must be at least 8 characters long. "); }
	 * 
	 * if (confirmPassword == null || !confirmPassword.equals(newPassword)) {
	 * isValid = false; errors.append("Passwords do not match. "); }
	 * 
	 * if (!isValid) { request.setAttribute("errorMessage", errors.toString());
	 * doGet(request, response); return; }
	 * 
	 * // Verify current password try { boolean passwordMatched =
	 * userService.verifyPassword(currentUser.getId(), currentPassword); if
	 * (!passwordMatched) { request.setAttribute("errorMessage",
	 * "Current password is incorrect."); doGet(request, response); return; }
	 * 
	 * // Update password String encryptedPassword =
	 * PasswordUtil.encrypt(newPassword);
	 * currentUser.setPassword(encryptedPassword);
	 * 
	 * boolean updated = userService.updateUserPassword(currentUser.getId(),
	 * encryptedPassword); if (updated) { request.setAttribute("successMessage",
	 * "Password updated successfully!"); } else {
	 * request.setAttribute("errorMessage",
	 * "Failed to update password. Please try again."); } } catch (Exception e) {
	 * e.printStackTrace(); request.setAttribute("errorMessage",
	 * "An error occurred while updating your password: " + e.getMessage()); }
	 * 
	 * doGet(request, response); }
	 */
    
    /**
     * Updates the user's avatar
//     */
    private void updateAvatar(HttpServletRequest request, HttpServletResponse response, User currentUser)
            throws ServletException, IOException {
        
        try {
            Part filePart = request.getPart("avatar");
            
            
            String imagePath = currentUser.getAvatarPath();
            
            // Handle image upload if new image is provided
            Part imagePart = request.getPart("image");
			/*
			 * if (imagePart != null && imagePart.getSize() > 0) { String imageName =
			 * imageUtil.getImageNameFromPart(imagePart); imagePath = imageName;
			 * imageUtil.uploadImage(imagePart, request.getServletContext().getRealPath(""),
			 * "products"); }
			 */
            
            // Save uploaded profile image
	        ImageUtil imageUtil = new ImageUtil();
	        String avatarPath = imageUtil.getImageNameFromPart(filePart);
	        imageUtil.uploadImage(filePart, "", "profile");
            System.out.print(imagePath);
            
            // Check if a file was selected
            if (filePart == null || filePart.getSize() <= 0) {
                request.setAttribute("errorMessage", "Please select an image file.");
                doGet(request, response);
                return;
            }
			/*
			 * // Validate file type String fileName =
			 * Paths.get(filePart.getSubmittedFileName()).getFileName().toString(); String
			 * fileExtension = fileName.substring(fileName.lastIndexOf(".") +
			 * 1).toLowerCase();
			 * 
			 * if (!fileExtension.equals("jpg") && !fileExtension.equals("jpeg") &&
			 * !fileExtension.equals("png") && !fileExtension.equals("gif")) {
			 * request.setAttribute("errorMessage",
			 * "Only JPG, JPEG, PNG, and GIF files are allowed."); doGet(request, response);
			 * return; }
			 */
            
          
			/* currentUser.setAvatarPath(relativePath); */
            
            boolean updated = userService.updateUserAvatar(currentUser.getId(), avatarPath);
            if (updated) {
                // Update session with updated user info
                SessionUtil.setAttribute(request, "user", currentUser);
                request.setAttribute("successMessage", "Profile picture updated successfully!");
            } else {
                request.setAttribute("errorMessage", "Failed to update profile picture. Please try again.");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "An error occurred while uploading your profile picture: " + e.getMessage());
        }
        
        doGet(request, response);
    }
}