package com.bikerental.servlet;

import com.bikerental.dao.BikeDAO;
import com.bikerental.model.Bike;
import com.bikerental.model.Person;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/addBike")
public class AddBikeServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        // 1. User login wela kiyala sure karagannawa
        HttpSession session = request.getSession();
        Person loggedInUser = (Person) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        // 2. Form eken ena wisthara gannawa
        String brand = request.getParameter("brand");
        String model = request.getParameter("model");
        double price = Double.parseDouble(request.getParameter("price"));

        // 3. Auto Bike ID ekak hadanawa (e.g., B-9A2F1)
        String bikeId = "B-" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();

        // 4. Aluth Bike object ekak hadala details purawanawa
        Bike newBike = new Bike();
        newBike.setBikeId(bikeId);
        newBike.setBrand(brand);
        newBike.setModel(model);
        newBike.setPricePerDay(price);
        newBike.setAvailable(true); // Aluthen daana bike ekak aniwa available ne
        newBike.setOwnerId(loggedInUser.getId()); // Bike eka daana kenage ID eka save karanawa

        // 5. DAO eka haraha bikes.txt ekata liyanawa
        BikeDAO dao = new BikeDAO();
        dao.addBike(newBike);

        // 6. Save wunata passe ayeth Dashboard ekata yawanawa (success message ekakuth ekka)
        response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp?bikeAdded=true");
    }
}