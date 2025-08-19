<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Pahanedu Bookshop Staff Dashboard">
    <title>Pahanedu Bookshop - Staff Dashboard</title>
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

        .dashboard-tiles {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
        }

        .tile {
            background-color: #ffffff;
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 1.5rem;
            text-align: center;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            cursor: pointer;
        }

        .tile:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0,0,0,0.15);
        }

        .tile-icon {
            font-size: 2.5rem;
            color: var(--accent-color);
            margin-bottom: 1rem;
        }

        .tile-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.4rem;
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }

        .tile-description {
            font-size: 0.9rem;
            color: #666666;
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

            .tile {
                padding: 1rem;
            }

            .tile-title {
                font-size: 1.2rem;
            }

            .tile-description {
                font-size: 0.85rem;
            }
        }
    </style>
</head>
<body>
<%
    String successMessage = (String) session.getAttribute("successMessage");
    if (successMessage != null) {
        session.removeAttribute("successMessage");
%>
<script>
    alert("<%= successMessage %>");
</script>
<%
    }
%>

    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

    <nav class="sidebar" id="sidebar">
        <div class="logo">📚 Pahanedu Bookshop</div>
        <div class="nav flex-column">
            <a href="${pageContext.request.contextPath}/manageCustomers" class="nav-link"><span class="nav-icon">👤</span>Manage Customers</a>
            <a href="${pageContext.request.contextPath}/staffManageItems" class="nav-link"><span class="nav-icon">📚</span>Manage Items</a>
            <a href="${pageContext.request.contextPath}/staffGenerateBill" class="nav-link"><span class="nav-icon">🧾</span>Generate Bill</a>
            <a href="${pageContext.request.contextPath}/ViewBillsControl" class="nav-link"><span class="nav-icon">📋</span>View Bills</a>
            <a href="${pageContext.request.contextPath}/help.jsp" class="nav-link"><span class="nav-icon">❓</span>Help Section</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link"><span class="nav-icon">🚪</span>Logout</a>
        </div>
    </nav>

    <div class="main-content">
        <div class="header-banner">
            <h2 class="main-title">Staff Dashboard</h2>
            <p class="welcome-text">Welcome, Staff! Manage your bookshop tasks efficiently.</p>
        </div>

        <div class="container">
            <div class="dashboard-tiles">
                <div class="tile" onclick="window.location.href='${pageContext.request.contextPath}/manageCustomers'">
                    <span class="tile-icon">👤</span>
                    <h3 class="tile-title">Manage Customers</h3>
                    <p class="tile-description"></p>
                </div>
                <div class="tile" onclick="window.location.href='${pageContext.request.contextPath}/staffManageItems'">
                    <span class="tile-icon">📚</span>
                    <h3 class="tile-title">Manage Items</h3>
                    <p class="tile-description"></p>
                </div>
                <div class="tile" onclick="window.location.href='${pageContext.request.contextPath}/staffGenerateBill'">
                    <span class="tile-icon">🧾</span>
                    <h3 class="tile-title">Generate Bill</h3>
                    <p class="tile-description"></p>
                </div>
                <div class="tile" onclick="window.location.href='${pageContext.request.contextPath}/ViewBillsControl'">
                    <span class="tile-icon">📋</span>
                    <h3 class="tile-title">View Bills</h3>
                    <p class="tile-description"></p>
                </div>
                <div class="tile" onclick="window.location.href='${pageContext.request.contextPath}/help.jsp'">
                    <span class="tile-icon">❓</span>
                    <h3 class="tile-title">Help Section</h3>
                    <p class="tile-description"></p>
                </div>
            </div>
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