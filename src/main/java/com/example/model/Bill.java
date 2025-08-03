package com.example.model;

import java.sql.Timestamp;

public class Bill {
    private int billId;
    private int customerId;
    private Timestamp billDate;
    private double totalAmount;
    private String customerName;
    private String customerEmail;

    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }
    public Timestamp getBillDate() { return billDate; }
    public void setBillDate(Timestamp billDate) { this.billDate = billDate; }
    public double getTotalAmount() { return totalAmount; }
    public void setTotalAmount(double totalAmount) { this.totalAmount = totalAmount; }
    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }
    public String getCustomerEmail() { return customerEmail; }
    public void setCustomerEmail(String customerEmail) { this.customerEmail = customerEmail; }
}