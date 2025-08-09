package com.example.control;

import com.example.model.Staff;
import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        if (session != null) {
            Staff staff = (Staff) session.getAttribute("staff");
            if (staff != null && "admin".equals(staff.getRole())) {
                chain.doFilter(request, response);
                return;
            }
        }
        resp.sendRedirect("login.jsp");
    }

    @Override
    public void destroy() {}
}