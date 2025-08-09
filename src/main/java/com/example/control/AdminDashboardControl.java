package com.example.control;

import com.example.model.Staff;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // Add this import
import java.io.IOException;

@WebServlet("/adminDashboard")
public class AdminDashboardControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Staff staff = (session != null) ? (Staff) session.getAttribute("staff") : null;
        System.out.println("AdminDashboardControl: Staff = " + staff + ", Role = " + (staff != null ? staff.getRole() : "null"));
        if (staff != null && "admin".equals(staff.getRole())) {
            System.out.println("AdminDashboardControl: Admin access granted, forwarding to adminDashboard.jsp");
            request.getRequestDispatcher("/adminDashboard.jsp").forward(request, response);
        } else {
            System.out.println("AdminDashboardControl: Unauthorized access, redirecting to login.jsp");
            request.setAttribute("error", "Access denied. Please log in as admin.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}