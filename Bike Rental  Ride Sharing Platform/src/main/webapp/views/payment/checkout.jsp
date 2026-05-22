<%@ page import="com.bikerental.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Person loggedInUser = (Person) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
        return;
    }

    // Test karanna lesi wenna api Dummy Booking ID ekakai Amount ekakai form ekata gannawa
    String bookingId = request.getParameter("bookingId");
    if(bookingId == null) bookingId = "BKG-TEST01"; // URL eken awe nattam default ekak danawa
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout - RideShare</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; }
        .navbar { background: #1a1a2e; padding: 15px 0; }
        .navbar-brand { font-weight: 700; color: #fff !important; }
        .checkout-card { border: none; border-radius: 20px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); max-width: 500px; margin: 50px auto; background: #fff; overflow: hidden;}
        .checkout-header { background: #1a1a2e; color: white; padding: 30px 20px; text-align: center; }
        .form-control, .form-select { border-radius: 10px; padding: 12px; }
        .btn-pay { background: linear-gradient(135deg, #11998e 0%, #38ef7d 100%); color: white; border: none; border-radius: 12px; padding: 15px; font-weight: 700; width: 100%; font-size: 1.1rem; transition: 0.3s;}
        .btn-pay:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(56, 239, 125, 0.4); color: white;}
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="bi bi-wallet2 text-warning me-2"></i>Secure Checkout</a>
            <a href="${pageContext.request.contextPath}/views/user/dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3 py-2">
                <i class="bi bi-x-lg me-1"></i> Cancel
            </a>
        </div>
    </nav>

    <div class="container px-3">
        <div class="card checkout-card">
            <div class="checkout-header">
                <i class="bi bi-credit-card-fill" style="font-size: 3rem; color: #38ef7d;"></i>
                <h3 class="fw-bold mt-2">Payment Details</h3>
                <p class="text-white-50 mb-0">Complete your ride payment securely.</p>
            </div>
            <div class="card-body p-4">

                <form action="${pageContext.request.contextPath}/processPayment" method="post">
                    <input type="hidden" name="bikeId" value="<%= request.getParameter("bikeId") %>">
                    <div class="mb-3">
                        <label class="form-label text-muted fw-bold small">Booking Reference</label>
                        <input type="text" name="bookingId" class="form-control bg-light fw-bold text-secondary" value="<%= bookingId %>" readonly>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-muted fw-bold small">Total Amount (Rs.)</label>
                        <input type="number" name="amount" class="form-control fw-bold fs-5 text-dark" value="1500" readonly>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-muted fw-bold small">Select Payment Method</label>
                        <select name="method" class="form-select fw-bold" required>
                            <option value="" disabled selected>Choose a method...</option>
                            <option value="Credit/Debit Card">💳 Credit / Debit Card</option>
                            <option value="Cash on Delivery">💵 Cash (Pay at counter)</option>
                        </select>
                    </div>

                    <button type="submit" class="btn btn-pay">
                        <i class="bi bi-shield-lock-fill me-2"></i>Pay Now
                    </button>
                </form>

            </div>
        </div>
    </div>
</body>
</html>