package com.example.service;

import com.example.dao.BillDao;
import com.example.dao.DatabaseConnection;
import com.example.model.Bill;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class BillService {
    private BillDao billDao;

    public BillService() {
        Connection connection = DatabaseConnection.getConnection();
        this.billDao = new BillDao(connection);
    }

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