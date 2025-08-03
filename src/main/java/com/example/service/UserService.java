package com.example.service;

import com.example.dao.UserDao;
import com.example.model.User;
import java.sql.SQLException;

public class UserService {
    private final UserDao userDao;

    public UserService() {
        this.userDao = new UserDao();
    }

    public User authenticate(String username, String password) throws SQLException {
        System.out.println("UserService: Attempting to authenticate username=" + username);
        User user = userDao.findUserByUsernameAndPassword(username, password);
        if (user != null) {
            System.out.println("UserService: Authentication successful for " + username);
        } else {
            System.out.println("UserService: Authentication failed for " + username);
        }
        return user;
    }
}