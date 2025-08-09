<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Customer Dashboard</title>
</head>
<body>
    <h2>Customer Dashboard</h2>
    <c:if test="${not empty sessionScope.user && sessionScope.user.role == 'customer'}">
        <p>Welcome, ${sessionScope.user.username}</p>
        <a href="ViewBillsControl">View Your Bills</a><br>
        <a href="logout.jsp">Logout</a>
    </c:if>
    <c:if test="${empty sessionScope.user || sessionScope.user.role != 'customer'}">
        <p>Please <a href="login.jsp">login</a> as a customer to access the dashboard.</p>
    </c:if>
</body>
</html>