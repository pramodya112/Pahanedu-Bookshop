<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Item" %>
<%@ page import="com.example.model.Staff" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Pahanedu Bookshop Manage Items">
    <title>Pahanedu Bookshop - Manage Items</title>
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

        .form-container {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 2rem;
            margin-bottom: 2rem;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }

        .form-container h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.8rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 1.5rem;
        }

        .form-container label {
            display: block;
            text-align: left;
            font-size: 1rem;
            color: var(--text-color);
            margin-bottom: 0.5rem;
            font-weight: 500;
        }

        .form-container input[type="text"],
        .form-container input[type="number"],
        .form-container select {
            width: 100%;
            padding: 0.75rem;
            margin-bottom: 1rem;
            border: 1px solid #e0e0e0;
            border-radius: 6px;
            font-size: 1rem;
            box-sizing: border-box;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
        }

        .form-container input[type="text"]:focus,
        .form-container input[type="number"]:focus,
        .form-container select:focus {
            outline: none;
            border-color: var(--accent-color);
            box-shadow: 0 0 5px rgba(194, 166, 110, 0.3);
        }

        .action-btn, .delete-btn, .add-item-btn {
            background-color: var(--accent-color);
            color: var(--primary-color);
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
        }

        .add-item-btn {
            display: block;
            margin: 1rem auto 0;
            width: fit-content;
        }

        .action-btn:hover, .delete-btn:hover, .add-item-btn:hover {
            background-color: #a68b5a;
            transform: translateY(-2px);
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
            border-collapse: separate;
            border-spacing: 0;
        }

        th, td {
            padding: 0.75rem;
            text-align: left;
            border-bottom: 1px solid #e0e0e0;
        }

        th {
            background-color: var(--primary-color);
            color: var(--secondary-color);
            font-family: 'Cormorant Garamond', serif;
            font-weight: 600;
        }

        tr:last-child td {
            border-bottom: none;
        }

        .edit-link {
            color: var(--accent-color);
            text-decoration: none;
            font-weight: 500;
        }

        .edit-link:hover {
            text-decoration: underline;
        }

        .error {
            color: #d32f2f;
            font-size: 1rem;
            text-align: center;
            margin: 1.5rem 0;
            background-color: #ffebee;
            padding: 1rem;
            border-radius: 6px;
        }

        .message {
            color: #2e7d32;
            font-size: 1rem;
            text-align: center;
            margin: 1.5rem 0;
            background-color: #e8f5e9;
            padding: 1rem;
            border-radius: 6px;
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

            .form-container, .table-container {
                padding: 1rem;
            }

            th, td {
                font-size: 0.9rem;
                padding: 0.5rem;
            }
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
                <a href="${pageContext.request.contextPath}/help.jsp" class="nav-link"><span class="nav-icon">❓</span>Help Section</a>
            <% } %>
            <a href="${pageContext.request.contextPath}/ViewBillsControl" class="nav-link"><span class="nav-icon">📋</span>View Bills</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link"><span class="nav-icon">🚪</span>Logout</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="header-banner">
            <h2 class="main-title">Manage Items</h2>
            <p class="welcome-text">Add, edit, or delete items for Pahanedu Bookshop.</p>
        </div>

        <div class="container">
            <%
                if (currentStaff == null || (!"admin".equals(currentStaff.getRole()) && !"staff".equals(currentStaff.getRole()))) { 
            %>
                <div class="error">Access denied. Please log in as admin or staff.</div>
                <a href="${pageContext.request.contextPath}/login.jsp" class="action-btn">Login</a>
            <% } else { %>
                <% if (request.getAttribute("error") != null) { %>
                    <p class="error"><%= request.getAttribute("error") %></p>
                <% } %>
                <% if (request.getAttribute("successMessage") != null) { %>
                    <p class="message"><%= request.getAttribute("successMessage") %></p>
                <% } %>

                <div class="form-container">
                    <h3>Add New Item</h3>
                    <form action="${pageContext.request.contextPath}/manageItems" method="post">
                        <input type="hidden" name="action" value="add">
                        <label for="title">Book Title</label>
                        <input type="text" name="title" id="title" required>
                        <label for="author">Author</label>
                        <input type="text" name="author" id="author" required>
                        <label for="genre">Genre</label>
                        <select name="genre" id="genre" required>
                            <option value="Fiction">Fiction</option>
                            <option value="Non-Fiction">Non-Fiction</option>
                            <option value="Science Fiction">Science Fiction</option>
                            <option value="Fantasy">Fantasy</option>
                            <option value="Mystery">Mystery</option>
                            <option value="Biography">Biography</option>
                            <option value="Romance">Romance</option>
                            <option value="History">History</option>
                        </select>
                        <label for="price">Price (Rs)</label>
                        <input type="number" step="0.01" name="price" id="price" required>
                        <label for="quantity">Quantity</label>
                        <input type="number" name="quantity" id="quantity" required>
                        <button type="submit" class="add-item-btn">Add Item</button>
                    </form>
                </div>

                <div class="table-container">
                    <h3>Existing Items</h3>
                    <% List<Item> itemList = (List<Item>) request.getAttribute("itemList"); %>
                    <% if (itemList != null && !itemList.isEmpty()) { %>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Title</th>
                                        <th>Author</th>
                                        <th>Genre</th>
                                        <th>Price (Rs)</th>
                                        <th>Quantity</th>
                                        <th>Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% for (Item item : itemList) { %>
                                        <tr>
                                            <td><%= item.getItemId() %></td>
                                            <td><%= item.getTitle() %></td>
                                            <td><%= item.getAuthor() %></td>
                                            <td><%= item.getGenre() %></td>
                                            <td><%= String.format("%.2f", item.getPrice()) %></td>
                                            <td><%= item.getQuantity() %></td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/manageItems?action=edit&itemId=<%= item.getItemId() %>" class="edit-link">Edit</a>
                                                <form action="${pageContext.request.contextPath}/manageItems" method="post" style="display:inline;">
                                                    <input type="hidden" name="action" value="delete">
                                                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                                                    <button type="submit" class="delete-btn" onclick="return confirm('Are you sure you want to delete this item?');">Delete</button>
                                                </form>
                                            </td>
                                        </tr>
                                    <% } %>
                                </tbody>
                            </table>
                        </div>
                    <% } else { %>
                        <p class="error">No items found.</p>
                    <% } %>
                </div>
            <% } %>
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