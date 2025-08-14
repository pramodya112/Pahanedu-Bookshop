package com.example.dao;

import com.example.model.Staff;
import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import static org.junit.jupiter.api.Assertions.*;

public class StaffDaoTest {
    private Connection connection;
    private StaffDao staffDao;

    @BeforeEach
    void setUp() throws SQLException {
        String url = "jdbc:mysql://localhost:3306/loginsystem";
        String username = "root";
        String password = "MYSQL@123";

        connection = DriverManager.getConnection(url, username, password);

        try (Statement stmt = connection.createStatement()) {
            stmt.execute("DROP TABLE IF EXISTS staff");
            stmt.execute("CREATE TABLE staff (staff_id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(50), password VARCHAR(50), first_name VARCHAR(50), last_name VARCHAR(50), role VARCHAR(20))");
        }
        staffDao = new StaffDao(connection);
    }

    @Test
    void testAddStaff() throws SQLException {
        Staff staff = new Staff();
        staff.setUsername("testuser");
        staff.setPassword("testpass");
        staff.setFirstName("Test");
        staff.setLastName("User");
        staff.setRole("staff");
        staffDao.addStaff(staff);

        Staff foundStaff = staffDao.authenticateStaff("testuser", "testpass");
        assertNotNull(foundStaff);
        assertEquals("testuser", foundStaff.getUsername());
    }

    @Test
    void testGetStaffById() throws SQLException {
        Staff staff = new Staff();
        staff.setUsername("admin");
        staff.setPassword("adminpass");
        staff.setFirstName("Admin");
        staff.setLastName("User");
        staff.setRole("admin");
        staffDao.addStaff(staff);
        int staffId = staffDao.authenticateStaff("admin", "adminpass").getStaffId();

        Staff foundStaff = staffDao.getStaffById(staffId);
        assertNotNull(foundStaff);
        assertEquals("admin", foundStaff.getUsername());
    }

    @Test
    void testGetAllStaff() throws SQLException {
        Staff staff1 = new Staff();
        staff1.setUsername("user1");
        staff1.setPassword("pass1");
        staff1.setFirstName("First");
        staff1.setLastName("User");
        staff1.setRole("staff");
        staffDao.addStaff(staff1);

        Staff staff2 = new Staff();
        staff2.setUsername("user2");
        staff2.setPassword("pass2");
        staff2.setFirstName("Second");
        staff2.setLastName("User");
        staff2.setRole("admin");
        staffDao.addStaff(staff2);

        List<Staff> staffList = staffDao.getAllStaff();
        assertEquals(2, staffList.size());
    }

    @Test
    void testUpdateStaff() throws SQLException {
        Staff staff = new Staff();
        staff.setUsername("olduser");
        staff.setPassword("oldpass");
        staff.setFirstName("Old");
        staff.setLastName("User");
        staff.setRole("staff");
        staffDao.addStaff(staff);
        int staffId = staffDao.authenticateStaff("olduser", "oldpass").getStaffId();

        Staff updatedStaff = new Staff();
        updatedStaff.setStaffId(staffId);
        updatedStaff.setUsername("newuser");
        updatedStaff.setPassword("newpass");
        updatedStaff.setFirstName("New");
        updatedStaff.setLastName("User");
        updatedStaff.setRole("admin");
        staffDao.updateStaff(updatedStaff);

        Staff foundStaff = staffDao.getStaffById(staffId);
        assertEquals("newuser", foundStaff.getUsername());
        assertEquals("admin", foundStaff.getRole());
    }

    @Test
    void testDeleteStaff() throws SQLException {
        Staff staff = new Staff();
        staff.setUsername("todelete");
        staff.setPassword("pass");
        staff.setFirstName("To");
        staff.setLastName("Delete");
        staff.setRole("staff");
        staffDao.addStaff(staff);
        int staffId = staffDao.authenticateStaff("todelete", "pass").getStaffId();

        staffDao.deleteStaff(staffId);
        Staff deletedStaff = staffDao.getStaffById(staffId);
        assertNull(deletedStaff);
    }

    @AfterEach
    void tearDown() throws SQLException {
        if (connection != null && !connection.isClosed()) {
            connection.close();
        }
    }
}