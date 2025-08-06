package com.example.control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/adminDashboard")
public class AdminDashboardControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            System.out.println("AdminDashboardControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }
        System.out.println("AdminDashboardControl: Forwarding to adminDashboard.jsp");
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }
}