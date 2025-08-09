<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Generate Bill - Pahanedu Bookshop</title>
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
            max-width: 1000px;
            width: 90%;
            text-align: center;
            margin: 2rem;
        }

        h2, h3 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        h3 {
            font-size: 1.8rem;
        }

        .error, .message {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .message {
            color: #006400;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }

        th, td {
            padding: 0.75rem;
            border: 1px solid #D2B48C;
            text-align: left;
        }

        th {
            background-color: #8B4513;
            color: #FFF8DC;
        }

        tr:nth-child(even) {
            background-color: #F5F5DC;
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

        .customer-selection {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
        }

        select, input[type="number"] {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #D2B48C;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }

        input[type="submit"], button {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
        }

        input[type="submit"]:hover, button:hover {
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
            h3 {
                font-size: 1.5rem;
            }
            .customer-selection {
                flex-direction: column;
                align-items: stretch;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Generate Bill</h2>
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <c:if test="${not empty successMessage}">
            <p class="message">${successMessage}</p>
        </c:if>

        <!-- Generate Bill Form -->
        <h3>Select Items for Bill</h3>
        <form action="${pageContext.request.contextPath}/staffGenerateBill" method="post">
            <input type="hidden" name="action" value="generateBill">
            <div class="customer-selection">
                <div>
                    <label for="customerId">Select Customer</label>
                    <select id="customerId" name="customerId" required>
                        <c:forEach var="customer" items="${customerList}">
                            <option value="${customer.customerId}">${customer.firstName} ${customer.lastName}</option>
                        </c:forEach>
                    </select>
                </div>
                <div>
                    <a href="${pageContext.request.contextPath}/addCustomer.jsp">
                        <button type="button">Add New Customer</button>
                    </a>
                </div>
            </div>
            <table>
                <tr>
                    <th>Title</th>
                    <th>Price</th>
                    <th>Quantity Available</th>
                    <th>Quantity to Purchase</th>
                </tr>
                <c:forEach var="item" items="${itemList}">
                    <tr>
                        <td>${item.title}</td>
                        <td>${item.price}</td>
                        <td>${item.quantity}</td>
                        <td>
                            <input type="number" name="quantities" min="0" max="${item.quantity}" value="0">
                            <input type="hidden" name="itemIds" value="${item.itemId}">
                        </td>
                    </tr>
                </c:forEach>
            </table>
            <input type="submit" value="Generate Bill">
        </form>
        <a href="${pageContext.request.contextPath}/staffDashboard">Back to Dashboard</a>
    </div>
</body>
</html>