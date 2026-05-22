package com.bikerental.servlet;

import com.bikerental.dao.PaymentDAO;
import com.bikerental.model.Payment;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.UUID;

@WebServlet("/processPayment")
public class PaymentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String bookingId = request.getParameter("bookingId");
        String method = request.getParameter("method"); // Cash hari Card hari
        double amount = Double.parseDouble(request.getParameter("amount"));
        String bikeId = request.getParameter("bikeId");

        Payment payment = new Payment();

        // Random Transaction Id
        String txnId = "TXN-" + UUID.randomUUID().toString().substring(0, 4).toUpperCase();

        // Time
        String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm"));

        payment.setTransactionId(txnId);
        payment.setBookingId(bookingId);
        payment.setAmount(amount);
        payment.setMethod(method);
        payment.setTimestamp(now);


        payment.process();


        PaymentDAO dao = new PaymentDAO();
        dao.recordPayment(payment);


        response.sendRedirect(request.getContextPath() + "/views/review/submit-review.jsp?bookingId=" + bookingId + "&bikeId=" + bikeId);
    }
}