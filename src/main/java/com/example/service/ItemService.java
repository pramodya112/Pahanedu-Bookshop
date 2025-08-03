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
        System.out.println("ItemService: Fetching all items");
        List<Item> itemList = itemDao.findAllItems();
        System.out.println("ItemService: Retrieved " + itemList.size() + " items");
        return itemList;
    }

    public void addItem(String name, String description, double price, int stockQuantity) throws SQLException {
        System.out.println("ItemService: Adding item: " + name);
        Item item = new Item();
        item.setName(name);
        item.setDescription(description);
        item.setPrice(price);
        item.setStockQuantity(stockQuantity);
        itemDao.addItem(item);
        System.out.println("ItemService: Item added: " + name);
    }

    public void deleteItem(int itemId) throws SQLException {
        System.out.println("ItemService: Deleting item with ID: " + itemId);
        itemDao.deleteItem(itemId);
        System.out.println("ItemService: Item deleted with ID: " + itemId);
    }
}