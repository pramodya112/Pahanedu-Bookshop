<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Customer" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Customer - Pahanedu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #212529;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            background-color: #e3e8e2; /* A lighter shade of green for the container */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 450px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        h2 {
            font-family: 'Playfair Display', serif;
            color: #8b4513; /* Brown color */
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
            color: #212529;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #7A8450;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input[type="text"]:focus, input[type="email"]:focus, textarea:focus {
            outline: none;
            border-color: #b38996;
            box-shadow: 0 0 5px rgba(179, 137, 150, 0.5);
        }
        textarea {
            height: 100px;
            resize: vertical;
        }
        .action-btn {
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black;              /* Changed text color to black */
            font-weight: bold;         /* Made text bold */
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
            width: 100%;
            margin-top: 1rem;
        }
        .action-btn:hover {
            background-color: #8b4513;
            color: black;              /* Keep text black on hover */
        }
        .back-btn {
            display: inline-block;
            margin-top: 1rem;
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black;              /* Changed text color to black */
            font-weight: bold;         /* Made text bold */
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .back-btn:hover {
            background-color: #8b4513;
            color: black;              /* Keep text black on hover */
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Customer</h2>
        <% 
            Customer customer = (Customer) request.getAttribute("customer");
            if (customer == null) {
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
            <button type="submit" class="action-btn">Update Customer</button>
        </form>
        <a href="manageCustomers" class="back-btn">Back to Manage Customers</a>
    </div>
</body>
</html>
