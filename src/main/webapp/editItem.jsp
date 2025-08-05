<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Item" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Edit Item</title>
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

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        h2 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .form-container {
            margin-bottom: 2rem;
        }

        .form-container label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #6B4E31;
            margin-bottom: 0.5rem;
        }

        .form-container input, .form-container textarea {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #D2B48C;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-container textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-container input:focus, .form-container textarea:focus {
            outline: none;
            border-color: #8B4513;
            box-shadow: 0 0 5px rgba(139, 69, 19, 0.5);
        }

        .form-container button, .back-btn {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        .form-container button:hover, .back-btn:hover {
            background-color: #6B4E31;
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
        <h2>Pahanedu Bookshop - Edit Item</h2>
        <% Item item = (Item) request.getAttribute("item"); %>
        <% if (item == null) { %>
            <p class="error">No item found to edit.</p>
        <% } else { %>
            <% if (request.getAttribute("error") != null) { %>
                <p class="error"><%= request.getAttribute("error") %></p>
            <% } %>
            <div class="form-container">
                <form action="manageItems" method="post">
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
                    <button type="submit">Update Item</button>
                </form>
            </div>
        <% } %>
        <button class="back-btn" onclick="window.location.href='manageItems'">Back to Manage Items</button>
    </div>
</body>
</html>