package com.example.control;

import com.example.model.Bill;
import com.example.model.BillItem;
import com.example.model.Customer;
import com.example.model.Item;
import com.example.model.ReceiptItem;
import com.example.service.StaffService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@WebServlet("/staffGenerateBill")
public class StaffGenerateBillControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        staffService = new StaffService(); // This creates a real StaffService for the app
    }

    // --- IMPORTANT: Ensure this setter is present for testability ---
    public void setStaffService(StaffService staffService) {
        this.staffService = staffService; // This allows tests to inject a mock StaffService
    }
    // --- End of important setter ---


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        // Retrieve and remove session messages for one-time display
        if (session.getAttribute("message") != null) {
            request.setAttribute("message", session.getAttribute("message"));
            session.removeAttribute("message");
        }
        if (session.getAttribute("error") != null) {
            request.setAttribute("error", session.getAttribute("error"));
            session.removeAttribute("error");
        }

        try {
            List<Customer> customerList = staffService.getAllCustomers();
            List<Item> itemList = staffService.getAllItems();

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
        HttpSession session = request.getSession();
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
                session.setAttribute("message", "Customer added successfully"); // Set message in session
                response.sendRedirect(request.getContextPath() + "/staffGenerateBill"); // Redirect
                return;
            } else if ("generateBill".equals(action)) {
                String customerIdStr = request.getParameter("customerId");
                String[] itemIds = request.getParameterValues("itemIds");
                String[] quantities = request.getParameterValues("quantities");

                if (customerIdStr == null || customerIdStr.isEmpty()) {
                    session.setAttribute("error", "Please select a customer");
                    response.sendRedirect(request.getContextPath() + "/staffGenerateBill");
                    return;
                }

                int customerId = Integer.parseInt(customerIdStr);
                List<BillItem> billItems = new ArrayList<>();
                double totalAmount = 0.0;
                List<ReceiptItem> receiptItems = new ArrayList<>();

                if (itemIds == null || quantities == null || itemIds.length != quantities.length) {
                    session.setAttribute("error", "Invalid item selection or quantities");
                    response.sendRedirect(request.getContextPath() + "/staffGenerateBill");
                    return;
                }

                for (int i = 0; i < itemIds.length; i++) {
                    int itemId = Integer.parseInt(itemIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);
                    Item item = staffService.getItemById(itemId);

                    if (item == null || (quantity > 0 && quantity > item.getQuantity())) {
                        session.setAttribute("error", "Insufficient stock or item not found.");
                        response.sendRedirect(request.getContextPath() + "/staffGenerateBill");
                        return;
                    }

                    if (quantity > 0) {
                        BillItem billItem = new BillItem();
                        billItem.setItemId(itemId);
                        billItem.setQuantity(quantity);
                        billItem.setUnitPrice(item.getPrice());
                        billItems.add(billItem);
                        totalAmount += item.getPrice() * quantity;
                        item.setQuantity(item.getQuantity() - quantity);
                        staffService.updateItem(item);

                        receiptItems.add(new ReceiptItem(item, quantity));
                    }
                }

                if (billItems.isEmpty()) {
                    session.setAttribute("error", "No valid items selected");
                    response.sendRedirect(request.getContextPath() + "/staffGenerateBill");
                    return;
                }

                // Generate a unique reference number
                String referenceNumber = generateUniqueReferenceNumber();

                Bill bill = new Bill();
                bill.setReferenceNumber(referenceNumber); // Set the reference number
                bill.setCustomerId(customerId);
                bill.setTotalAmount(totalAmount);
                bill.setBillDate(new Date());
                bill.setBillItems(billItems);

                staffService.addBill(bill); // Ensure this method can handle the new field

                Customer customer = staffService.getCustomerById(customerId);

                request.setAttribute("bill", bill);
                request.setAttribute("receiptItems", receiptItems);
                request.setAttribute("customer", customer);
                session.setAttribute("message", "Bill generated successfully");
                request.getRequestDispatcher("billReceipt.jsp").forward(request, response);
                return;
            } else {
                session.setAttribute("error", "Invalid action");
                response.sendRedirect(request.getContextPath() + "/staffGenerateBill");
                return;
            }
        } catch (SQLException e) {
            System.err.println("SQLException in doPost: " + e.getMessage());
            session.setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/staffGenerateBill");
            return;
        } catch (NumberFormatException e) {
            System.err.println("NumberFormatException in doPost: " + e.getMessage());
            session.setAttribute("error", "Invalid input format: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/staffGenerateBill");
            return;
        }
    }

    /**
     * Generates a unique, alphanumeric reference number.
     * Example: INV-20250811103055-1234
     */
    private String generateUniqueReferenceNumber() {
        String prefix = "INV-";
        String timestamp = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String randomPart = String.format("%04d", (int) (Math.random() * 9999));
        return prefix + timestamp + "-" + randomPart;
    }
}