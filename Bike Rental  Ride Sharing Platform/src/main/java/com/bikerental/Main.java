package com.bikerental;

import com.bikerental.dao.UserDAO;
import com.bikerental.model.Customer;
import com.bikerental.model.Person;

public class Main {
    public static void main(String[] args) {
        UserDAO dao = new UserDAO();

        // 1. Aluth Customer kenekwa (Nimal) hadamu
        Customer c1 = new Customer();
        c1.setId("U001");
        c1.setName("Nimal");
        c1.setEmail("nimal@gmail.com");

        System.out.println("--- Aluth User Kenek Save Karanawa ---");
        // Password eka "1234" kiyala deela pothata liyamu
        dao.registerUser(c1, "1234");

        System.out.println("\n--- Login Wela Balamu ---");
        // 2. Hari email ekai password ekai deela login wenawada balamu
        Person loggedInUser = dao.loginUser("nimal@gmail.com", "1234");

        if (loggedInUser != null) {
            System.out.println("Login eka hari! Welcome " + loggedInUser.getName());
            System.out.println("Me aputh kenage Role eka: " + loggedInUser.getRole());
        } else {
            System.out.println("Login Failed! Email eka hari password eka hari waradi.");
        }
    }
}