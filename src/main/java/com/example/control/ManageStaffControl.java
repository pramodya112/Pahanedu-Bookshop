package com.example.control;

import com.example.model.Staff;
import com.example.service.StaffService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // Import HttpSession
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Forward session attributes to request scope for display
        if (session.getAttribute("message") != null) {
            request.setAttribute("message", session.getAttribute("message"));
            session.removeAttribute("message"); // Remove it after retrieving
        }
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error"); // Remove it after retrieving
        }

        try {
            // Retrieve all staff members
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
        String action = request.getParameter("action");
        HttpSession session = request.getSession(); // Get the session

        try {
            if ("add".equals(action)) {
                // Add new staff
                Staff staff = new Staff();
                staff.setUsername(request.getParameter("username"));
                staff.setPassword(request.getParameter("password")); // Assumes password hashing in StaffService
                staff.setFirstName(request.getParameter("firstName"));
                staff.setLastName(request.getParameter("lastName"));
                staff.setRole(request.getParameter("role"));
                staffService.addStaff(staff);
                session.setAttribute("message", "Staff added successfully");

            } else if ("update".equals(action)) {
                // Update existing staff
                Staff staff = new Staff();
                staff.setStaffId(Integer.parseInt(request.getParameter("staffId")));
                staff.setUsername(request.getParameter("username"));
                staff.setPassword(request.getParameter("password")); // Assumes password hashing in StaffService
                staff.setFirstName(request.getParameter("firstName"));
                staff.setLastName(request.getParameter("lastName"));
                staff.setRole(request.getParameter("role"));
                staffService.updateStaff(staff);
                session.setAttribute("message", "Staff updated successfully");

            } else if ("delete".equals(action)) {
                // Delete staff
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                staffService.deleteStaff(staffId);
                session.setAttribute("message", "Staff deleted successfully");
            }
            
            // Redirect to the doGet method to refresh the page
            response.sendRedirect(request.getContextPath() + "/manageStaff");

        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manageStaff");
        }
    }
}