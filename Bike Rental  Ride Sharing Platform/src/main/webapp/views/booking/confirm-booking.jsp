<%@ page import="com.bikerental.model.Bike" %>
<%@ page import="com.bikerental.dao.BikeDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String bikeId = request.getParameter("id");
    BikeDAO bikeDao = new BikeDAO();
    Bike bike = bikeDao.getBikeById(bikeId);

    if (bike == null) {
        response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Confirm Booking | QuickeRide</title>

    <jsp:include page="/views/common-css.jsp" />

    <style>
        /* 📝 Custom Styles for Booking Page */
        .glass-input { background: rgba(255, 255, 255, 0.6); border: 1px solid rgba(0, 0, 0, 0.1); color: #111; padding: 12px 15px; border-radius: 10px; transition: 0.3s;}
        .glass-input:focus { background: rgba(255, 255, 255, 0.9); border-color: #ff6a00; box-shadow: 0 0 10px rgba(255,106,0,0.2); outline: none;}

        .addon-card {
            background: rgba(255, 255, 255, 0.3);
            border: 1px solid rgba(255, 255, 255, 0.5);
            border-radius: 12px;
            padding: 15px;
            margin-bottom: 10px;
            transition: 0.3s;
            cursor: pointer;
        }
        .addon-card:hover { background: rgba(255, 255, 255, 0.5); transform: translateX(5px); }

        .form-check-input:checked { background-color: #ff6a00; border-color: #ff6a00; }

        .bike-preview-box {
            background: rgba(255, 106, 0, 0.1);
            border-radius: 15px;
            padding: 20px;
            border: 1px solid rgba(255, 106, 0, 0.2);
            margin-bottom: 25px;
        }
    </style>
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/views/navbar.jsp" />

    <div class="container mt-5 pb-5 d-flex justify-content-center">
        <div class="glass-card w-100 p-0" style="max-width: 600px; overflow: hidden;">

            <div style="background: linear-gradient(135deg, #ff6a00, #ee0979); padding: 40px 20px; text-align: center;">
                <h2 class="fw-bold text-white m-0" style="font-family: 'Bebas Neue', sans-serif; font-size: 40px; letter-spacing: 2px;">Customize Your Ride</h2>
                <p class="text-white-50 m-0 small">Tailor your experience to your needs</p>
            </div>

            <div class="p-4 p-md-5">
                <form action="${pageContext.request.contextPath}/processBooking" method="post">
                    <input type="hidden" name="bikeId" value="<%= bike.getBikeId() %>">

                    <div class="bike-preview-box d-flex align-items-center">
                        <div style="width: 60px; height: 60px; background: white; border-radius: 12px; display: flex; align-items: center; justify-content: center; margin-right: 20px; box-shadow: 0 4px 10px rgba(0,0,0,0.05);">
                            <i class="bi bi-scooter text-danger" style="font-size: 1.8rem;"></i>
                        </div>
                        <div>
                            <h4 class="fw-bold mb-0 text-dark" style="font-family: 'Syne', sans-serif;"><%= bike.getBrand() %> <%= bike.getModel() %></h4>
                            <div class="fw-bold" style="color: #e65c00;">Rs. <%= bike.getPricePerDay() %> <small class="text-muted fw-normal">/ day</small></div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-bold small text-muted" style="letter-spacing: 1px;">HOW MANY DAYS?</label>
                        <input type="number" name="days" class="form-control glass-input" value="1" min="1" required>
                    </div>

                    <label class="form-label fw-bold small text-muted mb-3" style="letter-spacing: 1px;">ADD-ONS (CHOOSE YOUR EXTRAS)</label>

                    <div class="addon-card d-flex align-items-center">
                        <input class="form-check-input ms-0 me-3 mt-0" type="checkbox" id="extraHelmet" name="extraHelmet" value="true" style="transform: scale(1.3);">
                        <label class="form-check-label fw-bold text-dark w-100 mb-0" for="extraHelmet" style="cursor:pointer; font-size: 14px;">
                            <i class="bi bi-shield-check text-primary me-2"></i> Extra Helmet
                            <span class="float-end text-muted">+ Rs. 500</span>
                        </label>
                    </div>

                    <div class="addon-card d-flex align-items-center">
                        <input class="form-check-input ms-0 me-3 mt-0" type="checkbox" id="ridingGloves" name="ridingGloves" value="true" style="transform: scale(1.3);">
                        <label class="form-check-label fw-bold text-dark w-100 mb-0" for="ridingGloves" style="cursor:pointer; font-size: 14px;">
                            <i class="bi bi-person-fill text-success me-2"></i> Riding Gloves
                            <span class="float-end text-muted">+ Rs. 200</span>
                        </label>
                    </div>

                    <div class="addon-card d-flex align-items-center mb-4">
                        <input class="form-check-input ms-0 me-3 mt-0" type="checkbox" id="phoneMount" name="phoneMount" value="true" style="transform: scale(1.3);">
                        <label class="form-check-label fw-bold text-dark w-100 mb-0" for="phoneMount" style="cursor:pointer; font-size: 14px;">
                            <i class="bi bi-phone text-info me-2"></i> Phone Mount
                            <span class="float-end text-muted">+ Rs. 100</span>
                        </label>
                    </div>

                    <button type="submit" class="btn-orange w-100 shadow-sm mt-2" style="padding: 16px; font-size: 14px; letter-spacing: 2px;">
                        PROCEED TO CHECKOUT <i class="bi bi-arrow-right ms-2"></i>
                    </button>

                    <div class="text-center mt-4">
                        <a href="<%= request.getContextPath() %>/views/user/dashboard.jsp" class="text-muted text-decoration-none small fw-bold">
                            <i class="bi bi-arrow-left"></i> Cancel and Go Back
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <footer class="mt-auto">
        &copy; 2026 QUICKERIDE RENTAL SYSTEM | SLIIT ACADEMIC PROJECT
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>