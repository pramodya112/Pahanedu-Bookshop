package com.example.service;

import com.example.dao.BillDao;
import com.example.dao.DatabaseConnection;
import com.example.model.Bill;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class BillService {

    public void addBill(Bill bill) throws SQLException {
        try (Connection connection = DatabaseConnection.getConnection()) {
            BillDao billDao = new BillDao(connection);
            billDao.addBill(bill);
        }
    }

    public List<Bill> getAllBills() throws SQLException {
        try (Connection connection = DatabaseConnection.getConnection()) {
            BillDao billDao = new BillDao(connection);
            return billDao.findAllBills();
        }
    }

    public Bill getBillById(int billId) throws SQLException {
        try (Connection connection = DatabaseConnection.getConnection()) {
            BillDao billDao = new BillDao(connection);
            return billDao.findBillById(billId);
        }
    }

    public List<Bill> getBillsByCustomerId(int customerId) throws SQLException {
        try (Connection connection = DatabaseConnection.getConnection()) {
            BillDao billDao = new BillDao(connection);
            return billDao.findBillsByCustomerId(customerId);
        }
    }
}