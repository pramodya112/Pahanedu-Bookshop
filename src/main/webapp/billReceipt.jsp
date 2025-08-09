<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Bill" %>
<%@ page import="com.example.model.Item" %>
<%@ page import="com.example.model.Customer" %>
<%@ page import="com.example.service.StaffService" %>
<%@ page import="java.util.List" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Bill Receipt</title>
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
            max-width: 600px;
            width: 90%;
            text-align: center;
            margin: 2rem;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .success {
            color: #228B22;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
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
        }

        th {
            background-color: #D2B48C;
            font-family: 'Playfair Display', serif;
        }

        .total {
            font-weight: bold;
            font-size: 1.2rem;
            margin-top: 1rem;
        }

        .print-btn, .back-btn {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            margin: 0.5rem;
        }

        .print-btn:hover, .back-btn:hover {
            background-color: #6B4E31;
        }

        @media print {
            .print-btn, .back-btn {
                display: none;
            }
        }

        @media (max-width: 600px) {
            .container {
                padding: 1.5rem;
                margin: 1rem;
            }
            h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Pahanedu Bookshop - Bill Receipt</h2>
        <% if (request.getAttribute("successMessage") != null) { %>
            <p class="success"><%= request.getAttribute("successMessage") %></p>
        <% } %>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% 
            Bill bill = (Bill) request.getAttribute("bill");
            List<Item> selectedItems = (List<Item>) request.getAttribute("selectedItems");
            String[] quantities = (String[]) request.getAttribute("quantities");
            Customer customer = null;
            try {
                StaffService staffService = new StaffService();
                customer = staffService.getCustomerById(bill.getCustomerId());
            } catch (SQLException e) {
                request.setAttribute("error", "Error loading customer: " + e.getMessage());
            }
        %>
        <% if (customer != null) { %>
            <p><strong>Customer:</strong> <%= customer.getFirstName() %> <%= customer.getLastName() %></p>
            <p><strong>Email:</strong> <%= customer.getEmail() %></p>
            <p><strong>Bill Date:</strong> <%= bill.getBillDate() != null ? bill.getBillDate() : new Date() %></p>
            <table>
                <tr>
                    <th>Title</th>
                    <th>Price ($)</th>
                    <th>Quantity</th>
                    <th>Subtotal (Rs)</th>
                </tr>
                <% if (selectedItems != null && quantities != null) { %>
                    <% for (int i = 0; i < selectedItems.size(); i++) { %>
                        <tr>
                            <td><%= selectedItems.get(i).getTitle() %></td>
                            <td><%= String.format("%.2f", selectedItems.get(i).getPrice()) %></td>
                            <td><%= quantities[i] %></td>
                            <td><%= String.format("%.2f", selectedItems.get(i).getPrice() * Integer.parseInt(quantities[i])) %></td>
                        </tr>
                    <% } %>
                <% } %>
            </table>
            <p class="total">Total Amount: Rs<%= String.format("%.2f", bill.getTotalAmount()) %></p>
        <% } else { %>
            <p class="error">Customer not found.</p>
        <% } %>
        <button class="print-btn" onclick="window.print()">Print Receipt</button>
        <button class="back-btn" onclick="window.location.href='staffGenerateBill'">Back to Generate Bill</button>
    </div>
</body>
</html>