package com.example.service;

import com.example.dao.ItemDao;
import com.example.dao.CustomerDao;
import com.example.dao.BillDao;
import com.example.dao.StaffDao;
import com.example.dao.DatabaseConnection;
import com.example.model.Item;
import com.example.model.Customer;
import com.example.model.Bill;
import com.example.model.Staff;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class StaffService {
    private ItemDao itemDao;
    private CustomerDao customerDao;
    private BillDao billDao;
    private StaffDao staffDao;

    public StaffService() {
        Connection connection = DatabaseConnection.getConnection();
        this.itemDao = new ItemDao(connection);
        this.customerDao = new CustomerDao(connection);
        this.billDao = new BillDao(connection);
        this.staffDao = new StaffDao(connection);
    }

    public Staff authenticateStaff(String username, String password) throws SQLException {
        return staffDao.authenticateStaff(username, password);
    }

    public List<Staff> getAllStaff() throws SQLException {
        return staffDao.getAllStaff();
    }

    public void addStaff(Staff staff) throws SQLException {
        staffDao.addStaff(staff);
    }

    public void updateStaff(Staff staff) throws SQLException {
        staffDao.updateStaff(staff);
    }

    public void deleteStaff(int staffId) throws SQLException {
        staffDao.deleteStaff(staffId);
    }

    public Staff getStaffById(int staffId) throws SQLException {
        return staffDao.getStaffById(staffId);
    }

    public List<Item> getAllItems() throws SQLException {
        return itemDao.getAllItems();
    }

    public void addItem(Item item) throws SQLException {
        item.setAuthor("");
        item.setGenre("");
        itemDao.addItem(item);
    }

    public void updateItem(Item item) throws SQLException {
        item.setAuthor("");
        item.setGenre("");
        itemDao.updateItem(item);
    }

    public Item getItemById(int itemId) throws SQLException {
        return itemDao.getItemById(itemId);
    }

    public void deleteItem(int itemId) throws SQLException {
        itemDao.deleteItem(itemId);
    }

    public List<Customer> getAllCustomers() throws SQLException {
        return customerDao.getAllCustomers();
    }

    public void addCustomer(Customer customer) throws SQLException {
        customerDao.addCustomer(customer);
    }

    public void updateCustomer(Customer customer) throws SQLException {
        customerDao.updateCustomer(customer);
    }

    public Customer getCustomerById(int customerId) throws SQLException {
        return customerDao.getCustomerById(customerId);
    }

    public void deleteCustomer(int customerId) throws SQLException {
        customerDao.deleteCustomer(customerId);
    }

    public List<Bill> getBillsByCustomerId(int customerId) throws SQLException {
        return billDao.findBillsByCustomerId(customerId);
    }

    public void addBill(Bill bill) throws SQLException {
        billDao.addBill(bill);
    }

    public List<Bill> getAllBills() throws SQLException {
        return billDao.findAllBills();
    }

    public Bill getBillById(int billId) throws SQLException {
        return billDao.findBillById(billId);
    }
}