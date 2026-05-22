<%@ page import="com.bikerental.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Person loggedInUser = (Person) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
        return;
    }

    // URL එකෙන් එන IDs ටික ගන්නවා
    String bookingId = request.getParameter("bookingId");
    String bikeId = request.getParameter("bikeId");

    // Test කරන්න ලේසි වෙන්න Dummy IDs (ID එක URL එකේ නැත්තම් විතරයි මේක වැඩ කරන්නේ)
    if(bookingId == null) bookingId = "BKG-TEST01";
    if(bikeId == null) bikeId = "B-TEST01";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Rate Your Ride | QuickeRide</title>

    <jsp:include page="/views/common-css.jsp" />

    <style>
        /* 📝 Input fields සඳහා Glass style එක */
        .glass-input { background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(0, 0, 0, 0.1); color: #111; padding: 12px 15px; border-radius: 10px; transition: 0.3s;}
        .glass-input:focus { background: rgba(255, 255, 255, 0.9); border-color: #ff6a00; box-shadow: 0 0 10px rgba(255,106,0,0.2); outline: none;}

        .input-group-text { background: transparent; border: none; padding-right: 0; }

        /* 🌟 Star Rating එකට පොඩි Glow එකක් */
        .star-icon { color: #f39c12; text-shadow: 0 0 10px rgba(243, 156, 18, 0.3); }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/views/navbar.jsp" />

    <div class="container mt-5 pb-5 d-flex justify-content-center align-items-center flex-grow-1">

        <div class="glass-card w-100 p-0 overflow-hidden shadow-lg" style="max-width: 550px;">

            <div style="background: linear-gradient(135deg, #f1c40f, #e67e22); padding: 40px 20px; text-align: center;">
                <i class="bi bi-star-fill text-white mb-2 shadow-sm d-inline-block" style="font-size: 3rem;"></i>
                <h2 class="fw-bold text-white m-0" style="font-family: 'Bebas Neue', sans-serif; font-size: 40px; letter-spacing: 2px;">Rate Your Ride</h2>
                <p class="text-white-50 m-0 small">Your feedback helps us improve the journey</p>
            </div>

            <div class="p-4 p-md-5">
                <form action="${pageContext.request.contextPath}/submitReview" method="post">

                    <div class="row mb-4 g-3">
                        <div class="col-6">
                            <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">BOOKING REF</label>
                            <div class="input-group">
                                <span class="input-group-text position-absolute" style="z-index: 10; padding-top: 13px;"><i class="bi bi-hash text-muted"></i></span>
                                <input type="text" name="bookingId" class="form-control glass-input fw-bold" style="padding-left: 35px; background: rgba(0,0,0,0.03);" value="<%= bookingId %>" readonly>
                            </div>
                        </div>
                        <div class="col-6">
                            <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">VEHICLE ID</label>
                            <div class="input-group">
                                <span class="input-group-text position-absolute" style="z-index: 10; padding-top: 13px;"><i class="bi bi-scooter text-muted"></i></span>
                                <input type="text" name="bikeId" class="form-control glass-input fw-bold" style="padding-left: 35px; background: rgba(0,0,0,0.03);" value="<%= bikeId %>" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="mb-4 text-start">
                        <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">OVERALL RATING</label>
                        <div class="input-group">
                            <span class="input-group-text position-absolute" style="z-index: 10; padding-top: 13px;"><i class="bi bi-stars star-icon"></i></span>
                            <select name="rating" class="form-select glass-input fw-bold" style="padding-left: 45px;" required>
                                <option value="" disabled selected>Select stars...</option>
                                <option value="5">⭐⭐⭐⭐⭐ (Excellent)</option>
                                <option value="4">⭐⭐⭐⭐ (Very Good)</option>
                                <option value="3">⭐⭐⭐ (Good)</option>
                                <option value="2">⭐⭐ (Poor)</option>
                                <option value="1">⭐ (Terrible)</option>
                            </select>
                        </div>
                    </div>

                    <div class="mb-5 text-start">
                        <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">YOUR COMMENTS</label>
                        <div class="input-group">
                            <span class="input-group-text position-absolute" style="z-index: 10; top: 13px;"><i class="bi bi-chat-left-text text-muted"></i></span>
                            <textarea name="comment" class="form-control glass-input" rows="4" style="padding-left: 45px;" placeholder="How was the bike? Any issues?" required></textarea>
                        </div>
                    </div>

                    <button type="submit" class="btn-orange w-100 shadow-sm" style="padding: 15px; font-size: 15px; letter-spacing: 2px;">
                        <i class="bi bi-send-fill me-2"></i>Submit Review
                    </button>

                    <div class="text-center mt-4">
                        <a href="${pageContext.request.contextPath}/views/user/dashboard.jsp" class="text-muted text-decoration-none small fw-bold">
                            <i class="bi bi-x-circle me-1"></i> Cancel and Go Back
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2026 QUICKERIDE RENTAL SYSTEM | SLIIT ACADEMIC PROJECT
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>