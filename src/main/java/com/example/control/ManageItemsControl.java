package com.example.control;

import com.example.model.Item;
import com.example.service.ItemService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession; // New Import
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/manageItems")
public class ManageItemsControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        itemService = new ItemService();
    }

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

        String action = request.getParameter("action");
        try {
            if ("edit".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                Item item = itemService.getItemById(itemId);
                request.setAttribute("item", item);
                request.getRequestDispatcher("editItem.jsp").forward(request, response);
            } else {
                List<Item> itemList = itemService.getAllItems();
                request.setAttribute("itemList", itemList);
                request.getRequestDispatcher("manageItems.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageItems.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        HttpSession session = request.getSession(); // Get the session

        try {
            if ("add".equals(action)) {
                Item item = new Item();
                item.setTitle(request.getParameter("title"));
                item.setAuthor(request.getParameter("author"));
                item.setGenre(request.getParameter("genre"));
                item.setPrice(Double.parseDouble(request.getParameter("price")));
                item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                itemService.addItem(item);
                session.setAttribute("message", "Item added successfully");
            } else if ("update".equals(action)) {
                Item item = new Item();
                item.setItemId(Integer.parseInt(request.getParameter("itemId")));
                item.setTitle(request.getParameter("title"));
                item.setAuthor(request.getParameter("author"));
                item.setGenre(request.getParameter("genre"));
                item.setPrice(Double.parseDouble(request.getParameter("price")));
                item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                itemService.updateItem(item);
                session.setAttribute("message", "Item updated successfully");
            } else if ("delete".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                itemService.deleteItem(itemId);
                session.setAttribute("message", "Item deleted successfully");
            }

            // Redirect back to the doGet method to refresh the page and display the message
            response.sendRedirect(request.getContextPath() + "/manageItems");
            
        } catch (SQLException e) {
            session.setAttribute("error", "Database error: " + e.getMessage());
            response.sendRedirect(request.getContextPath() + "/manageItems");
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid number format for price or quantity.");
            response.sendRedirect(request.getContextPath() + "/manageItems");
        }
    }
}