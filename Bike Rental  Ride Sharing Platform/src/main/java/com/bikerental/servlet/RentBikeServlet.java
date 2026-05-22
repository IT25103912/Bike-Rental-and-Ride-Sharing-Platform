package com.bikerental.servlet;

import com.bikerental.dao.BikeDAO;
import com.bikerental.dao.BookingDAO;
import com.bikerental.model.Person;
import com.bikerental.model.StandardBooking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.UUID;

@WebServlet("/rentBike")
public class RentBikeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Person loggedInUser = (Person) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        String bikeId = request.getParameter("id");

        if (bikeId != null) {
            // 1. Bike eke status eka false (Rented) karanawa
            BikeDAO bikeDao = new BikeDAO();
            bikeDao.updateBikeStatus(bikeId, false);

            // 2. Aluth Booking ekak hadala save karanawa
            StandardBooking booking = new StandardBooking();

            // Random Booking ID ekak auto hadanawa (e.g. BKG-A1B2C)
            String uniqueID = "BKG-" + UUID.randomUUID().toString().substring(0, 5).toUpperCase();

            booking.setBookingId(uniqueID);
            booking.setCustomerId(loggedInUser.getId());
            booking.setBikeId(bikeId);
            booking.setStatus("Active"); // Booking eka "Active" kiyala mark karanawa

            BookingDAO bookingDao = new BookingDAO();
            bookingDao.addBooking(booking); // bookings.txt pothata liyanawa
        }

        response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp?rented=true");
    }
}