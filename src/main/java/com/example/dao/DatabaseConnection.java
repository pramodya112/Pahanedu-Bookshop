package com.example.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseConnection {
    // Modified URL to include allowPublicKeyRetrieval=true
    private static final String URL = "jdbc:mysql://localhost:3306/loginsystem?useSSL=false&allowPublicKeyRetrieval=true";
    private static final String USER = "root";
    private static final String PASSWORD = "MYSQL@123";

    public static Connection getConnection() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException | SQLException e) {
            // Throw a RuntimeException to indicate a critical failure to connect
            throw new RuntimeException("Failed to connect to database: " + e.getMessage());
        }
    }
}