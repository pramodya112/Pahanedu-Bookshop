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

@WebServlet("/StaffCustomerControl")
public class StaffCustomerControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if (action == null || action.isEmpty()) {
                List<Customer> customerList = customerService.getAllCustomers();
                request.setAttribute("customerList", customerList);
                request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                Customer customer = customerService.getCustomerById(customerId);
                request.setAttribute("customer", customer);
                request.getRequestDispatcher("editCustomer.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                customerService.deleteCustomer(customerId);
                request.setAttribute("successMessage", "Customer deleted successfully.");
                List<Customer> customerList = customerService.getAllCustomers();
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
        try {
            if ("add".equals(action)) {
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                Customer customer = new Customer();
                customer.setFirstName(firstName);
                customer.setLastName(lastName);
                customer.setEmail(email);
                customer.setPhone(phone);
                customerService.addCustomer(customer);
                request.setAttribute("successMessage", "Customer added successfully.");
            } else if ("update".equals(action)) {
                int customerId = Integer.parseInt(request.getParameter("customerId"));
                String firstName = request.getParameter("firstName");
                String lastName = request.getParameter("lastName");
                String email = request.getParameter("email");
                String phone = request.getParameter("phone");
                Customer customer = new Customer();
                customer.setCustomerId(customerId);
                customer.setFirstName(firstName);
                customer.setLastName(lastName);
                customer.setEmail(email);
                customer.setPhone(phone);
                customerService.updateCustomer(customer);
                request.setAttribute("successMessage", "Customer updated successfully.");
            }
            List<Customer> customerList = customerService.getAllCustomers();
            request.setAttribute("customerList", customerList);
            request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageCustomers.jsp").forward(request, response);
        }
    }
}