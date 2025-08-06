package com.example.control;

import com.example.model.Item;
import com.example.service.StaffService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Item> itemList = staffService.getAllItems();
            request.setAttribute("itemList", itemList);
            request.getRequestDispatcher("staffManageItems.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffManageItems.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                Item item = new Item();
                item.setTitle(request.getParameter("title"));
                item.setAuthor(""); // Staff does not set author
                item.setGenre(""); // Staff does not set genre
                item.setPrice(Double.parseDouble(request.getParameter("price")));
                item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                staffService.addItem(item);
                request.setAttribute("successMessage", "Item added successfully");
            } else if ("update".equals(action)) {
                Item item = new Item();
                item.setItemId(Integer.parseInt(request.getParameter("itemId")));
                item.setTitle(request.getParameter("title"));
                item.setAuthor(""); // Staff does not set author
                item.setGenre(""); // Staff does not set genre
                item.setPrice(Double.parseDouble(request.getParameter("price")));
                item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                staffService.updateItem(item);
                request.setAttribute("successMessage", "Item updated successfully");
            } else if ("delete".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                staffService.deleteItem(itemId);
                request.setAttribute("successMessage", "Item deleted successfully");
            }

            List<Item> itemList = staffService.getAllItems();
            request.setAttribute("itemList", itemList);
            request.getRequestDispatcher("staffManageItems.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("staffManageItems.jsp").forward(request, response);
        }
    }
}