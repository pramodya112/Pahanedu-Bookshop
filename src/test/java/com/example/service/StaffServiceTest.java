package com.example.service;

import com.example.dao.CustomerDao;
import com.example.dao.ItemDao;
import com.example.model.Customer;
import com.example.model.Item;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;

public class StaffServiceTest {

    // Correctly mock the DAOs that StaffService uses
    @Mock
    private CustomerDao customerDao;

    @Mock
    private ItemDao itemDao;

    @InjectMocks
    private StaffService staffService;

    @BeforeEach
    void setUp() {
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testGetAllCustomers() throws SQLException {
        // Arrange
        List<Customer> customers = new ArrayList<>();
        customers.add(new Customer());
        when(customerDao.getAllCustomers()).thenReturn(customers); // Corrected mock object

        // Act
        List<Customer> foundCustomers = staffService.getAllCustomers();

        // Assert
        assertEquals(1, foundCustomers.size());
        verify(customerDao, times(1)).getAllCustomers(); // Corrected mock object
    }

    @Test
    void testGetItemById() throws SQLException {
        // Arrange
        Item item = new Item();
        item.setItemId(1);
        when(itemDao.getItemById(1)).thenReturn(item); // Corrected mock object

        // Act
        Item foundItem = staffService.getItemById(1);

        // Assert
        assertEquals(1, foundItem.getItemId());
        verify(itemDao, times(1)).getItemById(1); // Corrected mock object
    }
}