<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Customer" %>
<%@ page import="com.example.model.Item" %>
<%@ page import="com.example.model.Bill" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Generate Bill</title>
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

        h2 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .success {
            color: #228B22;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .form-container {
            margin-bottom: 2rem;
        }

        .form-container label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #6B4E31;
            margin-bottom: 0.5rem;
        }

        .form-container select, .form-container input {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #D2B48C;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-container select:focus, .form-container input:focus {
            outline: none;
            border-color: #8B4513;
            box-shadow: 0 0 5px rgba(139, 69, 19, 0.5);
        }

        .form-container button, .back-btn, .view-btn {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-container button:hover, .back-btn:hover, .view-btn:hover {
            background-color: #6B4E31;
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

        .item-row {
            margin-bottom: 1rem;
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
        <h2>Pahanedu Bookshop - Generate Bill</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
            <p class="success"><%= request.getAttribute("successMessage") %></p>
        <% } %>
        <div class="form-container">
            <form action="BillControl" method="get">
                <label for="customerId">Select Customer</label>
                <select name="customerId" id="customerId" onchange="this.form.submit()">
                    <option value="">Select a customer</option>
                    <% List<Customer> customerList = (List<Customer>) request.getAttribute("customerList"); %>
                    <% if (customerList != null) { %>
                        <% for (Customer customer : customerList) { %>
                            <option value="<%= customer.getCustomerId() %>"
                                    <%= request.getParameter("customerId") != null && request.getParameter("customerId").equals(String.valueOf(customer.getCustomerId())) ? "selected" : "" %>>
                                <%= customer.getFirstName() %> <%= customer.getLastName() %>
                            </option>
                        <% } %>
                    <% } %>
                </select>
            </form>
        </div>
        <% if (request.getParameter("customerId") != null) { %>
            <h3>Customer Bills</h3>
            <% List<Bill> billList = (List<Bill>) request.getAttribute("billList"); %>
            <% if (billList != null && !billList.isEmpty()) { %>
                <table>
                    <tr>
                        <th>Bill ID</th>
                        <th>Date</th>
                        <th>Total Amount ($)</th>
                    </tr>
                    <% for (Bill bill : billList) { %>
                        <tr>
                            <td><%= bill.getBillId() %></td>
                            <td><%= bill.getBillDate() %></td>
                            <td><%= String.format("%.2f", bill.getTotalAmount()) %></td>
                        </tr>
                    <% } %>
                </table>
            <% } else { %>
                <p>No bills found for this customer.</p>
            <% } %>
        <% } %>
        <div class="form-container">
            <form action="BillControl" method="post">
                <label for="customerId">Generate Bill for Customer</label>
                <select name="customerId" id="customerId" required>
                    <option value="">Select a customer</option>
                    <% if (customerList != null) { %>
                        <% for (Customer customer : customerList) { %>
                            <option value="<%= customer.getCustomerId() %>">
                                <%= customer.getFirstName() %> <%= customer.getLastName() %>
                            </option>
                        <% } %>
                    <% } %>
                </select>
                <h3>Select Items</h3>
                <% List<Item> itemList = (List<Item>) request.getAttribute("itemList"); %>
                <% if (itemList != null) { %>
                    <% for (Item item : itemList) { %>
                        <div class="item-row">
                            <label for="item_<%= item.getItemId() %>">
                                <%= item.getName() %> ($<%= String.format("%.2f", item.getPrice()) %>) - Stock: <%= item.getStockQuantity() %>
                            </label>
                            <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                            <input type="number" name="quantity" id="item_<%= item.getItemId() %>" min="0" value="0">
                        </div>
                    <% } %>
                <% } %>
                <button type="submit">Generate Bill</button>
            </form>
        </div>
        <button class="back-btn" onclick="window.location.href='staffDashboard.jsp'">Back to Dashboard</button>
    </div>
</body>
</html>