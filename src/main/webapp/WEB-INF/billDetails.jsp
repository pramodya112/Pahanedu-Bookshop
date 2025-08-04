<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.example.model.Bill, com.example.model.BillItem" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Bill Details</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap');

        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: url('https://images.unsplash.com/photo-1512820790803-83ca960114d9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: 'Roboto', sans-serif;
        }

        .container {
            background-color: #FFF8DC;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 900px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
            margin: 2rem;
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        h2, h3, h4 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            margin-bottom: 1rem;
        }

        h2 { font-size: 2.5rem; }
        h3 { font-size: 1.8rem; }
        h4 { font-size: 1.4rem; }

        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        p {
            font-size: 1rem;
            color: #6B4E31;
            margin: 0.5rem 0;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        th, td {
            padding: 0.75rem;
            border: 1px solid #D2B48C;
            color: #6B4E31;
            text-align: left;
        }

        th {
            background-color: #D2B48C;
            font-family: 'Playfair Display', serif;
        }

        .back-btn {
            display: inline-block;
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            text-decoration: none;
            transition: background-color 0.3s ease;
            margin-top: 1rem;
        }

        .back-btn:hover {
            background-color: #6B4E31;
        }

        @media (max-width: 600px) {
            .container {
                padding: 1.5rem;
                margin: 1rem;
            }
            h2 { font-size: 1.8rem; }
            h3 { font-size: 1.5rem; }
            h4 { font-size: 1.2rem; }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Pahanedu Bookshop - Bill Details</h2>
        <a href="BillControl" class="back-btn">Back to Bills</a>
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
            <p>Total Amount: $<%= String.format("%.2f", bill.getTotalAmount()) %></p>
            <h4>Items</h4>
            <table>
                <tr>
                    <th>Item Name</th>
                    <th>Quantity</th>
                    <th>Unit Price</th>
                    <th>Total</th>
                </tr>
                <% 
                    List<BillItem> billItems = bill.getBillItems();
                    if (billItems != null && !billItems.isEmpty()) {
                        for (BillItem item : billItems) {
                %>
                    <tr>
                        <td><%= item.getItemName() != null ? item.getItemName() : "N/A" %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>$<%= String.format("%.2f", item.getUnitPrice()) %></td>
                        <td>$<%= String.format("%.2f", item.getQuantity() * item.getUnitPrice()) %></td>
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
    </div>
</body>
</html>