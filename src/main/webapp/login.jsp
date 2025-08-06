<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Login</title>
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

        .form-container {
            background-color: #FFF8DC; /* Beige background for card */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 400px;
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
            color: #8B4513; /* Saddle brown */
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        h3 {
            font-family: 'Playfair Display', serif;
            color: #6B4E31; /* Darker brown */
            font-size: 1.25rem;
            margin-bottom: 1.5rem;
        }

        .error {
            color: #B22222; /* Firebrick red */
            font-size: 0.9rem;
            margin-bottom: 1rem;
        }

        label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #6B4E31;
            margin-bottom: 0.5rem;
        }

        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #D2B48C; /* Tan border */
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        input[type="text"]:focus,
        input[type="password"]:focus {
            outline: none;
            border-color: #8B4513;
            box-shadow: 0 0 5px rgba(139, 69, 19, 0.5);
        }

        input[type="submit"] {
            width: 100%;
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #6B4E31;
        }

        p.footer {
            font-size: 0.9rem;
            color: #6B4E31;
            margin-top: 1.5rem;
        }

        @media (max-width: 480px) {
            .form-container {
                padding: 1.5rem;
                width: 95%;
            }
            h2 {
                font-size: 1.5rem;
            }
            h3 {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="form-container">
        <h2>Pahanedu Bookshop</h2>
        <h3>Login</h3>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <form action="login" method="post">
            <label for="username">Username</label>
            <input type="text" name="username" id="username" required placeholder="Enter your username">
            <label for="password">Password</label>
            <input type="password" name="password" id="password" required placeholder="Enter your password">
            <input type="submit" value="Login">
        </form>
        <p class="footer">Welcome to Pahanedu Bookshop's Portal</p>
    </div>
</body>
</html>