package com.example.control;

import com.example.model.Staff;
import com.example.service.StaffService;
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

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
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
                session.setAttribute("role", "admin");
                session.setAttribute("username", username);
                System.out.println("LoginControl: Admin authenticated, role set to 'admin', redirecting to /LoginSystem/adminDashboard");
                response.sendRedirect(request.getContextPath() + "/adminDashboard");
                return;
            }

            // Check staff credentials against database
            Staff staff = staffService.authenticateStaff(username, password);
            if (staff != null) {
                HttpSession session = request.getSession();
                session.setAttribute("role", "staff");
                session.setAttribute("staffId", staff.getStaffId());
                session.setAttribute("username", staff.getUsername());
                System.out.println("LoginControl: Staff authenticated, role set to 'staff', redirecting to /LoginSystem/staffDashboard");
                response.sendRedirect(request.getContextPath() + "/staffDashboard");
            } else {
                System.out.println("LoginControl: Authentication failed for username: " + username);
                request.setAttribute("error", "Invalid username or password");
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("LoginControl: Database error: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}