package com.example.dao;

import com.example.model.Bill;
import com.example.model.BillItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class BillDao {
    private Connection connection;

    public BillDao(Connection connection) {
        this.connection = connection;
    }

    public void addBill(Bill bill) throws SQLException {
        connection.setAutoCommit(false);
        try {
            String billQuery = "INSERT INTO bills (customer_id, total_amount, bill_date) VALUES (?, ?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(billQuery, PreparedStatement.RETURN_GENERATED_KEYS)) {
                stmt.setInt(1, bill.getCustomerId());
                stmt.setDouble(2, bill.getTotalAmount());
                stmt.setDate(3, new java.sql.Date(bill.getBillDate() != null ? bill.getBillDate().getTime() : new Date().getTime()));
                stmt.executeUpdate();
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        bill.setBillId(rs.getInt(1));
                    }
                }
            }

            String itemQuery = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = connection.prepareStatement(itemQuery)) {
                for (BillItem billItem : bill.getBillItems()) {
                    stmt.setInt(1, bill.getBillId());
                    stmt.setInt(2, billItem.getItemId());
                    stmt.setInt(3, billItem.getQuantity());
                    stmt.setDouble(4, billItem.getUnitPrice());
                    stmt.executeUpdate();
                }
            }
            connection.commit();
        } catch (SQLException e) {
            connection.rollback();
            throw e;
        } finally {
            connection.setAutoCommit(true);
        }
    }

    public List<Bill> findBillsByCustomerId(int customerId) throws SQLException {
        List<Bill> bills = new ArrayList<>();
        String query = "SELECT * FROM bills WHERE customer_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, customerId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Bill bill = new Bill();
                    bill.setBillId(rs.getInt("bill_id"));
                    bill.setCustomerId(rs.getInt("customer_id"));
                    bill.setTotalAmount(rs.getDouble("total_amount"));
                    bill.setBillDate(rs.getDate("bill_date"));
                    bill.setBillItems(getBillItems(bill.getBillId()));
                    bills.add(bill);
                }
            }
        }
        return bills;
    }

    public List<Bill> findAllBills() throws SQLException {
        List<Bill> bills = new ArrayList<>();
        String query = "SELECT * FROM bills";
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillId(rs.getInt("bill_id"));
                bill.setCustomerId(rs.getInt("customer_id"));
                bill.setTotalAmount(rs.getDouble("total_amount"));
                bill.setBillDate(rs.getDate("bill_date"));
                bill.setBillItems(getBillItems(bill.getBillId()));
                bills.add(bill);
            }
        }
        return bills;
    }

    public Bill findBillById(int billId) throws SQLException {
        Bill bill = null;
        String query = "SELECT * FROM bills WHERE bill_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, billId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    bill = new Bill();
                    bill.setBillId(rs.getInt("bill_id"));
                    bill.setCustomerId(rs.getInt("customer_id"));
                    bill.setTotalAmount(rs.getDouble("total_amount"));
                    bill.setBillDate(rs.getDate("bill_date"));
                    bill.setBillItems(getBillItems(billId));
                }
            }
        }
        return bill;
    }

    private List<BillItem> getBillItems(int billId) throws SQLException {
        List<BillItem> billItems = new ArrayList<>();
        String query = "SELECT * FROM bill_items WHERE bill_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, billId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BillItem billItem = new BillItem();
                    billItem.setBillId(rs.getInt("bill_id"));
                    billItem.setItemId(rs.getInt("item_id"));
                    billItem.setQuantity(rs.getInt("quantity"));
                    billItem.setUnitPrice(rs.getDouble("unit_price"));
                    billItems.add(billItem);
                }
            }
        }
        return billItems;
    }
}