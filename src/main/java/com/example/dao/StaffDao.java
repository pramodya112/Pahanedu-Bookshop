package com.example.dao;

import com.example.model.Staff;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StaffDao {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/loginsystem?useSSL=false";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "MYSQL@123";

    public List<Staff> findAllStaff() throws SQLException {
        List<Staff> staffList = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("SELECT * FROM staff")) {
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Staff staff = new Staff();
                    staff.setStaffId(rs.getInt("staff_id"));
                    staff.setUsername(rs.getString("username"));
                    staff.setPassword(rs.getString("password"));
                    staff.setFirstName(rs.getString("first_name"));
                    staff.setLastName(rs.getString("last_name"));
                    staff.setRole(rs.getString("role"));
                    staffList.add(staff);
                    System.out.println("StaffDao: Found staff: " + staff.getUsername());
                }
                System.out.println("StaffDao: Retrieved " + staffList.size() + " staff members");
            }
        } catch (ClassNotFoundException e) {
            System.out.println("StaffDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
        return staffList;
    }

    public void addStaff(Staff staff) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement(
                         "INSERT INTO staff (username, password, first_name, last_name, role) VALUES (?, ?, ?, ?, ?)")) {
                stmt.setString(1, staff.getUsername());
                stmt.setString(2, staff.getPassword());
                stmt.setString(3, staff.getFirstName());
                stmt.setString(4, staff.getLastName());
                stmt.setString(5, staff.getRole());
                stmt.executeUpdate();
                System.out.println("StaffDao: Added staff: " + staff.getUsername());
            }
        } catch (ClassNotFoundException e) {
            System.out.println("StaffDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
    }

    public void deleteStaff(int staffId) throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
                 PreparedStatement stmt = conn.prepareStatement("DELETE FROM staff WHERE staff_id = ?")) {
                stmt.setInt(1, staffId);
                stmt.executeUpdate();
                System.out.println("StaffDao: Deleted staff with ID: " + staffId);
            }
        } catch (ClassNotFoundException e) {
            System.out.println("StaffDao: JDBC Driver error: " + e.getMessage());
            throw new SQLException("JDBC Driver not found", e);
        }
    }
}