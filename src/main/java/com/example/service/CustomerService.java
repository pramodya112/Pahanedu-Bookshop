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
        System.out.println("CustomerService: Fetching all customers");
        List<Customer> customerList = customerDao.findAllCustomers();
        System.out.println("CustomerService: Retrieved " + customerList.size() + " customers");
        return customerList;
    }

    public void addCustomer(String firstName, String lastName, String email, String phone, String address) throws SQLException {
        System.out.println("CustomerService: Adding customer: " + firstName + " " + lastName);
        Customer customer = new Customer();
        customer.setFirstName(firstName);
        customer.setLastName(lastName);
        customer.setEmail(email);
        customer.setPhone(phone);
        customer.setAddress(address);
        customerDao.addCustomer(customer);
        System.out.println("CustomerService: Customer added: " + firstName + " " + lastName);
    }

    public void deleteCustomer(int customerId) throws SQLException {
        System.out.println("CustomerService: Deleting customer with ID: " + customerId);
        customerDao.deleteCustomer(customerId);
        System.out.println("CustomerService: Customer deleted with ID: " + customerId);
    }
}