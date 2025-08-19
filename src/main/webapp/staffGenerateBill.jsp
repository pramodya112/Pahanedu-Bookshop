<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Pahanedu Bookshop - Generate Bill">
    <title>Pahanedu Bookshop - Generate Bill</title>
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

        .container {
            background-color: #ffffff;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            max-width: 1000px;
            width: 100%;
            margin: 0 auto;
        }

        .success {
            color: #2e7d32;
            font-size: 1rem;
            text-align: center;
            margin: 1rem 0;
            background-color: #e8f5e9;
            padding: 1rem;
            border-radius: 6px;
        }

        .error {
            color: #d32f2f;
            font-size: 1rem;
            text-align: center;
            margin: 1rem 0;
            background-color: #ffebee;
            padding: 1rem;
            border-radius: 6px;
        }

        h3 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 1.8rem;
            font-weight: 600;
            margin-top: 2rem;
            margin-bottom: 1rem;
        }
        
        form {
            margin-bottom: 2rem;
        }
        
        label {
            font-weight: 500;
            margin-bottom: 0.5rem;
        }
        
        .form-control, select {
            border-radius: 6px;
            border: 1px solid #ddd;
            padding: 0.75rem;
            width: 100%;
            margin-bottom: 1rem;
        }

        .btn-primary, .btn-link-custom {
            background-color: var(--accent-color);
            color: var(--primary-color) !important;
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary:hover, .btn-link-custom:hover {
            background-color: #a68b5a;
            transform: translateY(-2px);
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 1rem;
            margin-bottom: 2rem;
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

        .back-btn {
            background-color: var(--accent-color);
            color: var(--primary-color);
            font-weight: 600;
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease, transform 0.2s ease;
            margin: 0.5rem;
            text-decoration: none;
            display: inline-block;
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

            .container {
                padding: 1.5rem;
            }
        }

        @media (max-width: 576px) {
            .main-title {
                font-size: 1.8rem;
            }

            .container {
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
    <button class="toggle-btn" onclick="toggleSidebar()">☰</button>

    <nav class="sidebar" id="sidebar">
        <div class="logo">📚 Pahanedu Bookshop</div>
        <div class="nav flex-column">
            <c:set var="staffRole" value="${sessionScope.staff.role}" />
            <c:set var="dashboardUrl" value="${pageContext.request.contextPath}/login.jsp" />
            <c:set var="dashboardLabel" value="Back to Login" />
            <c:if test="${staffRole == 'admin'}">
                <c:set var="dashboardUrl" value="${pageContext.request.contextPath}/adminDashboard.jsp" />
                <c:set var="dashboardLabel" value="Admin Dashboard" />
            </c:if>
            <c:if test="${staffRole == 'staff'}">
                <c:set var="dashboardUrl" value="${pageContext.request.contextPath}/staffDashboard.jsp" />
                <c:set var="dashboardLabel" value="Staff Dashboard" />
            </c:if>

            <a href="${dashboardUrl}" class="nav-link"><span class="nav-icon">🏠</span>${dashboardLabel}</a>
            <a href="${pageContext.request.contextPath}/manageCustomers" class="nav-link"><span class="nav-icon">👤</span>Manage Customers</a>
            
            <c:if test="${staffRole == 'admin'}">
                <a href="${pageContext.request.contextPath}/manageStaff" class="nav-link"><span class="nav-icon">👥</span>Manage Staff</a>
                <a href="${pageContext.request.contextPath}/manageItems" class="nav-link"><span class="nav-icon">📚</span>Manage Items</a>
                <a href="${pageContext.request.contextPath}/viewLogs" class="nav-link"><span class="nav-icon">📜</span>View Logs</a>
            </c:if>
            <c:if test="${staffRole == 'staff'}">
                <a href="${pageContext.request.contextPath}/staffManageItems" class="nav-link"><span class="nav-icon">📚</span>Manage Items</a>
                <a href="${pageContext.request.contextPath}/staffGenerateBill" class="nav-link active"><span class="nav-icon">🧾</span>Generate Bill</a>
                <a href="${pageContext.request.contextPath}/help.jsp" class="nav-link"><span class="nav-icon">❓</span>Help Section</a>
            </c:if>
            <a href="${pageContext.request.contextPath}/ViewBillsControl" class="nav-link"><span class="nav-icon">📋</span>View Bills</a>
            <a href="${pageContext.request.contextPath}/logout" class="nav-link"><span class="nav-icon">🚪</span>Logout</a>
        </div>
    </nav>
    <div class="main-content">
        <div class="header-banner">
            <h2 class="main-title">Generate Bill</h2>
            <p class="welcome-text">
                Create a new bill for a customer.
            </p>
        </div>
        <div class="container">
            <c:if test="${not empty requestScope.error}">
                <p class="error">${requestScope.error}</p>
            </c:if>
            <c:if test="${not empty requestScope.message}">
                <p class="success">${requestScope.message}</p>
            </c:if>
            <c:choose>
                <c:when test="${not empty requestScope.customerList and not empty requestScope.itemList}">
                    <form action="${pageContext.request.contextPath}/staffGenerateBill" method="post">
                        <input type="hidden" name="action" value="generateBill" />
                        <div class="row align-items-center mb-4">
                            <div class="col-md-6 mb-3 mb-md-0">
                                <label for="customerId" class="form-label">Select Customer</label>
                                <select id="customerId" name="customerId" class="form-select" required>
                                    <c:forEach var="customer" items="${requestScope.customerList}">
                                        <option value="${customer.customerId}">${customer.firstName} ${customer.lastName}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="col-md-6 text-md-start">
                                <a href="${pageContext.request.contextPath}/addCustomer.jsp" class="btn-link-custom">Add New Customer</a>
                            </div>
                        </div>
                        <h3>Select Items for Bill</h3>
                        <table>
                            <thead>
                                <tr>
                                    <th>Title</th>
                                    <th>Price (Rs)</th>
                                    <th>Quantity Available</th>
                                    <th>Quantity to Purchase</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="item" items="${requestScope.itemList}">
                                    <tr>
                                        <td>${item.title}</td>
                                        <td><fmt:formatNumber value="${item.price}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                                        <td>${item.quantity}</td>
                                        <td>
                                            <input type="number" name="quantities" min="0" max="${item.quantity}" value="0" class="form-control d-inline-block w-auto" />
                                            <input type="hidden" name="itemIds" value="${item.itemId}" />
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="d-grid gap-2 col-md-4 mx-auto">
                            <button type="submit" class="btn btn-primary">Generate Bill</button>
                        </div>
                    </form>
                </c:when>
                <c:otherwise>
                    <p class="error">
                        <c:if test="${empty requestScope.customerList}">No customers available. Please add a customer first.</c:if>
                        <c:if test="${empty requestScope.itemList}">No items available. Please add items first.</c:if>
                    </p>
                </c:otherwise>
            </c:choose>
            <div class="text-center mt-4">
                <a href="${pageContext.request.contextPath}/staffDashboard.jsp" class="back-btn">Back to Dashboard</a>
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