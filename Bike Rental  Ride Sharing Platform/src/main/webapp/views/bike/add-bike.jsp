<%@ page import="com.bikerental.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Login wela nattan kelinma login page ekata yawanawa
    Person loggedInUser = (Person) session.getAttribute("user");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/views/user/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>List Your Bike - RideShare Platform</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">

    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; }

        /* Navbar */
        .navbar { background: #1a1a2e; padding: 15px 0; }
        .navbar-brand { font-weight: 700; letter-spacing: 1px; color: #fff !important; font-size: 1.5rem; }

        /* Form Card Layout */
        .form-container { min-height: calc(100vh - 80px); display: flex; align-items: center; justify-content: center; padding: 40px 0; }
        .custom-card { border: none; border-radius: 20px; box-shadow: 0 15px 35px rgba(0,0,0,0.1); overflow: hidden; background: #fff; max-width: 550px; width: 100%; }
        .card-header-custom { background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%); color: white; padding: 35px 20px; text-align: center; }

        /* Inputs & Buttons */
        .btn-custom { background: linear-gradient(135deg, #FF416C 0%, #FF4B2B 100%); border: none; border-radius: 12px; font-weight: 600; padding: 14px; color: white; transition: transform 0.2s; }
        .btn-custom:hover { transform: translateY(-2px); color: white; opacity: 0.9; }
        .form-control { border-radius: 10px; padding: 12px 15px; border: 1px solid #e0e0e0; border-left: none; background-color: #f8f9fa;}
        .form-control:focus { box-shadow: none; border-color: #FF416C; background-color: #fff;}
        .input-group-text { background-color: #f8f9fa; border: 1px solid #e0e0e0; border-right: none; }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="${pageContext.request.contextPath}/views/user/dashboard.jsp">
                <i class="bi bi-lightning-charge-fill text-warning me-2"></i>RideShare Platform
            </a>
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/views/user/dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3 py-2">
                    <i class="bi bi-arrow-left me-2"></i>Back to Dashboard
                </a>
            </div>
        </div>
    </nav>

    <div class="container px-3 form-container">
        <div class="custom-card p-0">
            <div class="card-header-custom">
                <i class="bi bi-scooter text-warning mb-2" style="font-size: 3rem;"></i>
                <h3 class="fw-bold mb-0">List Your Vehicle</h3>
                <p class="text-light opacity-75 mb-0 small mt-1">Start earning money by sharing your ride</p>
            </div>
            <div class="card-body p-5">
                <form action="${pageContext.request.contextPath}/addBike" method="post">

                    <div class="mb-4">
                        <label class="form-label text-muted fw-semibold small">Vehicle Brand</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-tag text-muted"></i></span>
                            <input type="text" name="brand" class="form-control" placeholder="e.g. Yamaha, Honda" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-muted fw-semibold small">Vehicle Model</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="bi bi-info-circle text-muted"></i></span>
                            <input type="text" name="model" class="form-control" placeholder="e.g. FZ V3, Dio" required>
                        </div>
                    </div>

                    <div class="mb-5">
                        <label class="form-label text-muted fw-semibold small">Price Per Day (LKR)</label>
                        <div class="input-group">
                            <span class="input-group-text fw-bold text-muted">Rs.</span>
                            <input type="number" name="price" class="form-control" placeholder="1500" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-custom w-100 shadow-sm text-uppercase" style="letter-spacing: 1px;">
                        <i class="bi bi-plus-circle-fill me-2"></i>Publish Listing
                    </button>
                </form>
            </div>
        </div>
    </div>

</body>
</html>