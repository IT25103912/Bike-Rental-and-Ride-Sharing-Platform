<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bikerental.dao.*, com.bikerental.model.*, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Financial Reports | QuickeRide</title>

    <jsp:include page="/views/common-css.jsp" />
</head>
<body>

<jsp:include page="/views/navbar.jsp" />

<div class="container mt-5 pb-5">

    <div class="mb-5 text-center">
        <h2 class="fw-bold text-dark" style="font-family: 'Bebas Neue', sans-serif; font-size: 45px; letter-spacing: 2px;">📊 Financial Overview</h2>
        <p style="color: #555; font-size: 16px;">Track your system's revenue, expenses, and net profit.</p>
    </div>

    <%
        // 1. PaymentDAO හරහා සම්පූර්ණ ආදායම (Revenue) ගණනය කිරීම
        PaymentDAO pDao = new PaymentDAO();
        List<Payment> pList = pDao.getAllPayments();
        double totalRevenue = 0;

        if (pList != null) {
            for (Payment p : pList) {
                totalRevenue += p.getAmount(); // හැම Payment එකකම ගාණ එකතු කරනවා
            }
        }

        // 2. Member 1 ගේ දත්ත (නඩත්තු වියදම්) ලබා ගැනීම - මේක තමයි Integration එක!
        MaintenanceDAO mDao = new MaintenanceDAO();
        List<Maintenance> mList = mDao.getAllRecords();
        double totalMaintenanceCost = 0;
        if (mList != null) {
            for (Maintenance m : mList) {
                totalMaintenanceCost += m.getCost();
            }
        }

        // 3. ලාභය ගණනය කිරීම (Profit = Revenue - Expenses)
        double netProfit = totalRevenue - totalMaintenanceCost;
    %>

    <div class="row g-4 mb-5">
        <div class="col-md-4">
            <div class="glass-card text-center h-100 p-4" style="border-bottom: 4px solid #10b981;">
                <i class="bi bi-cash-coin mb-3 d-block" style="font-size: 3rem; color: #10b981;"></i>
                <h5 class="fw-bold mb-3" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px; color: #555;">Total Rental Revenue</h5>
                <h2 class="fw-bold" style="color: #10b981;">Rs. <%= String.format("%.2f", totalRevenue) %></h2>
                <p class="small text-muted mb-0">From customer payments</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="glass-card text-center h-100 p-4" style="border-bottom: 4px solid #ef4444;">
                <i class="bi bi-tools mb-3 d-block" style="font-size: 3rem; color: #ef4444;"></i>
                <h5 class="fw-bold mb-3" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px; color: #555;">Total Maintenance Cost</h5>
                <h2 class="fw-bold" style="color: #ef4444;">Rs. <%= String.format("%.2f", totalMaintenanceCost) %></h2>
                <p class="small text-muted mb-0">From bike repairs</p>
            </div>
        </div>

        <div class="col-md-4">
            <div class="glass-card text-center h-100 p-4" style="border-bottom: 4px solid #3b82f6;">
                <i class="bi bi-wallet2 mb-3 d-block" style="font-size: 3rem; color: #3b82f6;"></i>
                <h5 class="fw-bold mb-3" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px; color: #555;">Net Profit</h5>
                <h2 class="fw-bold" style="color: #3b82f6;">Rs. <%= String.format("%.2f", netProfit) %></h2>
                <p class="small text-muted mb-0">Revenue minus Expenses</p>
            </div>
        </div>
    </div>

    <div class="glass-card text-center p-5 mt-4" style="max-width: 700px; margin: 0 auto;">
        <i class="bi bi-file-earmark-text mb-3 d-block" style="font-size: 3.5rem; color: #e65c00;"></i>
        <h3 class="fw-bold mb-3" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 2px; color: #111;">Generate Formal Report File</h3>
        <p style="color: #555; font-size: 15px; margin-bottom: 30px;">Generate a text file with all financial details securely.</p>

        <form action="<%= request.getContextPath() %>/generateReport" method="POST">
            <input type="hidden" name="format" value="TXT">
            <button type="submit" class="btn-orange shadow-sm" style="padding: 12px 35px; font-size: 14px; letter-spacing: 1px; text-transform: uppercase;">
                <i class="bi bi-download me-2"></i> Download System Report
            </button>
        </form>
    </div>

</div>

<footer>
    &copy; 2026 QUICKERIDE RENTAL SYSTEM | SLIIT ACADEMIC PROJECT
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>