package com.example.dao;

import com.example.model.Customer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CustomerDao {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/loginsystem?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "MYSQL@123";

    public List<Customer> findAllCustomers() throws SQLException {
        List<Customer> customerList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM customers")) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setFirstName(rs.getString("first_name"));
                    customer.setLastName(rs.getString("last_name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setAddress(rs.getString("address"));
                    customerList.add(customer);
                    System.out.println("CustomerDao: Found customer: " + customer.getFirstName() + " " + customer.getLastName());
                }
                System.out.println("CustomerDao: Retrieved " + customerList.size() + " customers");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("CustomerDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
        return customerList;
    }

    public void addCustomer(Customer customer) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO customers (first_name, last_name, email, phone, address) VALUES (?, ?, ?, ?, ?)")) {
                stmt.setString(1, customer.getFirstName());
                stmt.setString(2, customer.getLastName());
                stmt.setString(3, customer.getEmail());
                stmt.setString(4, customer.getPhone());
                stmt.setString(5, customer.getAddress());
                stmt.executeUpdate();
                System.out.println("CustomerDao: Added customer: " + customer.getFirstName() + " " + customer.getLastName());
            }
        } catch (ClassNotFoundException e) {
            System.out.println("CustomerDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
    }

    public void deleteCustomer(int customerId) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("DELETE FROM customers WHERE customer_id = ?")) {
                stmt.setInt(1, customerId);
                stmt.executeUpdate();
                System.out.println("CustomerDao: Deleted customer with ID: " + customerId);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("CustomerDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
    }
}