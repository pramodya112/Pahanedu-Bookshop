package com.example.service;

import com.example.dao.CustomerDao;
import com.example.dao.DatabaseConnection;
import com.example.model.Customer;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

public class CustomerService {
    private final CustomerDao customerDao;

    public CustomerService() {
        Connection connection = DatabaseConnection.getConnection();
        this.customerDao = new CustomerDao(connection);
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

    public void deleteCustomer(int customerId) throws SQLException {
        customerDao.deleteCustomer(customerId);
    }
}