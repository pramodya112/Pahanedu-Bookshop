<<<<<<< HEAD
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Customer" %>
<%@ page import="java.util.List" %>
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
<<<<<<< HEAD
    <title>Pahanedu Bookshop - Manage Customers</title>
=======
    <title>Generate Bill - Pahanedu Bookshop</title>
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
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
<<<<<<< HEAD
            max-width: 900px;
=======
            max-width: 1000px;
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
            width: 90%;
            text-align: center;
            margin: 2rem;
        }

<<<<<<< HEAD
        h2 {
=======
        h2, h3 {
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

<<<<<<< HEAD
        .error {
=======
        h3 {
            font-size: 1.8rem;
        }

        .error, .message {
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

<<<<<<< HEAD
        .success {
            color: #228B22;
            font-size: 1rem;
            margin-bottom: 1rem;
=======
        .message {
            color: #006400;
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
        }

        table {
            width: 100%;
            border-collapse: collapse;
<<<<<<< HEAD
            margin-top: 1rem;
=======
            margin-bottom: 2rem;
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
        }

        th, td {
            padding: 0.75rem;
            border: 1px solid #D2B48C;
<<<<<<< HEAD
            color: #6B4E31;
        }

        th {
            background-color: #D2B48C;
            font-family: 'Playfair Display', serif;
        }

        .form-container {
            margin-bottom: 2rem;
        }

        .form-container label {
=======
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
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #6B4E31;
            margin-bottom: 0.5rem;
        }

<<<<<<< HEAD
        .form-container input {
=======
        input[type="text"], input[type="email"], input[type="number"], select, textarea {
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #D2B48C;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
        }

<<<<<<< HEAD
        .form-container button, .delete-btn, .back-btn {
=======
        textarea {
            height: 100px;
        }

        input[type="submit"], button {
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
<<<<<<< HEAD
            margin: 0 0.25rem;
        }

        .form-container button:hover, .delete-btn:hover, .back-btn:hover {
            background-color: #6B4E31;
        }

        a.edit-link {
            color: #8B4513;
            text-decoration: none;
            margin: 0 0.5rem;
        }

        a.edit-link:hover {
=======
        }

        input[type="submit"]:hover, button:hover {
            background-color: #6B4E31;
        }

        a {
            color: #8B4513;
            text-decoration: none;
        }

        a:hover {
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
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
<<<<<<< HEAD
=======
            h3 {
                font-size: 1.5rem;
            }
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
        }
    </style>
</head>
<body>
    <div class="container">
<<<<<<< HEAD
        <h2>Pahanedu Bookshop - Manage Customers</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% if (request.getAttribute("successMessage") != null) { %>
            <p class="success"><%= request.getAttribute("successMessage") %></p>
        <% } %>
        <div class="form-container">
            <form action="staffManageCustomers" method="post">
                <input type="hidden" name="action" value="add">
                <label for="firstName">First Name</label>
                <input type="text" name="firstName" id="firstName" required>
                <label for="lastName">Last Name</label>
                <input type="text" name="lastName" id="lastName" required>
                <label for="email">Email</label>
                <input type="email" name="email" id="email" required>
                <label for="phone">Phone</label>
                <input type="text" name="phone" id="phone" required>
                <label for="address">Address</label>
                <input type="text" name="address" id="address" required>
                <button type="submit">Add Customer</button>
            </form>
        </div>
        <% List<Customer> customerList = (List<Customer>) request.getAttribute("customerList"); %>
        <% if (customerList != null && !customerList.isEmpty()) { %>
            <table>
                <tr>
                    <th>ID</th>
                    <th>First Name</th>
                    <th>Last Name</th>
                    <th>Email</th>
                    <th>Phone</th>
                    <th>Address</th>
                    <th>Action</th>
                </tr>
                <% for (Customer customer : customerList) { %>
                    <tr>
                        <td><%= customer.getCustomerId() %></td>
                        <td><%= customer.getFirstName() %></td>
                        <td><%= customer.getLastName() %></td>
                        <td><%= customer.getEmail() %></td>
                        <td><%= customer.getPhone() %></td>
                        <td><%= customer.getAddress() %></td>
                        <td>
                            <a href="staffManageCustomers?action=edit&customerId=<%= customer.getCustomerId() %>" class="edit-link">Edit</a>
                            <form action="staffManageCustomers" method="post" style="display:inline;">
                                <input type="hidden" name="action" value="delete">
                                <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                                <button type="submit" class="delete-btn">Delete</button>
                            </form>
                        </td>
                    </tr>
                <% } %>
            </table>
        <% } else { %>
            <p>No customers found.</p>
        <% } %>
        <button class="back-btn" onclick="window.location.href='staffDashboard.jsp'">Back to Dashboard</button>
=======
        <h2>Generate Bill</h2>
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>
        <c:if test="${not empty successMessage}">
            <p class="message">${successMessage}</p>
        </c:if>

        <!-- Add Customer Form -->
        <h3>Add New Customer</h3>
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

        <!-- Generate Bill Form -->
        <h3>Select Items for Bill</h3>
        <form action="${pageContext.request.contextPath}/staffGenerateBill" method="post">
            <input type="hidden" name="action" value="generateBill">
            <label for="customerId">Select Customer</label>
            <select id="customerId" name="customerId" required>
                <c:forEach var="customer" items="${customerList}">
                    <option value="${customer.customerId}">${customer.firstName} ${customer.lastName}</option>
                </c:forEach>
            </select>
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
>>>>>>> b1c7f666f3631571e7b4cc3142f2f4133f65a919
    </div>
</body>
</html>