<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Item" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Pahanedu Bookshop - Manage Items</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap"
        rel="stylesheet"
    />
    <style>
        body {
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #212529;
            margin: 0;
            padding: 0;
        }
        nav.dashboard-header {
            background-color: #b38996;
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .navbar-brand {
            color: #212529;
            font-family: 'Dancing Script', cursive;
            font-size: 1.5rem;
            font-weight: 700;
            text-decoration: none;
        }
        .btn-dashboard {
            background-color: #b38996;
            color: black;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            padding: 0.5rem 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }
        .btn-dashboard:hover {
            background-color: #8b4513;
            color: black;
        }
        .main-container {
            background-color: #e3e8e2;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 900px;
            width: 90%;
            margin: 2rem auto;
            animation: fadeIn 1s ease-in-out;
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
            text-align: center;
        }
        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
            text-align: center;
        }
        .success {
            color: #228B22;
            font-size: 1rem;
            margin-bottom: 1rem;
            text-align: center;
        }
        .form-container {
            margin-bottom: 2rem;
            background-color: #d8e0d4;
            padding: 1.5rem;
            border-radius: 10px;
            text-align: left;
        }
        .form-container label {
            display: block;
            font-size: 1rem;
            color: #212529;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        .form-container input[type="text"],
        .form-container input[type="number"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #7A8450;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-container input[type="text"]:focus,
        .form-container input[type="number"]:focus {
            outline: none;
            border-color: #b38996;
            box-shadow: 0 0 5px rgba(179, 137, 150, 0.5);
        }
        /* Center only the Add Item button */
        .form-container button.action-btn {
            display: block;
            margin: 1.5rem auto 0 auto;
            padding: 0.75rem 2.5rem;
            background-color: #b38996;
            color: black;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        .form-container button.action-btn:hover {
            background-color: #8b4513;
            color: black;
        }

        /* Other buttons */
        .action-btn, .delete-btn {
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-right: 0.25rem;
            display: inline-block;
        }
        .action-btn:hover, .delete-btn:hover {
            background-color: #8b4513;
            color: black;
        }
        .back-btn {
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-top: 1rem;
            display: inline-block;
        }
        .back-btn:hover {
            background-color: #8b4513;
            color: black;
        }
        /* Table styles */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }
        th, td {
            padding: 0.75rem;
            border: 1px solid #c8d4c1;
            color: #212529;
            text-align: left;
        }
        th {
            background-color: #b38996;
            color: #fff;
            font-family: 'Playfair Display', serif;
        }
        /* Edit link styling */
        a.edit-link {
            color: black;
            font-weight: bold;
            text-decoration: none;
            margin-right: 0.5rem;
        }
        a.edit-link:hover {
            text-decoration: underline;
        }
        /* Responsive */
        @media (max-width: 600px) {
            .main-container {
                padding: 1.5rem;
                margin: 1rem auto;
            }
            h2 {
                font-size: 1.8rem;
            }
        }
    </style>
</head>
<body>

<%
    com.example.model.Staff staff = (com.example.model.Staff) session.getAttribute("staff");
    String dashboardUrl = "login.jsp";
    if (staff != null) {
        if ("admin".equals(staff.getRole())) {
            dashboardUrl = "adminDashboard.jsp";
        } else if ("staff".equals(staff.getRole())) {
            dashboardUrl = "staffDashboard.jsp";
        }
    }
%>

<nav class="dashboard-header">
    <a href="#" class="navbar-brand">📚 Pahanedu Bookshop</a>
    <a href="<%= dashboardUrl %>" class="btn-dashboard">Back to Dashboard</a>
</nav>

<div class="main-container">
    <h2>Pahanedu Bookshop - Manage Items</h2>

    <% if (request.getAttribute("error") != null) { %>
        <p class="error"><%= request.getAttribute("error") %></p>
    <% } %>
    <% if (request.getAttribute("successMessage") != null) { %>
        <p class="success"><%= request.getAttribute("successMessage") %></p>
    <% } %>

    <div class="form-container">
        <form action="manageItems" method="post">
            <input type="hidden" name="action" value="add" />
            <label for="title">Book Title</label>
            <input type="text" name="title" id="title" required />
            <label for="author">Author</label>
            <input type="text" name="author" id="author" required />
            <label for="genre">Genre</label>
            <input type="text" name="genre" id="genre" required />
            <label for="price">Price ($)</label>
            <input type="number" step="0.01" name="price" id="price" required />
            <label for="quantity">Quantity</label>
            <input type="number" name="quantity" id="quantity" required />
            <button type="submit" class="action-btn">Add Item</button>
        </form>
    </div>

    <%
        List<Item> itemList = (List<Item>) request.getAttribute("itemList");
    %>

    <% if (itemList != null && !itemList.isEmpty()) { %>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Author</th>
                    <th>Genre</th>
                    <th>Price ($)</th>
                    <th>Quantity</th>
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                <% for (Item item : itemList) { %>
                    <tr>
                        <td><%= item.getItemId() %></td>
                        <td><%= item.getTitle() %></td>
                        <td><%= item.getAuthor() %></td>
                        <td><%= item.getGenre() %></td>
                        <td><%= String.format("%.2f", item.getPrice()) %></td>
                        <td><%= item.getQuantity() %></td>
                        <td>
                            <a href="manageItems?action=edit&itemId=<%= item.getItemId() %>" class="edit-link">Edit</a>
                            <form action="manageItems" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete" />
                                <input type="hidden" name="itemId" value="<%= item.getItemId() %>" />
                                <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this item?');">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </tbody>
        </table>
    <% } else { %>
        <p>No items found.</p>
    <% } %>

    <button class="back-btn" onclick="window.location.href='<%= dashboardUrl %>'">Back to Dashboard</button>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
