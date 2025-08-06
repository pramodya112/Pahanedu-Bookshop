<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Customer - Pahanedu Bookshop</title>
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
            max-width: 600px;
            width: 90%;
            text-align: center;
            margin: 2rem;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .error, .message {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .message {
            color: #006400;
        }

        form {
            margin-bottom: 2rem;
        }

        label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #6B4E31;
            margin-bottom: 0.5rem;
        }

        input[type="text"], input[type="email"], textarea {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #D2B48C;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        textarea {
            height: 100px;
        }

        input[type="submit"] {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #6B4E31;
        }

        a {
            color: #8B4513;
            text-decoration: none;
        }

        a:hover {
            text-decoration: underline;
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
        <h2>Add New Customer</h2>
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <c:if test="${not empty successMessage}">
            <p class="message">${successMessage}</p>
        </c:if>
        <form action="${pageContext.request.contextPath}/staffGenerateBill" method="post">
            <input type="hidden" name="action" value="addCustomer">
            <label for="firstName">First Name</label>
            <input type="text" name="firstName" id="firstName" required>
            <label for="lastName">Last Name</label>
            <input type="text" name="lastName" id="lastName" required>
            <label for="email">Email</label>
            <input type="email" name="email" id="email">
            <label for="phone">Phone</label>
            <input type="text" name="phone" id="phone">
            <label for="address">Address</label>
            <textarea name="address" id="address"></textarea>
            <input type="submit" value="Add Customer">
        </form>
        <a href="${pageContext.request.contextPath}/staffGenerateBill">Back to Generate Bill</a>
    </div>
</body>
</html>