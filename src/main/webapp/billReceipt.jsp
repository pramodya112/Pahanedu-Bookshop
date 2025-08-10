<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="com.example.model.Bill" %>
<%@ page import="com.example.model.Customer" %>
<%@ page import="com.example.model.ReceiptItem" %> <%-- Import the new class --%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Bill Receipt</title>
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
            font-size: 2rem;
            margin-bottom: 1rem;
        }

        .success {
            color: #228B22;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        .error {
            color: #B22222;
            font-size: 1rem;
            margin-bottom: 1rem;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        th, td {
            padding: 0.75rem;
            border: 1px solid #D2B48C;
            color: #6B4E31;
        }

        th {
            background-color: #D2B48C;
            font-family: 'Playfair Display', serif;
        }

        .total {
            font-weight: bold;
            font-size: 1.2rem;
            margin-top: 1rem;
        }

        .print-btn, .back-btn {
            padding: 0.75rem;
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            margin: 0.5rem;
        }

        .print-btn:hover, .back-btn:hover {
            background-color: #6B4E31;
        }

        @media print {
            .print-btn, .back-btn {
                display: none;
            }
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
<script>
        window.onload = function() {
            // Get the message from the request scope
            var message = '<%= request.getAttribute("message") %>';
            
            if (message && message.trim() !== 'null') {
                alert(message);
            }
        };
    </script>
    <div class="container">
        <h2>Pahanedu Bookshop - Bill Receipt</h2>
        <c:if test="${not empty successMessage}">
            <p class="success">${successMessage}</p>
        </c:if>
        <c:if test="${not empty error}">
            <p class="error">${error}</p>
        </c:if>

        <c:choose>
            <c:when test="${not empty bill and not empty customer}">
                <p><strong>Customer:</strong> ${customer.firstName} ${customer.lastName}</p>
                <p><strong>Email:</strong> ${customer.email}</p>
                <p><strong>Bill Date:</strong> ${bill.billDate}</p>
                
                <table>
                    <tr>
                        <th>Title</th>
                        <th>Price (Rs)</th>
                        <th>Quantity</th>
                        <th>Subtotal (Rs)</th>
                    </tr>
                    <c:forEach var="receiptItem" items="${receiptItems}">
                        <tr>
                            <td>${receiptItem.item.title}</td>
                            <td>${receiptItem.item.price}</td>
                            <td>${receiptItem.quantity}</td>
                            <td>${receiptItem.item.price * receiptItem.quantity}</td>
                        </tr>
                    </c:forEach>
                </table>
                <p class="total">Total Amount: Rs${bill.totalAmount}</p>
            </c:when>
            <c:otherwise>
                <p class="error">Bill or Customer details not found.</p>
            </c:otherwise>
        </c:choose>
        
        <button class="print-btn" onclick="window.print()">Print Receipt</button>
        <button class="back-btn" onclick="window.location.href='staffGenerateBill'">Back to Generate Bill</button>
    </div>
</body>
</html>