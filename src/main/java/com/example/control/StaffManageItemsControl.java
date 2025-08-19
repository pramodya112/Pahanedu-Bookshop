package com.example.control;

import com.example.model.Item;
import com.example.model.Staff; // Import the Staff model
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

@WebServlet("/staffManageItems")
public class StaffManageItemsControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private StaffService staffService;

    @Override
    public void init() throws ServletException {
        staffService = new StaffService();
    }
    
    // Helper method to check if the user is authorized (admin or staff)
    private boolean isAuthorized(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("staff") != null) {
            Staff currentStaff = (Staff) session.getAttribute("staff");
            String role = currentStaff.getRole();
            return "admin".equals(role) || "staff".equals(role);
        }
        return false;
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Security check: Deny access if user is not an admin or staff
        if (!isAuthorized(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Access denied. Please log in as admin or staff.");
            return;
        }

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
        
        String action = request.getParameter("action");
        try {
            if ("edit".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                Item item = staffService.getItemById(itemId);
                request.setAttribute("item", item);
                // Redirect to the staffEditItem.jsp page when action is 'edit'
                request.getRequestDispatcher("staffEditItem.jsp").forward(request, response);
            } else {
                List<Item> itemList = staffService.getAllItems();
                request.setAttribute("itemList", itemList);
                request.getRequestDispatcher("staffManageItems.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffManageItems.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid item ID provided for editing.");
            request.getRequestDispatcher("staffManageItems.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Security check: Deny access if user is not an admin or staff
        if (!isAuthorized(request)) {
            response.sendRedirect(request.getContextPath() + "/login.jsp?error=Access denied. Please log in as admin or staff.");
            return;
        }

        String action = request.getParameter("action");
        HttpSession session = request.getSession();

        try {
            if ("add".equals(action)) {
                Item item = new Item();
                item.setTitle(request.getParameter("title"));
                item.setAuthor(request.getParameter("author"));
                item.setGenre(request.getParameter("genre"));
                item.setPrice(Double.parseDouble(request.getParameter("price")));
                item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                staffService.addItem(item);
                session.setAttribute("message", "Item added successfully");
            } else if ("update".equals(action)) {
                Item item = new Item();
                item.setItemId(Integer.parseInt(request.getParameter("itemId")));
                item.setTitle(request.getParameter("title"));
                item.setAuthor(request.getParameter("author"));
                item.setGenre(request.getParameter("genre"));
                item.setPrice(Double.parseDouble(request.getParameter("price")));
                item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                staffService.updateItem(item);
                session.setAttribute("message", "Item updated successfully");
            } else if ("delete".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                staffService.deleteItem(itemId);
                session.setAttribute("message", "Item deleted successfully");
            }

            // Redirect to the doGet method to refresh the page and display the message
            response.sendRedirect(request.getContextPath() + "/staffManageItems");

        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/staffManageItems");
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid number format for price or quantity.");
            response.sendRedirect(request.getContextPath() + "/staffManageItems");
        }
    }
}