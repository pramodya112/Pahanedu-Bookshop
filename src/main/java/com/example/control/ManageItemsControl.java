package com.example.control;

import com.example.model.Item;
import com.example.service.ItemService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
        String action = request.getParameter("action");
        try {
            if ("edit".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                Item item = itemService.getItemById(itemId);
                if (item != null) {
                    request.setAttribute("item", item);
                    request.getRequestDispatcher("editItem.jsp").forward(request, response);
                } else {
                    request.setAttribute("error", "Item not found");
                    loadItemList(request, response);
                }
            } else {
                loadItemList(request, response);
            }
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            loadItemList(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            if ("add".equals(action)) {
                Item item = new Item();
                item.setTitle(request.getParameter("title"));
                item.setAuthor(request.getParameter("author"));
                item.setGenre(request.getParameter("genre"));
                item.setPrice(Double.parseDouble(request.getParameter("price")));
                item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                itemService.addItem(item);
                request.setAttribute("successMessage", "Item added successfully");
            } else if ("update".equals(action)) {
                Item item = new Item();
                item.setItemId(Integer.parseInt(request.getParameter("itemId")));
                item.setTitle(request.getParameter("title"));
                item.setAuthor(request.getParameter("author"));
                item.setGenre(request.getParameter("genre"));
                item.setPrice(Double.parseDouble(request.getParameter("price")));
                item.setQuantity(Integer.parseInt(request.getParameter("quantity")));
                itemService.updateItem(item);
                request.setAttribute("successMessage", "Item updated successfully");
            } else if ("delete".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                itemService.deleteItem(itemId);
                request.setAttribute("successMessage", "Item deleted successfully");
            } else {
                request.setAttribute("error", "Invalid action");
            }
            loadItemList(request, response);
        } catch (SQLException | NumberFormatException e) {
            request.setAttribute("error", "Error processing request: " + e.getMessage());
            loadItemList(request, response);
        }
    }

    private void loadItemList(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            List<Item> itemList = itemService.getAllItems();
            request.setAttribute("itemList", itemList);
            request.getRequestDispatcher("manageItems.jsp").forward(request, response);
        } catch (SQLException e) {
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("manageItems.jsp").forward(request, response);
        }
    }
}