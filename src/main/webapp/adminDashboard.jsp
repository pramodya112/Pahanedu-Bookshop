<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Staff" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Admin Dashboard</title>
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
            background-color: #FFF8DC; /* Beige */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 800px;
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
            color: #8B4513; /* Saddle brown */
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        p {
            color: #6B4E31; /* Darker brown */
            font-size: 1.1rem;
            margin: 0.5rem 0;
        }

        p.error {
            color: #B22222; /* Firebrick red */
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .dashboard {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-top: 2rem;
        }

        .dashboard a {
            display: block;
            padding: 1rem;
            background-color: #D2B48C; /* Tan */
            color: #6B4E31;
            text-decoration: none;
            border-radius: 5px;
            font-size: 1rem;
            transition: background-color 0.3s ease, color 0.3s ease;
        }

        .dashboard a:hover {
            background-color: #8B4513;
            color: #FFF8DC;
        }

        .welcome {
            font-family: 'Playfair Display', serif;
            font-size: 1.25rem;
            color: #6B4E31;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 600px) {
            .dashboard-container {
                padding: 1.5rem;
                margin: 1rem;
            }
            h2 {
                font-size: 1.8rem;
            }
            .dashboard {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <div class="dashboard-container">
        <h2>Pahanedu Bookshop - Admin Dashboard</h2>
        <% Staff staff = (Staff) session.getAttribute("staff"); %>
        <p>Session Username: <%= staff != null ? staff.getUsername() : "None" %></p>
        <p>Session Role: <%= staff != null ? staff.getRole() : "None" %></p>
        <% if (staff == null || !"admin".equals(staff.getRole())) { %>
            <p class="error">Access denied. Please log in as admin.</p>
            <a href="${pageContext.request.contextPath}/login.jsp" style="color: #8B4513; text-decoration: none;">Login</a>
        <% } else { %>
            <p class="welcome">Welcome, <%= staff.getUsername() %>!</p>
            <div class="dashboard">
                <a href="${pageContext.request.contextPath}/manageCustomers">Manage Customers</a>
                <a href="${pageContext.request.contextPath}/manageStaff">Manage Staff</a>
                <a href="${pageContext.request.contextPath}/manageItems">Manage Items</a>
                <a href="${pageContext.request.contextPath}/viewBills">View Bills</a>
                <a href="${pageContext.request.contextPath}/viewLogs">View Logs</a>
                <a href="${pageContext.request.contextPath}/logout">Logout</a>
            </div>
        <% } %>
    </div>
</body>
</html>