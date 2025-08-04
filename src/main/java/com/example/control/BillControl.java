package com.example.control;

import com.example.model.Bill;
import com.example.model.BillItem;
import com.example.model.Customer;
import com.example.model.Item;
import com.example.service.BillService;
import com.example.service.CustomerService;
import com.example.service.ItemService;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class BillControl extends HttpServlet {
    private final CustomerService customerService = new CustomerService();
    private final ItemService itemService = new ItemService();
    private final BillService billService = new BillService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("BillControl: Processing GET request at " + new java.util.Date());
        if (!"staff".equals(request.getSession().getAttribute("role"))) {
            System.out.println("BillControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }
        
        if ("view".equals(request.getParameter("action"))) {
            int billId = Integer.parseInt(request.getParameter("billId"));
            Bill bill = billService.getBillById(billId);
            request.setAttribute("bill", bill);
            request.getRequestDispatcher("billDetails.jsp").forward(request, response);
        }

        try {
            List<Customer> customerList = customerService.getAllCustomers();
            List<Item> itemList = itemService.getAllItems();
            request.setAttribute("customerList", customerList);
            request.setAttribute("itemList", itemList);
            String customerId = request.getParameter("customerId");
            if (customerId != null) {
                List<Bill> billList = billService.getBillsByCustomerId(Integer.parseInt(customerId));
                request.setAttribute("billList", billList);
            }
            System.out.println("BillControl: Forwarding to generateBill.jsp with " + customerList.size() + " customers and " + itemList.size() + " items");
            request.getRequestDispatcher("generateBill.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            System.out.println("BillControl: Database error: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("BillControl: Processing POST request at " + new java.util.Date());
        if (!"staff".equals(request.getSession().getAttribute("role"))) {
            System.out.println("BillControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String[] itemIds = request.getParameterValues("itemId");
            String[] quantities = request.getParameterValues("quantity");

            Bill bill = new Bill();
            bill.setCustomerId(customerId);
            bill.setBillDate(new Date());
            List<BillItem> billItems = new ArrayList<>();
            double totalAmount = 0.0;

            for (int i = 0; i < itemIds.length; i++) {
                int itemId = Integer.parseInt(itemIds[i]);
                int quantity = Integer.parseInt(quantities[i]);
                if (quantity > 0) {
                    Item item = itemService.getItemById(itemId);
                    if (item != null && item.getStockQuantity() >= quantity) {
                        BillItem billItem = new BillItem();
                        billItem.setItemId(itemId);
                        billItem.setQuantity(quantity);
                        billItem.setUnitPrice(item.getPrice());
                        billItems.add(billItem);
                        totalAmount += item.getPrice() * quantity;
                    } else {
                        throw new SQLException("Insufficient stock for item ID: " + itemId);
                    }
                }
            }

            bill.setBillItems(billItems);
            bill.setTotalAmount(totalAmount);
            billService.addBill(bill);
            request.setAttribute("successMessage", "Bill generated successfully for customer ID: " + customerId);

            List<Customer> customerList = customerService.getAllCustomers();
            List<Item> itemList = itemService.getAllItems();
            request.setAttribute("customerList", customerList);
            request.setAttribute("itemList", itemList);
            System.out.println("BillControl: Forwarding to generateBill.jsp");
            request.getRequestDispatcher("generateBill.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            System.out.println("BillControl: Error: " + e.getMessage());
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
    
    
}	
