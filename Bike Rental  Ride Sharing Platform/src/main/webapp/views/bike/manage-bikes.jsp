<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bikerental.dao.*, com.bikerental.model.*, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Bikes | QuickeRide</title>

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

        /* Action Buttons Hover */
        .btn-edit { background: #f1c40f; color: #000; border: none; font-weight: 700; border-radius: 8px; transition: 0.3s; }
        .btn-edit:hover { background: #f39c12; transform: translateY(-2px); color: #000; }

        .btn-delete { background: #e74c3c; color: #fff; border: none; font-weight: 700; border-radius: 8px; transition: 0.3s; }
        .btn-delete:hover { background: #c0392b; transform: translateY(-2px); color: #fff; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

<jsp:include page="/views/navbar.jsp" />

<div class="container mt-5 flex-grow-1">

    <div class="d-flex justify-content-between align-items-center mb-5">
        <div>
            <h2 class="fw-bold text-dark m-0" style="font-family: 'Bebas Neue', sans-serif; font-size: 45px; letter-spacing: 2px;">🚲 Manage Inventory</h2>
            <p style="color: #555; font-size: 16px;">View, edit or remove vehicles from your rental fleet.</p>
        </div>
        <a href="add-bike.jsp" class="btn-orange text-decoration-none shadow-sm" style="padding: 12px 25px;">
            <i class="bi bi-plus-circle me-1"></i> Add New Bike
        </a>
    </div>

    <% if ("deleted".equals(request.getParameter("msg"))) { %>
        <div class="alert alert-dismissible fade show shadow-sm text-center mb-4" role="alert" style="background: rgba(239, 68, 68, 0.2); border: 1px solid rgba(239, 68, 68, 0.4); color: #991b1b; backdrop-filter: blur(10px); border-radius: 12px; font-weight: 700;">
            <i class="bi bi-trash3-fill me-2"></i> Bike removed successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>
    <% if ("updated".equals(request.getParameter("msg"))) { %>
        <div class="alert alert-dismissible fade show shadow-sm text-center mb-4" role="alert" style="background: rgba(16, 185, 129, 0.2); border: 1px solid rgba(16, 185, 129, 0.4); color: #065f46; backdrop-filter: blur(10px); border-radius: 12px; font-weight: 700;">
            <i class="bi bi-check-circle-fill me-2"></i> Bike details updated successfully!
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    <% } %>

    <div class="glass-card p-0 mb-5">
        <div class="table-responsive">
            <table class="table glass-table align-middle m-0 text-start">
                <thead>
                    <tr>
                        <th class="p-4">Bike ID</th>
                        <th class="p-4">Brand & Model</th>
                        <th class="p-4">Price/Day</th>
                        <th class="p-4 text-center">Status</th>
                        <th class="p-4 text-center">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        BikeDAO bDao = new BikeDAO();
                        List<Bike> bikes = bDao.getAllBikes();

                        if(bikes != null && !bikes.isEmpty()) {
                            for(Bike b : bikes) {
                    %>
                    <tr>
                        <td class="p-4 fw-bold" style="color: #e65c00;"><%= b.getBikeId() %></td>
                        <td class="p-4 fw-bold text-dark"><%= b.getBrand() %> <%= b.getModel() %></td>
                        <td class="p-4 fw-bold">Rs. <%= String.format("%.2f", b.getPricePerDay()) %></td>
                        <td class="p-4 text-center">
                            <% if(b.isAvailable()) { %>
                                <span class="badge rounded-pill px-3 py-2 shadow-sm" style="background: #10b981; font-size: 11px; letter-spacing: 1px;">AVAILABLE</span>
                            <% } else { %>
                                <span class="badge rounded-pill px-3 py-2 shadow-sm" style="background: #ef4444; font-size: 11px; letter-spacing: 1px;">UNAVAILABLE</span>
                            <% } %>
                        </td>
                        <td class="p-4 text-center">
                            <a href="update-bike.jsp?id=<%= b.getBikeId() %>" class="btn btn-sm btn-edit px-3 py-2 me-1 shadow-sm">
                                <i class="bi bi-pencil-square"></i>
                            </a>
                            <a href="<%= request.getContextPath() %>/deleteBike?id=<%= b.getBikeId() %>"
                               class="btn btn-sm btn-delete px-3 py-2 shadow-sm"
                               onclick="return confirm('Are you sure you want to delete this bike?');">
                               <i class="bi bi-trash3-fill"></i>
                            </a>
                        </td>
                    </tr>
                    <%      }
                        } else {
                    %>
                    <tr>
                        <td colspan="5" class="text-center py-5">
                            <h1 class="display-3 text-muted mb-3">🚲</h1>
                            <h5 class="text-muted fw-bold" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px;">No bikes found in the inventory.</h5>
                        </td>
                    </tr>
                    <% } %>
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