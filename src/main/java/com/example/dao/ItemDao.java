package com.example.dao;

import com.example.model.Item;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemDao {
    private Connection connection;

    public ItemDao(Connection connection) {
        this.connection = connection;
    }

    public List<Item> getAllItems() throws SQLException {
        List<Item> items = new ArrayList<>();
        String query = "SELECT * FROM items";
        try (PreparedStatement stmt = connection.prepareStatement(query);
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
        return items;
    }

    public void addItem(Item item) throws SQLException {
        String query = "INSERT INTO items (title, author, genre, price, quantity) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getAuthor());
            stmt.setString(3, item.getGenre());
            stmt.setDouble(4, item.getPrice());
            stmt.setInt(5, item.getQuantity());
            stmt.executeUpdate();
        }
    }

    public void updateItem(Item item) throws SQLException {
        String query = "UPDATE items SET title = ?, author = ?, genre = ?, price = ?, quantity = ? WHERE item_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setString(1, item.getTitle());
            stmt.setString(2, item.getAuthor());
            stmt.setString(3, item.getGenre());
            stmt.setDouble(4, item.getPrice());
            stmt.setInt(5, item.getQuantity());
            stmt.setInt(6, item.getItemId());
            stmt.executeUpdate();
        }
    }

    public Item getItemById(int itemId) throws SQLException {
        String query = "SELECT * FROM items WHERE item_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, itemId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Item item = new Item();
                    item.setItemId(rs.getInt("item_id"));
                    item.setTitle(rs.getString("title"));
                    item.setAuthor(rs.getString("author"));
                    item.setGenre(rs.getString("genre"));
                    item.setPrice(rs.getDouble("price"));
                    item.setQuantity(rs.getInt("quantity"));
                    return item;
                }
            }
        }
        return null;
    }

    public void deleteItem(int itemId) throws SQLException {
        String query = "DELETE FROM items WHERE item_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, itemId);
            stmt.executeUpdate();
        }
    }
}