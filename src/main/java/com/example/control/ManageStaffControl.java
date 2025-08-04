package com.example.control;

import com.example.model.Staff;
import com.example.service.StaffService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/ManageStaffControl")
public class ManageStaffControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null || action.isEmpty()) {
                List<Staff> staffList = staffService.getAllStaff();
                request.setAttribute("staffList", staffList);
                request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                Staff staff = staffService.getStaffById(staffId);
                request.setAttribute("staff", staff);
                request.getRequestDispatcher("editStaff.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                staffService.deleteStaff(staffId);
                request.setAttribute("successMessage", "Staff deleted successfully.");
                List<Staff> staffList = staffService.getAllStaff();
                request.setAttribute("staffList", staffList);
                request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String name = request.getParameter("name");
                Staff staff = new Staff();
                staff.setUsername(username);
                staff.setPassword(password); // Password will be hashed in StaffService
                staff.setName(name);
                staffService.addStaff(staff);
                request.setAttribute("successMessage", "Staff added successfully.");
            } else if ("update".equals(action)) {
                int staffId = Integer.parseInt(request.getParameter("staffId"));
                String username = request.getParameter("username");
                String password = request.getParameter("password");
                String name = request.getParameter("name");
                Staff staff = new Staff();
                staff.setStaffId(staffId);
                staff.setUsername(username);
                staff.setPassword(password); // Password will be hashed if changed
                staff.setName(name);
                staffService.updateStaff(staff);
                request.setAttribute("successMessage", "Staff updated successfully.");
            }
            List<Staff> staffList = staffService.getAllStaff();
            request.setAttribute("staffList", staffList);
            request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageStaff.jsp").forward(request, response);
        }
    }
}