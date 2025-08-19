package com.example.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class LogService {

    private static final String DB_URL = "jdbc:mysql://localhost:3306/loginsystem";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "MYSQL@123";

    public void logEvent(String username, String action) {
        String insertSQL = "INSERT INTO logs (action, username) VALUES (?, ?)";
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(insertSQL)) {
                stmt.setString(1, action);
                stmt.setString(2, username);
                stmt.executeUpdate();
            }
        } catch (ClassNotFoundException | SQLException e) {
            System.err.println("Error logging event for user " + username + ": " + e.getMessage());
            e.printStackTrace();
        }
    }
}