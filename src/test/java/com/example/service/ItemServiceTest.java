package com.example.service;

import com.example.dao.ItemDao;
import com.example.dao.DatabaseConnection;
import com.example.model.Item;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

class ItemServiceTest {

    private ItemService itemService;
    private ItemDao itemDao;
    private Connection connection;

    @BeforeEach
    void setUp() throws SQLException {
        // Assuming DatabaseConnection.getConnection() points to a test database.
        connection = DatabaseConnection.getConnection();
        
        // Clean up the tables in the correct order to avoid foreign key errors
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("DROP TABLE IF EXISTS bill_items");
            stmt.execute("DROP TABLE IF EXISTS bills");
            stmt.execute("DROP TABLE IF EXISTS customers");
            stmt.execute("DROP TABLE IF EXISTS items");

            // Now, re-create the tables in the correct order
            stmt.execute("CREATE TABLE items (item_id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(100) NOT NULL, price DOUBLE NOT NULL, quantity INT, author VARCHAR(100), genre VARCHAR(50))");
            // You will need to create the other tables here as well, if they are needed for your tests
            stmt.execute("CREATE TABLE customers (customer_id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), email VARCHAR(100) NOT NULL UNIQUE, phone VARCHAR(20), address VARCHAR(255))");
            stmt.execute("CREATE TABLE bills (bill_id INT AUTO_INCREMENT PRIMARY KEY, customer_id INT, bill_date DATE, total_amount DOUBLE, FOREIGN KEY (customer_id) REFERENCES customers(customer_id))");
            stmt.execute("CREATE TABLE bill_items (bill_item_id INT AUTO_INCREMENT PRIMARY KEY, bill_id INT, item_id INT, quantity INT, FOREIGN KEY (bill_id) REFERENCES bills(bill_id), FOREIGN KEY (item_id) REFERENCES items(item_id))");
        }
        
        this.itemDao = new ItemDao(connection);
        this.itemService = new ItemService(); 
    }

    @Test
    void testAddItem() throws SQLException {
        Item item = new Item();
        item.setTitle("The Hitchhiker's Guide to the Galaxy");
        item.setPrice(15.99);
        item.setQuantity(10);
        item.setAuthor("Douglas Adams");
        item.setGenre("Science Fiction");

        int initialSize = itemService.getAllItems().size();
        itemService.addItem(item);
        
        List<Item> items = itemService.getAllItems();
        assertEquals(initialSize + 1, items.size());
    }

    @Test
    void testUpdateItem() throws SQLException {
        Item item = new Item();
        item.setTitle("Dune");
        item.setPrice(12.50);
        item.setQuantity(5);
        itemService.addItem(item);

        Item addedItem = itemDao.getAllItems().get(0);
        
        addedItem.setPrice(14.75);
        itemService.updateItem(addedItem);
        
        Item updatedItem = itemDao.getItemById(addedItem.getItemId());
        assertEquals(14.75, updatedItem.getPrice());
    }

    @Test
    void testDeleteItem() throws SQLException {
        Item item = new Item();
        item.setTitle("1984");
        item.setPrice(9.99);
        item.setQuantity(20);
        itemService.addItem(item);
        
        int initialSize = itemService.getAllItems().size();
        
        Item addedItem = itemDao.getAllItems().get(0);
        itemService.deleteItem(addedItem.getItemId());
        
        int finalSize = itemService.getAllItems().size();
        assertEquals(initialSize - 1, finalSize);
    }
    
    @Test
    void testGetAllItems() throws SQLException {
        Item item1 = new Item();
        item1.setTitle("The Lord of the Rings");
        item1.setPrice(25.00);
        item1.setQuantity(8);
        itemService.addItem(item1);
        
        Item item2 = new Item();
        item2.setTitle("Pride and Prejudice");
        item2.setPrice(11.25);
        item2.setQuantity(15);
        itemService.addItem(item2);
        
        List<Item> result = itemService.getAllItems();
        assertEquals(2, result.size());
    }
    
    @AfterEach
    void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            try (Statement stmt = connection.createStatement()) {
                // Drop tables in the correct order
                stmt.execute("DROP TABLE IF EXISTS bill_items");
                stmt.execute("DROP TABLE IF EXISTS bills");
                stmt.execute("DROP TABLE IF EXISTS customers");
                stmt.execute("DROP TABLE IF EXISTS items");
            }
            connection.close();
        }
    }
}