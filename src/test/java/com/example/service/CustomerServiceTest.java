package com.example.service;

import com.example.dao.CustomerDao;
import com.example.dao.DatabaseConnection;
import com.example.model.Customer;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

class CustomerServiceTest {

    private CustomerService customerService;
    private CustomerDao customerDao;
    private Connection connection;

    @BeforeEach
    void setUp() throws SQLException {
        // You'll need to configure DatabaseConnection.java to point to a test database.
        // For example, by providing test properties or a test database URL.
        connection = DatabaseConnection.getConnection();
        
        // Clean up the table for a fresh start for each test
        try (Statement stmt = connection.createStatement()) {
            stmt.execute("DROP TABLE IF EXISTS customers");
            stmt.execute("CREATE TABLE customers (customer_id INT AUTO_INCREMENT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), email VARCHAR(100) NOT NULL UNIQUE, phone VARCHAR(20), address VARCHAR(255))");
        }
        
        this.customerDao = new CustomerDao(connection);
        this.customerService = new CustomerService(); 
    }

    @Test
    void testAddCustomer() throws SQLException {
        Customer customer = new Customer();
        customer.setFirstName("John");
        customer.setLastName("Doe");
        customer.setEmail("john.doe@example.com"); 
        customer.setPhone("555-1234");
        customer.setAddress("123 Main St");

        int initialSize = customerService.getAllCustomers().size();
        customerService.addCustomer(customer);
        
        List<Customer> customers = customerService.getAllCustomers();
        assertEquals(initialSize + 1, customers.size());
    }

    @Test
    void testUpdateCustomer() throws SQLException {
        // First, add a customer to the database to have something to update.
        Customer customer = new Customer();
        customer.setFirstName("Jane");
        customer.setLastName("Doe");
        customer.setEmail("jane.doe@example.com");
        customer.setPhone("555-5678");
        customer.setAddress("456 Oak St");
        customerService.addCustomer(customer);

        // Fetch the customer to get the generated ID
        List<Customer> customers = customerService.getAllCustomers();
        Customer addedCustomer = customers.get(0);
        
        // Update the customer
        addedCustomer.setFirstName("Janet");
        customerService.updateCustomer(addedCustomer);
        
        // Verify the update by fetching all customers and checking the name.
        customers = customerService.getAllCustomers();
        assertEquals("Janet", customers.get(0).getFirstName());
    }

    @Test
    void testDeleteCustomer() throws SQLException {
        // First, add a customer to the database to have something to delete.
        Customer customer = new Customer();
        customer.setFirstName("Delete");
        customer.setLastName("Me");
        customer.setEmail("delete.me@example.com");
        customerService.addCustomer(customer);
        
        int initialSize = customerService.getAllCustomers().size();
        
        List<Customer> customers = customerService.getAllCustomers();
        Customer addedCustomer = customers.get(0);
        customerService.deleteCustomer(addedCustomer.getCustomerId());
        
        int finalSize = customerService.getAllCustomers().size();
        assertEquals(initialSize - 1, finalSize);
    }
    
    @Test
    void testGetAllCustomers() throws SQLException {
        // Add two customers to the database
        Customer customer1 = new Customer();
        customer1.setFirstName("John");
        customer1.setLastName("Doe");
        customer1.setEmail("john.doe@example.com");
        customerService.addCustomer(customer1);
        
        Customer customer2 = new Customer();
        customer2.setFirstName("Jane");
        customer2.setLastName("Smith");
        customer2.setEmail("jane.smith@example.com");
        customerService.addCustomer(customer2);
        
        List<Customer> result = customerService.getAllCustomers();
        assertEquals(2, result.size());
    }

    @AfterEach
    void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            try (Statement stmt = connection.createStatement()) {
                stmt.execute("DROP TABLE customers");
            }
            connection.close();
        }
    }
}