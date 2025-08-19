package com.example.control;

import com.example.model.Staff;
import com.example.service.StaffService;
import com.example.service.LogService; // Import the new LogService
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/login")
public class LoginControl extends HttpServlet {
    private StaffService staffService;
    private LogService logService; // Declare the new service

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
        logService = new LogService(); // Initialize the new service
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Check for hardcoded admin credentials
            if ("admin".equals(username) && "admin123".equals(password)) {
                HttpSession session = request.getSession();
                Staff staff = new Staff();
                staff.setUsername(username);
                staff.setRole("admin");
                session.setAttribute("staff", staff);
                session.setAttribute("successMessage", "Welcome, Admin!");

                // Log admin login
                logService.logEvent(username, "Admin Logged in");

                System.out.println("LoginControl: Admin authenticated, Staff object set with role='admin', redirecting to adminDashboard.jsp");
                response.sendRedirect(request.getContextPath() + "/adminDashboard.jsp");
                return;
            }

            // Check staff credentials against database
            Staff staff = staffService.authenticateStaff(username, password);
            if (staff != null) {
                HttpSession session = request.getSession();
                session.setAttribute("staff", staff);
                session.setAttribute("successMessage", "Welcome, " + staff.getUsername() + "!");

                // Log staff login
                logService.logEvent(username, "Staff Logged in");

                System.out.println("LoginControl: Staff authenticated, Staff object set with role='staff', redirecting to staffDashboard.jsp");
                response.sendRedirect(request.getContextPath() + "/staffDashboard.jsp");
            } else {
                System.out.println("LoginControl: Authentication failed for username: " + username);
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("LoginControl: Database error: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
}