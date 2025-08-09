<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Bill" %>
<%@ page import="com.example.model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - View Bills</title>
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
            margin: 2rem;
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

        .details-link {
            color: #8B4513;
            text-decoration: none;
        }

        .details-link:hover {
            text-decoration: underline;
        }

        .back-btn {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
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
            h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Pahanedu Bookshop - View Bills</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% List<Bill> billList = (List<Bill>) request.getAttribute("billList"); %>
        <% Map<Integer, Customer> customerMap = (Map<Integer, Customer>) request.getAttribute("customerMap"); %>
        <% if (billList != null && !billList.isEmpty()) { %>
            <table>
                <tr>
                    <th>Bill ID</th>
                    <th>Customer Name</th>
                    <th>Total Amount ($)</th>
                    <th>Bill Date</th>
                    <th>Action</th>
                </tr>
                <% for (Bill bill : billList) { %>
                    <% Customer customer = customerMap.get(bill.getCustomerId()); %>
                    <tr>
                        <td><%= bill.getBillId() %></td>
                        <td><%= customer != null ? customer.getFirstName() + " " + customer.getLastName() : "Unknown" %></td>
                        <td><%= String.format("%.2f", bill.getTotalAmount()) %></td>
                        <td><%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></td>
                        <td><a href="${pageContext.request.contextPath}/bill?action=view&billId=<%= bill.getBillId() %>" class="details-link">View Details</a></td>
                    </tr>
                <% } %>
            </table>
        <% } else { %>
            <p>No bills found.</p>
        <% } %>
        <button class="back-btn" onclick="window.location.href='staffDashboard.jsp'">Back to Dashboard</button>
    </div>
</body>
</html>