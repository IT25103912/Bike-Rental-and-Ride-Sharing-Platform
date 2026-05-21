package com.bikerental.servlet;

import com.bikerental.model.Person;
import com.bikerental.model.StandardBooking;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/processBooking")
public class ProcessBookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        HttpSession session = request.getSession();
        Person loggedInUser = (Person) session.getAttribute("user");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
            return;
        }

        // Form එකෙන් එන දේවල් අල්ලගන්නවා
        String bikeId = request.getParameter("bikeId");
        int days = Integer.parseInt(request.getParameter("days"));

        // Checkbox එකක් ටික් කරලා නැත්නම් එන්නේ null. ටික් කරලා නම් true වෙනවා.
        boolean extraHelmet = request.getParameter("extraHelmet") != null;
        boolean ridingGloves = request.getParameter("ridingGloves") != null;
        boolean phoneMount = request.getParameter("phoneMount") != null;

        // Object එක හදලා Data සෙට් කරනවා
        StandardBooking booking = new StandardBooking();
        booking.setCustomerId(loggedInUser.getId());
        booking.setBikeId(bikeId);
        booking.setNumberOfDays(days);

        // Add-ons සෙට් කරනවා
        booking.setHasExtraHelmet(extraHelmet);
        booking.setHasRidingGloves(ridingGloves);
        booking.setHasPhoneMount(phoneMount);

        // සල්ලි ගෙවලා ඉවර වෙනකන් මේක තාවකාලිකව Session එකේ තියාගන්නවා
        session.setAttribute("tempBooking", booking);

        // Checkout Page එකට යවනවා
        response.sendRedirect(request.getContextPath() + "/views/payment/checkout.jsp?bikeId=" + bikeId);
    }
}