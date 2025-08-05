package com.example.dao;

import com.example.model.Item;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemDao {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/loginsystem?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "MYSQL@123";

    public List<Item> findAllItems() throws SQLException {
        List<Item> items = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM items");
                 ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Item item = new Item();
                    item.setItemId(rs.getInt("item_id"));
                    item.setTitle(rs.getString("title"));
                    item.setAuthor(rs.getString("author"));
                    item.setGenre(rs.getString("genre"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    items.add(item);
                }
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
        return items;
    }

    public Item findItemById(int itemId) throws SQLException {
        Item item = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM items WHERE item_id = ?")) {
                stmt.setInt(1, itemId);
                ResultSet rs = stmt.executeQuery();
                if (rs.next()) {
                    item = new Item();
                    item.setItemId(rs.getInt("item_id"));
                    item.setTitle(rs.getString("title"));
                    item.setAuthor(rs.getString("author"));
                    item.setGenre(rs.getString("genre"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                }
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
        return item;
    }

    public void addItem(Item item) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO items (title, author, genre, price, quantity) VALUES (?, ?, ?, ?, ?)")) {
                stmt.setString(1, item.getTitle());
                stmt.setString(2, item.getAuthor());
                stmt.setString(3, item.getGenre());
                stmt.setDouble(4, item.getPrice());
                stmt.setInt(5, item.getQuantity());
                stmt.executeUpdate();
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
    }

    public void updateItem(Item item) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                         "UPDATE items SET title = ?, author = ?, genre = ?, price = ?, quantity = ? WHERE item_id = ?")) {
                stmt.setString(1, item.getTitle());
                stmt.setString(2, item.getAuthor());
                stmt.setString(3, item.getGenre());
                stmt.setDouble(4, item.getPrice());
                stmt.setInt(5, item.getQuantity());
                stmt.setInt(6, item.getItemId());
                stmt.executeUpdate();
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
    }

    public void deleteItem(int itemId) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("DELETE FROM items WHERE item_id = ?")) {
                stmt.setInt(1, itemId);
                stmt.executeUpdate();
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("JDBC Driver not found", e);
        }
    }
}