<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Staff" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Pahanedu Bookshop Help Section">
    <title>Pahanedu Bookshop - Help Section</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #1c2526; /* Charcoal gray */
            --secondary-color: #f9f6f1; /* Creamy white */
            --accent-color: #c2a66e; /* Subtle gold */
            --text-color: #333333;
        }

        body {
            background-color: var(--secondary-color);
            font-family: 'Inter', sans-serif;
            color: var(--text-color);
            margin: 0;
            display: flex;
            min-height: 100vh;
            overflow-x: hidden;
        }

        .sidebar {
            background: linear-gradient(180deg, var(--primary-color) 0%, #2a3a4a 100%);
            width: 260px;
            padding: 2rem 1.5rem;
            position: fixed;
            height: 100%;
            transition: transform 0.3s ease-in-out;
            z-index: 1000;
        }

        .sidebar-active {
            transform: translateX(0);
        }

        .sidebar .logo {
            color: var(--accent-color);
            font-family: 'Cormorant Garamond', serif;
            font-size: 2rem;
            font-weight: 700;
            text-align: center;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .nav-link {
            color: var(--secondary-color) !important;
            font-size: 1rem;
            font-weight: 500;
            padding: 0.8rem 1rem;
            border-radius: 6px;
            transition: background-color 0.3s ease, transform 0.2s ease;
            display: flex;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .nav-link:hover {
            background-color: var(--accent-color);
            color: var(--primary-color) !important;
            transform: translateX(5px);
        }

        .nav-link.active {
            background-color: var(--accent-color);
            color: var(--primary-color) !important;
        }

        .nav-icon {
            margin-right: 0.75rem;
            font-size: 1.1rem;
        }

        .main-content {
            margin-left: 260px;
            padding: 2rem;
            flex-grow: 1;
            background-color: var(--secondary-color);
        }

        .header-banner {
            background: linear-gradient(rgba(28, 37, 38, 0.8), rgba(28, 37, 38, 0.8)), url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            color: var(--secondary-color);
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
            text-align: center;
        }

        .main-title {
            color: var(--secondary-color);
            font-family: 'Cormorant Garamond', serif;
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .welcome-text {
            font-size: 1.1rem;
            font-weight: 400;
        }

        .content-container {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 2rem;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .content-container h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
            border-bottom: 2px solid var(--accent-color);
            padding-bottom: 0.5rem;
        }

        .content-container ul {
            list-style-type: none;
            padding-left: 0;
        }

        .content-container li {
            margin-bottom: 1rem;
            line-height: 1.5;
            position: relative;
            padding-left: 25px;
        }

        .content-container li::before {
            content: "•";
            color: var(--accent-color);
            font-size: 1.5rem;
            position: absolute;
            left: 0;
            top: -5px;
        }
        
        .back-btn {
            background-color: var(--accent-color);
            color: var(--primary-color);
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            width: fit-content;
            margin: 2rem auto 0;
            text-align: center;
            text-decoration: none;
            display: block;
        }

        .back-btn:hover {
            background-color: #a68b5a;
            transform: translateY(-2px);
        }

        .toggle-btn {
            background-color: var(--accent-color);
            border: none;
            color: var(--primary-color);
            font-size: 1.2rem;
            padding: 0.5rem 1rem;
            border-radius: 6px;
            position: fixed;
            top: 1rem;
            left: 1rem;
            z-index: 1001;
            display: none;
        }

        .footer {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            padding: 1.5rem;
            text-align: center;
            margin-top: 3rem;
            font-size: 0.9rem;
            border-top: 1px solid #e0e0e0;
        }

        .footer a {
            color: var(--accent-color);
            text-decoration: none;
        }

        .footer a:hover {
            text-decoration: underline;
        }

        @media (max-width: 992px) {
            .sidebar {
                transform: translateX(-260px);
            }

            .sidebar-active {
                transform: translateX(0);
            }

            .main-content {
                margin-left: 0;
            }

            .toggle-btn {
                display: block;
            }

            .header-banner {
                padding: 1.5rem;
            }

            .main-title {
                font-size: 2.2rem;
            }
        }

        @media (max-width: 576px) {
            .main-title {
                font-size: 1.8rem;
            }

            .content-container {
                padding: 1rem;
            }

            .content-container h3 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('sidebar-active');
        }
    </script>
    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

    <nav class="sidebar" id="sidebar">
        <div class="logo">📚 Pahanedu Bookshop</div>
        <div class="nav flex-column">
            <%
                Staff currentStaff = (Staff) session.getAttribute("staff"); 
                String dashboardUrl = "${pageContext.request.contextPath}/login.jsp";
                String dashboardLabel = "Back to Login";
                if (currentStaff != null) {
                    if ("admin".equals(currentStaff.getRole())) {
                        dashboardUrl = "${pageContext.request.contextPath}/adminDashboard.jsp";
                        dashboardLabel = "Admin Dashboard";
                    } else if ("staff".equals(currentStaff.getRole())) {
                        dashboardUrl = "${pageContext.request.contextPath}/staffDashboard.jsp";
                        dashboardLabel = "Staff Dashboard";
                    }
                }
            %>
            <a href="<%= dashboardUrl %>" class="nav-link"><span class="nav-icon">🏠</span><%= dashboardLabel %></a>
            <a href="${pageContext.request.contextPath}/manageCustomers" class="nav-link"><span class="nav-icon">👤</span>Manage Customers</a>
            <% if (currentStaff != null && "admin".equals(currentStaff.getRole())) { %>
                <a href="${pageContext.request.contextPath}/manageStaff" class="nav-link"><span class="nav-icon">👥</span>Manage Staff</a>
                <a href="${pageContext.request.contextPath}/manageItems" class="nav-link"><span class="nav-icon">📚</span>Manage Items</a>
                <a href="${pageContext.request.contextPath}/viewLogs" class="nav-link"><span class="nav-icon">📜</span>View Logs</a>
            <% } else { %>
                <a href="${pageContext.request.contextPath}/staffManageItems" class="nav-link"><span class="nav-icon">📚</span>Manage Items</a>
                <a href="${pageContext.request.contextPath}/staffGenerateBill" class="nav-link"><span class="nav-icon">🧾</span>Generate Bill</a>
                <a href="${pageContext.request.contextPath}/help.jsp" class="nav-link active"><span class="nav-icon">❓</span>Help Section</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/ViewBillsControl" class="nav-link"><span class="nav-icon">📋</span>View Bills</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link"><span class="nav-icon">🚪</span>Logout</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="header-banner">
            <h2 class="main-title">Help Section</h2>
            <p class="welcome-text">Your guide to using the Pahanedu Bookshop system.</p>
        </div>

        <div class="container content-container">
            <h3>General Usage</h3>
            <ul>
                <li>Logging In: Use your assigned username and password to log in. Your access to certain features depends on your role (Admin or Staff).</li>
                <li>Dashboard: After logging in, you will be directed to your dashboard. This serves as the main menu for all system functionalities.</li>
                <li>Logout: Always remember to log out after you finish your work to secure your account.</li>
            </ul>
            
            <h3>Managing Customers</h3>
            <ul>
                <li>Adding: Use the form at the top of the "Manage Customers" page to add a new customer by entering their details.</li>
                <li>Editing: To update a customer's information, click the **Edit** link next to their name in the table. This will take you to a dedicated page to modify their details.</li>
                <li>Deleting: To permanently remove a customer record, click the **Delete** button. This function is restricted to **Admin** users only.</li>
            </ul>
            
            <h3>Managing Items</h3>
            <ul>
                <li>Adding: Use the form on the "Manage Items" page to add a new book title, price, and quantity to the inventory.</li>
                <li>Updating: To update a book's details or adjust its quantity, click the **Edit** link next to the item in the table.</li>
                <li>Deleting: To permanently remove a book from the inventory, click the **Delete** button. This function is restricted to **Admin** users only.</li>
            </ul>

            <% 
                Staff staff = (Staff) session.getAttribute("staff");
                if (staff != null) { 
            %>
                <h3>Generating Bills</h3>
                <ul>
                    <li>Select a Customer: Choose the customer for whom you are generating the bill from the dropdown list.</li>
                    <li>Select Items & Quantity: Check the box next to each item the customer is purchasing and enter the desired quantity.</li>
                    <li>Generate Bill: Click the **Generate Bill** button to finalize the transaction. A receipt will be displayed for you to view or print.</li>
                </ul>
            <% } %>
            
            <a href="<%= dashboardUrl %>" class="back-btn">Back to Dashboard</a>
        </div>

        <footer class="footer">
            <p>&copy; 2025 Pahanedu Bookshop. All rights reserved. | <a href="mailto:support@pahanedubookshop.com">Contact Us</a></p>
        </footer>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</body>
</html>