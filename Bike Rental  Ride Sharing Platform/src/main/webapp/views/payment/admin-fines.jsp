<%@ page import="com.bikerental.model.Person" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    Person loggedInUser = (Person) session.getAttribute("user");
    if (loggedInUser == null || !"Admin".equals(loggedInUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/views/user/dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Manage Fines - Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #f4f7f6; }
        .navbar { background: #1a1a2e; padding: 15px 0; }
        .navbar-brand { font-weight: 700; color: #fff !important; }
        .fine-card { border: none; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.05); max-width: 600px; margin: 50px auto; }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark shadow-sm">
        <div class="container">
            <a class="navbar-brand" href="#"><i class="bi bi-exclamation-triangle-fill text-danger me-2"></i>Issue Fines (Admin)</a>
            <a href="${pageContext.request.contextPath}/views/user/dashboard.jsp" class="btn btn-outline-light btn-sm rounded-pill px-3 py-2">
                <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
            </a>
        </div>
    </nav>

    <div class="container px-3">
        <% if("true".equals(request.getParameter("success"))) { %>
            <div class="alert alert-success mt-4 rounded-3 fw-bold max-w-600 mx-auto text-center">
                <i class="bi bi-check-circle-fill me-2"></i>Fine issued successfully!
            </div>
        <% } %>

        <div class="card fine-card">
            <div class="card-header bg-danger text-white p-3 text-center rounded-top-4">
                <h4 class="mb-0 fw-bold"><i class="bi bi-receipt-cutoff me-2"></i>Apply Penalty</h4>
            </div>
            <div class="card-body p-4">
                <form action="${pageContext.request.contextPath}/addFine" method="post">
                    <div class="mb-3">
                        <label class="form-label fw-bold">Booking Reference ID</label>
                        <input type="text" name="bookingId" class="form-control" placeholder="e.g. BKG-4F70B" required>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-bold">Reason for Penalty</label>
                        <select name="reason" class="form-select fw-bold" required onchange="toggleDaysField(this.value)">
                            <option value="" disabled selected>Select reason...</option>
                            <option value="Late Return">Late Return (Rs.500 per day)</option>
                            <option value="Damage">Vehicle Damage (Rs.2000 flat)</option>
                        </select>
                    </div>

                    <div class="mb-4" id="daysField" style="display: none;">
                        <label class="form-label fw-bold">Number of Days Late</label>
                        <input type="number" name="lateDays" class="form-control" placeholder="Enter days" min="1">
                    </div>

                    <button type="submit" class="btn btn-danger w-100 fw-bold py-2 shadow-sm">
                        <i class="bi bi-send-fill me-2"></i>Issue Fine
                    </button>
                </form>
            </div>
        </div>
    </div>

    <script>
        function toggleDaysField(reason) {
            const daysField = document.getElementById("daysField");
            if (reason === "Late Return") {
                daysField.style.display = "block";
                document.getElementsByName("lateDays")[0].required = true;
            } else {
                daysField.style.display = "none";
                document.getElementsByName("lateDays")[0].required = false;
            }
        }
    </script>
</body>
</html>