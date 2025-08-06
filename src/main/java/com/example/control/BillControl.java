package com.example.control;

import com.example.model.Bill;
import com.example.model.BillItem;
import com.example.model.Customer;
import com.example.model.Item;
import com.example.service.BillService;
import com.example.service.StaffService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/bill")
public class BillControl extends HttpServlet {
    private final BillService billService = new BillService();
    private final StaffService staffService = new StaffService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!"staff".equals(request.getSession().getAttribute("role"))) {
            System.out.println("BillControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Customer> customerList = staffService.getAllCustomers();
            List<Item> itemList = staffService.getAllItems();
            request.setAttribute("customerList", customerList);
            request.setAttribute("itemList", itemList);
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        if (!"staff".equals(request.getSession().getAttribute("role"))) {
            System.out.println("BillControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int customerId = Integer.parseInt(request.getParameter("customerId"));
            String[] quantities = request.getParameterValues("quantities");
            String[] itemIds = request.getParameterValues("itemIds");

            List<BillItem> billItems = new ArrayList<>();
            double totalAmount = 0.0;

            for (int i = 0; i < itemIds.length; i++) {
                int quantity = Integer.parseInt(quantities[i]);
                if (quantity > 0) {
                    int itemId = Integer.parseInt(itemIds[i]);
                    Item item = staffService.getItemById(itemId);
                    if (item != null && item.getQuantity() >= quantity) {
                        BillItem billItem = new BillItem();
                        billItem.setItemId(itemId);
                        billItem.setQuantity(quantity);
                        billItem.setUnitPrice(item.getPrice());
                        billItems.add(billItem);
                        totalAmount += quantity * item.getPrice();
                    } else {
                        request.setAttribute("error", "Invalid quantity or item not found for item ID: " + itemId);
                        request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
                        return;
                    }
                }
            }

            if (billItems.isEmpty()) {
                request.setAttribute("error", "No items selected for the bill");
                request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
                return;
            }

            Bill bill = new Bill();
            bill.setCustomerId(customerId);
            bill.setTotalAmount(totalAmount);
            bill.setBillDate(new Date());
            bill.setBillItems(billItems);

            billService.addBill(bill);

            for (BillItem billItem : billItems) {
                Item item = staffService.getItemById(billItem.getItemId());
                item.setQuantity(item.getQuantity() - billItem.getQuantity());
                staffService.updateItem(item);
            }

            request.setAttribute("successMessage", "Bill generated successfully");
            List<Customer> customerList = staffService.getAllCustomers();
            List<Item> itemList = staffService.getAllItems();
            request.setAttribute("customerList", customerList);
            request.setAttribute("itemList", itemList);
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid input format: " + e.getMessage());
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        }
    }
}