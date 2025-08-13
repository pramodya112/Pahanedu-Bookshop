<%@ page import="com.example.model.Staff" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Pahanedu Bookshop - Help Section</title>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Playfair+Display:wght@400;700&family=Roboto:wght@400&display=swap" rel="stylesheet" />
    <style>
        body {
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #fff; /* White text */
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
            max-width: 800px;
            width: 90%;
            text-align: left;
            animation: fadeIn 1s ease-in-out;
            margin: 2rem auto;
            color: #6B4E31; /* Brown text inside container */
        }

        @keyframes fadeIn {
            0% { opacity: 0; transform: translateY(20px); }
            100% { opacity: 1; transform: translateY(0); }
        }

        h2, h3 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
            margin-top: 0;
        }

        h2 {
            font-size: 2.5rem;
            text-align: center;
            margin-bottom: 1.5rem;
        }

        h3 {
            font-size: 1.5rem;
            border-bottom: 2px solid #D2B48C;
            padding-bottom: 0.5rem;
            margin-top: 2rem;
            margin-bottom: 1rem;
        }

        ul {
            list-style-type: disc;
            padding-left: 2rem;
            margin-top: 0;
        }

        li {
            margin-bottom: 1rem;
            line-height: 1.5;
        }

        .back-btn {
            display: block;
            width: 200px;
            margin: 2rem auto 0;
            padding: 0.75rem;
            background-color: #b38996;
            color: black;
            border: none;
            border-radius: 5px;
            font-size: 1rem;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
            transition: background-color 0.3s ease;
            font-weight: bold;  /* <-- Added bold here */
        }

        .back-btn:hover {
            background-color: #8b4513;
            color: black;
        }
    </style>
</head>
<body>
    <%
        Staff staff = (Staff) session.getAttribute("staff");
        boolean isAdmin = staff != null && "admin".equals(staff.getRole());
    %>
    <div class="container">
        <h2>Help Section - System Usage Guidelines</h2>
        
        <h3>General Usage</h3>
        <ul>
            <li>Logging In: Use your assigned username and password to log in. Your access to certain features depends on your role (Admin or Staff).</li>
            <li>Dashboard: After logging in, you will be directed to your dashboard. This serves as the main menu for all system functionalities.</li>
            <li>Logout: Always remember to log out after you finish your work to secure your account.</li>
        </ul>
        
        <h3>Managing Customers</h3>
        <ul>
            <li>Adding: Use the form at the top of the "Manage Customers" page to add a new customer by entering their details.</li>
            <li>Editing: To update a customer's information, click the Edit link next to their name in the table. This will take you to a dedicated page to modify their details.</li>
            <li>Deleting: To permanently remove a customer record, click the Delete button. This function is restricted to Admin users only.</li>
        </ul>
        
        <h3>Managing Items</h3>
        <ul>
            <li>Adding: Use the form on the "Manage Items" page to add a new book title, price, and quantity to the inventory.</li>
            <li>Updating: To update a book's details or adjust its quantity, click the Edit link next to the item in the table.</li>
            <li>Deleting: To permanently remove a book from the inventory, click the Delete button. This function is restricted to Admin users only.</li>
        </ul>

        <% if (staff != null) { %>
            <h3>Generating Bills</h3>
            <ul>
                <li>Select a Customer: Choose the customer for whom you are generating the bill from the dropdown list.</li>
                <li>Select Items & Quantity: Check the box next to each item the customer is purchasing and enter the desired quantity.</li>
                <li>Generate Bill: Click the Generate Bill button to finalize the transaction. A receipt will be displayed for you to view or print.</li>
            </ul>
        <% } %>
        
        <%
            String dashboardUrl = "login.jsp";
            if (staff != null) {
                if ("admin".equals(staff.getRole())) {
                    dashboardUrl = "adminDashboard.jsp";
                } else if ("staff".equals(staff.getRole())) {
                    dashboardUrl = "staffDashboard.jsp";
                }
            }
        %>
        <a href="<%= dashboardUrl %>" class="back-btn">Back to Dashboard</a>
    </div>
</body>
</html>
