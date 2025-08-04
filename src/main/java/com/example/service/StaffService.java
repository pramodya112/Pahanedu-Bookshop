package com.example.service;

import com.example.dao.StaffDao;
import com.example.model.Staff;
import java.sql.SQLException;
import java.util.List;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

public class StaffService {
    private final StaffDao staffDao;

    public StaffService() {
        this.staffDao = new StaffDao();
    }

    public List<Staff> getAllStaff() throws SQLException {
        return staffDao.findAllStaff();
    }

    public Staff getStaffById(int staffId) throws SQLException {
        return staffDao.findStaffById(staffId);
    }

    public void addStaff(Staff staff) throws SQLException {
        staff.setPassword(hashPassword(staff.getPassword()));
        staffDao.addStaff(staff);
    }

    public void updateStaff(Staff staff) throws SQLException {
        if (staff.getPassword() != null && !staff.getPassword().isEmpty()) {
            staff.setPassword(hashPassword(staff.getPassword()));
        }
        staffDao.updateStaff(staff);
    }

    public void deleteStaff(int staffId) throws SQLException {
        staffDao.deleteStaff(staffId);
    }

    public Staff authenticateStaff(String username, String password) throws SQLException {
        Staff staff = staffDao.findStaffByUsername(username);
        if (staff != null && verifyPassword(password, staff.getPassword())) {
            return staff;
        }
        return null;
    }

    private String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hashedBytes = md.digest(password.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : hashedBytes) {
                sb.append(String.format("%02x", b));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("Hashing algorithm not found", e);
        }
    }

    private boolean verifyPassword(String inputPassword, String storedPassword) {
        String hashedInput = hashPassword(inputPassword);
        return hashedInput.equals(storedPassword);
    }
}