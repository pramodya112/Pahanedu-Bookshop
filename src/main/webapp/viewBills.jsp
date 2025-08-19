<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Bill" %>
<%@ page import="com.example.model.Customer" %>
<%@ page import="com.example.model.Staff" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Pahanedu Bookshop - View Bills">
    <title>Pahanedu Bookshop - View Bills</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;700&family=Inter:wght@400;500;600&display=anonymous">
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

        .sidebar-hidden {
            transform: translateX(-260px);
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

        .table-container {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 1.5rem;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
        }

        th, td {
            padding: 0.75rem;
            border: 1px solid #e0e0e0;
            text-align: left;
            font-size: 0.9rem;
        }

        th {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
        }

        tr:nth-child(even) {
            background-color: #f7f7f7;
        }

        tr:hover {
            background-color: #f1f0eb;
        }

        .details-link {
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 500;
        }

        .details-link:hover {
            text-decoration: underline;
        }

        .error {
            color: #d32f2f;
            font-size: 1rem;
            text-align: center;
            margin: 2rem 0;
            background-color: #ffebee;
            padding: 1rem;
            border-radius: 6px;
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
            display: inline-block;
            margin-top: 1rem;
            text-decoration: none;
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

            .table-container {
                padding: 1rem;
            }

            th, td {
                font-size: 0.85rem;
                padding: 0.5rem;
            }
        }
    </style>
</head>
<body>
    <% 
        // Debug logging for context path and session (Line ~150)
        System.out.println("Context Path: " + request.getContextPath());
        Staff currentStaff = (Staff) session.getAttribute("staff");
        System.out.println("Current Staff: " + (currentStaff != null ? currentStaff.getRole() : "null"));
    %>

    <script>
        window.onload = function() {
            var message = '<%= request.getAttribute("message") != null ? request.getAttribute("message") : "" %>';
            var error = '<%= request.getAttribute("error") != null ? request.getAttribute("error") : "" %>';
            
            if (message && message.trim() !== '') {
                alert(message);
            }
            if (error && error.trim() !== '') {
                alert('Error: ' + error);
            }
        };
    </script>

    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

    <nav class="sidebar" id="sidebar">
        <div class="logo">📚 Pahanedu Bookshop</div>
        <div class="nav flex-column">
            <% // Sidebar navigation (Line ~170)
                String dashboardUrl = request.getContextPath() + "/login.jsp";
                String dashboardLabel = "Back to Login";
                boolean isAdmin = false;
                if (currentStaff != null && currentStaff.getRole() != null) {
                    if ("admin".equals(currentStaff.getRole())) {
                        dashboardUrl = request.getContextPath() + "/adminDashboard.jsp";
                        dashboardLabel = "Admin Dashboard";
                        isAdmin = true;
                    } else if ("staff".equals(currentStaff.getRole())) {
                        dashboardUrl = request.getContextPath() + "/staffDashboard.jsp";
                        dashboardLabel = "Staff Dashboard";
                    }
                }
                System.out.println("Dashboard URL: " + dashboardUrl);
            %>
            <a href="<%= dashboardUrl %>" class="nav-link <%= request.getRequestURI().contains("adminDashboard.jsp") ? "active" : "" %>"><span class="nav-icon">🏠</span><%= dashboardLabel %></a>
            <a href="<%= request.getContextPath() %>/manageCustomers" class="nav-link"><span class="nav-icon">👤</span>Manage Customers</a>
            <% if (isAdmin) { %>
                <a href="<%= request.getContextPath() %>/manageStaff" class="nav-link"><span class="nav-icon">👥</span>Manage Staff</a>
                <a href="<%= request.getContextPath() %>/manageItems" class="nav-link"><span class="nav-icon">📚</span>Manage Items</a>
                <a href="<%= request.getContextPath() %>/viewLogs" class="nav-link"><span class="nav-icon">📜</span>View Logs</a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/staffManageItems" class="nav-link"><span class="nav-icon">📚</span>Manage Items</a>
                <a href="<%= request.getContextPath() %>/staffGenerateBill" class="nav-link"><span class="nav-icon">🧾</span>Generate Bill</a>
                <a href="<%= request.getContextPath() %>/help.jsp" class="nav-link"><span class="nav-icon">❓</span>Help Section</a>
            <% } %>
            <a href="<%= request.getContextPath() %>/ViewBillsControl" class="nav-link <%= request.getRequestURI().contains("viewBills.jsp") ? "active" : "" %>"><span class="nav-icon">📋</span>View Bills</a>
            <a href="<%= request.getContextPath() %>/logout" class="nav-link"><span class="nav-icon">🚪</span>Logout</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="header-banner">
            <h2 class="main-title">View Bills</h2>
            <p class="welcome-text">
                Welcome, <%= currentStaff != null ? currentStaff.getFirstName() + " " + currentStaff.getLastName() : "User" %>! Review billing records.
            </p>
        </div>

        <div class="container">
            <% // Access control (Line ~210)
                if (currentStaff == null) { 
            %>
                <div class="error">Access denied. Please log in.</div>
                <a href="<%= request.getContextPath() %>/login.jsp" class="back-btn">Login</a>
            <% } else { %>
                <% // Data retrieval (Line ~215)
                    List<Bill> billList = (List<Bill>) request.getAttribute("billList");
                    Map<Integer, Customer> customerMap = (Map<Integer, Customer>) request.getAttribute("customerMap");
                %>
                <% // Table rendering (Line ~220)
                    if (billList != null && !billList.isEmpty() && customerMap != null) { 
                %>
                    <div class="table-container">
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
                                <% // Table loop (Line ~230)
                                    for (Bill bill : billList) { 
                                        if (bill == null) {
                                            System.out.println("Null bill detected in billList");
                                            continue;
                                        }
                                        Customer customer = customerMap.get(bill.getCustomerId());
                                        String customerName = customer != null ? (customer.getFirstName() + " " + customer.getLastName()) : "Unknown";
                                        String billDate = bill.getBillDate() != null ? bill.getBillDate().toString() : "N/A";
                                        String billDetailsUrl = request.getContextPath() + "/staffViewBillDetails?billId=" + bill.getBillId();
                                %>
                                <tr>
                                    <td><%= bill.getBillId() %></td>
                                    <td><%= customerName %></td>
                                    <td><%= String.format("%.2f", bill.getTotalAmount()) %></td>
                                    <td><%= billDate %></td>
                                    <td><a href="<%= billDetailsUrl %>" class="details-link">View Details</a></td>
                                </tr>
                                <% } // End table loop (Line ~245)
                                %>
                            </tbody>
                        </table>
                    </div>
                <% } else { // Line ~250
                %>
                    <div class="error">No bills found or customer data is unavailable.</div>
                <% } // Line ~252
                %>
            <% } // Line ~253
            %>
        </div>

        <footer class="footer">
            <p>&copy; 2025 Pahanedu Bookshop. All rights reserved. | <a href="mailto:support@pahanedubookshop.com">Contact Us</a></p>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <script>
        function toggleSidebar() {
            const sidebar = document.getElementById('sidebar');
            sidebar.classList.toggle('sidebar-active');
        }
    </script>
</body>
</html>