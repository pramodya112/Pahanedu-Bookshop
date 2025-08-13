<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Staff" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Staff - Pahanedu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #212529;
        }
        .dashboard-header {
            background-color: #b38996; /* A darker, richer shade of pink for the header */
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            padding: 1rem 2rem;
        }
        .navbar-brand {
            color: #212529 !important;
            font-family: 'Dancing Script', cursive;
            font-size: 1.5rem;
            font-weight: 700;
        }
        .main-container {
            background-color: #e3e8e2; /* A lighter shade of green for the container */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 900px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
            margin: 2rem auto;
        }
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }
        h2 {
            font-family: 'Playfair Display', serif;
            color: #8b4513;
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
            margin-top: 1rem;
        }
        th, td {
            padding: 0.75rem;
            border: 1px solid #c8d4c1; /* Lighter border color */
            color: #212529;
            text-align: left;
        }
        th {
            background-color: #b38996;
            color: #fff;
            font-family: 'Playfair Display', serif;
        }
        .form-container {
            margin-bottom: 2rem;
            background-color: #d8e0d4;
            padding: 1.5rem;
            border-radius: 10px;
        }
        .form-container h3 {
            font-family: 'Playfair Display', serif;
            color: #8b4513;
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
        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #7A8450;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input[type="text"]:focus, input[type="password"]:focus {
            outline: none;
            border-color: #b38996;
            box-shadow: 0 0 5px rgba(179, 137, 150, 0.5);
        }
        .action-btn, .delete-btn {
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: #000; /* black text */
            font-weight: bold;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
            margin: 0 0.25rem;
        }
        .action-btn:hover, .delete-btn:hover {
            background-color: #8b4513;
        }
        a.edit-link {
            color: #000; /* black text */
            font-weight: bold;
            text-decoration: none;
            margin: 0 0.5rem;
        }
        a.edit-link:hover {
            text-decoration: underline;
        }
        
        /* Specific styles for the "Add Staff" button */
        .add-staff-btn {
            padding: 0.5rem 1rem; /* Make it smaller */
            background-color: #b38996; /* Keep the same color */
            color: #000 !important; /* Change text color to black */
            font-weight: bold; /* Make text bold */
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            display: block; /* Make it a block element */
            margin: 1rem auto 0; /* Center it with auto margins */
            width: fit-content; /* Shrink to fit the content */
        }
        .add-staff-btn:hover {
             background-color: #8b4513;
        }

        .back-btn {
            display: inline-block;
            margin-top: 1.5rem;
            background-color: #b38996;
            color: #fff;
            border: none;
            border-radius: 5px;
            padding: 0.75rem 1.5rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .back-btn:hover {
            background-color: #8b4513;
        }
    </style>
</head>
<body>
<script>
    window.onload = function() {
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

    <nav class="navbar navbar-expand-lg navbar-light dashboard-header">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">📚 Pahanedu Bookshop</a>
            <a href="${pageContext.request.contextPath}/adminDashboard.jsp" class="btn btn-outline-light me-2">Back to Dashboard</a>
        </div>
    </nav>

    <div class="main-container">
        <h2>Pahanedu Bookshop - Manage Staff</h2>

        <h3>Add New Staff</h3>
        <div class="form-container">
            <form action="${pageContext.request.contextPath}/manageStaff" method="post">
                <input type="hidden" name="action" value="add">
                <label for="username">Username</label>
                <input type="text" name="username" id="username" required class="form-control">
                <label for="password">Password</label>
                <input type="password" name="password" id="password" required class="form-control">
                <label for="firstName">First Name</label>
                <input type="text" name="firstName" id="firstName" required class="form-control">
                <label for="lastName">Last Name</label>
                <input type="text" name="lastName" id="lastName" required class="form-control">
                <label for="role">Role</label>
                <input type="text" name="role" id="role" required class="form-control">
                <button type="submit" class="add-staff-btn">Add Staff</button>
            </form>
        </div>

        <h3>Staff List</h3>
        <% List<Staff> staffList = (List<Staff>) request.getAttribute("staffList"); %>
        <% if (staffList != null && !staffList.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Username</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Role</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (Staff staff : staffList) { %>
                            <tr>
                                <td><%= staff.getStaffId() %></td>
                                <td><%= staff.getUsername() %></td>
                                <td><%= staff.getFirstName() %></td>
                                <td><%= staff.getLastName() %></td>
                                <td><%= staff.getRole() %></td>
                                <td>
                                    <a href="${pageContext.request.contextPath}/editStaff.jsp?staffId=<%= staff.getStaffId() %>" class="edit-link">Edit</a>
                                    <form action="${pageContext.request.contextPath}/manageStaff" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="staffId" value="<%= staff.getStaffId() %>">
                                        <button type="submit" class="delete-btn" onclick="return confirm('Are you sure?');">Delete</button>
                                    </form>
                                </td>
                            </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <p>No staff found.</p>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
