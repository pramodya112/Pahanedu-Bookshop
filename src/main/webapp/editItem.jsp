<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Item" %>
<%@ page import="com.example.service.ItemService" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Item - Pahanedu Bookshop</title>
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
            max-width: 400px;
            width: 90%;
            text-align: center;
            margin: 2rem;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
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
            color: #6B4E31;
            margin-bottom: 0.5rem;
        }

        input[type="text"], input[type="number"] {
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
            text-decoration: none; /* Remove underline from links */
            display: inline-block; /* Make the link behave like a button */
            text-align: center;
        }
        
        input[type="submit"]:hover, .button-link:hover {
            background-color: #6B4E31;
        }

        a {
            color: #8B4513;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Edit Item</h2>
        <% 
            String itemId = request.getParameter("itemId");
            Item item = null;
            String error = null;
            try {
                if (itemId != null && !itemId.isEmpty()) {
                    ItemService itemService = new ItemService();
                    item = itemService.getItemById(Integer.parseInt(itemId));
                } else {
                    error = "Item ID is missing.";
                }
            } catch (SQLException e) {
                error = "Error loading item: " + e.getMessage();
            } catch (NumberFormatException e) {
                error = "Invalid item ID.";
            }
        %>
        <% if (error != null) { %>
            <p class="error"><%= error %></p>
        <% } %>
        <% if (item != null) { %>
            <form action="${pageContext.request.contextPath}/manageItems" method="post">
                <input type="hidden" name="action" value="update">
                <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                <label for="title">Book Title</label>
                <input type="text" name="title" id="title" value="<%= item.getTitle() %>" required>
                <label for="author">Author</label>
                <input type="text" name="author" id="author" value="<%= item.getAuthor() %>" required>
                <label for="genre">Genre</label>
                <input type="text" name="genre" id="genre" value="<%= item.getGenre() %>" required>
                <label for="price">Price ($)</label>
                <input type="number" step="0.01" name="price" id="price" value="<%= String.format("%.2f", item.getPrice()) %>" required>
                <label for="quantity">Quantity</label>
                <input type="number" name="quantity" id="quantity" value="<%= item.getQuantity() %>" required>
                <input type="submit" value="Update Item">
            </form>
        <% } else { %>
            <p class="error">Item not found.</p>
        <% } %>
        <br>
        <a href="${pageContext.request.contextPath}/manageItems" class="button-link">Back to Manage Items</a>
    </div>
</body>
</html>