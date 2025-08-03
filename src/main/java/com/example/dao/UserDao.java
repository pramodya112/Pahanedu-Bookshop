package com.example.dao;

import com.example.model.User;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/loginsystem?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "MYSQL@123";

    public User findUserByUsernameAndPassword(String username, String password) throws SQLException {
        User user = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?")) {
                stmt.setString(1, username);
                stmt.setString(2, password);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    user = new User();
                    user.setUserId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    System.out.println("UserDao: Found user: " + user.getUsername());
                } else {
                    System.out.println("UserDao: No user found for username: " + username);
                }
            }
        } catch (ClassNotFoundException e) {
            System.out.println("UserDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
        return user;
    }

    public List<User> findUsersByRole(String role) throws SQLException {
        List<User> users = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM users WHERE role = ?")) {
                stmt.setString(1, role);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    User user = new User();
                    user.setUserId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                    users.add(user);
                }
                System.out.println("UserDao: Found " + users.size() + " users with role=" + role);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("UserDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
        return users;
    }
}