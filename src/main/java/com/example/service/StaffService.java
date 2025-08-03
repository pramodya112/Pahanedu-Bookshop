package com.example.service;

import com.example.dao.StaffDao;
import com.example.model.Staff;
import java.sql.SQLException;
import java.util.List;

public class StaffService {
    private final StaffDao staffDao;

    public StaffService() {
        this.staffDao = new StaffDao();
    }

    public List<Staff> getAllStaff() throws SQLException {
        System.out.println("StaffService: Fetching all staff");
        List<Staff> staffList = staffDao.findAllStaff();
        System.out.println("StaffService: Retrieved " + staffList.size() + " staff members");
        return staffList;
    }

    public void addStaff(String username, String password, String firstName, String lastName, String role) throws SQLException {
        System.out.println("StaffService: Adding staff: " + username);
        Staff staff = new Staff();
        staff.setUsername(username);
        staff.setPassword(password);
        staff.setFirstName(firstName);
        staff.setLastName(lastName);
        staff.setRole(role);
        staffDao.addStaff(staff);
        System.out.println("StaffService: Staff added: " + username);
    }

    public void deleteStaff(int staffId) throws SQLException {
        System.out.println("StaffService: Deleting staff with ID: " + staffId);
        staffDao.deleteStaff(staffId);
        System.out.println("StaffService: Staff deleted with ID: " + staffId);
    }
}