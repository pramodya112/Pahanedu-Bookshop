package com.example.dao;

import com.example.model.Item;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class ItemDaoTest {
    private Connection connection;
    private ItemDao itemDao;

    @BeforeEach
    void setUp() throws SQLException {
        // Use a real database connection for DAO tests
        String url = "jdbc:mysql://localhost:3306/loginsystem";
        String username = "root";
        String password = "MYSQL@123";

        connection = DriverManager.getConnection(url, username, password);

        // Drop and recreate the table with the correct name 'items'
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("DROP TABLE IF EXISTS items");
            stmt.execute("CREATE TABLE items (item_id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(100), author VARCHAR(100), genre VARCHAR(50), price DOUBLE, quantity INT)");
        }
        itemDao = new ItemDao(connection);
    }

    @Test
    void testAddItem() throws SQLException {
        Item item = new Item();
        item.setTitle("Test Book");
        item.setAuthor("Test Author");
        item.setGenre("Fiction");
        item.setPrice(19.99);
        item.setQuantity(10);
        itemDao.addItem(item);

        Item foundItem = itemDao.getItemById(1);
        assertNotNull(foundItem);
        assertEquals("Test Book", foundItem.getTitle());
    }

    @Test
    void testGetItemById() throws SQLException {
        Item item = new Item();
        item.setTitle("Another Book");
        item.setAuthor("Another Author");
        item.setGenre("Non-Fiction");
        item.setPrice(25.50);
        item.setQuantity(5);
        itemDao.addItem(item);
        
        // Retrieve the item ID from the database after insertion
        int itemId = itemDao.getItemById(1).getItemId();

        Item foundItem = itemDao.getItemById(itemId);
        assertNotNull(foundItem);
        assertEquals("Another Book", foundItem.getTitle());
    }

    @Test
    void testGetAllItems() throws SQLException {
        Item item1 = new Item();
        item1.setTitle("Book 1");
        item1.setAuthor("Author 1");
        item1.setPrice(10.0);
        item1.setQuantity(2);
        itemDao.addItem(item1);

        Item item2 = new Item();
        item2.setTitle("Book 2");
        item2.setAuthor("Author 2");
        item2.setPrice(15.0);
        item2.setQuantity(5);
        itemDao.addItem(item2);

        List<Item> itemList = itemDao.getAllItems();
        assertEquals(2, itemList.size());
    }
    
    @Test
    void testUpdateItem() throws SQLException {
        Item item = new Item();
        item.setTitle("Old Book");
        item.setAuthor("Old Author");
        item.setPrice(10.0);
        item.setQuantity(5);
        itemDao.addItem(item);
        int itemId = itemDao.getItemById(1).getItemId();
        
        Item updatedItem = new Item();
        updatedItem.setItemId(itemId);
        updatedItem.setTitle("New Book");
        updatedItem.setAuthor("New Author");
        updatedItem.setPrice(20.0);
        updatedItem.setQuantity(10);
        itemDao.updateItem(updatedItem);
        
        Item foundItem = itemDao.getItemById(itemId);
        assertEquals("New Book", foundItem.getTitle());
        assertEquals(20.0, foundItem.getPrice());
    }
    
    @Test
    void testDeleteItem() throws SQLException {
        Item item = new Item();
        item.setTitle("To Delete");
        item.setAuthor("Some Author");
        item.setPrice(10.0);
        item.setQuantity(5);
        itemDao.addItem(item);
        int itemId = itemDao.getItemById(1).getItemId();
        
        itemDao.deleteItem(itemId);
        Item deletedItem = itemDao.getItemById(itemId);
        assertNull(deletedItem);
    }

    @AfterEach
    void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}