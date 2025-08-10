package com.example.control;

import com.example.model.Customer;
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

@WebServlet("/manageCustomers")
public class ManageCustomersControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve and remove session attributes to display one-time messages
        if (session.getAttribute("message") != null) {
            request.setAttribute("message", session.getAttribute("message"));
            session.removeAttribute("message");
        }
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }

        String action = request.getParameter("action");
        try {
            if ("edit".equals(action)) {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                Customer customer = staffService.getCustomerById(customerId);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            } else {
                List<Customer> customerList = staffService.getAllCustomers();
                request.setAttribute("customerList", customerList);
                request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        
        // Get the current user's role from the session
        Staff staff = (Staff) session.getAttribute("staff");

        try {
            if ("add".equals(action)) {
                Customer customer = new Customer();
                customer.setFirstName(request.getParameter("firstName"));
                customer.setLastName(request.getParameter("lastName"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));
                staffService.addCustomer(customer);
                session.setAttribute("message", "Customer added successfully");
            } else if ("update".equals(action)) {
                Customer customer = new Customer();
                customer.setCustomerId(Integer.parseInt(request.getParameter("customerId")));
                customer.setFirstName(request.getParameter("firstName"));
                customer.setLastName(request.getParameter("lastName"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));
                staffService.updateCustomer(customer);
                session.setAttribute("message", "Customer updated successfully");
            } else if ("delete".equals(action)) {
                // Security check: Only allow 'admin' to delete customers
                if (staff != null && "admin".equals(staff.getRole())) {
                    int customerId = Integer.parseInt(request.getParameter("customerId"));
                    staffService.deleteCustomer(customerId);
                    session.setAttribute("message", "Customer deleted successfully");
                } else {
                    session.setAttribute("error", "You do not have permission to delete customers.");
                }
            }

            response.sendRedirect(request.getContextPath() + "/manageCustomers");

        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manageCustomers");
        }
    }
}