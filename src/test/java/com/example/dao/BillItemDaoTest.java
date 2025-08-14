package com.example.dao;

import com.example.model.Bill;
import com.example.model.BillItem;
import com.example.model.Item;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class BillItemDaoTest {
    private Connection connection;
    private BillItemDao billItemDao;

    @BeforeEach
    void setUp() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/loginsystem";
        String username = "root";
        String password = "MYSQL@123";

        connection = DriverManager.getConnection(url, username, password);

        // Drop and recreate tables in the correct order to handle foreign keys
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("DROP TABLE IF EXISTS bill_items");
            stmt.execute("DROP TABLE IF EXISTS bills");
            stmt.execute("DROP TABLE IF EXISTS items");

            stmt.execute("CREATE TABLE bills (bill_id INT AUTO_INCREMENT PRIMARY KEY, customer_id INT, staff_id INT, total_amount DOUBLE)");
            stmt.execute("CREATE TABLE items (item_id INT AUTO_INCREMENT PRIMARY KEY, title VARCHAR(100), author VARCHAR(100), genre VARCHAR(50), price DOUBLE, quantity INT)");
            stmt.execute("CREATE TABLE bill_items (bill_item_id INT AUTO_INCREMENT PRIMARY KEY, bill_id INT, item_id INT, quantity INT, unit_price DOUBLE, FOREIGN KEY (bill_id) REFERENCES bills(bill_id), FOREIGN KEY (item_id) REFERENCES items(item_id))");
        }
        
        billItemDao = new BillItemDao(connection);
    }
    
    @Test
    void testAddBillItem() throws SQLException {
        // Manually insert a Bill and an Item to get valid foreign key IDs
        int billId = createTestBill();
        int itemId = createTestItem();
        
        BillItem billItem = new BillItem();
        billItem.setBillId(billId);
        billItem.setItemId(itemId);
        billItem.setQuantity(2);
        billItem.setUnitPrice(10.0);
        billItemDao.addBillItem(billItem);
        
        List<BillItem> billItems = billItemDao.getBillItemsByBillId(billId);
        assertEquals(1, billItems.size());
        assertEquals(2, billItems.get(0).getQuantity());
        assertEquals(10.0, billItems.get(0).getUnitPrice());
    }

    @Test
    void testGetBillItemsByBillId() throws SQLException {
        // Setup data for the test by manually inserting a Bill and Items
        int billId = createTestBill();
        int itemId1 = createTestItem("Item 1", 5.0, 5);
        int itemId2 = createTestItem("Item 2", 8.0, 8);
        
        BillItem billItem1 = new BillItem();
        billItem1.setBillId(billId);
        billItem1.setItemId(itemId1);
        billItem1.setQuantity(1);
        billItem1.setUnitPrice(5.0);
        billItemDao.addBillItem(billItem1);

        BillItem billItem2 = new BillItem();
        billItem2.setBillId(billId);
        billItem2.setItemId(itemId2);
        billItem2.setQuantity(3);
        billItem2.setUnitPrice(8.0);
        billItemDao.addBillItem(billItem2);

        // Perform the test
        List<BillItem> billItems = billItemDao.getBillItemsByBillId(billId);
        assertEquals(2, billItems.size());
    }

    private int createTestBill() throws SQLException {
        String sql = "INSERT INTO bills (customer_id, staff_id, total_amount) VALUES (?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, 1);
            stmt.setInt(2, 1);
            stmt.setDouble(3, 0.0);
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        throw new SQLException("Failed to create test bill.");
    }
    
    private int createTestItem() throws SQLException {
        return createTestItem("Test Item", 10.0, 10);
    }
    
    private int createTestItem(String title, double price, int quantity) throws SQLException {
        String sql = "INSERT INTO items (title, author, genre, price, quantity) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, title);
            stmt.setString(2, "Test Author");
            stmt.setString(3, "Fiction");
            stmt.setDouble(4, price);
            stmt.setInt(5, quantity);
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        throw new SQLException("Failed to create test item.");
    }
    
    @AfterEach
    void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}