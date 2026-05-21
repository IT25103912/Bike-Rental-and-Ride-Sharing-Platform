<%@ page import="com.bikerental.model.Bike" %>
<%@ page import="com.bikerental.dao.BikeDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="com.bikerental.model.Person" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Admin කෙනෙක්ද කියලා Session එකෙන් චෙක් කරනවා
    Person user = (Person) session.getAttribute("user");
    if (user == null || !"Admin".equals(user.getRole())) {
        response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
        return;
    }

    // BikeDAO එකෙන් data ගන්නවා
    BikeDAO bikeDao = new BikeDAO();
    List<Bike> allBikes = bikeDao.getAllBikes();
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard | QuickeRide</title>
    <jsp:include page="/views/common-css.jsp" />

    <style>
        .btn-status-maint {
            background: linear-gradient(135deg, #e65c00, #c0392b);
            color: #fff; border: none; padding: 10px; border-radius: 8px;
            font-weight: 700; text-transform: uppercase; font-size: 12px;
            letter-spacing: 1px; cursor: pointer; width: 100%;
            transition: all 0.3s ease-in-out; /* ⏳ Smooth Animation එක */
        }
        .btn-status-maint:hover {
            transform: translateY(-4px); /* ⬆️ උඩට ඉස්සෙන Effect එක */
            box-shadow: 0 8px 20px rgba(230, 92, 0, 0.4);
            color: #fff;
        }

        .btn-status-ready {
            background: linear-gradient(135deg, #10b981, #059669);
            color: #fff; border: none; padding: 10px; border-radius: 8px;
            font-weight: 700; text-transform: uppercase; font-size: 12px;
            letter-spacing: 1px; cursor: pointer; width: 100%;
            transition: all 0.3s ease-in-out; /* ⏳ Smooth Animation එක */
        }
        .btn-status-ready:hover {
            transform: translateY(-4px); /* ⬆️ උඩට ඉස්සෙන Effect එක */
            box-shadow: 0 8px 20px rgba(16, 185, 129, 0.4);
            color: #fff;
        }
    </style>
</head>
<body>

    <jsp:include page="/views/navbar.jsp" />

    <div class="container mt-4 pb-5 text-start">

        <div class="d-flex justify-content-end mb-2">
            <a href="<%= request.getContextPath() %>/views/user/dashboard.jsp"
               style="display: inline-flex; align-items: center; gap: 8px; padding: 8px 20px; background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(255, 106, 0, 0.4); border-radius: 30px; font-weight: 800; color: #e65c00; text-transform: uppercase; font-size: 11px; letter-spacing: 1px; text-decoration: none; backdrop-filter: blur(10px); transition: all 0.3s ease-in-out; box-shadow: 0 4px 15px rgba(255, 106, 0, 0.1);"
               onmouseover="this.style.background='#ff6a00'; this.style.color='#fff'; this.style.transform='translateY(-2px)';"
               onmouseout="this.style.background='rgba(255, 255, 255, 0.6)'; this.style.color='#e65c00'; this.style.transform='translateY(0)';">
                <i class="bi bi-house-door-fill" style="font-size: 14px;"></i> User Dashboard
            </a>
        </div>

        <div class="mb-5 text-center">
            <h2 class="fw-bold text-dark" style="font-family: 'Bebas Neue', sans-serif; font-size: 45px; letter-spacing: 2px;">Welcome back, Admin! 👋</h2>
            <p style="color: #555; font-size: 16px;">Manage your fleet and track system activity.</p>
        </div>

        <div class="row g-4 mb-5">
            <div class="col-md-4">
                <div class="glass-card text-center h-100 p-4">
                    <h1 class="display-5 mb-3">🛠️</h1>
                    <h4 class="fw-bold mb-3" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px; color: #111;">Maintenance</h4>
                    <a href="<%= request.getContextPath() %>/views/admin/admin-maintenance.jsp" class="btn-orange w-100 d-block text-decoration-none">View Logs</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="glass-card text-center h-100 p-4" style="border-color: #ff6a00; box-shadow: 0 10px 30px rgba(255, 106, 0, 0.2);">
                    <h1 class="display-5 mb-3">🚲</h1>
                    <h4 class="fw-bold mb-3" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px; color: #111;">Inventory</h4>
                    <a href="<%= request.getContextPath() %>/views/bike/manage-bikes.jsp" class="btn-orange w-100 d-block text-decoration-none" style="background: #111;">Manage Bikes</a>
                </div>
            </div>
            <div class="col-md-4">
                <div class="glass-card text-center h-100 p-4">
                    <h1 class="display-5 mb-3">📊</h1>
                    <h4 class="fw-bold mb-3" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px; color: #111;">Reports</h4>
                    <a href="<%= request.getContextPath() %>/views/admin/admin-reports.jsp" class="btn-orange w-100 d-block text-decoration-none" style="background: #10b981;">View Reports</a>
                </div>
            </div>
        </div>

        <div class="sec-hdr mt-5">
            <h3 class="sec-title text-dark">Live Fleet Status</h3>
            <div class="sec-hr"></div>
        </div>

        <div class="row g-4 px-3">
            <%
                if(allBikes != null && !allBikes.isEmpty()) {
                    for(Bike bike : allBikes) {
            %>
            <div class="col-md-4">
                <div class="bcard h-100 position-relative p-3">

                    <%-- Status Badge Logic --%>
                    <%
                        String badgeClass = "bg-success";
                        if("Rented".equals(bike.getStatus())) badgeClass = "bg-danger";
                        if("Maintenance".equals(bike.getStatus())) badgeClass = "bg-warning text-dark";
                    %>
                    <div style="position:absolute; top:15px; right:15px; z-index:10; font-size: 11px; letter-spacing: 1px; font-weight: bold;" class="badge <%= badgeClass %> rounded-pill px-3 py-2 shadow-sm text-uppercase">
                        <%= bike.getStatus() %>
                    </div>

                    <div class="binfo pt-4 mt-2">
                        <div class="bname" style="color: #111;"><%= bike.getBrand() %> <%= bike.getModel() %></div>
                        <div class="bspecs">Vehicle ID: <em style="color: #e65c00; font-style: normal; font-weight: bold;"><%= bike.getBikeId() %></em></div>

                        <div class="d-flex justify-content-between align-items-center mt-2 mb-3">
                            <div class="bprice" style="color: #e65c00;">Rs.<%= bike.getPricePerDay() %> <small style="color: #666;">/day</small></div>
                        </div>

                        <%-- Update Status Buttons --%>
                        <div class="d-grid mt-3 border-top pt-4" style="border-color: rgba(0,0,0,0.08) !important;">
                            <% if(!"Maintenance".equals(bike.getStatus())) { %>
                                <form action="<%= request.getContextPath() %>/updateStatus" method="post">
                                    <input type="hidden" name="bikeId" value="<%= bike.getBikeId() %>">
                                    <input type="hidden" name="newStatus" value="Maintenance">
                                    <button type="submit" class="btn-status-maint shadow-sm">
                                        <i class="bi bi-wrench-adjustable me-1"></i> Set Maintenance
                                    </button>
                                </form>
                            <% } else { %>
                                <form action="<%= request.getContextPath() %>/updateStatus" method="post">
                                    <input type="hidden" name="bikeId" value="<%= bike.getBikeId() %>">
                                    <input type="hidden" name="newStatus" value="Available">
                                    <button type="submit" class="btn-status-ready shadow-sm">
                                        <i class="bi bi-check-circle-fill me-1"></i> Ready to Rent
                                    </button>
                                </form>
                            <% } %>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } else {
            %>
                <div class="col-12 text-center py-5">
                    <div class="glass-card d-inline-block p-5">
                        <h1 class="display-1 text-muted mb-3">📭</h1>
                        <h4 class="text-muted fw-bold" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 2px;">No bikes found in the inventory.</h4>
                        <a href="<%= request.getContextPath() %>/views/bike/add-bike.jsp" class="btn-orange mt-3 d-inline-block text-decoration-none">Add a Bike</a>
                    </div>
                </div>
            <% } %>
        </div>

    </div>

    <footer>
        &copy; 2026 QUICKERIDE RENTAL SYSTEM | SLIIT ACADEMIC PROJECT
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>