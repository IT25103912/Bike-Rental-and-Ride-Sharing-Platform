<%@ page import="com.bikerental.model.Person" %>
<%
    Person navUser = (Person) session.getAttribute("user");
%>
<nav>
    <div class="d-flex align-items-center gap-3">
        <div class="logo-bolt"><i class="bi bi-lightning-charge-fill"></i></div>
        <div>
            <div class="logo-name">QuickeRide</div>
            <div style="font-size: 11px; color: #555; font-weight: bold; letter-spacing: 2px; text-transform: uppercase; margin-top:-4px;">
                Welcome, <%= navUser != null ? navUser.getName() : "Guest" %>
            </div>
        </div>
    </div>

    <div class="d-none d-lg-flex gap-2">
        <%-- පොදු ලින්ක්ස් (හැමෝටම පේන ඒවා) --%>
        <a href="${pageContext.request.contextPath}/views/user/profile.jsp" class="np"><i class="bi bi-person"></i> Profile</a>
        <a href="${pageContext.request.contextPath}/views/booking/my-bookings.jsp" class="np"><i class="bi bi-bicycle"></i> My Rides</a>

        <%-- ඇඩ්මින් කොටස (Admin ට විතරයි පේන්නේ) --%>
        <% if(navUser != null && "Admin".equals(navUser.getRole())) { %>
            <a href="${pageContext.request.contextPath}/views/admin/admin-dashboard.jsp" class="np"><i class="bi bi-shield-lock"></i> Admin</a>

            <%-- 🆕 මෙන්න මේ ලින්ක් එක අලුතින් ඇඩ් කළා --%>
            <a href="${pageContext.request.contextPath}/views/admin/system-logs.jsp" class="np"><i class="bi bi-terminal"></i> Logs</a>

            <a href="${pageContext.request.contextPath}/views/review/admin-reviews.jsp" class="np"><i class="bi bi-chat-dots"></i> Moderate</a>
            <a href="${pageContext.request.contextPath}/views/payment/admin-fines.jsp" class="np"><i class="bi bi-exclamation-triangle"></i> Fines</a>
        <% } %>

        <%-- කස්ටමර් කොටස (Admin නොවන අයට විතරයි පේන්නේ) --%>
        <% if(navUser != null && !"Admin".equals(navUser.getRole())) { %>
            <a href="${pageContext.request.contextPath}/views/payment/customer-fines.jsp" class="np"><i class="bi bi-exclamation-triangle"></i> Fines</a>
            <a href="${pageContext.request.contextPath}/views/review/my-reviews.jsp" class="np"><i class="bi bi-star"></i> Reviews</a>
        <% } %>

        <%-- පොදු ලින්ක්ස් (Payments සහ Logout) --%>
        <a href="${pageContext.request.contextPath}/views/payment/payment-history.jsp" class="np"><i class="bi bi-wallet2"></i> Payments</a>
        <a href="${pageContext.request.contextPath}/logout" class="np ms-2"><i class="bi bi-box-arrow-right"></i> Logout</a>
    </div>
</nav>