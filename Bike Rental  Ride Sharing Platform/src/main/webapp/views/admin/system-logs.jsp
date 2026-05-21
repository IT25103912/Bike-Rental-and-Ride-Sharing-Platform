<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bikerental.dao.LogDAO, java.util.List, com.bikerental.model.Person" %>
<%
    // 1. Session check - ඇඩ්මින්ට විතරයි මේක බලන්න පුළුවන්
    Person user = (Person) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
        return;
    }

    // 2. DAO එක හරහා ලොග්ස් ටික ගන්නවා
    LogDAO logDao = new LogDAO();
    List<String> logs = logDao.getAllLogs();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>System Logs | QuickeRide Admin</title>
    <jsp:include page="/views/common-css.jsp" />

    <style>
        .log-entry {
            background: rgba(255, 255, 255, 0.3);
            border-left: 4px solid #ff6a00;
            margin-bottom: 10px;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 14px;
            transition: 0.2s;
        }
        .log-entry:hover {
            background: rgba(255, 255, 255, 0.6);
            transform: translateX(5px);
        }
        .log-time { color: #e65c00; font-weight: 800; font-family: 'Inter', sans-serif; }
        .log-user { color: #555; font-weight: 600; margin: 0 10px; }
        .log-action { color: #111; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/views/navbar.jsp" />

    <div class="container mt-5 flex-grow-1 pb-5">
        <div class="mb-5">
            <h2 class="fw-bold text-dark" style="font-family: 'Bebas Neue', sans-serif; font-size: 45px; letter-spacing: 2px;">
                <i class="bi bi-terminal me-2"></i> System Activity Logs
            </h2>
            <p style="color: #555; font-size: 16px;">Monitoring all user actions and system events recorded in <b>logs.txt</b>.</p>
        </div>

        <div class="glass-card p-4">
            <% if(logs.isEmpty()) { %>
                <div class="text-center py-5">
                    <h1 class="display-1 opacity-25">📄</h1>
                    <h4 class="text-muted" style="font-family: 'Bebas Neue', sans-serif;">No logs recorded yet.</h4>
                </div>
            <% } else {
                for(String log : logs) {
                    // LogDAO එකේ අපි සේව් කළේ "Timestamp | User | Action" විදිහට
                    String[] parts = log.split(" \\| ");
            %>
                <div class="log-entry shadow-sm d-flex align-items-center">
                    <span class="log-time"><i class="bi bi-clock me-1"></i> <%= (parts.length > 0) ? parts[0] : "" %></span>
                    <span class="log-user border-start border-end px-3">
                        <i class="bi bi-person-circle me-1"></i> <%= (parts.length > 1) ? parts[1] : "System" %>
                    </span>
                    <span class="log-action">
                        <i class="bi bi-caret-right-fill text-orange me-1"></i> <%= (parts.length > 2) ? parts[2] : log %>
                    </span>
                </div>
            <% } } %>
        </div>

        <div class="mt-4">
            <a href="<%= request.getContextPath() %>/views/admin/admin-dashboard.jsp" class="btn btn-orange text-decoration-none">
                <i class="bi bi-arrow-left me-2"></i> Back to Dashboard
            </a>
        </div>
    </div>

    <footer>
        &copy; 2026 QUICKERIDE RENTAL SYSTEM | ADMIN PANEL
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>