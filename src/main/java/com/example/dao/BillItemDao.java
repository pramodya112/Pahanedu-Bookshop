package com.example.dao;

import com.example.model.BillItem;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class BillItemDao {
    private Connection connection;

    public BillItemDao(Connection connection) {
        this.connection = connection;
    }

    public void addBillItem(BillItem billItem) throws SQLException {
        String query = "INSERT INTO bill_items (bill_id, item_id, quantity, unit_price) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, billItem.getBillId());
            stmt.setInt(2, billItem.getItemId());
            stmt.setInt(3, billItem.getQuantity());
            stmt.setDouble(4, billItem.getUnitPrice()); // Use getUnitPrice()
            stmt.executeUpdate();
        }
    }

    public List<BillItem> getBillItemsByBillId(int billId) throws SQLException {
        List<BillItem> billItems = new ArrayList<>();
        String query = "SELECT * FROM bill_items WHERE bill_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, billId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    BillItem billItem = new BillItem();
                    billItem.setBillItemId(rs.getInt("bill_item_id"));
                    billItem.setBillId(rs.getInt("bill_id"));
                    billItem.setItemId(rs.getInt("item_id"));
                    billItem.setQuantity(rs.getInt("quantity"));
                    billItem.setUnitPrice(rs.getDouble("unit_price")); // Use setUnitPrice()
                    billItems.add(billItem);
                }
            }
        }
        return billItems;
    }

    // Add other BillItemDao methods here (e.g., updateBillItem, deleteBillItem)
}