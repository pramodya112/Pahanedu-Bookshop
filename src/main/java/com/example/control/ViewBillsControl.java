package com.example.control;

import com.example.model.Bill;
import com.example.model.Staff;
import com.example.model.Customer;
import com.example.service.BillService;
import com.example.service.CustomerService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

@WebServlet("/ViewBillsControl")
public class ViewBillsControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BillService billService;
    private CustomerService customerService;

    @Override
    public void init() throws ServletException {
        billService = new BillService();
        customerService = new CustomerService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staff") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        Staff staff = (Staff) session.getAttribute("staff");
        String role = staff.getRole();
        if (!"admin".equals(role) && !"staff".equals(role)) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Bill> billList = billService.getAllBills();
            
            List<Customer> customerList = customerService.getAllCustomers();
            Map<Integer, Customer> customerMap = new HashMap<>();
            for (Customer customer : customerList) {
                customerMap.put(customer.getCustomerId(), customer);
            }
            
            request.setAttribute("billList", billList);
            request.setAttribute("customerMap", customerMap);
            request.getRequestDispatcher("viewBills.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("viewBills.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}