<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Staff" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Staff - Pahanedu Bookshop</title>
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
            max-width: 800px;
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

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #D2B48C;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        input[type="submit"], .button-link {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none; /* Add this to remove underline for links */
            display: inline-block; /* Make the link behave like a block element for padding */
            text-align: center;
            margin-top: 1rem;
        }

        input[type="submit"]:hover, .button-link:hover {
            background-color: #6B4E31;
        }
        
        a.edit-link {
            color: #8B4513;
            text-decoration: none;
        }

        a.edit-link:hover {
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
<script>
    window.onload = function() {
        // Retrieve messages from the request attribute
        var message = '<%= request.getAttribute("message") %>';
        var error = '<%= request.getAttribute("error") %>';
        
        if (message && message.trim() !== 'null') {
            alert(message);
        }
        if (error && error.trim() !== 'null') {
            alert('Error: ' + error);
        }
    };
</script>

    <div class="container">
        <h2>Manage Staff</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("message") != null) { %>
            <p class="message"><%= request.getAttribute("message") %></p>
        <% } %>

        <h3>Add New Staff</h3>
        <form action="${pageContext.request.contextPath}/manageStaff" method="post">
            <input type="hidden" name="action" value="add">
            <label for="username">Username</label>
            <input type="text" name="username" id="username" required>
            <label for="password">Password</label>
            <input type="password" name="password" id="password" required>
            <label for="firstName">First Name</label>
            <input type="text" name="firstName" id="firstName" required>
            <label for="lastName">Last Name</label>
            <input type="text" name="lastName" id="lastName" required>
            <label for="role">Role</label>
            <input type="text" name="role" id="role" required>
            <input type="submit" value="Add Staff">
        </form>

        <h3>Staff List</h3>
        <% List<Staff> staffList = (List<Staff>) request.getAttribute("staffList"); %>
        <% if (staffList != null && !staffList.isEmpty()) { %>
            <table>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Role</th>
                    <th>Actions</th>
                </tr>
                <% for (Staff staff : staffList) { %>
                    <tr>
                        <td><%= staff.getStaffId() %></td>
                        <td><%= staff.getUsername() %></td>
                        <td><%= staff.getFirstName() %></td>
                        <td><%= staff.getLastName() %></td>
                        <td><%= staff.getRole() %></td>
                        <td>
                            <form action="${pageContext.request.contextPath}/manageStaff" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="staffId" value="<%= staff.getStaffId() %>">
                                <input type="submit" value="Delete" onclick="return confirm('Are you sure?');">
                            </form>
                            <a href="${pageContext.request.contextPath}/editStaff.jsp?staffId=<%= staff.getStaffId() %>" class="edit-link">Edit</a>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } else { %>
            <p>No staff found.</p>
        <% } %>
        <a href="${pageContext.request.contextPath}/adminDashboard.jsp" class="button-link">Back to Dashboard</a>
    </div>
</body>
</html>