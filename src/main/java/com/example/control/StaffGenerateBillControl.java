package com.example.control;

import com.example.model.Bill;
import com.example.model.BillItem;
import com.example.model.Customer;
import com.example.model.Item;
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

@WebServlet("/staffGenerateBill")
public class StaffGenerateBillControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Customer> customerList = staffService.getAllCustomers();
            List<Item> itemList = staffService.getAllItems();
            System.out.println("doGet: customerList size=" + (customerList != null ? customerList.size() : 0));
            System.out.println("doGet: itemList size=" + (itemList != null ? itemList.size() : 0));
            if (customerList == null || customerList.isEmpty()) {
                request.setAttribute("error", "No customers available. Please add a customer first.");
            }
            if (itemList == null || itemList.isEmpty()) {
                request.setAttribute("error", "No items available. Please add items first.");
            }
            request.setAttribute("customerList", customerList);
            request.setAttribute("itemList", itemList);
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        } catch (SQLException e) {
            System.err.println("SQLException in doGet: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("doPost action: " + action);

        try {
            if ("addCustomer".equals(action)) {
                Customer customer = new Customer();
                customer.setFirstName(request.getParameter("firstName"));
                customer.setLastName(request.getParameter("lastName"));
                customer.setEmail(request.getParameter("email"));
                customer.setPhone(request.getParameter("phone"));
                customer.setAddress(request.getParameter("address"));
                staffService.addCustomer(customer);
                request.setAttribute("successMessage", "Customer added successfully");
                List<Customer> customerList = staffService.getAllCustomers();
                List<Item> itemList = staffService.getAllItems();
                request.setAttribute("customerList", customerList);
                request.setAttribute("itemList", itemList);
                request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
            } else if ("generateBill".equals(action)) {
                String customerIdStr = request.getParameter("customerId");
                String[] itemIds = request.getParameterValues("itemIds");
                String[] quantities = request.getParameterValues("quantities");

                System.out.println("customerId: " + customerIdStr);
                System.out.println("itemIds: " + (itemIds != null ? String.join(",", itemIds) : "null"));
                System.out.println("quantities: " + (quantities != null ? String.join(",", quantities) : "null"));

                if (customerIdStr == null || customerIdStr.isEmpty()) {
                    request.setAttribute("error", "Please select a customer");
                    List<Customer> customerList = staffService.getAllCustomers();
                    List<Item> itemList = staffService.getAllItems();
                    request.setAttribute("customerList", customerList);
                    request.setAttribute("itemList", itemList);
                    request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
                    return;
                }

                int customerId = Integer.parseInt(customerIdStr);
                List<BillItem> billItems = new ArrayList<>();
                List<Item> selectedItems = new ArrayList<>();
                double totalAmount = 0.0;

                if (itemIds == null || quantities == null || itemIds.length != quantities.length) {
                    request.setAttribute("error", "Invalid item selection or quantities");
                    List<Customer> customerList = staffService.getAllCustomers();
                    List<Item> itemList = staffService.getAllItems();
                    request.setAttribute("customerList", customerList);
                    request.setAttribute("itemList", itemList);
                    request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
                    return;
                }

                for (int i = 0; i < itemIds.length; i++) {
                    int itemId = Integer.parseInt(itemIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    Item item = staffService.getItemById(itemId);
                    System.out.println("Processing itemId=" + itemId + ", quantity=" + quantity);
                    if (item == null) {
                        request.setAttribute("error", "Item not found for ID: " + itemId);
                        List<Customer> customerList = staffService.getAllCustomers();
                        List<Item> itemList = staffService.getAllItems();
                        request.setAttribute("customerList", customerList);
                        request.setAttribute("itemList", itemList);
                        request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
                        return;
                    }
                    if (quantity > 0) {
                        if (quantity > item.getQuantity()) {
                            request.setAttribute("error", "Insufficient stock for " + item.getTitle());
                            List<Customer> customerList = staffService.getAllCustomers();
                            List<Item> itemList = staffService.getAllItems();
                            request.setAttribute("customerList", customerList);
                            request.setAttribute("itemList", itemList);
                            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
                            return;
                        }
                        BillItem billItem = new BillItem();
                        billItem.setItemId(itemId);
                        billItem.setQuantity(quantity);
                        billItem.setUnitPrice(item.getPrice());
                        billItems.add(billItem);
                        selectedItems.add(item);
                        totalAmount += item.getPrice() * quantity;
                        item.setQuantity(item.getQuantity() - quantity);
                        staffService.updateItem(item);
                    }
                }

                if (billItems.isEmpty()) {
                    request.setAttribute("error", "No valid items selected");
                    List<Customer> customerList = staffService.getAllCustomers();
                    List<Item> itemList = staffService.getAllItems();
                    request.setAttribute("customerList", customerList);
                    request.setAttribute("itemList", itemList);
                    request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
                    return;
                }

                Bill bill = new Bill();
                bill.setCustomerId(customerId);
                bill.setTotalAmount(totalAmount);
                bill.setBillDate(new Date());
                bill.setBillItems(billItems); // Set billItems

                staffService.addBill(bill);

                request.setAttribute("bill", bill);
                request.setAttribute("selectedItems", selectedItems);
                request.setAttribute("quantities", quantities);
                request.setAttribute("successMessage", "Bill generated successfully");
                request.getRequestDispatcher("billReceipt.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Invalid action");
                request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.err.println("SQLException in doPost: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("NumberFormatException in doPost: " + e.getMessage());
            request.setAttribute("error", "Invalid input format: " + e.getMessage());
            request.getRequestDispatcher("staffGenerateBill.jsp").forward(request, response);
        }
    }
}