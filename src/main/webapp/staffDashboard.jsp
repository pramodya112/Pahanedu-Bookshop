<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Staff" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Staff Dashboard</title>
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

        .dashboard-container {
            background-color: #FFF8DC;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 600px;
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

        p {
            color: #6B4E31;
            font-size: 1.1rem;
            margin: 0.5rem 0;
        }

        p.error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .dashboard a {
            display: block;
            padding: 0.75rem;
            background-color: #D2B48C;
            color: #6B4E31;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1rem;
            margin: 0.5rem 0;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .dashboard a:hover {
            background-color: #8B4513;
            color: #FFF8DC;
        }

        @media (max-width: 600px) {
            .dashboard-container {
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
    <div class="dashboard-container">
        <h2>Pahanedu Bookshop - Staff Dashboard</h2>
        <% Staff staff = (Staff) session.getAttribute("staff"); %>
        <% if (staff == null || !"staff".equals(staff.getRole())) { %>
            <p class="error">Access denied. Please log in as staff.</p>
            <a href="login.jsp">Login</a>
        <% } else { %>
            <p>Welcome, <%= staff.getUsername() %>!</p>
            <div class="dashboard">
                <a href="manageItems">Manage Items</a>
                <a href="viewBills">View Bills</a>
                <a href="logout">Logout</a>
            </div>
        <% } %>
    </div>
</body>
</html>