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
        List<Item> itemList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM items")) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Item item = new Item();
                    item.setItemId(rs.getInt("item_id"));
                    item.setName(rs.getString("name"));
                    item.setDescription(rs.getString("description"));
                    item.setPrice(rs.getDouble("price"));
                    item.setStockQuantity(rs.getInt("stock_quantity"));
                    itemList.add(item);
                    System.out.println("ItemDao: Found item: " + item.getName());
                }
                System.out.println("ItemDao: Retrieved " + itemList.size() + " items");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("ItemDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
        return itemList;
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
                    item.setName(rs.getString("name"));
                    item.setDescription(rs.getString("description"));
                    item.setPrice(rs.getDouble("price"));
                    item.setStockQuantity(rs.getInt("stock_quantity"));
                    System.out.println("ItemDao: Found item: " + item.getName());
                }
            }
        } catch (ClassNotFoundException e) {
            System.out.println("ItemDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
        return item;
    }

    public void addItem(Item item) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO items (name, description, price, stock_quantity) VALUES (?, ?, ?, ?)")) {
                stmt.setString(1, item.getName());
                stmt.setString(2, item.getDescription());
                stmt.setDouble(3, item.getPrice());
                stmt.setInt(4, item.getStockQuantity());
                stmt.executeUpdate();
                System.out.println("ItemDao: Added item: " + item.getName());
            }
        } catch (ClassNotFoundException e) {
            System.out.println("ItemDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
    }

    public void updateItemStock(int itemId, int stockQuantity) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("UPDATE items SET stock_quantity = ? WHERE item_id = ?")) {
                stmt.setInt(1, stockQuantity);
                stmt.setInt(2, itemId);
                stmt.executeUpdate();
                System.out.println("ItemDao: Updated stock for item ID: " + itemId);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("ItemDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
    }
}