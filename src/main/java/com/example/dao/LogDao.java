package com.example.dao;

import com.example.model.Log;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class LogDao {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/loginsystem?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "MYSQL@123";

    public void addLog(Log log) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO logs (username, action, log_time) VALUES (?, ?, ?)")) {
                stmt.setString(1, log.getUsername());
                stmt.setString(2, log.getAction());
                stmt.setTimestamp(3, log.getLogTime());
                stmt.executeUpdate();
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
    }
}