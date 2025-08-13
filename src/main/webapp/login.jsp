<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - Pahanedu Bookshop</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-image: linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), 
                             url('https://images.unsplash.com/photo-1512820790803-83ca960114d9?ixlib=rb-4.0.3&auto=format&fit=crop&w=1350&q=80');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
            font-family: 'Roboto', sans-serif;
        }
        .login-card {
            background: linear-gradient(135deg, #FFF8DC 0%, #F5E6B8 100%);
            border-radius: 15px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
            z-index: 1;
        }
        .login-card h2 {
            font-family: 'Playfair Display', serif;
            color: #8B4513;
        }
        .btn-custom {
            background-color: #8B4513;
            color: #FFF8DC;
            border: none;
            font-weight: 700;
            transition: background-color 0.2s ease;
        }
        .btn-custom:hover {
            background-color: #6B4E31;
            color: #FFF8DC;
        }
    </style>
</head>
<body>
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card login-card p-4 p-md-5" style="max-width: 450px; width: 100%;">
            <div class="card-body text-center">
                <h2 class="card-title mb-4">Pahanedu Bookshop</h2>
                <h5 class="card-subtitle mb-3 text-muted">Staff Login</h5>
                
                <% 
                    String errorMessage = (String) request.getAttribute("errorMessage");
                    if (errorMessage != null) {
                %>
                        <div class="alert alert-danger" role="alert">
                            <%= errorMessage %>
                        </div>
                <%
                    }
                %>

                <form action="login" method="post">
                    <div class="mb-3 text-start">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-4 text-start">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <button type="submit" class="btn btn-custom w-100">Login</button>
                </form>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>