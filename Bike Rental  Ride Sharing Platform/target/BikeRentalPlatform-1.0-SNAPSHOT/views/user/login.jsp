<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Login - Bike Rental System</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
  <style>
    body { background: linear-gradient(135deg, #667eea 0%, #764ba2 100%); min-height: 100vh; }
    .custom-card { border-radius: 20px; background-color: rgba(255, 255, 255, 0.95); box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2); }
    .btn-custom { background: linear-gradient(to right, #667eea, #764ba2); border: none; border-radius: 10px; }
    .btn-custom:hover { opacity: 0.9; }
  </style>
</head>
<body class="d-flex align-items-center">
<div class="container">
  <div class="row justify-content-center">
    <div class="col-md-4 mt-5 mb-5">
      <div class="card custom-card border-0">
        <div class="card-body p-5">
          <div class="text-center mb-4">
            <i class="bi bi-person-circle" style="font-size: 3.5rem; color: #667eea;"></i>
            <h2 class="fw-bold mt-2">Welcome Back!</h2>
            <p class="text-muted">Login to your account</p>
          </div>
          <form action="${pageContext.request.contextPath}/login" method="post">
            <div class="form-floating mb-3">
              <input type="email" name="email" class="form-control" id="emailAdd" placeholder="name@example.com" required>
              <label for="emailAdd"><i class="bi bi-envelope me-2 text-muted"></i>Email Address</label>
            </div>
            <div class="form-floating mb-4">
              <input type="password" name="password" class="form-control" id="pass" placeholder="Password" required>
              <label for="pass"><i class="bi bi-lock me-2 text-muted"></i>Password</label>
            </div>
            <button type="submit" class="btn btn-primary btn-custom w-100 py-3 fw-bold text-white">
              <i class="bi bi-box-arrow-in-right me-2"></i> Login
            </button>
          </form>
          <div class="text-center mt-4">
            <p class="mb-0">Don't have an account? <a href="${pageContext.request.contextPath}/views/user/register.jsp" class="fw-bold text-decoration-none" style="color: #764ba2;">Register here</a></p>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>