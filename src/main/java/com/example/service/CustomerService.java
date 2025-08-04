package com.example.service;

import com.example.dao.CustomerDao;
import com.example.model.Customer;
import java.sql.SQLException;
import java.util.List;

public class CustomerService {
    private final CustomerDao customerDao;

    public CustomerService() {
        this.customerDao = new CustomerDao();
    }

    public List<Customer> getAllCustomers() throws SQLException {
        return customerDao.findAllCustomers();
    }

    public Customer getCustomerById(int customerId) throws SQLException {
        return customerDao.findCustomerById(customerId);
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