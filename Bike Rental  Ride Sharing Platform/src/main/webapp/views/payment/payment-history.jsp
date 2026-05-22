<%@ page import="com.bikerental.model.Person" %>
<%@ page import="com.bikerental.model.BaseBooking" %>
<%@ page import="com.bikerental.model.Payment" %>
<%@ page import="com.bikerental.dao.BookingDAO" %>
<%@ page import="com.bikerental.dao.PaymentDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Person loggedInUser = (Person) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
        return;
    }

    // 1. User ge bookings tika gannawa
    BookingDAO bookingDao = new BookingDAO();
    List<BaseBooking> myBookings = bookingDao.getBookingsByCustomer(loggedInUser.getId());

    // 2. Okkoma payments tika gannawa
    PaymentDAO paymentDao = new PaymentDAO();
    List<Payment> allPayments = paymentDao.getAllPayments();

    // 3. User ta adala payments witarak filter karanawa (Cross-module data linking)
    List<Payment> myPayments = new ArrayList<>();
    for(Payment p : allPayments) {
        for(BaseBooking b : myBookings) {
            if(p.getBookingId().equals(b.getBookingId())) {
                myPayments.add(p);
                break;
            }
        }
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment History - RideShare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; }
        .navbar { background: #1a1a2e; padding: 15px 0; }
        .navbar-brand { font-weight: 700; color: #fff !important; }
        .history-card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="bi bi-receipt text-warning me-2"></i>Payment History</a>
            <a href="${pageContext.request.contextPath}/views/user/dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3 py-2">
                <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
            </a>
        </div>
    </nav>

    <div class="container mt-5">
        <h3 class="fw-bold mb-4" style="color: #1a1a2e;">Your Transactions</h3>

        <div class="card history-card">
            <div class="card-body p-0">
                <table class="table table-hover mb-0 align-middle">
                    <thead class="table-light">
                        <tr>
                            <th class="py-3 px-4">Transaction ID</th>
                            <th class="py-3">Date & Time</th>
                            <th class="py-3">Method</th>
                            <th class="py-3">Amount</th>
                            <th class="py-3 text-end px-4">Status</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if(myPayments.isEmpty()) { %>
                            <tr><td colspan="5" class="text-center py-5 text-muted"><i class="bi bi-wallet2 fs-1 d-block mb-2"></i>No payments found.</td></tr>
                        <% } else {
                            for(Payment p : myPayments) { %>
                        <tr>
                            <td class="fw-bold px-4 text-primary"><%= p.getTransactionId() %></td>
                            <td class="text-muted"><%= p.getTimestamp() %></td>
                            <td><i class="bi bi-credit-card-2-front text-secondary me-2"></i><%= p.getMethod() %></td>
                            <td class="fw-bold text-success">Rs. <%= p.getAmount() %></td>
                            <td class="text-end px-4">
                                <span class="badge bg-success px-3 py-2 rounded-pill"><i class="bi bi-check-circle-fill me-1"></i><%= p.getStatus() %></span>
                            </td>
                            <td class="text-end px-4">
                                                            <span class="badge bg-success px-3 py-2 rounded-pill"><i class="bi bi-check-circle-fill me-1"></i><%= p.getStatus() %></span>

                                                            <a href="${pageContext.request.contextPath}/views/review/submit-review.jsp?bookingId=<%= p.getBookingId() %>"
                                                               class="btn btn-sm btn-warning fw-bold ms-2 shadow-sm text-dark">
                                                                <i class="bi bi-star-fill me-1"></i>Rate
                                                            </a>
                                                        </td>
                        </tr>
                        <%  }
                           } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>