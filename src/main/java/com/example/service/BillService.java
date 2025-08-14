package com.example.service;

import com.example.dao.BillDao;
import com.example.dao.DatabaseConnection;
import com.example.model.Bill;
import java.sql.Connection;
import java.sql.SQLException; // Still needed for method signatures

import java.util.List;

public class BillService {

    private BillDao billDao;

    // 1. Constructor for Dependency Injection (USED BY JUNIT TESTS)
    // Mockito will use this constructor to inject the mock BillDao.
    public BillService(BillDao billDao) {
        this.billDao = billDao;
    }

    // 2. No-argument Constructor (USED BY YOUR WEB APPLICATION)
    // This constructor ensures that when your servlet instantiates BillService
    // in the actual application, it gets a BillDao connected to the real database.
    public BillService() {
        try {
            // Get a real database connection here for the application's runtime
            Connection connection = DatabaseConnection.getConnection();
            this.billDao = new BillDao(connection);
        } catch (RuntimeException e) { // <-- CHANGE THIS TO CATCH RuntimeException
            // This catches the RuntimeException thrown by DatabaseConnection.getConnection()
            // It's crucial: If connection fails here, the service cannot operate.
            throw new RuntimeException("Failed to initialize BillService due to database connection error.", e);
        }
        // Note: The BillDao constructor itself (new BillDao(connection)) typically
        // does not throw SQLException, it just takes a Connection.
        // SQL exceptions would come from methods called on billDao.
    }

    // --- Service Methods now use the injected/initialized billDao ---
    // These methods correctly declare 'throws SQLException' because billDao methods do.

    public void addBill(Bill bill) throws SQLException {
        billDao.addBill(bill);
    }

    public List<Bill> getAllBills() throws SQLException {
        return billDao.findAllBills();
    }

    public Bill getBillById(int billId) throws SQLException {
        return billDao.findBillById(billId);
    }

    public List<Bill> getBillsByCustomerId(int customerId) throws SQLException {
        return billDao.findBillsByCustomerId(customerId);
    }
}
