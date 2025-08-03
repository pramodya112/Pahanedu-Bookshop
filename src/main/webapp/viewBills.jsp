<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.example.model.Bill, com.example.model.BillItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Bill Details</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2>Bill Details</h2>
    <a href="viewBills">Back to Bills</a>
    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>
    <% 
        Bill bill = (Bill) request.getAttribute("bill");
        if (bill != null) {
    %>
    <h3>Bill ID: <%= bill.getBillId() %></h3>
    <p>Customer: <%= bill.getCustomerName() != null ? bill.getCustomerName() : "N/A" %></p>
    <p>Email: <%= bill.getCustomerEmail() != null ? bill.getCustomerEmail() : "N/A" %></p>
    <p>Bill Date: <%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></p>
    <p>Total Amount: <%= bill.getTotalAmount() %></p>
    <h4>Items</h4>
    <table>
        <tr>
            <th>Item Name</th>
            <th>Quantity</th>
            <th>Unit Price</th>
            <th>Total</th>
        </tr>
        <% 
            @SuppressWarnings("unchecked")
            List<BillItem> billItems = (List<BillItem>) request.getAttribute("billItems");
            if (billItems != null && !billItems.isEmpty()) {
                for (BillItem item : billItems) {
        %>
        <tr>
            <td><%= item.getItemName() != null ? item.getItemName() : "N/A" %></td>
            <td><%= item.getQuantity() %></td>
            <td><%= item.getUnitPrice() %></td>
            <td><%= item.getQuantity() * item.getUnitPrice() %></td>
        </tr>
        <% 
                }
            } else {
        %>
        <tr>
            <td colspan="4">No items found.</td>
        </tr>
        <% } %>
    </table>
    <% } else { %>
    <p>No bill found.</p>
    <% } %>
</body>
</html>