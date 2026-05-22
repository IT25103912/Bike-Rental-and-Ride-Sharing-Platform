package com.bikerental.model;
import com.bikerental.interfaces.Authenticatable;

public class Admin extends Person implements Authenticatable {
    private String passwordHash;
    private String adminPin; // Boss ta witharak thiyena rahas PIN eka

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    public String getAdminPin() { return adminPin; }
    public void setAdminPin(String adminPin) { this.adminPin = adminPin; }

    @Override
    public String getRole() {
        return "Admin";
    }

    @Override
    public boolean authenticate(String password) {
        return this.passwordHash.equals(password);
    }

    @Override
    public void setRole(String fRole) {
        // Admin ge role eka wenas karanna awashya nathi nisa meka empty thiyanna
    }
}
