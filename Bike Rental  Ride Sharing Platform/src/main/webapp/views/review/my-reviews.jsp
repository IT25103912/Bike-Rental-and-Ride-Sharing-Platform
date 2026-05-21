<%@ page import="com.bikerental.model.Person" %>
<%@ page import="com.bikerental.model.Review" %>
<%@ page import="com.bikerental.dao.ReviewDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Person loggedInUser = (Person) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
        return;
    }

    // Database (Text file) eken me user ge reviews tika gannawa
    ReviewDAO reviewDao = new ReviewDAO();
    List<Review> myReviews = reviewDao.getReviewsByUser(loggedInUser.getId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Reviews | QuickeRide</title>

    <jsp:include page="/views/common-css.jsp" />

    <style>
        /* 📝 Glass Table සඳහා අලුත් Styles */
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

        .stars { color: #f39c12; font-size: 1.1rem; letter-spacing: 2px; }

        .reply-box {
            background: rgba(255, 255, 255, 0.5);
            border-left: 4px solid #10b981;
            padding: 10px 15px;
            border-radius: 0 10px 10px 0;
            display: inline-block;
            max-width: 250px;
            text-align: left;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/views/navbar.jsp" />

    <div class="container mt-5 flex-grow-1 pb-5">

        <div class="mb-5 text-center">
            <h2 class="fw-bold text-dark" style="font-family: 'Bebas Neue', sans-serif; font-size: 45px; letter-spacing: 2px;">⭐ Your Feedback History</h2>
            <p style="color: #555; font-size: 16px;">Review all the ratings and comments you've given to our fleet.</p>
        </div>

        <div class="glass-card p-0 mb-5 overflow-hidden shadow-lg">
            <div class="table-responsive">
                <table class="table glass-table align-middle m-0">
                    <thead>
                        <tr>
                            <th class="p-4">Review ID</th>
                            <th class="p-4">Vehicle ID</th>
                            <th class="p-4">Rating</th>
                            <th class="p-4">Your Comment</th>
                            <th class="p-4 text-end">Owner's Reply</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if(myReviews.isEmpty()) { %>
                            <tr>
                                <td colspan="5" class="text-center py-5">
                                    <h1 class="display-3 text-muted mb-3 opacity-25">💬</h1>
                                    <h5 class="text-muted fw-bold" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px;">You haven't submitted any reviews yet.</h5>
                                    <a href="<%= request.getContextPath() %>/views/booking/my-bookings.jsp" class="btn-orange text-decoration-none d-inline-block mt-2">Rate a Past Ride</a>
                                </td>
                            </tr>
                        <% } else {
                            for(Review r : myReviews) { %>
                        <tr>
                            <td class="p-4 fw-bold" style="color: #e65c00;"><%= r.getContentId() %></td>
                            <td class="p-4 fw-bold text-dark">
                                <i class="bi bi-scooter text-danger me-2"></i><%= r.getBikeId() %>
                            </td>
                            <td class="p-4">
                                <div class="stars">
                                    <% for(int i=0; i<r.getRating(); i++) { %>★<% } %>
                                    <% for(int i=r.getRating(); i<5; i++) { %><span class="text-muted" style="opacity:0.2;">★</span><% } %>
                                </div>
                            </td>
                            <td class="p-4">
                                <div class="text-dark fw-semibold small italic">"<%= r.getComment() %>"</div>
                            </td>
                            <td class="p-4 text-end">
                                <%
                                    String reply = r.getOwnerReply();
                                    if(reply == null || reply.trim().isEmpty() || reply.equalsIgnoreCase("None") || reply.equalsIgnoreCase("null")) {
                                %>
                                    <span class="badge rounded-pill px-3 py-2 border text-muted" style="background: rgba(0,0,0,0.03); font-size: 10px; letter-spacing: 1px;">PENDING REPLY</span>
                                <% } else { %>
                                    <div class="reply-box shadow-sm">
                                        <div class="fw-bold text-success small mb-1" style="font-size: 10px;"><i class="bi bi-reply-fill me-1"></i>ADMIN REPLIED:</div>
                                        <div class="text-dark small fw-semibold">"<%= reply %>"</div>
                                    </div>
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