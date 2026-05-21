<%@ page import="com.bikerental.model.Person" %>
<%@ page import="com.bikerental.model.BaseBooking" %>
<%@ page import="com.bikerental.dao.BookingDAO" %>
<%@ page import="com.bikerental.dao.BikeDAO" %>
<%@ page import="com.bikerental.model.Bike" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Person loggedInUser = (Person) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
        return;
    }

    BookingDAO dao = new BookingDAO();
    List<BaseBooking> myBookings = dao.getBookingsByCustomer(loggedInUser.getId());

    BikeDAO bikeDao = new BikeDAO();
    List<Bike> allBikes = bikeDao.getAllBikes();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Rides | QuickeRide</title>

    <jsp:include page="/views/common-css.jsp" />

    <style>
        .glass-table { --bs-table-bg: transparent; --bs-table-color: #333; }
        .glass-table th {
            border-bottom: 2px solid rgba(255, 106, 0, 0.4);
            font-weight: 800; text-transform: uppercase; font-size: 12px; letter-spacing: 1px; color: #555;
        }
        .glass-table td {
            border-bottom: 1px solid rgba(0, 0, 0, 0.05);
            background: rgba(255, 255, 255, 0.2);
            padding: 15px 10px;
        }
        .glass-table tbody tr:hover td { background: rgba(255, 255, 255, 0.6); }

        /* Rate Button Style */
        .btn-rate {
            background: linear-gradient(135deg, #ff6a00, #ee0979);
            color: #fff; border: none; font-weight: 700; border-radius: 8px; transition: 0.3s;
        }
        .btn-rate:hover { transform: translateY(-2px); box-shadow: 0 5px 15px rgba(255, 106, 0, 0.3); color: #fff; }

        .btn-cancel-ride {
            background: rgba(231, 76, 60, 0.1); color: #e74c3c; border: 1.5px solid #e74c3c;
            font-weight: 700; border-radius: 8px; transition: 0.3s;
        }
        .btn-cancel-ride:hover { background: #e74c3c; color: #fff; transform: translateY(-2px); }

        .badge-progress { background: rgba(52, 152, 219, 0.2); color: #2980b9; border: 1px solid #3498db; font-weight: 700; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/views/navbar.jsp" />

    <div class="container mt-5 flex-grow-1 pb-5">

        <div class="mb-5 text-center">
            <h2 class="fw-bold text-dark" style="font-family: 'Bebas Neue', sans-serif; font-size: 45px; letter-spacing: 2px;">🏁 Your Ride History</h2>
            <p style="color: #555; font-size: 16px;">Track your past adventures and manage your current bookings.</p>
        </div>

        <%-- Success Alerts --%>
        <% if("success".equals(request.getParameter("status"))) { %>
            <div class="alert alert-dismissible fade show shadow-sm text-center mb-4" role="alert" style="background: rgba(16, 185, 129, 0.2); border: 1px solid rgba(16, 185, 129, 0.4); color: #065f46; backdrop-filter: blur(10px); border-radius: 12px; font-weight: 700;">
                <i class="bi bi-check-circle-fill me-2"></i> Action Successful!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="glass-card p-0 mb-5 overflow-hidden">
            <div class="table-responsive">
                <table class="table glass-table align-middle m-0">
                    <thead>
                        <tr>
                            <th class="p-4">Booking Ref</th>
                            <th class="p-4">Vehicle Details</th>
                            <th class="p-4">Status</th>
                            <th class="p-4 text-end">Action</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if(myBookings.isEmpty()) { %>
                            <tr>
                                <td colspan="4" class="text-center py-5">
                                    <h1 class="display-3 text-muted mb-3 opacity-25">🚲</h1>
                                    <h5 class="text-muted fw-bold" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px;">No rides booked yet.</h5>
                                    <a href="<%= request.getContextPath() %>/views/user/dashboard.jsp" class="btn-orange text-decoration-none d-inline-block mt-2">Find a Ride</a>
                                </td>
                            </tr>
                        <% } else {
                            for(BaseBooking b : myBookings) {
                                String bikeDisplayName = b.getBikeId();
                                for(Bike bike : allBikes) {
                                    if(bike.getBikeId().equals(b.getBikeId())) {
                                        bikeDisplayName = bike.getBrand() + " " + bike.getModel();
                                        break;
                                    }
                                }
                        %>
                        <tr>
                            <td class="p-4 fw-bold" style="color: #e65c00;"><%= b.getBookingId() %></td>
                            <td class="p-4">
                                <div class="fw-bold text-dark" style="font-size: 1.1rem;"><i class="bi bi-scooter me-2" style="color: #ff6a00;"></i><%= bikeDisplayName %></div>
                                <small class="text-muted fw-bold">ID: <%= b.getBikeId() %></small>
                            </td>
                            <td class="p-4">
                                <% if("Active".equalsIgnoreCase(b.getStatus())) { %>
                                    <span class="badge rounded-pill px-3 py-2 shadow-sm" style="background: #10b981; font-size: 11px; letter-spacing: 1px;">ACTIVE</span>
                                <% } else if("Completed".equalsIgnoreCase(b.getStatus())) { %>
                                    <span class="badge rounded-pill px-3 py-2 shadow-sm bg-primary" style="font-size: 11px; letter-spacing: 1px;">COMPLETED</span>
                                <% } else { %>
                                    <span class="badge rounded-pill px-3 py-2 shadow-sm bg-secondary" style="font-size: 11px; letter-spacing: 1px;"><%= b.getStatus().toUpperCase() %></span>
                                <% } %>
                            </td>
                            <td class="p-4 text-end">
                                <% if("Completed".equalsIgnoreCase(b.getStatus())) { %>
                                    <%-- Ride එක ඉවර නම් විතරක් Rate කරන්න දෙනවා --%>
                                    <a href="${pageContext.request.contextPath}/views/review/submit-review.jsp?bookingId=<%= b.getBookingId() %>&bikeId=<%= b.getBikeId() %>"
                                       class="btn btn-sm btn-rate px-3 py-2 shadow-sm">
                                       <i class="bi bi-star-fill text-warning me-1"></i> Rate Ride
                                    </a>
                                <% } else if("Active".equalsIgnoreCase(b.getStatus())) { %>
                                    <%-- Ride එක යන ගමන් නම් 'In Progress' කියලා පෙන්නනවා --%>
                                    <span class="badge badge-progress px-3 py-2 me-2"><i class="bi bi-clock-history me-1"></i> Ride in Progress</span>

                                    <a href="${pageContext.request.contextPath}/cancelBooking?bookingId=<%= b.getBookingId() %>&bikeId=<%= b.getBikeId() %>"
                                       class="btn btn-sm btn-cancel-ride px-3 py-2 shadow-sm"
                                       onclick="return confirm('Are you sure you want to cancel this ride?');">
                                       <i class="bi bi-x-circle me-1"></i> Cancel
                                    </a>
                                <% } else { %>
                                    <span class="text-muted small fw-bold"><i class="bi bi-check-all me-1"></i> Settled</span>
                                <% } %>
                            </td>
                        </tr>
                        <%  }
                           } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <footer>
        &copy; 2026 QUICKERIDE RENTAL SYSTEM | SLIIT ACADEMIC PROJECT
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>