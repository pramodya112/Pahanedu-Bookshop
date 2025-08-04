package com.example.service;

import com.example.dao.BillDao;
import com.example.model.Bill;
import java.sql.SQLException;
import java.util.List;

public class BillService {
    private final BillDao billDao;

    public BillService() {
        this.billDao = new BillDao();
    }

    public List<Bill> getAllBills() throws SQLException {
        return billDao.findAllBills();
    }
}