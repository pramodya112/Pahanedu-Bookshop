package com.example.control;

import com.example.model.Item;
import com.example.service.ItemService;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class ManageItemsControl extends HttpServlet {
    private final ItemService itemService = new ItemService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ManageItemsControl: Processing GET request to fetch item list");
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            System.out.println("ManageItemsControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            List<Item> itemList = itemService.getAllItems();
            request.setAttribute("itemList", itemList);
            System.out.println("ManageItemsControl: Forwarding to manageItems.jsp with " + itemList.size() + " items");
            request.getRequestDispatcher("manageItems.jsp").forward(request, response);
        } catch (SQLException e) {
            System.out.println("ManageItemsControl: Database error: " + e.getMessage());
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("ManageItemsControl: Processing POST request");
        if (!"admin".equals(request.getSession().getAttribute("role"))) {
            System.out.println("ManageItemsControl: Unauthorized access, redirecting to login.jsp");
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int stockQuantity = Integer.parseInt(request.getParameter("stockQuantity"));
                System.out.println("ManageItemsControl: Adding item: " + name);
                itemService.addItem(name, description, price, stockQuantity);
                request.setAttribute("successMessage", "Item " + name + " added successfully!");
            } else if ("delete".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                System.out.println("ManageItemsControl: Deleting item with ID: " + itemId);
                itemService.deleteItem(itemId);
            }
            List<Item> itemList = itemService.getAllItems();
            request.setAttribute("itemList", itemList);
            System.out.println("ManageItemsControl: Forwarding to manageItems.jsp");
            request.getRequestDispatcher("manageItems.jsp").forward(request, response);
        } catch (SQLException | NumberFormatException e) {
            System.out.println("ManageItemsControl: Error: " + e.getMessage());
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }
}