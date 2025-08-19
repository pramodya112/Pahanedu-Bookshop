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
import java.util.List;

@WebServlet("/manageStaff")
public class ManageStaffControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
    }

    private boolean isAdmin(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) {
            Staff staff = (Staff) session.getAttribute("staff");
            return staff != null && "admin".equals(staff.getRole());
        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Access denied. Please log in as admin.");
            return;
        }

        HttpSession session = request.getSession();

        if (session.getAttribute("message") != null) {
            request.setAttribute("message", session.getAttribute("message"));
            session.removeAttribute("message");
        }
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }

        try {
            List<Staff> staffList = staffService.getAllStaff();
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!isAdmin(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Access denied. Please log in as admin.");
            return;
        }

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("add".equals(action)) {
                Staff staff = new Staff();
                staff.setUsername(request.getParameter("username"));
                staff.setPassword(request.getParameter("password"));
                staff.setFirstName(request.getParameter("firstName"));
                staff.setLastName(request.getParameter("lastName"));
                staff.setRole(request.getParameter("role"));
                staff.setGmail(request.getParameter("gmail"));
                staffService.addStaff(staff);
                session.setAttribute("message", "Staff added successfully");

            } else if ("update".equals(action)) {
                Staff staff = new Staff();
                staff.setStaffId(Integer.parseInt(request.getParameter("staffId")));
                staff.setUsername(request.getParameter("username"));
                staff.setPassword(request.getParameter("password"));
                staff.setFirstName(request.getParameter("firstName"));
                staff.setLastName(request.getParameter("lastName"));
                staff.setRole(request.getParameter("role"));
                staff.setGmail(request.getParameter("gmail"));
                staffService.updateStaff(staff);
                session.setAttribute("message", "Staff updated successfully");

            } else if ("delete".equals(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                staffService.deleteStaff(staffId);
                session.setAttribute("message", "Staff deleted successfully");
            }

            response.sendRedirect(request.getContextPath() + "/manageStaff");

        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manageStaff");
        }
    }
}