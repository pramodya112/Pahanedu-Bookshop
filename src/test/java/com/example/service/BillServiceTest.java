package com.example.service;

import com.example.dao.BillDao;
import com.example.model.Bill;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import java.sql.SQLException;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.Mockito.*;

public class BillServiceTest {
    @Mock
    private BillDao billDao;

    @InjectMocks
    private BillService billService;

    @BeforeEach
    void setUp() {
        // Change from openMocks() to initMocks()
        MockitoAnnotations.initMocks(this);
    }

    @Test
    void testAddBill() throws SQLException {
        Bill bill = new Bill();
        // Set properties of the bill object
        billService.addBill(bill);
        // Verify that the billDao's addBill method was called exactly once
        verify(billDao, times(1)).addBill(bill);
    }

    @Test
    void testGetBillById() throws SQLException {
        Bill bill = new Bill();
        bill.setBillId(1);
        when(billDao.findBillById(1)).thenReturn(bill);
        
        Bill foundBill = billService.getBillById(1);
        assertNotNull(foundBill);
        assertEquals(1, foundBill.getBillId());
    }
}