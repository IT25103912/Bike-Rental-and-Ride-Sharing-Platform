<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bikerental.dao.*, com.bikerental.model.*, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maintenance | QuickeRide</title>

    <jsp:include page="/views/common-css.jsp" />

    <style>
        /* 📝 Glass Table සඳහා අලුත් Styles ටිකක් */
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
        .glass-table tbody tr { transition: all 0.2s; }
        .glass-table tbody tr:hover td { background: rgba(255, 255, 255, 0.6); }

        /* Input fields සඳහා Glass style එක */
        .glass-input { background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(0, 0, 0, 0.1); }
        .glass-input:focus { background: rgba(255, 255, 255, 0.9); border-color: #ff6a00; box-shadow: 0 0 10px rgba(255,106,0,0.2); }
    </style>
</head>
<body>

<jsp:include page="/views/navbar.jsp" />

<div class="container mt-5 pb-5">
    <div class="row">
        <div class="col-12">

            <div class="mb-5 text-center">
                <h2 class="fw-bold text-dark" style="font-family: 'Bebas Neue', sans-serif; font-size: 45px; letter-spacing: 2px;">🛠️ Maintenance Management</h2>
                <p style="color: #555; font-size: 16px;">Log and track bike repairs to keep your fleet in top condition.</p>
            </div>

            <%
                if ("true".equals(request.getParameter("success"))) {
            %>
                <div class="alert alert-dismissible fade show shadow-sm text-center mb-4" role="alert" style="background: rgba(16, 185, 129, 0.2); border: 1px solid rgba(16, 185, 129, 0.4); color: #065f46; backdrop-filter: blur(10px); border-radius: 12px; font-weight: 700;">
                    <i class="bi bi-check-circle-fill me-2"></i> Success! Maintenance record added and bike status updated to 'Unavailable'.
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            <%
                }
            %>

            <div class="glass-card mb-5">
                <h4 class="fw-bold mb-4" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px; color: #111;">Add New Repair Record</h4>

                <form action="../../addMaintenance" method="POST">
                    <div class="row">
                        <div class="col-md-3 mb-3">
                            <label class="form-label fw-bold small text-muted">BIKE ID</label>
                            <input type="text" name="bikeId" class="form-control glass-input" placeholder="E.g. B001" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label fw-bold small text-muted">REPAIR DESCRIPTION</label>
                            <input type="text" name="description" class="form-control glass-input" placeholder="E.g. Brake Service" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label fw-bold small text-muted">COST (LKR)</label>
                            <input type="number" name="cost" class="form-control glass-input" placeholder="0.00" required>
                        </div>
                        <div class="col-md-3 mb-3">
                            <label class="form-label fw-bold small text-muted">DATE</label>
                            <input type="date" name="date" class="form-control glass-input" required>
                        </div>
                    </div>
                    <div class="mt-3 text-end">
                        <button type="submit" class="btn-orange">
                            <i class="bi bi-tools me-2"></i> Record Maintenance
                        </button>
                    </div>
                </form>
            </div>

            <div class="glass-card mb-5">
                <h4 class="fw-bold mb-4" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px; color: #111;">Maintenance History Log</h4>

                <div class="table-responsive">
                    <table class="table glass-table align-middle m-0">
                        <thead>
                            <tr>
                                <th>M-ID</th>
                                <th>Bike ID</th>
                                <th>Description</th>
                                <th class="text-end">Cost (LKR)</th>
                                <th>Date</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                MaintenanceDAO mDao = new MaintenanceDAO();
                                List<Maintenance> records = mDao.getAllRecords();
                                if(records != null && !records.isEmpty()) {
                                    for(Maintenance m : records) {
                            %>
                            <tr>
                                <td><span class="badge" style="background: #111; letter-spacing: 1px;"><%= m.getMaintenanceId() %></span></td>
                                <td class="fw-bold" style="color: #e65c00;"><%= m.getBikeId() %></td>
                                <td><%= m.getDescription() %></td>
                                <td class="text-end fw-bold">Rs. <%= String.format("%.2f", m.getCost()) %></td>
                                <td class="text-muted"><%= m.getDate() %></td>
                            </tr>
                            <%      }
                                } else {
                            %>
                            <tr>
                                <td colspan="5" class="text-center py-5">
                                    <h1 class="display-4 text-muted mb-3">📂</h1>
                                    <h5 class="text-muted fw-bold" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 1px;">No maintenance records found.</h5>
                                </td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>
    </div>
</div>

<footer>
    &copy; 2026 QUICKERIDE RENTAL SYSTEM | SLIIT ACADEMIC PROJECT
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>