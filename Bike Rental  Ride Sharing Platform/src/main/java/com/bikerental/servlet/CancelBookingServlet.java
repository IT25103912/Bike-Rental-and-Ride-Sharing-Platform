package com.bikerental.servlet;

import com.bikerental.dao.BikeDAO;
import com.bikerental.dao.BookingDAO;
import com.bikerental.model.StandardBooking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String bikeId = request.getParameter("bikeId");

        if (bookingId != null && bikeId != null) {
            // 1. Booking eke status eka 'Cancelled' karanawa
            BookingDAO bookingDao = new BookingDAO();
            bookingDao.updateBookingStatus(bookingId, "Cancelled");

            // 2. Bike eka ayeth Available (true) karanawa wena kenekta ganna
            BikeDAO bikeDao = new BikeDAO();
            bikeDao.updateBikeStatus(bikeId, "Available"); // දැන් හරි!

            // OOP Polymorphism Requirement eka wada karanawa kiyala pennanna Console ekata print karanawa
            StandardBooking sb = new StandardBooking();
            sb.cancel("Customer requested cancellation");
        }

        response.sendRedirect(request.getContextPath() + "/views/booking/my-bookings.jsp?cancelled=true");
    }
}