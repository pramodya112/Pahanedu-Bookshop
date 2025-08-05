package com.example.control;

import com.example.model.Log;
import com.example.model.Staff;
import com.example.dao.LogDao;
import com.example.service.StaffService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;

@WebServlet("/LoginControl")
public class LoginControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private LogDao logDao;
    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        logDao = new LogDao();
        staffService = new StaffService();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        Log log = new Log();
        log.setUsername(username);
        log.setLogTime(new Timestamp(System.currentTimeMillis()));

        // Hardcoded admin check
        if ("admin".equals(username) && "adminpass".equals(password)) {
            HttpSession session = request.getSession(true);
            Staff admin = new Staff();
            admin.setUsername("admin");
            admin.setFirstName("Admin");
            admin.setLastName("User");
            admin.setRole("admin");
            session.setAttribute("staff", admin);
            log.setAction("Hardcoded admin login");
            try {
                logDao.addLog(log);
            } catch (SQLException e) {
                System.out.println("LogDao: Failed to log admin login: " + e.getMessage());
            }
            response.sendRedirect("adminDashboard.jsp");
        } else {
            // Staff authentication
            try {
                Staff staff = staffService.authenticateStaff(username, password);
                if (staff != null) {
                    HttpSession session = request.getSession(true);
                    session.setAttribute("staff", staff);
                    log.setAction("Staff login successful for username=" + username);
                    logDao.addLog(log);
                    response.sendRedirect("staffDashboard.jsp");
                } else {
                    log.setAction("Failed login: Invalid staff credentials for username=" + username);
                    logDao.addLog(log);
                    request.setAttribute("error", "Invalid username or password");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
            } catch (SQLException e) {
                log.setAction("Failed login: Database error for username=" + username);
                try {
                    logDao.addLog(log);
                } catch (SQLException ex) {
                    System.out.println("LogDao: Failed to log error: " + ex.getMessage());
                }
                request.setAttribute("error", "Database error: " + e.getMessage());
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        }
    }
}