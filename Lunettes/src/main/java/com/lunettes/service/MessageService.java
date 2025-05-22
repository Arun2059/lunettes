package com.lunettes.service;

import com.lunettes.model.Message;
import com.lunettes.config.DbConfig;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class MessageService {

    public boolean isValid(Message message) {
        if (message.getName() == null || message.getName().trim().isEmpty()) return false;
        if (message.getEmail() == null || !message.getEmail().matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,}$")) return false;
        if (message.getSubject() == null || message.getSubject().trim().isEmpty()) return false;
        if (message.getMessage() == null || message.getMessage().trim().isEmpty()) return false;
        return true;
    }

    public boolean saveMessage(Message msg) {
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "INSERT INTO messages (user_id, imagepath, username, name, email, subject, message, created_at) " +
                         "VALUES (?, ?, ?, ?, ?, ?, ?, NOW())";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, msg.getUserId());
            stmt.setString(2, msg.getImagePath());
            stmt.setString(3, msg.getUsername());
            stmt.setString(4, msg.getName());
            stmt.setString(5, msg.getEmail());
            stmt.setString(6, msg.getSubject());
            stmt.setString(7, msg.getMessage());

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Message> getAllMessages() {
        List<Message> messages = new ArrayList<>();
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "SELECT * FROM messages ORDER BY created_at DESC";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Message msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setUserId(rs.getInt("user_id"));
                msg.setImagePath(rs.getString("imagepath"));
                msg.setUsername(rs.getString("username"));
                msg.setName(rs.getString("name"));
                msg.setEmail(rs.getString("email"));
                msg.setSubject(rs.getString("subject"));
                msg.setMessage(rs.getString("message"));
                msg.setCreatedAt(rs.getTimestamp("created_at"));
                msg.setRead(rs.getBoolean("is_read"));
                messages.add(msg);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return messages;
    }

    public Message getMessageById(int id) {
        Message msg = null;
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "SELECT * FROM messages WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                msg = new Message();
                msg.setId(rs.getInt("id"));
                msg.setUserId(rs.getInt("user_id"));
                msg.setImagePath(rs.getString("imagepath"));
                msg.setUsername(rs.getString("username"));
                msg.setName(rs.getString("name"));
                msg.setEmail(rs.getString("email"));
                msg.setSubject(rs.getString("subject"));
                msg.setMessage(rs.getString("message"));
                msg.setCreatedAt(rs.getTimestamp("created_at"));
                msg.setRead(rs.getBoolean("is_read"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return msg;
    }

    public boolean markAsRead(int messageId) {
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "UPDATE messages SET is_read = true WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, messageId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteMessage(int messageId) {
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "DELETE FROM messages WHERE id = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, messageId);
            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public int getUnreadMessageCount() {
        try (Connection conn = DbConfig.getDbConnection()) {
            String sql = "SELECT COUNT(*) FROM messages WHERE is_read = false";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}