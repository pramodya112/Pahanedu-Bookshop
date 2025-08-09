package com.example.control;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/staffDashboard")
public class StaffDashboardControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!"staff".equals(request.getSession().getAttribute("role"))) {
            System.out.println("StaffDashboardControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }
        System.out.println("StaffDashboardControl: Forwarding to staffDashboard.jsp");
        request.getRequestDispatcher("staffDashboard.jsp").forward(request, response);
    }
}