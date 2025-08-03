<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, com.example.model.Log" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Logs</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ccc; padding: 8px; text-align: left; }
        th { background-color: #f2f2f2; }
        .error { color: red; }
    </style>
</head>
<body>
    <h2>View Logs</h2>
    <a href="adminDashboard.jsp">Back to Dashboard</a>
    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>
    <h3>Log List</h3>
    <table>
        <tr>
            <th>ID</th>
            <th>Action</th>
            <th>Username</th>
            <th>Time</th>
        </tr>
        <% 
            @SuppressWarnings("unchecked")
            List<Log> logs = (List<Log>) request.getAttribute("logs");
            if (logs != null && !logs.isEmpty()) {
                for (Log log : logs) {
        %>
        <tr>
            <td><%= log.getLogId() %></td>
            <td><%= log.getAction() != null ? log.getAction() : "N/A" %></td>
            <td><%= log.getUsername() != null ? log.getUsername() : "N/A" %></td>
            <td><%= log.getLogTime() != null ? log.getLogTime() : "N/A" %></td>
        </tr>
        <% 
                }
            } else {
        %>
        <tr>
            <td colspan="4">No logs found.</td>
        </tr>
        <% } %>
    </table>
</body>
</html>