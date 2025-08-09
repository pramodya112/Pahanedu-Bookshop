package com.example.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class LogoutControl extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("LogoutControl: Processing logout request");
        HttpSession session = request.getSession(false);
        if (session != null) {
            System.out.println("LogoutControl: Invalidating session for username=" + session.getAttribute("username"));
            session.invalidate();
        }
        System.out.println("LogoutControl: Redirecting to login.jsp");
        response.sendRedirect("login.jsp");
    }
}