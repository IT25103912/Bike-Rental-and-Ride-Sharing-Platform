<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.bikerental.dao.*, com.bikerental.model.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Bike | QuickeRide</title>

    <jsp:include page="/views/common-css.jsp" />

    <style>
        /* 📝 Input fields සඳහා Glass style එක */
        .glass-input { background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(0, 0, 0, 0.1); color: #111; padding: 12px 15px; border-radius: 10px; transition: 0.3s;}
        .glass-input:focus { background: rgba(255, 255, 255, 0.9); border-color: #ff6a00; box-shadow: 0 0 10px rgba(255,106,0,0.2); outline: none;}

        .input-group-text { background: transparent; border: none; padding-right: 0; }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/views/navbar.jsp" />

    <div class="container mt-5 pb-5 d-flex justify-content-center align-items-center" style="min-height: 75vh;">
        <%
            String bikeId = request.getParameter("id");
            BikeDAO dao = new BikeDAO();
            Bike bike = dao.getBikeById(bikeId);

            if(bike != null) {
        %>
        <div class="glass-card w-100 p-5" style="max-width: 550px;">

            <div class="text-center mb-4">
                <div style="width: 70px; height: 70px; background: linear-gradient(135deg, #f1c40f, #f39c12); border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 15px; box-shadow: 0 5px 15px rgba(243, 156, 18, 0.3);">
                    <i class="bi bi-pencil-square text-white" style="font-size: 2rem;"></i>
                </div>
                <h2 class="fw-bold text-dark m-0" style="font-family: 'Bebas Neue', sans-serif; font-size: 38px; letter-spacing: 2px;">Update Vehicle</h2>
                <p style="color: #666; font-size: 14px; margin-top: 5px;">Modify details for ID: <span class="fw-bold text-dark"><%= bike.getBikeId() %></span></p>
            </div>

            <form action="<%= request.getContextPath() %>/updateBike" method="POST">
                <input type="hidden" name="bikeId" value="<%= bike.getBikeId() %>">

                <div class="mb-4">
                    <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">VEHICLE BRAND</label>
                    <div class="input-group">
                        <span class="input-group-text position-absolute" style="z-index: 10; padding-top: 13px;"><i class="bi bi-tag" style="color: #ff6a00;"></i></span>
                        <input type="text" name="brand" class="form-control glass-input" style="padding-left: 45px;" value="<%= bike.getBrand() %>" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">VEHICLE MODEL</label>
                    <div class="input-group">
                        <span class="input-group-text position-absolute" style="z-index: 10; padding-top: 13px;"><i class="bi bi-info-circle" style="color: #ff6a00;"></i></span>
                        <input type="text" name="model" class="form-control glass-input" style="padding-left: 45px;" value="<%= bike.getModel() %>" required>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">PRICE PER DAY (LKR)</label>
                    <div class="input-group">
                        <span class="input-group-text position-absolute fw-bold" style="z-index: 10; padding-top: 13px; color: #ff6a00; padding-left: 10px;">Rs.</span>
                        <input type="number" name="price" class="form-control glass-input" style="padding-left: 50px;" value="<%= bike.getPricePerDay() %>" required>
                    </div>
                </div>

                <div class="mb-5">
                    <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">AVAILABILITY STATUS</label>
                    <div class="input-group">
                        <span class="input-group-text position-absolute" style="z-index: 10; padding-top: 13px;"><i class="bi bi-shield-check" style="color: #ff6a00;"></i></span>
                        <select name="status" class="form-select glass-input" style="padding-left: 45px;">
                            <option value="true" <%= bike.isAvailable() ? "selected" : "" %>>✅ Available</option>
                            <option value="false" <%= !bike.isAvailable() ? "selected" : "" %>>🔒 Unavailable (Rented/Maintenance)</option>
                        </select>
                    </div>
                </div>

                <button type="submit" class="btn-orange w-100 shadow-sm mb-3" style="font-size: 15px; padding: 14px; letter-spacing: 2px;">
                    <i class="bi bi-save2-fill me-2"></i>Save Changes
                </button>

                <div class="text-center">
                    <a href="manage-bikes.jsp" class="text-muted text-decoration-none small fw-bold">
                        <i class="bi bi-x-circle me-1"></i> Cancel and Go Back
                    </a>
                </div>
            </form>
        </div>
        <% } else { %>
            <div class="glass-card p-5 text-center" style="max-width: 500px;">
                <i class="bi bi-exclamation-triangle-fill text-danger display-1 mb-3"></i>
                <h3 class="fw-bold text-dark" style="font-family: 'Bebas Neue', sans-serif; letter-spacing: 2px;">Bike Not Found!</h3>
                <p class="text-muted mb-4">The bike ID you are trying to update does not exist.</p>
                <a href="manage-bikes.jsp" class="btn-orange text-decoration-none d-inline-block">Return to Inventory</a>
            </div>
        <% } %>
    </div>

    <footer class="mt-auto">
        &copy; 2026 QUICKERIDE RENTAL SYSTEM | SLIIT ACADEMIC PROJECT
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>