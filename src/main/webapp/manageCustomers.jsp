<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Customer" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Customers - Pahanedu Bookshop</title>
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
            max-width: 1000px;
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

        .error, .message {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .message {
            color: #006400;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }

        th, td {
            padding: 0.75rem;
            border: 1px solid #D2B48C;
            text-align: left;
        }

        th {
            background-color: #8B4513;
            color: #FFF8DC;
        }

        tr:nth-child(even) {
            background-color: #F5F5DC;
        }

        form {
            margin-bottom: 2rem;
        }

        label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #6B4E31;
            margin-bottom: 0.5rem;
        }

        input[type="text"], textarea {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #D2B48C;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        textarea {
            height: 100px;
        }

        input[type="submit"] {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #6B4E31;
        }

        a {
            color: #8B4513;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
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
        <h2>Manage Customers</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <p class="message"><%= request.getAttribute("message") %></p>
        <% } %>

        <!-- Add Customer Form -->
        <h3>Add New Customer</h3>
        <form action="${pageContext.request.contextPath}/manageCustomers" method="post">
            <input type="hidden" name="action" value="add">
            <label for="firstName">First Name</label>
            <input type="text" name="firstName" id="firstName" required>
            <label for="lastName">Last Name</label>
            <input type="text" name="lastName" id="lastName" required>
            <label for="email">Email</label>
            <input type="text" name="email" id="email" required>
            <label for="phone">Phone</label>
            <input type="text" name="phone" id="phone" required>
            <label for="address">Address</label>
            <textarea name="address" id="address" required></textarea>
            <input type="submit" value="Add Customer">
        </form>

        <!-- Customer List -->
        <h3>Customer List</h3>
        <% List<Customer> customerList = (List<Customer>) request.getAttribute("customerList"); %>
        <% if (customerList != null && !customerList.isEmpty()) { %>
            <table>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Actions</th>
                </tr>
                <% for (Customer customer : customerList) { %>
                    <tr>
                        <td><%= customer.getCustomerId() %></td>
                        <td><%= customer.getFirstName() %></td>
                        <td><%= customer.getLastName() %></td>
                        <td><%= customer.getEmail() %></td>
                        <td><%= customer.getPhone() %></td>
                        <td><%= customer.getAddress() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/manageCustomers" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                                <input type="submit" value="Delete" onclick="return confirm('Are you sure?');">
                            </form>
                            <a href="${pageContext.request.contextPath}/editCustomer.jsp?customerId=<%= customer.getCustomerId() %>">Edit</a>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } else { %>
            <p>No customers found.</p>
        <% } %>
        <a href="${pageContext.request.contextPath}/adminDashboard.jsp">Back to Dashboard</a>
    </div>
</body>
</html>