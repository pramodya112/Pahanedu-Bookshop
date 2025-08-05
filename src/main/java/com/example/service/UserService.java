package com.example.service;

import com.example.dao.UserDao;
import com.example.model.User;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.List;

public class UserService {
    private final UserDao userDao;

    public UserService() {
        this.userDao = new UserDao();
    }

    public User authenticate(String username, String password) throws SQLException {
        System.out.println("UserService: Attempting to authenticate username=" + username);
        User user = userDao.findUserByUsernameAndPassword(username, hashPassword(password));
        if (user != null) {
            System.out.println("UserService: Authentication successful for " + username);
        } else {
            System.out.println("UserService: Authentication failed for " + username);
        }
        return user;
    }

    public List<User> getAllCustomers() throws SQLException {
        return userDao.getAllCustomers();
    }

    public void addUser(User user) throws SQLException {
        user.setPassword(hashPassword(user.getPassword()));
        userDao.addUser(user);
    }

    public void updateUser(User user) throws SQLException {
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(hashPassword(user.getPassword()));
        }
        userDao.updateUser(user);
    }

    public void deleteUser(int userId) throws SQLException {
        userDao.deleteUser(userId);
    }

    private String hashPassword(String password) {
        try {
            MessageDigest digest = MessageDigest.getInstance("SHA-256");
            byte[] hash = digest.digest(password.getBytes());
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                String hex = Integer.toHexString(0xff & b);
                if (hex.length() == 1) hexString.append('0');
                hexString.append(hex);
            }
            return hexString.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Error hashing password", e);
        }
    }
}