package com.example.control;

import com.example.model.Bill;
import com.example.model.Item;
import com.example.service.BillService;
import com.example.service.StaffService;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Field;
import static org.mockito.Mockito.*;

public class BillControlTest {
    
    @Mock
    private BillService billService;
    
    @Mock
    private StaffService staffService;
    
    @Mock
    private HttpServletRequest request;
    
    @Mock
    private HttpServletResponse response;
    
    @Mock
    private RequestDispatcher requestDispatcher;
    
    @Mock
    private HttpSession session;
    
    private BillControl billControl;

    @BeforeEach
    void setUp() throws Exception {
        MockitoAnnotations.initMocks(this);
        billControl = new BillControl();
        
        // Use reflection to inject the mocks
        setField(billControl, "billService", billService);
        setField(billControl, "staffService", staffService);
    }
    
    // Helper method using Reflection to set a private field
    private void setField(Object target, String fieldName, Object value) throws Exception {
        Field field = target.getClass().getDeclaredField(fieldName);
        field.setAccessible(true);
        field.set(target, value);
    }

    @Test
    void testDoPostAddBill() throws Exception {
        // Arrange
        when(request.getSession()).thenReturn(session);
        when(session.getAttribute("role")).thenReturn("staff");
        when(request.getParameter("customerId")).thenReturn("100");
        when(request.getParameterValues("quantities")).thenReturn(new String[]{"2"});
        when(request.getParameterValues("itemIds")).thenReturn(new String[]{"10"});
        
        Item mockItem = new Item();
        mockItem.setQuantity(5);
        mockItem.setPrice(100.0);
        when(staffService.getItemById(10)).thenReturn(mockItem);
        
        when(request.getRequestDispatcher("staffGenerateBill.jsp")).thenReturn(requestDispatcher);
        
        // Act
        billControl.doPost(request, response);

        // Assert
        verify(billService, times(1)).addBill(any(Bill.class));
        verify(staffService, times(1)).updateItem(any(Item.class));
        
        verify(request).getRequestDispatcher("staffGenerateBill.jsp");
        verify(requestDispatcher).forward(request, response);
    }
}