package com.example.model;

import org.junit.jupiter.api.Test;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class BillTest {
    @Test
    void testBillConstructorAndGettersSetters() {
        Bill bill = new Bill();
        assertNotNull(bill.getBillItems());

        bill.setBillId(1);
        bill.setReferenceNumber("INV-20250814123456-1234");
        bill.setCustomerId(100);
        bill.setTotalAmount(500.0);
        bill.setBillDate(new Date(System.currentTimeMillis()));
        List<BillItem> items = new ArrayList<>();
        items.add(new BillItem());
        bill.setBillItems(items);

        assertEquals(1, bill.getBillId());
        assertEquals("INV-20250814123456-1234", bill.getReferenceNumber());
        assertEquals(100, bill.getCustomerId());
        assertEquals(500.0, bill.getTotalAmount(), 0.01);
        assertNotNull(bill.getBillDate());
        assertEquals(1, bill.getBillItems().size());
    }

    @Test
    void testBillItemsNullHandling() {
        Bill bill = new Bill();
        bill.setBillItems(null);
        assertNotNull(bill.getBillItems());
        assertTrue(bill.getBillItems().isEmpty());
    }
}