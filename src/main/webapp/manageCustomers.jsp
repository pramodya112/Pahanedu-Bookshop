<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="com.example.model.Customer" %>
<%@ page import="com.example.model.Staff" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Manage Customers</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #212529;
        }
        .dashboard-header {
            background-color: #b38996; /* A darker, richer shade of pink for the header */
            box-shadow: 0 2px 4px rgba(0,0,0,.1);
            padding: 1rem 2rem;
        }
        .navbar-brand {
            color: #212529 !important;
            font-family: 'Dancing Script', cursive;
            font-size: 1.5rem;
            font-weight: 700;
        }
        .main-container {
            background-color: #e3e8e2; /* A lighter shade of green for the container */
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            max-width: 900px;
            width: 90%;
            text-align: center;
            animation: fadeIn 1s ease-in-out;
            margin: 2rem auto;
        }
        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
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
        .success {
            color: #228B22;
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
            border: 1px solid #c8d4c1; /* Lighter border color */
            color: #212529;
        }
        th {
            background-color: #b38996;
            color: #fff;
            font-family: 'Playfair Display', serif;
        }
        .form-container {
            margin-bottom: 2rem;
            background-color: #d8e0d4;
            padding: 1.5rem;
            border-radius: 10px;
        }
        .form-container label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: #212529;
            margin-bottom: 0.5rem;
            font-weight: bold;
        }
        .form-container input {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #7A8450;
            border-radius: 5px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }
        .form-container input:focus {
            outline: none;
            border-color: #b38996;
            box-shadow: 0 0 5px rgba(179, 137, 150, 0.5);
        }

        /* Updated button styles */
        .action-btn, .delete-btn, .back-btn {
            padding: 0.75rem 1.5rem;
            background-color: #b38996;
            color: black;          /* black text */
            font-weight: bold;     /* bold text */
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            transition: background-color 0.3s ease;
            margin: 0 0.25rem;
        }
        .action-btn:hover, .delete-btn:hover, .back-btn:hover {
            background-color: #8b4513;
            color: black; /* keep text black on hover */
        }

        a.edit-link {
            color: #b38996;
            text-decoration: none;
            margin: 0 0.5rem;
            font-weight: bold;
        }
        a.edit-link:hover {
            text-decoration: underline;
        }
        .back-btn-container {
            margin-top: 1.5rem;
        }
    </style>
</head>
<body>
    <script>
        window.onload = function() {
            var message = '<%= request.getAttribute("message") %>';
            var error = '<%= request.getAttribute("error") %>';
            
            if (message && message.trim() !== 'null') {
                alert(message);
            }
            
            if (error && error.trim() !== 'null') {
                alert('Error: ' + error);
            }
        };
    </script>

    <nav class="navbar navbar-expand-lg navbar-light dashboard-header">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">📚 Pahanedu Bookshop</a>
             <%
                Staff staff = (Staff) session.getAttribute("staff"); 
                String dashboardUrl = "login.jsp";
            
                if (staff != null) {
                    if ("admin".equals(staff.getRole())) {
                        dashboardUrl = "adminDashboard.jsp";
                    } else if ("staff".equals(staff.getRole())) {
                        dashboardUrl = "staffDashboard.jsp";
                    }
                }
            %>
            <a href="<%= dashboardUrl %>" class="btn back-btn">Back to Dashboard</a>
        </div>
    </nav>

    <div class="main-container">
        <h2>Pahanedu Bookshop - Manage Customers</h2>
        <div class="form-container">
            <h3>Add New Customer</h3>
            <form action="manageCustomers" method="post">
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
                <button type="submit" class="action-btn">Add Customer</button>
            </form>
        </div>
        
        <h3>Existing Customers</h3>
        <% List<Customer> customerList = (List<Customer>) request.getAttribute("customerList"); %>
        <% if (customerList != null && !customerList.isEmpty()) { %>
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Email</th>
                            <th>Phone</th>
                            <th>Address</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% 
                            boolean isAdmin = staff != null && "admin".equals(staff.getRole());
                            for (Customer customer : customerList) { 
                        %>
                        <tr>
                            <td><%= customer.getCustomerId() %></td>
                            <td><%= customer.getFirstName() %></td>
                            <td><%= customer.getLastName() %></td>
                            <td><%= customer.getEmail() %></td>
                            <td><%= customer.getPhone() %></td>
                            <td><%= customer.getAddress() %></td>
                            <td>
                                <a href="manageCustomers?action=edit&customerId=<%= customer.getCustomerId() %>" class="edit-link">Edit</a>
                                <% if (isAdmin) { %>
                                    <form action="manageCustomers" method="post" style="display:inline;">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="customerId" value="<%= customer.getCustomerId() %>">
                                        <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this customer?');">Delete</button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        <% } else { %>
            <p>No customers found.</p>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
