package com.example.service;

import com.example.dao.ItemDao;
import com.example.dao.DatabaseConnection;
import com.example.model.Item;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class ItemService {
    private ItemDao itemDao;

    public ItemService() {
        Connection connection = DatabaseConnection.getConnection();
        this.itemDao = new ItemDao(connection);
    }

    public List<Item> getAllItems() throws SQLException {
        return itemDao.getAllItems();
    }

    public void addItem(Item item) throws SQLException {
        itemDao.addItem(item);
    }

    public void updateItem(Item item) throws SQLException {
        itemDao.updateItem(item);
    }

    public Item getItemById(int itemId) throws SQLException {
        return itemDao.getItemById(itemId);
    }

    public void deleteItem(int itemId) throws SQLException {
        itemDao.deleteItem(itemId);
    }
}