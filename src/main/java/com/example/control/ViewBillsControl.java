package com.example.control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.model.Bill;
import com.example.model.BillItem;

public class ViewBillsControl extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/loginsystem";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "MYSQL@123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        String billId = request.getParameter("billId");
        if (billId != null) {
            // View single bill details
            List<BillItem> billItems = new ArrayList<>();
            Bill bill = null;
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
                    // Fetch bill
                    try (PreparedStatement stmt = conn.prepareStatement(
                            "SELECT b.bill_id, b.customer_id, b.bill_date, b.total_amount, c.first_name, c.last_name, c.email " +
                            "FROM bills b JOIN customers c ON b.customer_id = c.customer_id WHERE b.bill_id = ?")) {
                        stmt.setInt(1, Integer.parseInt(billId));
                        ResultSet rs = stmt.executeQuery();
                        if (rs.next()) {
                            bill = new Bill();
                            bill.setBillId(rs.getInt("bill_id"));
                            bill.setCustomerId(rs.getInt("customer_id"));
                            bill.setBillDate(rs.getTimestamp("bill_date"));
                            bill.setTotalAmount(rs.getDouble("total_amount"));
                            bill.setCustomerName(rs.getString("first_name") + " " + rs.getString("last_name"));
                            bill.setCustomerEmail(rs.getString("email"));
                        }
                    }
                    // Fetch bill items
                    try (PreparedStatement stmt = conn.prepareStatement(
                            "SELECT bi.bill_item_id, bi.item_id, bi.quantity, bi.unit_price, i.name " +
                            "FROM bill_items bi JOIN items i ON bi.item_id = i.item_id WHERE bi.bill_id = ?")) {
                        stmt.setInt(1, Integer.parseInt(billId));
                        ResultSet rs = stmt.executeQuery();
                        while (rs.next()) {
                            BillItem item = new BillItem();
                            item.setBillItemId(rs.getInt("bill_item_id"));
                            item.setItemName(rs.getString("name"));
                            item.setQuantity(rs.getInt("quantity"));
                            item.setUnitPrice(rs.getDouble("unit_price"));
                            billItems.add(item);
                        }
                    }
                }
            } catch (ClassNotFoundException | SQLException | NumberFormatException e) {
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            request.setAttribute("bill", bill);
            request.setAttribute("billItems", billItems);
            request.getRequestDispatcher("viewBill.jsp").forward(request, response);
        } else {
            // View all bills
            List<Bill> bills = new ArrayList<>();
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                     PreparedStatement stmt = conn.prepareStatement(
                             "SELECT b.bill_id, b.customer_id, b.bill_date, b.total_amount, c.first_name, c.last_name, c.email " +
                             "FROM bills b JOIN customers c ON b.customer_id = c.customer_id")) {
                    ResultSet rs = stmt.executeQuery();
                    while (rs.next()) {
                        Bill bill = new Bill();
                        bill.setBillId(rs.getInt("bill_id"));
                        bill.setCustomerId(rs.getInt("customer_id"));
                        bill.setBillDate(rs.getTimestamp("bill_date"));
                        bill.setTotalAmount(rs.getDouble("total_amount"));
                        bill.setCustomerName(rs.getString("first_name") + " " + rs.getString("last_name"));
                        bill.setCustomerEmail(rs.getString("email"));
                        bills.add(bill);
                    }
                }
            } catch (ClassNotFoundException | SQLException e) {
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("error.jsp").forward(request, response);
                return;
            }
            request.setAttribute("bills", bills);
            request.getRequestDispatcher("viewBills.jsp").forward(request, response);
        }
    }
}