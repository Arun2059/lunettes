package com.lunettes.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.lunettes.config.DbConfig;
import com.lunettes.utils.ImageUtil;
import com.lunettes.utils.PasswordUtil;

import jakarta.servlet.http.Part;

public class RegisterService {
	public boolean registerUser(
	        String firstName, String middleName, String lastName,
	        String username, String dob, String gender,
	        String email, String countryCode, String contactNumber,
	        String address, String password, String role,
	        Part profileImagePart) throws Exception {

	    boolean isSaved = false;

	    try (Connection conn = DbConfig.getDbConnection()) {
	        // Generate salt and hash the password
	        byte[] salt = PasswordUtil.generateSalt();
	        String encodedSalt = PasswordUtil.encodeSalt(salt);
	        String hashedPassword = PasswordUtil.hashPassword(password, salt);

	        // Save uploaded profile image
	        ImageUtil imageUtil = new ImageUtil();
	        String avatarPath = imageUtil.getImageNameFromPart(profileImagePart);
	        imageUtil.uploadImage(profileImagePart, "", "profile");

	        // SQL with salt column included
	        String sql = "INSERT INTO users (first_name, middle_name, last_name, username, dob, gender, email, country_code, contact_number, address, password, salt, avatar_path, role) " +
	                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

	        PreparedStatement stmt = conn.prepareStatement(sql);
	        stmt.setString(1, firstName);
	        stmt.setString(2, middleName);
	        stmt.setString(3, lastName);
	        stmt.setString(4, username);
	        stmt.setString(5, dob);
	        stmt.setString(6, gender);
	        stmt.setString(7, email);
	        stmt.setString(8, countryCode);
	        stmt.setString(9, contactNumber);
	        stmt.setString(10, address);
	        stmt.setString(11, hashedPassword);
	        stmt.setString(12, encodedSalt); // add salt here
	        stmt.setString(13, avatarPath);
	        stmt.setString(14, role);

	        int rows = stmt.executeUpdate();
	        isSaved = rows > 0;

	    } catch (ClassNotFoundException | SQLException e) {
	        e.printStackTrace();
	    }

	    return isSaved;
	}

}
