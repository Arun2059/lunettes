package com.lunettes.config;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DbConfig is a configuration class for managing database connections. It
 * handles the connection to a MySQL database using JDBC.
 */
public class DbConfig {

    // Database configuration information
    private static final String DB_NAME = "lunettes";
    private static final String URL = "jdbc:mysql://localhost:3306/" + DB_NAME + "?useSSL=false&serverTimezone=UTC";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";

    /**
     * Establishes a connection to the database.
     *
     * @return Connection object for the database
     * @throws SQLException           if a database access error occurs
     * @throws ClassNotFoundException if the JDBC driver class is not found
     */
    public static Connection getDbConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver");
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }

    /**
     * Closes the given database connection, statement, and result set.
     *
     * @param conn the database connection
     * @param stmt the prepared statement
     * @param rs   the result set
     */
    public static void closeResources(Connection conn, PreparedStatement stmt, ResultSet rs) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException ignored) {
        }

        try {
            if (stmt != null) stmt.close();
        } catch (SQLException ignored) {
        }

        try {
            if (conn != null) conn.close();
        } catch (SQLException ignored) {
        }
    }

    /**
     * Closes only the given PreparedStatement.
     *
     * @param stmt the prepared statement
     */
    public static void closeStatement(PreparedStatement stmt) {
        try {
            if (stmt != null) stmt.close();
        } catch (SQLException ignored) {
        }
    }

    /**
     * Closes only the given Connection.
     *
     * @param conn the database connection
     */
    public static void closeConnection(Connection conn) {
        try {
            if (conn != null) conn.close();
        } catch (SQLException ignored) {
        }
    }

    /**
     * Closes only the given ResultSet.
     *
     * @param rs the result set
     */
    public static void closeResultSet(ResultSet rs) {
        try {
            if (rs != null) rs.close();
        } catch (SQLException ignored) {
        }
    }
}
