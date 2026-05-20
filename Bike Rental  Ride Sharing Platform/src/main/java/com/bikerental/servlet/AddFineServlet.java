package com.bikerental.servlet;

import com.bikerental.dao.PaymentDAO;
import com.bikerental.model.Fine;
import com.bikerental.util.FineCalculator;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@WebServlet("/addFine")
public class AddFineServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String bookingId = request.getParameter("bookingId");
        String reason = request.getParameter("reason");

        int lateDays = 0;
        String daysParam = request.getParameter("lateDays");
        if(daysParam != null && !daysParam.isEmpty()){
            lateDays = Integer.parseInt(daysParam);
        }

        double fineAmount = 0.0;

        // Encapsulation - FineCalculator
        if ("Damage".equals(reason)) {
            fineAmount = FineCalculator.calculateDamageFine();
        } else if ("Late Return".equals(reason)) {
            fineAmount = FineCalculator.calculateLateFine(lateDays);
        }

        // creat Fine object
        Fine fine = new Fine();
        fine.setTransactionId("FNE-" + UUID.randomUUID().toString().substring(0, 4).toUpperCase());
        fine.setAmount(fineAmount);
        fine.setTimestamp(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm")));
        fine.setBookingId(bookingId);
        fine.setReason(reason);
        fine.setStatus("Unpaid");


        PaymentDAO dao = new PaymentDAO();
        dao.recordFine(fine);

        response.sendRedirect(request.getContextPath() + "/views/payment/admin-fines.jsp?success=true");
    }
}