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

    public Staff authenticateStaff(String username, String password) throws SQLException {
        return staffDao.findStaffByUsernameAndPassword(username, password);
    }

    public List<Staff> getAllStaff() throws SQLException {
        return staffDao.findAllStaff();
    }

    public Staff getStaffById(int staffId) throws SQLException {
        return staffDao.findStaffById(staffId);
    }

    public void addStaff(Staff staff) throws SQLException {
        if (staff.getPassword() == null || staff.getPassword().isEmpty()) {
            throw new SQLException("Password cannot be empty for new staff");
        }
        staffDao.addStaff(staff);
    }

    public void updateStaff(Staff staff) throws SQLException {
        if (staff.getPassword() == null || staff.getPassword().isEmpty()) {
            Staff existingStaff = staffDao.findStaffById(staff.getStaffId());
            if (existingStaff != null) {
                staff.setPassword(existingStaff.getPassword());
            }
        }
        staffDao.updateStaff(staff);
    }

    public void deleteStaff(int staffId) throws SQLException {
        staffDao.deleteStaff(staffId);
    }
}