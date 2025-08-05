package com.example.control;

import com.example.model.Item;
import com.example.model.Staff;
import com.example.service.ItemService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/StaffItemControl")
public class StaffItemControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ItemService itemService;

    @Override
    public void init() throws ServletException {
        itemService = new ItemService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staff") == null || !"admin".equals(((Staff) session.getAttribute("staff")).getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if (action == null || action.isEmpty()) {
                List<Item> itemList = itemService.getAllItems();
                request.setAttribute("itemList", itemList);
                request.getRequestDispatcher("manageItems.jsp").forward(request, response);
            } else if ("edit".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                Item item = itemService.getItemById(itemId);
                request.setAttribute("item", item);
                request.getRequestDispatcher("editItem.jsp").forward(request, response);
            } else if ("delete".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                itemService.deleteItem(itemId);
                request.setAttribute("successMessage", "Item deleted successfully.");
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
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staff") == null || !"admin".equals(((Staff) session.getAttribute("staff")).getRole())) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
                Item item = new Item();
                item.setName(name);
                item.setPrice(price);
                item.setStockQuantity(stockQuantity);
                itemService.addItem(item);
                request.setAttribute("successMessage", "Item added successfully.");
            } else if ("update".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                String name = request.getParameter("name");
                double price = Double.parseDouble(request.getParameter("price"));
                int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
                Item item = new Item();
                item.setItemId(itemId);
                item.setName(name);
                item.setPrice(price);
                item.setStockQuantity(stockQuantity);
                itemService.updateItem(item);
                request.setAttribute("successMessage", "Item updated successfully.");
            }
            List<Item> itemList = itemService.getAllItems();
            request.setAttribute("itemList", itemList);
            request.getRequestDispatcher("manageItems.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageItems.jsp").forward(request, response);
        }
    }
}