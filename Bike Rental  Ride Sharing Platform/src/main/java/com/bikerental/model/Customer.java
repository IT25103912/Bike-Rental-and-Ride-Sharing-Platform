package com.bikerental.model;
import com.bikerental.interfaces.Authenticatable;

public class Customer extends Person implements Authenticatable {
    private String passwordHash; // Customer ge password eka

    public String getPasswordHash() { return passwordHash; }
    public void setPasswordHash(String passwordHash) { this.passwordHash = passwordHash; }

    // Person eken apu nithiya: Role eka mokakda?
    @Override
    public String getRole() {
        return "Customer";
    }

    // Authenticatable eken apu nithiya: Login wenne kohomada?
    @Override
    public boolean authenticate(String password) {
        return this.passwordHash.equals(password);
    }

    @Override
    public void setRole(String fRole) {
        // Customer ge role eka wenas karanna awashya nathi nisa meka scroll empty thiyanna puluwan
    }
}