<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.util.List, com.example.model.Log" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Pahanedu Bookshop - View Logs</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap');

        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #7A8450; /* muted green background */
            font-family: 'Roboto', sans-serif;
            color: #212529;
        }

        .container {
            background-color: #e3e8e2; /* light green container */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 900px;
            width: 90%;
            text-align: center;
            margin: 2rem;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            color: #8b4513;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            background-color: #fff; /* White background for the table */
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        th, td {
            padding: 0.75rem;
            border: 1px solid #c8d4c1;
            color: black;  /* black and bold text */
            font-weight: bold;
            text-align: left;
        }

        th {
            background-color: #b38996; /* pink header */
            color: white;
            font-family: 'Playfair Display', serif;
        }
        
        a.back-link {
            display: inline-block;
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black;      /* black text */
            font-weight: bold; /* bold text */
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            text-decoration: none;
            margin-top: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        a.back-link:hover {
            background-color: #8b4513;
            color: black; /* keep text black on hover */
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
    <div class="container">
        <h2>Pahanedu Bookshop - View Logs</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        
        <h3>Log List</h3>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Action</th>
                    <th>Username</th>
                    <th>Time</th>
                </tr>
            </thead>
            <tbody>
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
            </tbody>
        </table>
        
        <a href="adminDashboard.jsp" class="back-link">Back to Dashboard</a>
    </div>
</body>
</html>
