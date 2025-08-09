package com.example.control;

import com.example.model.Bill;
import com.example.model.Staff;
import com.example.service.BillService;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/staffViewBillDetails")
public class StaffViewBillDetailsControl extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BillService billService;

    @Override
    public void init() throws ServletException {
        billService = new BillService();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("staff") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String billIdStr = request.getParameter("billId");
        if (billIdStr == null || billIdStr.isEmpty()) {
            request.setAttribute("error", "Bill ID not provided.");
            request.getRequestDispatcher("billDetails.jsp").forward(request, response);
            return;
        }

        try {
            int billId = Integer.parseInt(billIdStr);
            Bill bill = billService.getBillById(billId);

            if (bill != null) {
                request.setAttribute("bill", bill);
                request.getRequestDispatcher("billDetails.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Bill with ID " + billId + " not found.");
                request.getRequestDispatcher("billDetails.jsp").forward(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Bill ID format.");
            request.getRequestDispatcher("billDetails.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("billDetails.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}