<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Staff" %>
<%@ page import="com.example.service.StaffService" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Staff - Pahanedu Bookshop</title>
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
        .main-container {
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
        .action-btn {
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black; /* Black text */
            font-weight: bold; /* Bold text */
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
            color: black; /* Keep black text on hover */
        }
        .back-btn {
            display: inline-block;
            margin-top: 1rem;
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black; /* Black text */
            font-weight: bold; /* Bold text */
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }
        .back-btn:hover {
            background-color: #8b4513;
            color: black; /* Keep black text on hover */
        }
    </style>
</head>
<body>
    <div class="main-container">
        <h2>Edit Staff</h2>
        <% 
            String staffIdParam = request.getParameter("staffId");
            Staff staff = null;
            String error = null;
            if (staffIdParam != null && !staffIdParam.isEmpty()) {
                try {
                    StaffService staffService = new StaffService();
                    staff = staffService.getStaffById(Integer.parseInt(staffIdParam));
                    if (staff == null) {
                        error = "Staff not found.";
                    }
                } catch (SQLException e) {
                    error = "Error loading staff: " + e.getMessage();
                } catch (NumberFormatException e) {
                    error = "Invalid staff ID.";
                }
            } else {
                error = "Staff ID is missing.";
            }
        %>
        
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>
        
        <% if (staff != null) { %>
            <form action="${pageContext.request.contextPath}/manageStaff" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="staffId" value="<%= staff.getStaffId() %>">
                <label for="username">Username</label>
                <input type="text" name="username" id="username" value="<%= staff.getUsername() %>" required>
                <label for="password">Password (leave blank to keep unchanged)</label>
                <input type="password" name="password" id="password">
                <label for="firstName">First Name</label>
                <input type="text" name="firstName" id="firstName" value="<%= staff.getFirstName() %>" required>
                <label for="lastName">Last Name</label>
                <input type="text" name="lastName" id="lastName" value="<%= staff.getLastName() %>" required>
                <label for="role">Role</label>
                <input type="text" name="role" id="role" value="<%= staff.getRole() %>" required>
                <button type="submit" class="action-btn">Update Staff</button>
            </form>
        <% } %>
        <a href="${pageContext.request.contextPath}/manageStaff" class="back-btn">Back to Manage Staff</a>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
