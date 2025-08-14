package com.example.dao;

import com.example.model.Bill;
import com.example.model.BillItem;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class BillDaoTest {
    private Connection connection;
    private BillDao billDao;

    @BeforeEach
    void setUp() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/loginsystem";
        String username = "root";
        String password = "MYSQL@123";

        connection = DriverManager.getConnection(url, username, password);
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("DROP TABLE IF EXISTS bill_items");
            stmt.execute("DROP TABLE IF EXISTS bills");
            stmt.execute("DROP TABLE IF EXISTS items");
            stmt.execute("DROP TABLE IF EXISTS customers");
            stmt.execute("CREATE TABLE customers (customer_id INT PRIMARY KEY)");
            stmt.execute("CREATE TABLE items (item_id INT PRIMARY KEY)");
            stmt.execute("CREATE TABLE bills (bill_id INT AUTO_INCREMENT PRIMARY KEY, customer_id INT, total_amount DOUBLE, bill_date DATE, reference_number VARCHAR(50))");
            stmt.execute("CREATE TABLE bill_items (bill_item_id INT AUTO_INCREMENT PRIMARY KEY, bill_id INT, item_id INT, quantity INT, unit_price DOUBLE)");
            stmt.execute("INSERT INTO customers (customer_id) VALUES (100)");
            stmt.execute("INSERT INTO items (item_id) VALUES (10)");
        }
        billDao = new BillDao(connection);
    }

    @Test
    void testAddBill() throws SQLException {
        Bill bill = new Bill();
        bill.setReferenceNumber("INV-20250814123456-1234");
        bill.setCustomerId(100);
        bill.setTotalAmount(500.0);
        bill.setBillDate(new Date(System.currentTimeMillis()));
        List<BillItem> items = new ArrayList<>();
        BillItem item = new BillItem();
        item.setItemId(10);
        item.setQuantity(2);
        item.setUnitPrice(250.0);
        items.add(item);
        bill.setBillItems(items);

        billDao.addBill(bill);

        List<Bill> bills = billDao.findAllBills();
        assertEquals(1, bills.size());
        assertEquals("INV-20250814123456-1234", bills.get(0).getReferenceNumber());
        assertEquals(100, bills.get(0).getCustomerId());
        assertEquals(500.0, bills.get(0).getTotalAmount(), 0.01);
        assertEquals(1, bills.get(0).getBillItems().size());
        assertEquals(10, bills.get(0).getBillItems().get(0).getItemId());
    }

    @Test
    void testFindBillById() throws SQLException {
        Bill bill = new Bill();
        bill.setReferenceNumber("INV-20250814123456-1234");
        bill.setCustomerId(100);
        bill.setTotalAmount(500.0);
        bill.setBillDate(new Date(System.currentTimeMillis()));
        billDao.addBill(bill);

        Bill foundBill = billDao.findBillById(bill.getBillId());
        assertNotNull(foundBill);
        assertEquals("INV-20250814123456-1234", foundBill.getReferenceNumber());
        assertEquals(100, foundBill.getCustomerId());
        assertEquals(500.0, foundBill.getTotalAmount(), 0.01);
    }

    @Test
    void testFindBillsByCustomerId() throws SQLException {
        Bill bill = new Bill();
        bill.setReferenceNumber("INV-20250814123456-1234");
        bill.setCustomerId(100);
        bill.setTotalAmount(500.0);
        bill.setBillDate(new Date(System.currentTimeMillis()));
        billDao.addBill(bill);

        List<Bill> bills = billDao.findBillsByCustomerId(100);
        assertEquals(1, bills.size());
        assertEquals("INV-20250814123456-1234", bills.get(0).getReferenceNumber());
        assertEquals(100, bills.get(0).getCustomerId());
    }

    @Test
    void testFindAllBills() throws SQLException {
        Bill bill = new Bill();
        bill.setReferenceNumber("INV-20250814123456-1234");
        bill.setCustomerId(100);
        bill.setTotalAmount(500.0);
        bill.setBillDate(new Date(System.currentTimeMillis()));
        billDao.addBill(bill);

        List<Bill> bills = billDao.findAllBills();
        assertEquals(1, bills.size());
        assertEquals("INV-20250814123456-1234", bills.get(0).getReferenceNumber());
        assertEquals(100, bills.get(0).getCustomerId());
    }

    @AfterEach
    void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}