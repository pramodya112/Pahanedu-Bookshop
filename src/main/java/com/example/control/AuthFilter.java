package com.example.control;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        String role = (String) httpRequest.getSession().getAttribute("role");
        String uri = httpRequest.getRequestURI();

        if (uri.endsWith("login.jsp") || uri.endsWith("LoginControl") || uri.endsWith(".css") || uri.endsWith(".js")) {
            chain.doFilter(request, response);
            return;
        }

        if (role == null) {
            System.out.println("AuthFilter: No role found, redirecting to login.jsp");
            httpResponse.sendRedirect("login.jsp");
            return;
        }

        if (role.equals("admin")) {
            chain.doFilter(request, response);
            return;
        }

        if (role.equals("staff") && (
                uri.endsWith("staffDashboard.jsp") ||
                uri.endsWith("staffManageCustomers.jsp") ||
                uri.endsWith("editCustomer.jsp") ||
                uri.endsWith("StaffCustomerControl") ||
                uri.endsWith("staffManageItems.jsp") ||
                uri.endsWith("StaffItemControl") ||
                uri.endsWith("generateBill.jsp") ||
                uri.endsWith("BillControl") ||
                uri.endsWith("help.jsp"))) {
            chain.doFilter(request, response);
            return;
        }

        System.out.println("AuthFilter: Unauthorized access for role " + role + " to " + uri);
        httpResponse.sendRedirect("error.jsp");
    }

    @Override
    public void destroy() {}
}