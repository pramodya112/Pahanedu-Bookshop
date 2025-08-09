<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2>Error</h2>
    <p class="error"><%= request.getAttribute("error") != null ? request.getAttribute("error") : "An unexpected error occurred." %></p>
    <a href="adminDashboard.jsp">Back to Dashboard</a>
    <a href="login.jsp">Login</a>
</body>
</html>