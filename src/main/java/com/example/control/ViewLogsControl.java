package com.example.control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.model.Log;

public class ViewLogsControl extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/loginsystem";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "MYSQL@123";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            response.sendRedirect("login.jsp");
            return;
        }

        List<Log> logs = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM logs ORDER BY log_time DESC")) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Log log = new Log();
                    log.setLogId(rs.getInt("log_id"));
                    log.setAction(rs.getString("action"));
                    log.setUsername(rs.getString("username"));
                    log.setLogTime(rs.getTimestamp("log_time"));
                    logs.add(log);
                }
            }
        } catch (ClassNotFoundException | SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
            return;
        }
        request.setAttribute("logs", logs);
        request.getRequestDispatcher("viewLogs.jsp").forward(request, response);
    }
}