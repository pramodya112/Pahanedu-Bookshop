<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Item" %>
<%@ page import="com.example.service.ItemService" %>
<%@ page import="java.sql.SQLException" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Edit Item - Pahanedu Bookshop</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap"
        rel="stylesheet"
    />
    <style>
        body {
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #212529;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
        }
        .container {
            background-color: #e3e8e2; /* Light green container */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 420px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
        }
        @keyframes fadeIn {
            0% {
                opacity: 0;
                transform: translateY(20px);
            }
            100% {
                opacity: 1;
                transform: translateY(0);
            }
        }
        h2 {
            font-family: 'Playfair Display', serif;
            color: #8b4513; /* Brown color */
            font-size: 2rem;
            margin-bottom: 1.5rem;
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
            color: #6B4E31; /* Brownish text */
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        input[type="text"],
        input[type="number"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1.25rem;
            border: 1px solid #7A8450;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            border-color: #b38996;
            box-shadow: 0 0 5px rgba(179, 137, 150, 0.5);
        }

        /* Button styles */
        .button-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 1rem;
            margin-top: 1rem;
        }
        input[type="submit"],
        a.button-link {
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black; /* Black text */
            font-weight: bold; /* Bold text */
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            text-decoration: none; /* Remove underline for links */
            display: inline-block;
            min-width: 180px;
            text-align: center;
            box-sizing: border-box;
            transition: background-color 0.3s ease;
        }
        input[type="submit"]:hover,
        a.button-link:hover {
            background-color: #8b4513;
            color: black; /* Keep text black on hover */
        }
        a.button-link {
            /* no left margin, since centered vertically */
            line-height: normal;
        }
        a {
            color: #8b4513;
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
                <input type="hidden" name="action" value="update" />
                <input type="hidden" name="itemId" value="<%= item.getItemId() %>" />
                
                <label for="title">Book Title</label>
                <input type="text" name="title" id="title" value="<%= item.getTitle() %>" required />
                
                <label for="author">Author</label>
                <input type="text" name="author" id="author" value="<%= item.getAuthor() %>" required />
                
                <label for="genre">Genre</label>
                <input type="text" name="genre" id="genre" value="<%= item.getGenre() %>" required />
                
                <label for="price">Price ($)</label>
                <input
                    type="number"
                    step="0.01"
                    name="price"
                    id="price"
                    value="<%= String.format("%.2f", item.getPrice()) %>"
                    required
                />
                
                <label for="quantity">Quantity</label>
                <input type="number" name="quantity" id="quantity" value="<%= item.getQuantity() %>" required />
                
                <div class="button-container">
                    <input type="submit" value="Update Item" />
                    <a href="${pageContext.request.contextPath}/manageItems" class="button-link">Back to Manage Items</a>
                </div>
            </form>
        <% } else if (error == null) { %>
            <p class="error">Item not found.</p>
            <a href="${pageContext.request.contextPath}/manageItems" class="button-link">Back to Manage Items</a>
        <% } %>
    </div>
</body>
</html>
