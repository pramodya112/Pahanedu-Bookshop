<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.example.model.Staff" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pahanedu Bookshop - Admin Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Dancing+Script:wght@400;700&family=Playfair+Display:wght@400;700&display=swap" rel="stylesheet">
    <style>
        body {
            background-color: #7A8450; /* Muted Green background */
            font-family: 'Roboto', sans-serif;
            color: #fff; /* Default text color to white */
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
        .navbar-text {
            color: #212529 !important;
            font-weight: 700;
        }
        .main-title {
            color: #fff;
            font-family: 'Playfair Display', serif;
            font-size: 2.5rem;
            font-weight: 700;
        }
        .card-option {
            transition: transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out;
            cursor: pointer;
            border: none;
            background-color: #e3e8e2; /* A lighter shade of green for card */
            border-radius: 1rem;
            color: #212529;
        }
        .card-option:hover {
            transform: translateY(-5px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.25) !important;
        }
        .card-body h5 {
            font-family: 'Playfair Display', serif;
            font-weight: 700;
            color: #8b4513;
        }
        .icon-box {
            font-size: 2rem;
            color: #8b4513;
            font-weight: 700;
        }
        a {
            text-decoration: none;
            color: #212529;
        }
        a:hover {
            color: #495057;
        }
        .error {
            color: #B22222; /* Firebrick red */
            font-size: 1rem;
            margin-bottom: 1rem;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-light dashboard-header">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">📚 Pahanedu Bookshop</a>
            <span class="navbar-text ms-auto me-3">
                Welcome, Admin!
            </span>
            <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger">Logout</a>
        </div>
    </nav>

    <div class="container mt-5">
        <h2 class="mb-4 main-title">Admin Dashboard</h2>
        
        <% 
            Staff staff = (Staff) session.getAttribute("staff"); 
            if (staff == null || !"admin".equals(staff.getRole())) { 
        %>
            <p class="error">Access denied. Please log in as admin.</p>
            <a href="${pageContext.request.contextPath}/login.jsp" class="btn btn-primary">Login</a>
        <% } else { %>
            <div class="row g-4">
            
                <div class="col-md-6 col-lg-4">
                    <a href="${pageContext.request.contextPath}/manageCustomers" class="d-block text-decoration-none">
                        <div class="card card-option p-4 text-center shadow-sm">
                            <div class="card-body">
                                <div class="icon-box mb-2">👤</div>
                                <h5 class="card-title">Manage Customers</h5>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-6 col-lg-4">
                    <a href="${pageContext.request.contextPath}/manageStaff" class="d-block text-decoration-none">
                        <div class="card card-option p-4 text-center shadow-sm">
                            <div class="card-body">
                                <div class="icon-box mb-2">👥</div>
                                <h5 class="card-title">Manage Staff</h5>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-6 col-lg-4">
                    <a href="${pageContext.request.contextPath}/manageItems" class="d-block text-decoration-none">
                        <div class="card card-option p-4 text-center shadow-sm">
                            <div class="card-body">
                                <div class="icon-box mb-2">📚</div>
                                <h5 class="card-title">Manage Items</h5>
                            </div>
                        </div>
                    </a>
                </div>

                <div class="col-md-6 col-lg-4">
                    <a href="${pageContext.request.contextPath}/ViewBillsControl" class="d-block text-decoration-none">
                        <div class="card card-option p-4 text-center shadow-sm">
                            <div class="card-body">
                                <div class="icon-box mb-2">📋</div>
                                <h5 class="card-title">View Bills</h5>
                            </div>
                        </div>
                    </a>
                </div>
                
                <div class="col-md-6 col-lg-4">
                    <a href="${pageContext.request.contextPath}/viewLogs" class="d-block text-decoration-none">
                        <div class="card card-option p-4 text-center shadow-sm">
                            <div class="card-body">
                                <div class="icon-box mb-2">📜</div>
                                <h5 class="card-title">View Logs</h5>
                            </div>
                        </div>
                    </a>
                </div>
                
            </div>
        <% } %>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>