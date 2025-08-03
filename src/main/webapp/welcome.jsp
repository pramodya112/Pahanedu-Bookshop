<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Welcome</title>
    <style>
        body { font-family: Arial, sans-serif; text-align: center; margin-top: 50px; }
        .welcome { width: 400px; margin: 0 auto; padding: 20px; border: 1px solid #ccc; border-radius: 5px; }
        h2 { color: #333; }
        .menu { margin-top: 20px; }
        .menu a { margin: 0 10px; text-decoration: none; color: #007bff; }
        .menu a:hover { text-decoration: underline; }
    </style>
</head>
<body>
    <% 
    // Check if user is logged in
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    %>
    <div class="welcome">
        <h2>Welcome, <%= session.getAttribute("username") %>!</h2>
        <p>You have successfully logged in to the system.</p>
        <div class="menu">
            <a href="profile.jsp">View Profile</a>
            <a href="settings.jsp">Settings</a>
            <a href="logout">Logout</a>
        </div>
    </div>
</body>
</html>