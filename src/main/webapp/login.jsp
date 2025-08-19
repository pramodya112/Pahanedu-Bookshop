<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop Login</title>
    <style>
        /* Your existing CSS for styling the page */
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@400;700&display=swap');

        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                             url('https://images.unsplash.com/photo-1512820790803-83ca960114d9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: 'Roboto', sans-serif;
            color: #FFF8DC;
        }

        .login-container {
            background: linear-gradient(135deg, #FFF8DC 0%, #F5E6B8 100%);
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            max-width: 400px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1.2s ease-in-out;
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(30px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        h1 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .error-message {
            color: #D20000;
            background-color: #ffe6e6;
            border: 1px solid #D20000;
            padding: 10px;
            border-radius: 5px;
            margin-bottom: 1rem;
            font-size: 0.9rem;
        }

        form {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        input[type="text"], input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        input[type="submit"] {
            padding: 0.8rem;
            background: linear-gradient(to bottom, #8B4513 0%, #6B4E31 100%);
            color: #FFF8DC;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        input[type="submit"]:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <div class="login-container">
        <h1>Admin & Staff Login</h1>
        
        <% 
            String error = (String) request.getAttribute("error");
            if (error != null) { 
        %>
            <div class="error-message"><%= error %></div>
        <% 
            } 
        %>

        <form action="login" method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <input type="submit" value="Login">
        </form>
    </div>
</body>
</html>