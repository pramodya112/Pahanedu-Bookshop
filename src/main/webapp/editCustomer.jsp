<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer - Pahanedu Bookshop</title>
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
            max-width: 400px;
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

        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #6B4E31;
            margin-bottom: 0.5rem;
        }

        input[type="text"], input[type="email"], textarea {
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
            resize: vertical;
        }

        input[type="submit"], a.button-link {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }

        input[type="submit"]:hover, a.button-link:hover {
            background-color: #6B4E31;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Customer</h2>
        <% 
            // The servlet has already fetched the customer and set it as a request attribute.
            // We just need to retrieve it here.
            Customer customer = (Customer) request.getAttribute("customer");
            if (customer == null) {
                // If the servlet couldn't find the customer, it likely set an error message.
                // We'll show that message.
                customer = new Customer(); // Initialize for null-safe access
        %>
            <p class="error">Customer not found or an error occurred.</p>
        <%
            }
        %>
        
        <form action="manageCustomers" method="post">
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
            <label for="firstName">First Name</label>
            <input type="text" name="firstName" id="firstName" value="<%= customer.getFirstName() %>" required>
            <label for="lastName">Last Name</label>
            <input type="text" name="lastName" id="lastName" value="<%= customer.getLastName() %>" required>
            <label for="email">Email</label>
            <input type="email" name="email" id="email" value="<%= customer.getEmail() %>" required>
            <label for="phone">Phone</label>
            <input type="text" name="phone" id="phone" value="<%= customer.getPhone() %>" required>
            <label for="address">Address</label>
            <textarea name="address" id="address" required><%= customer.getAddress() %></textarea>
            <input type="submit" value="Update Customer">
        </form>
        <br>
        <a href="manageCustomers" class="button-link">Back to Manage Customers</a>
    </div>
</body>
</html>