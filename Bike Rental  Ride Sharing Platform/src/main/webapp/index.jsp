<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.bikerental.model.Person" %>
<%
    // දැනටමත් ලොග් වෙලා ඉන්නවා නම් කෙලින්ම Dashboard එකට යවනවා
    Person user = (Person) session.getAttribute("user");
    if (user != null) {
        response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickeRide | Your Adventure Starts Here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <style>
        :root { --primary-color: #ff416c; --secondary-color: #ff4b2b; --dark-blue: #1a1a2e; }
        body { font-family: 'Segoe UI', sans-serif; overflow-x: hidden; }

        .navbar { background: white; padding: 15px 0; transition: 0.3s; }
        .navbar-brand { font-weight: 800; font-size: 1.5rem; color: var(--dark-blue); }

        .hero-section {
            background: linear-gradient(135deg, rgba(26, 26, 46, 0.9), rgba(26, 26, 46, 0.7)),
                        url('https://images.unsplash.com/photo-1485965120184-e220f721d03e?ixlib=rb-4.0.3&auto=format&fit=crop&w=1920&q=80');
            background-size: cover; background-position: center;
            height: 90vh; display: flex; align-items: center; color: white;
        }

        .hero-title { font-size: 4rem; font-weight: 900; line-height: 1.1; margin-bottom: 25px; }
        .highlight { color: var(--primary-color); }

        .btn-main {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none; color: white; padding: 15px 40px; border-radius: 50px;
            font-weight: 700; text-transform: uppercase; letter-spacing: 1px;
            transition: 0.3s; box-shadow: 0 10px 20px rgba(255, 65, 108, 0.3);
        }
        .btn-main:hover { transform: translateY(-3px); box-shadow: 0 15px 30px rgba(255, 65, 108, 0.5); color: white; }

        .feature-card {
            border: none; border-radius: 20px; padding: 30px; transition: 0.3s;
            background: #f8f9fa; text-align: center; height: 100%;
        }
        .feature-card:hover { background: white; transform: translateY(-10px); box-shadow: 0 20px 40px rgba(0,0,0,0.05); }
        .icon-box {
            width: 70px; height: 70px; background: rgba(255, 65, 108, 0.1);
            color: var(--primary-color); border-radius: 50%; display: flex;
            align-items: center; justify-content: center; margin: 0 auto 20px; font-size: 1.8rem;
        }
    </style>
</head>
<body>

    <nav class="navbar navbar-expand-lg sticky-top shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="#">
                <i class="bi bi-lightning-charge-fill text-warning"></i> QuickeRide
            </a>
            <div class="ms-auto">
                <a href="<%= request.getContextPath() %>/views/user/login.jsp" class="btn btn-outline-dark px-4 rounded-pill fw-bold me-2">Login</a>
                <a href="<%= request.getContextPath() %>/views/user/register.jsp" class="btn btn-dark px-4 rounded-pill fw-bold">Sign Up</a>
            </div>
        </div>
    </nav>

    <section class="hero-section">
        <div class="container text-center text-md-start">
            <div class="row">
                <div class="col-lg-7">
                    <h1 class="hero-title">Rent the <span class="highlight">Freedom</span> to Explore.</h1>
                    <p class="lead mb-5 opacity-75">Join Sri Lanka's leading bike rental and ride-sharing community. Best prices, top-quality bikes, and 24/7 support.</p>
                    <div class="d-flex flex-column flex-md-row gap-3">
                        <a href="<%= request.getContextPath() %>/views/user/login.jsp" class="btn btn-main">Start Your Ride</a>
                        <a href="#features" class="btn btn-outline-light px-4 py-3 rounded-pill fw-bold">Learn More</a>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section id="features" class="py-5">
        <div class="container py-5">
            <div class="text-center mb-5">
                <h2 class="fw-bold">Why Choose QuickeRide?</h2>
                <p class="text-muted">We provide the best service for our riders and bike owners.</p>
            </div>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="icon-box"><i class="bi bi-shield-check"></i></div>
                        <h4 class="fw-bold">Safe & Verified</h4>
                        <p class="text-muted">Every bike and user is verified through our SLIIT-standard security protocol.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="icon-box"><i class="bi bi-wallet2"></i></div>
                        <h4 class="fw-bold">Affordable Rates</h4>
                        <p class="text-muted">Transparent pricing with no hidden fees. Pay only for what you use.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="icon-box"><i class="bi bi-clock-history"></i></div>
                        <h4 class="fw-bold">Easy Listing</h4>
                        <p class="text-muted">Have a bike? List it in minutes and start earning extra income today.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer class="bg-dark text-white py-5 text-center">
        <div class="container">
            <h4 class="fw-bold mb-4">QuickeRide</h4>
            <p class="opacity-50 small">&copy; 2026 QuickeRide Rental System - A SLIIT Student Project</p>
            <div class="d-flex justify-content-center gap-3 mt-3">
                <a href="#" class="text-white opacity-50"><i class="bi bi-facebook"></i></a>
                <a href="#" class="text-white opacity-50"><i class="bi bi-instagram"></i></a>
                <a href="#" class="text-white opacity-50"><i class="bi bi-twitter"></i></a>
            </div>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>