package com.example.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet; // Import the WebServlet annotation
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/logout") // Add this annotation to map the servlet to the /logout URL
public class LogoutControl extends HttpServlet {
    private static final long serialVersionUID = 1L; // Add a serialVersionUID for good practice

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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}