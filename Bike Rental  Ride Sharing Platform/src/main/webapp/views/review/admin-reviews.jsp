<%@ page import="com.bikerental.model.Person" %>
<%@ page import="com.bikerental.model.Review" %>
<%@ page import="com.bikerental.dao.ReviewDAO" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Person loggedInUser = (Person) session.getAttribute("user");
    if (loggedInUser == null || !"Admin".equals(loggedInUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp");
        return;
    }

    ReviewDAO reviewDao = new ReviewDAO();
    List<Review> allReviews = reviewDao.getAllReviews();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Moderate Reviews | QuickeRide</title>

    <jsp:include page="/views/common-css.jsp" />

    <style>
        /* 📝 Glass Table Styles */
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

        .btn-reply { background: #3498db; color: #fff; border: none; font-weight: 700; border-radius: 8px; transition: 0.3s; }
        .btn-reply:hover { background: #2980b9; transform: translateY(-2px); color: #fff; }

        /* ✅ Fix for Modal Backdrop - මේක තමයි ප්‍රශ්නය විසඳන්නේ */
        .modal {
            background: rgba(0, 0, 0, 0.5); /* Modal එක පිටුපස අඳුරු කරන ස්තරය */
        }
        .modal-glass {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid rgba(255, 106, 0, 0.2);
        }
        .glass-input { background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(0, 0, 0, 0.1); border-radius: 10px; padding: 10px; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/views/navbar.jsp" />

    <div class="container mt-5 flex-grow-1 pb-5">

        <div class="mb-5 text-center">
            <h2 class="fw-bold text-dark" style="font-family: 'Bebas Neue', sans-serif; font-size: 45px; letter-spacing: 2px;">💬 Review Moderation</h2>
            <p style="color: #555; font-size: 16px;">Manage customer feedback and respond to reviews.</p>
        </div>

        <%-- Alerts --%>
        <% if("deleted".equals(request.getParameter("success"))) { %>
            <div class="alert alert-dismissible fade show shadow-sm text-center mb-4" role="alert" style="background: rgba(239, 68, 68, 0.2); border: 1px solid rgba(239, 68, 68, 0.4); color: #991b1b; backdrop-filter: blur(10px); border-radius: 12px; font-weight: 700;">
                <i class="bi bi-trash3-fill me-2"></i> Review successfully removed!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>
        <% if("replied".equals(request.getParameter("success"))) { %>
            <div class="alert alert-dismissible fade show shadow-sm text-center mb-4" role="alert" style="background: rgba(59, 130, 246, 0.2); border: 1px solid rgba(59, 130, 246, 0.4); color: #1e40af; backdrop-filter: blur(10px); border-radius: 12px; font-weight: 700;">
                <i class="bi bi-reply-all-fill me-2"></i> Reply sent successfully!
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        <% } %>

        <div class="glass-card p-0 mb-5 overflow-hidden shadow-lg">
            <div class="table-responsive">
                <table class="table glass-table align-middle m-0">
                    <thead>
                        <tr>
                            <th class="p-4">Review ID</th>
                            <th class="p-4 text-center">Vehicle</th>
                            <th class="p-4">Rating & Comment</th>
                            <th class="p-4 text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% if(allReviews.isEmpty()) { %>
                            <tr><td colspan="4" class="text-center py-5">No reviews found.</td></tr>
                        <% } else {
                            for(Review r : allReviews) { %>
                        <tr>
                            <td class="p-4 fw-bold" style="color: #e65c00;"><%= r.getContentId() %></td>
                            <td class="p-4 text-center">
                                <span class="badge bg-white text-dark shadow-sm border mb-2">U-<%= r.getAuthorId() %></span><br>
                                <div class="fw-bold"><i class="bi bi-scooter text-danger me-1"></i><%= r.getBikeId() %></div>
                            </td>
                            <td class="p-4">
                                <div class="stars mb-1">
                                    <% for(int i=0; i<r.getRating(); i++) { %>★<% } %>
                                </div>
                                <div class="text-dark fw-semibold small mb-2">"<%= r.getComment() %>"</div>
                                <% if(r.getOwnerReply() != null && !r.getOwnerReply().equals("None")) { %>
                                    <div class="mt-2 p-2 bg-white bg-opacity-50 border rounded-3 small text-muted">
                                        <span class="text-primary fw-bold">Admin:</span> <%= r.getOwnerReply() %>
                                    </div>
                                <% } %>
                            </td>
                            <td class="p-4 text-end">
                                <button type="button" class="btn btn-sm btn-reply px-3 py-2 me-1 shadow-sm" data-bs-toggle="modal" data-bs-target="#replyModal<%= r.getContentId() %>">
                                    <i class="bi bi-reply-fill me-1"></i> Reply
                                </button>

                                <form action="${pageContext.request.contextPath}/moderateReview" method="post" class="d-inline">
                                    <input type="hidden" name="reviewId" value="<%= r.getContentId() %>">
                                    <input type="hidden" name="action" value="delete">
                                    <button type="submit" class="btn btn-sm btn-outline-danger px-3 py-2 fw-bold" onclick="return confirm('Delete this review?');">
                                        <i class="bi bi-trash3-fill"></i>
                                    </button>
                                </form>

                                <%-- ✅ Fixed Modal Code --%>
                                <div class="modal fade" id="replyModal<%= r.getContentId() %>"
                                     tabindex="-1" aria-hidden="true"
                                     data-bs-backdrop="false"> <%-- Backdrop එක false කළා --%>
                                  <div class="modal-dialog modal-dialog-centered">
                                    <div class="modal-content modal-glass border-0 shadow-lg">
                                      <div class="modal-header border-0 pb-0 text-start">
                                        <h5 class="modal-title fw-bold" style="font-family: 'Bebas Neue', sans-serif; font-size: 25px; letter-spacing: 1px;"><i class="bi bi-reply-all-fill me-2 text-primary"></i>Reply to Customer</h5>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                      </div>
                                      <form action="${pageContext.request.contextPath}/moderateReview" method="post">
                                          <div class="modal-body p-4 text-start">
                                              <input type="hidden" name="reviewId" value="<%= r.getContentId() %>">
                                              <input type="hidden" name="action" value="reply">
                                              <div class="mb-3">
                                                  <label class="form-label text-muted fw-bold small">CUSTOMER'S COMMENT:</label>
                                                  <div class="p-3 bg-white bg-opacity-50 rounded-3 text-dark small border italic">"<%= r.getComment() %>"</div>
                                              </div>
                                              <div class="mb-3">
                                                  <label class="form-label text-dark fw-bold small">YOUR RESPONSE:</label>
                                                  <textarea name="replyText" class="form-control glass-input" rows="3" required><%= (r.getOwnerReply() != null && !r.getOwnerReply().equals("None")) ? r.getOwnerReply() : "" %></textarea>
                                              </div>
                                          </div>
                                          <div class="modal-footer border-0 pt-0">
                                            <button type="button" class="btn btn-light fw-bold px-4" data-bs-dismiss="modal">Cancel</button>
                                            <button type="submit" class="btn-orange shadow-sm px-4">Send Reply</button>
                                          </div>
                                      </form>
                                    </div>
                                  </div>
                                </div>
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