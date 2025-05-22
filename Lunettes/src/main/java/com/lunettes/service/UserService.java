package com.lunettes.service;

import com.lunettes.model.User;
import com.lunettes.config.DbConfig;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserService {
    
    // Fetch all users from the database
    public List<User> getAllUsers() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users";
        List<User> users = new ArrayList<>();
        
        try (Connection conn = DbConfig.getDbConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                User user = extractUserFromResultSet(rs);
                users.add(user);
            }
        }
        return users;
    }
    
    // Fetch user by ID
    public User getUserById(int id) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE id = ?";
        User user = null;
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = extractUserFromResultSet(rs);
                }
            }
        }
        return user;
    }
    
    // Fetch user by email
    public User getUserByEmail(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE email = ?";
        User user = null;
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = extractUserFromResultSet(rs);
                }
            }
        }
        return user;
    }
    
    // Fetch user by username
    public User getUserByUsername(String username) throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM users WHERE username = ?";
        User user = null;
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    user = extractUserFromResultSet(rs);
                }
            }
        }
        return user;
    }
    
    // Update user information
    public boolean updateUser(User user) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE users SET first_name = ?, middle_name = ?, last_name = ?, username = ?, " +
                     "dob = ?, gender = ?, email = ?, country_code = ?, contact_number = ?, " +
                     "address = ?, avatar_path = ?, role = ? WHERE id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, user.getFirstName());
            stmt.setString(2, user.getMiddleName());
            stmt.setString(3, user.getLastName());
            stmt.setString(4, user.getUsername());
            stmt.setDate(5, Date.valueOf(user.getDob()));
            stmt.setString(6, user.getGender());
            stmt.setString(7, user.getEmail());
            stmt.setString(8, user.getCountryCode());
            stmt.setString(9, user.getContactNumber());
            stmt.setString(10, user.getAddress());
            stmt.setString(11, user.getAvatarPath());
            stmt.setString(12, user.getRole());
            stmt.setInt(13, user.getId());
            
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Delete a user by ID
    public boolean deleteUser(int id) throws SQLException, ClassNotFoundException {
        String sql = "DELETE FROM users WHERE id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, id);
            return stmt.executeUpdate() > 0;
        }
    }
    
    // Helper method to extract user data from ResultSet
    private User extractUserFromResultSet(ResultSet rs) throws SQLException {
        User user = new User();
        user.setId(rs.getInt("id"));
        user.setFirstName(rs.getString("first_name"));
        user.setMiddleName(rs.getString("middle_name"));
        user.setLastName(rs.getString("last_name"));
        user.setUsername(rs.getString("username"));
        user.setDob(rs.getDate("dob").toString());
        user.setGender(rs.getString("gender"));
        user.setEmail(rs.getString("email"));
        user.setCountryCode(rs.getString("country_code"));
        user.setContactNumber(rs.getString("contact_number"));
        user.setAddress(rs.getString("address"));
        user.setPassword(rs.getString("password"));
        //user.set(rs.getString("salt"));
        user.setAvatarPath(rs.getString("avatar_path"));
        user.setRole(rs.getString("role"));
        
        return user;
    }
    
 // Check if a username is already taken
    public boolean isUsernameTaken(String username) throws SQLException, ClassNotFoundException {
        String sql = "SELECT id FROM users WHERE username = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, username);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // returns true if a record is found
            }
        }
    }

    // Check if an email is already taken
    public boolean isEmailTaken(String email) throws SQLException, ClassNotFoundException {
        String sql = "SELECT id FROM users WHERE email = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, email);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next(); // returns true if a record is found
            }
        }
    }

//    // Update only the avatar path of a user
    public boolean updateUserAvatar(int userId, String avatarPath) throws SQLException, ClassNotFoundException {
        String sql = "UPDATE users SET avatar_path = ? WHERE id = ?";
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, avatarPath);
            stmt.setInt(2, userId);
            return stmt.executeUpdate() > 0;
        }
    }
    

}