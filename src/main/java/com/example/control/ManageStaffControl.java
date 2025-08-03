package com.example.control;

import com.example.model.Staff;
import com.example.service.StaffService;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ManageStaffControl extends HttpServlet {
    private final StaffService staffService = new StaffService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ManageStaffControl: Processing GET request to fetch staff list");
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            System.out.println("ManageStaffControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Staff> staffList = staffService.getAllStaff();
            request.setAttribute("staffList", staffList);
            System.out.println("ManageStaffControl: Forwarding to manageStaff.jsp with " + staffList.size() + " staff");
            request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("ManageStaffControl: Database error: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ManageStaffControl: Processing POST request");
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            System.out.println("ManageStaffControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String role = request.getParameter("role");
                System.out.println("ManageStaffControl: Adding staff: " + firstName + " " + lastName);
                staffService.addStaff(username, password, firstName, lastName, role);
                request.setAttribute("successMessage", "Staff " + firstName + " " + lastName + " added successfully!");
            } else if ("delete".equals(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                System.out.println("ManageStaffControl: Deleting staff with ID: " + staffId);
                staffService.deleteStaff(staffId);
            }
            List<Staff> staffList = staffService.getAllStaff();
            request.setAttribute("staffList", staffList);
            System.out.println("ManageStaffControl: Forwarding to manageStaff.jsp");
            request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            System.out.println("ManageStaffControl: Error: " + e.getMessage());
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}