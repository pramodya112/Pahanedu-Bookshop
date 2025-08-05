package com.example.control;

import com.example.model.Log;
import com.example.model.Staff;
import com.example.dao.LogDao;
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

    @Override
    public void init() throws ServletException {
        logDao = new LogDao();
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
            log.setAction("Failed login: Invalid credentials for username=" + username);
            try {
                logDao.addLog(log);
            } catch (SQLException e) {
                System.out.println("LogDao: Failed to log error: " + e.getMessage());
            }
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}