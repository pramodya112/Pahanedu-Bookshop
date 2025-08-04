package com.example.model;

public class BillItem {
    private int billItemId;
    private int billId;
    private int itemId;
    private int quantity;
    private double unitPrice;
    private String itemName;
    public String getItemName() { return itemName; }
  
    
    
    public void setItemName(String itemName) { this.itemName = itemName; }
    public int getBillItemId() { return billItemId; }
    public void setBillItemId(int billItemId) { this.billItemId = billItemId; }
    public int getBillId() { return billId; }
    public void setBillId(int billId) { this.billId = billId; }
    public int getItemId() { return itemId; }
    public void setItemId(int itemId) { this.itemId = itemId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getUnitPrice() { return unitPrice; }
    public void setUnitPrice(double unitPrice) { this.unitPrice = unitPrice; }
}