package com.lunettes.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import com.lunettes.config.DbConfig;
import com.lunettes.model.User;
import com.lunettes.utils.PasswordUtil;

/**
 * Service class for user authentication operations
 */
public class LoginService {
    
    private static final Logger LOGGER = Logger.getLogger(LoginService.class.getName());
    
    /**
     * Authenticates a user based on username/email and password
     * 
     * @param usernameOrEmail the username or email provided by the user
     * @param password the password provided by the user
     * @return User object if authentication successful, null otherwise
     * @throws ClassNotFoundException 
     */
    public User authenticateUser(String usernameOrEmail, String password) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        User user = null;

        try {
            conn = DbConfig.getDbConnection();

            // Get user with matching username or email
            String sql = "SELECT * FROM users WHERE username = ? OR email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, usernameOrEmail);
            stmt.setString(2, usernameOrEmail);

            rs = stmt.executeQuery();

            if (rs.next()) {
                // Retrieve stored hash and salt
                String storedHash = rs.getString("password");
                String storedSaltBase64 = rs.getString("salt");

                if (storedHash != null && storedSaltBase64 != null) {
                    byte[] storedSalt = Base64.getDecoder().decode(storedSaltBase64);

                    // Verify password
                    boolean passwordMatches = PasswordUtil.verifyPassword(password, storedHash, storedSalt);

                    if (passwordMatches) {
                        // Populate user object if password is correct
                        user = new User();
                        user.setId(rs.getInt("id"));
                        user.setUsername(rs.getString("username"));
                        user.setFirstName(rs.getString("first_name"));
                        user.setMiddleName(rs.getString("middle_name"));
                        user.setLastName(rs.getString("last_name"));
                        user.setEmail(rs.getString("email"));
                        user.setDob(rs.getString("dob"));
                        user.setGender(rs.getString("gender"));
                        user.setCountryCode(rs.getString("country_code"));
                        user.setContactNumber(rs.getString("contact_number"));
                        user.setAddress(rs.getString("address"));
                        user.setAvatarPath(rs.getString("avatar_path"));
                        user.setRole(rs.getString("role"));

                        // (Optional) Update last login
                        //updateLastLogin(conn, user.getId());
                    }
                }
            }

        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error authenticating user", e);
        } finally {
            DbConfig.closeResources(conn, stmt, rs);
        }

        return user;
    }

    /**
     * Updates the last login timestamp for a user
     * 
     * @param conn the database connection
     * @param userId the user ID
     */
	/*
	 * private void updateLastLogin(Connection conn, int userId) { PreparedStatement
	 * stmt = null;
	 * 
	 * try { String sql =
	 * "UPDATE users SET last_login = CURRENT_TIMESTAMP WHERE id = ?"; stmt =
	 * conn.prepareStatement(sql); stmt.setInt(1, userId); stmt.executeUpdate(); }
	 * catch (SQLException e) { LOGGER.log(Level.WARNING,
	 * "Could not update last login time", e); } finally {
	 * DbConfig.closeStatement(stmt); } }
	 */
    
    /**
     * Checks if a username exists in the database
     * 
     * @param username the username to check
     * @return true if username exists, false otherwise
     * @throws ClassNotFoundException 
     */
    public boolean usernameExists(String username) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;
        
        try {
            conn = DbConfig.getDbConnection();
            String sql = "SELECT 1 FROM users WHERE username = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, username);
            rs = stmt.executeQuery();
            
            exists = rs.next();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking username existence", e);
        } finally {
        	DbConfig.closeResources(conn, stmt, rs);
        }
        
        return exists;
    }
    
    /**
     * Checks if an email exists in the database
     * 
     * @param email the email to check
     * @return true if email exists, false otherwise
     * @throws ClassNotFoundException 
     */
    public boolean emailExists(String email) throws ClassNotFoundException {
        Connection conn = null;
        PreparedStatement stmt = null;
        ResultSet rs = null;
        boolean exists = false;
        
        try {
            conn = DbConfig.getDbConnection();
            String sql = "SELECT 1 FROM users WHERE email = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, email);
            rs = stmt.executeQuery();
            
            exists = rs.next();
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking email existence", e);
        } finally {
        	DbConfig.closeResources(conn, stmt, rs);
        }
        
        return exists;
    }
}