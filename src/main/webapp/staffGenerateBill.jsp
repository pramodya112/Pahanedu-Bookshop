<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Generate Bill - Pahanedu Bookshop</title>
    <link
        href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap"
        rel="stylesheet"
    />
    <style>
        body {
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #212529;
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .container {
            background-color: #e3e8e2; /* Light green container */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 1000px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
            margin: 2rem auto;
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
        h2, h3 {
            font-family: 'Playfair Display', serif;
            color: #8b4513; /* Brown */
            margin-bottom: 1rem;
        }
        h2 {
            font-size: 2.5rem;
        }
        h3 {
            font-size: 1.8rem;
        }
        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }
        .message {
            color: #228B22;
            font-size: 1rem;
            margin-bottom: 1rem;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 2rem;
        }
        th, td {
            padding: 0.75rem;
            border: 1px solid #c8d4c1;
            text-align: left;
            color: #212529;
        }
        th {
            background-color: #b38996;
            color: #fff;
            font-family: 'Playfair Display', serif;
        }
        tr:nth-child(even) {
            background-color: #d8e0d4;
        }
        form {
            margin-bottom: 2rem;
        }
        label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #6B4E31; /* Brownish */
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        .customer-selection {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
            justify-content: center;
        }
        select, input[type="number"] {
            width: 100%;
            max-width: 220px;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #7A8450;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }
        input[type="submit"] {
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin-bottom: 0.5rem; /* Reduced space below submit */
        }
        input[type="submit"]:hover {
            background-color: #8b4513;
            color: black;
        }
        a button {
            all: unset;
            cursor: pointer;
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black;
            font-weight: bold;
            border-radius: 5px;
            font-size: 1rem;
            transition: background-color 0.3s ease;
        }
        a button:hover {
            background-color: #8b4513;
            color: black;
        }
        a {
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
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
            margin-top: 0; /* Reduced space above back button */
        }
        .back-btn:hover {
            background-color: #8b4513;
        }
        @media (max-width: 600px) {
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
            select, input[type="number"] {
                max-width: 100%;
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

        <h3>Select Items for Bill</h3>
        <form action="${pageContext.request.contextPath}/staffGenerateBill" method="post">
            <input type="hidden" name="action" value="generateBill" />
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
                    <a href="${pageContext.request.contextPath}/addCustomer.jsp"><button type="button">Add New Customer</button></a>
                </div>
            </div>

            <table>
                <thead>
                    <tr>
                        <th>Title</th>
                        <th>Price ($)</th>
                        <th>Quantity Available</th>
                        <th>Quantity to Purchase</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${itemList}">
                        <tr>
                            <td>${item.title}</td>
                            <td>${item.price}</td>
                            <td>${item.quantity}</td>
                            <td>
                                <input type="number" name="quantities" min="0" max="${item.quantity}" value="0" />
                                <input type="hidden" name="itemIds" value="${item.itemId}" />
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>

            <input type="submit" value="Generate Bill" />
        </form>

        <button class="back-btn" onclick="window.location.href='staffDashboard.jsp'">Back to Dashboard</button>
    </div>
</body>
</html>
