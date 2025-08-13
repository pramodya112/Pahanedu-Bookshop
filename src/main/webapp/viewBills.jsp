<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="com.example.model.Bill" %>
<%@ page import="com.example.model.Customer" %>
<%@ page import="com.example.model.Staff" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Pahanedu Bookshop - View Bills</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap');

        body {
            margin: 0;
            padding: 0;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #212529;
        }

        .container {
            background-color: #e3e8e2; /* same light green container */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 900px;
            width: 90%;
            text-align: center;
            margin: 2rem;
            font-family: 'Roboto', sans-serif;
        }

        h2 {
            font-family: 'Playfair Display', serif;
            color: #8b4513;
            font-size: 2.5rem;
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
            border: 1px solid #c8d4c1; /* same border color as staff table */
            color: black; /* Black text for table */
            font-weight: bold; /* Bold text for table */
            text-align: left;
        }

        th {
            background-color: #b38996; /* same pink background as staff table header */
            color: white;
            font-family: 'Playfair Display', serif;
        }

        tr:nth-child(even) {
            background-color: #d8e0d4; /* same striped row color as staff table */
        }

        .details-link {
            color: #8b4513;
            text-decoration: none;
            font-weight: bold;
        }

        .details-link:hover {
            text-decoration: underline;
        }

        .back-btn {
            padding: 0.75rem 1.5rem;
            background-color: #b38996; /* keep button color same */
            color: black; /* black text */
            font-weight: bold; /* bold text */
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            margin-top: 1rem;
            transition: background-color 0.3s ease;
        }

        .back-btn:hover {
            background-color: #8b4513;
            color: white; /* optional: white text on hover for contrast */
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
        <h2>Pahanedu Bookshop - View Bills</h2>
        <% if (request.getAttribute("error") != null) { %>
            <p class="error"><%= request.getAttribute("error") %></p>
        <% } %>
        <% List<Bill> billList = (List<Bill>) request.getAttribute("billList"); %>
        <% Map<Integer, Customer> customerMap = (Map<Integer, Customer>) request.getAttribute("customerMap"); %>
        <% if (billList != null && !billList.isEmpty() && customerMap != null) { %>
            <table>
                <thead>
                    <tr>
                        <th>Bill ID</th>
                        <th>Customer Name</th>
                        <th>Total Amount ($)</th>
                        <th>Bill Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                <% for (Bill bill : billList) { %>
                    <% Customer customer = customerMap.get(bill.getCustomerId()); %>
                    <tr>
                        <td><%= bill.getBillId() %></td>
                        <td><%= customer != null ? customer.getFirstName() + " " + customer.getLastName() : "Unknown" %></td>
                        <td><%= String.format("%.2f", bill.getTotalAmount()) %></td>
                        <td><%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></td>
                        <td><a href="${pageContext.request.contextPath}/staffViewBillDetails?billId=<%= bill.getBillId() %>" class="details-link">View Details</a></td>
                    </tr>
                <% } %>
                </tbody>
            </table>
        <% } else { %>
            <p>No bills found or customer data is unavailable.</p>
        <% } %>
        <% 
            Staff staff = (Staff) session.getAttribute("staff"); 
            String dashboardUrl = "login.jsp"; // Default to login page
            
            if (staff != null) {
                if ("admin".equals(staff.getRole())) {
                    dashboardUrl = "adminDashboard.jsp";
                } else if ("staff".equals(staff.getRole())) {
                    dashboardUrl = "staffDashboard.jsp";
                }
            }
        %>
        <button class="back-btn" onclick="window.location.href='<%= dashboardUrl %>'">Back to Dashboard</button>
    </div>
</body>
</html>
