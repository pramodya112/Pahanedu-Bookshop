<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
    <title>Welcome to Pahanedu Bookshop!!</title>
=======
    <title>Welcome to Pahanedu Bookshop</title>
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
    <style>
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

        .welcome-container {
            background: linear-gradient(135deg, #FFF8DC 0%, #F5E6B8 100%);
            padding: 3rem;
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            max-width: 500px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1.2s ease-in-out;
            margin: 2rem;
            position: relative;
            overflow: hidden;
        }

        .welcome-container::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('https://www.transparenttextures.com/patterns/old-books.png') repeat;
            opacity: 0.1;
            z-index: 0;
        }

        .welcome-container > * {
            position: relative;
            z-index: 1;
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(30px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        h1 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            font-size: 3rem;
            margin-bottom: 0.5rem;
            text-shadow: 1px 1px 2px rgba(0, 0, 0, 0.2);
        }

        .tagline {
            font-family: 'Roboto', sans-serif;
            color: #6B4E31;
            font-size: 1.2rem;
            margin-bottom: 2rem;
            font-style: italic;
        }

        .button-container {
            display: flex;
            justify-content: center;
            gap: 1rem;
        }

        button {
            padding: 0.8rem 2rem;
            background: linear-gradient(to bottom, #8B4513 0%, #6B4E31 100%);
            color: #FFF8DC;
            border: none;
            border-radius: 8px;
            font-size: 1.1rem;
            font-family: 'Roboto', sans-serif;
            font-weight: 700;
            cursor: pointer;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.2s ease, box-shadow 0.2s ease, background 0.2s ease;
            position: relative;
            overflow: hidden;
        }

        button::before {
            content: '📚';
            margin-right: 0.5rem;
            font-size: 1.2rem;
        }

        button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
            background: linear-gradient(to bottom, #6B4E31 0%, #5A3F27 100%);
        }

        button:active {
            transform: translateY(0);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
        }

        @media (max-width: 600px) {
            .welcome-container {
                padding: 2rem;
                margin: 1rem;
            }
            h1 {
                font-size: 2rem;
            }
            .tagline {
                font-size: 1rem;
            }
            button {
                padding: 0.6rem 1.5rem;
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="welcome-container">
        <h1>Pahanedu Bookshop</h1>
        <p class="tagline">Discover a World of Stories</p>
        <div class="button-container">
            <button onclick="window.location.href='login.jsp'">Admin Login</button>
            <button onclick="window.location.href='login.jsp'">Staff Login</button>
        </div>
    </div>
</body>
</html>