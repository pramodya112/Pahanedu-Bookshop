package com.example.control;

import com.example.model.Customer;
import com.example.service.CustomerService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/manageCustomers")
public class ManageCustomersControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            // Retrieve all customers
            List<Customer> customerList = customerService.getAllCustomers();
            request.setAttribute("customerList", customerList);
            request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                // Add new customer
                Customer customer = new Customer();
                customer.setFirstName(request.getParameter("firstName"));
                customer.setLastName(request.getParameter("lastName"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));
                customerService.addCustomer(customer);
                request.setAttribute("message", "Customer added successfully");

            } else if ("update".equals(action)) {
                // Update existing customer
                Customer customer = new Customer();
                customer.setCustomerId(Integer.parseInt(request.getParameter("customerId")));
                customer.setFirstName(request.getParameter("firstName"));
                customer.setLastName(request.getParameter("lastName"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));
                customerService.updateCustomer(customer);
                request.setAttribute("message", "Customer updated successfully");

            } else if ("delete".equals(action)) {
                // Delete customer
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                customerService.deleteCustomer(customerId);
                request.setAttribute("message", "Customer deleted successfully");
            }

            // Refresh customer list after action
            List<Customer> customerList = customerService.getAllCustomers();
            request.setAttribute("customerList", customerList);
            request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);

        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
        }
    }
}