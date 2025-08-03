package com.example.control;

import com.example.model.Customer;
import com.example.service.CustomerService;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ManageCustomersControl extends HttpServlet {
    private final CustomerService customerService = new CustomerService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ManageCustomersControl: Processing GET request to fetch customer list");
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            System.out.println("ManageCustomersControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Customer> customerList = customerService.getAllCustomers();
            request.setAttribute("customerList", customerList);
            System.out.println("ManageCustomersControl: Forwarding to manageCustomers.jsp with " + customerList.size() + " customers");
            request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("ManageCustomersControl: Database error: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ManageCustomersControl: Processing POST request");
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            System.out.println("ManageCustomersControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                System.out.println("ManageCustomersControl: Adding customer: " + firstName + " " + lastName);
                customerService.addCustomer(firstName, lastName, email, phone, address);
            } else if ("delete".equals(action)) {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                System.out.println("ManageCustomersControl: Deleting customer with ID: " + customerId);
                customerService.deleteCustomer(customerId);
            }
            System.out.println("ManageCustomersControl: Redirecting to manageCustomers");
            response.sendRedirect("manageCustomers");
        } catch (SQLException | NumberFormatException e) {
            System.out.println("ManageCustomersControl: Error: " + e.getMessage());
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}