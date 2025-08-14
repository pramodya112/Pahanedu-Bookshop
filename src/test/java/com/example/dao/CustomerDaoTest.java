package com.example.dao;

import com.example.model.Customer;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class CustomerDaoTest {
    private Connection connection;
    private CustomerDao customerDao;

    @BeforeEach
    void setUp() throws SQLException {
        // Use a real database connection for DAO tests
        String url = "jdbc:mysql://localhost:3306/loginsystem";
        String username = "root";
        String password = "MYSQL@123";

        connection = DriverManager.getConnection(url, username, password);

        // Drop and recreate the 'customers' table with the 'email' column
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("DROP TABLE IF EXISTS customers");
            stmt.execute("CREATE TABLE customers (customer_id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), email VARCHAR(100) NOT NULL, address VARCHAR(100), phone VARCHAR(20))");
        }
        customerDao = new CustomerDao(connection);
    }

    @Test
    void testAddCustomer() throws SQLException {
        Customer customer = new Customer();
        customer.setFirstName("John");
        customer.setLastName("Doe");
        customer.setEmail("john.doe@example.com"); // Set the email
        customer.setAddress("123 Test St");
        customer.setPhone("123-456-7890");
        customerDao.addCustomer(customer);

        Customer foundCustomer = customerDao.getCustomerById(1);
        assertNotNull(foundCustomer);
        assertEquals("john.doe@example.com", foundCustomer.getEmail());
    }

    @Test
    void testGetCustomerById() throws SQLException {
        Customer customer = new Customer();
        customer.setFirstName("Jane");
        customer.setLastName("Smith");
        customer.setEmail("jane.smith@example.com"); // Set the email
        customer.setAddress("456 Mock Ave");
        customer.setPhone("987-654-3210");
        customerDao.addCustomer(customer);
        
        Customer foundCustomer = customerDao.getCustomerById(1);
        assertNotNull(foundCustomer);
        assertEquals("jane.smith@example.com", foundCustomer.getEmail());
    }

    @Test
    void testGetAllCustomers() throws SQLException {
        Customer customer1 = new Customer();
        customer1.setFirstName("Alice");
        customer1.setLastName("Brown");
        customer1.setEmail("alice.brown@example.com"); // Set the email
        customer1.setAddress("789 Test Rd");
        customer1.setPhone("111-222-3333");
        customerDao.addCustomer(customer1);

        Customer customer2 = new Customer();
        customer2.setFirstName("Bob");
        customer2.setLastName("White");
        customer2.setEmail("bob.white@example.com"); // Set the email
        customer2.setAddress("321 Test Blvd");
        customer2.setPhone("444-555-6666");
        customerDao.addCustomer(customer2);

        List<Customer> customerList = customerDao.getAllCustomers();
        assertEquals(2, customerList.size());
    }

    @Test
    void testUpdateCustomer() throws SQLException {
        Customer customer = new Customer();
        customer.setFirstName("Old");
        customer.setLastName("Name");
        customer.setEmail("old.name@example.com"); // Set the email
        customer.setAddress("Old Address");
        customer.setPhone("123-123-1234");
        customerDao.addCustomer(customer);
        
        Customer oldCustomer = customerDao.getCustomerById(1);
        
        Customer updatedCustomer = new Customer();
        updatedCustomer.setCustomerId(oldCustomer.getCustomerId());
        updatedCustomer.setFirstName("New");
        updatedCustomer.setLastName("Name");
        updatedCustomer.setEmail("new.name@example.com"); // Set the new email
        updatedCustomer.setAddress("New Address");
        updatedCustomer.setPhone("456-456-4567");
        customerDao.updateCustomer(updatedCustomer);
        
        Customer foundCustomer = customerDao.getCustomerById(oldCustomer.getCustomerId());
        assertEquals("New", foundCustomer.getFirstName());
        assertEquals("new.name@example.com", foundCustomer.getEmail());
        assertEquals("New Address", foundCustomer.getAddress());
    }
    
    @Test
    void testDeleteCustomer() throws SQLException {
        Customer customer = new Customer();
        customer.setFirstName("ToDelete");
        customer.setLastName("Customer");
        customer.setEmail("delete.me@example.com"); // Set the email
        customer.setAddress("100 Delete St");
        customer.setPhone("999-999-9999");
        customerDao.addCustomer(customer);
        
        int customerId = customerDao.getCustomerById(1).getCustomerId();
        customerDao.deleteCustomer(customerId);
        
        Customer deletedCustomer = customerDao.getCustomerById(customerId);
        assertNull(deletedCustomer);
    }

    @AfterEach
    void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}