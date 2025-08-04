package com.example.service;

import com.example.dao.ItemDao;
import com.example.model.Item;
import java.sql.SQLException;
import java.util.List;

public class ItemService {
    private final ItemDao itemDao;

    public ItemService() {
        this.itemDao = new ItemDao();
    }

    public List<Item> getAllItems() throws SQLException {
        return itemDao.findAllItems();
    }

    public Item getItemById(int itemId) throws SQLException {
        return itemDao.findItemById(itemId);
    }

    public void addItem(Item item) throws SQLException {
        itemDao.addItem(item);
    }

    public void updateItem(Item item) throws SQLException {
        itemDao.updateItem(item);
    }

    public void deleteItem(int itemId) throws SQLException {
        itemDao.deleteItem(itemId);
    }
}