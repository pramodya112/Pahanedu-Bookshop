package com.example.model;

import java.sql.Timestamp;

public class Log {
    private int logId;
    private String action;
    private String username;
    private Timestamp logTime;

    public int getLogId() { return logId; }
    public void setLogId(int logId) { this.logId = logId; }
    public String getAction() { return action; }
    public void setAction(String action) { this.action = action; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public Timestamp getLogTime() { return logTime; }
    public void setLogTime(Timestamp logTime) { this.logTime = logTime; }
}