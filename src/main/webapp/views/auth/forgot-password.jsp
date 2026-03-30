<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quên mật khẩu | ATS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fbff; color: #333; }
        .auth-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 40px 15px; }
        .auth-card { background: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,123,255,0.08); padding: 40px; width: 100%; max-width: 450px; border: 1px solid #edf2f7; }
        .auth-logo { width: 60px; height: 60px; background: rgba(0, 123, 255, 0.1); color: #007bff; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 2rem; margin: 0 auto 20px; }
        .form-control { border-radius: 10px; padding: 12px 15px; border-color: #e2e8f0; font-size: 0.95rem; }
        .form-control:focus { border-color: #007bff; box-shadow: 0 0 0 3px rgba(0,123,255,0.15); }
    </style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/auth/login" class="position-absolute top-0 start-0 m-4 text-decoration-none text-muted fw-bold">
        <i class="bi bi-arrow-left me-2"></i>Quay lại đăng nhập
    </a>

    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="auth-logo"><i class="bi bi-shield-lock-fill"></i></div>
            <h3 class="fw-bold text-center mb-1">Khôi phục mật khẩu</h3>
            <p class="text-center text-muted small mb-4">Nhập email của bạn để nhận liên kết đặt lại mật khẩu.</p>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-3 py-2 small"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
            </c:if>
            <c:if test="${not empty success}">
                <div class="alert alert-success rounded-3 py-2 small">
                    <i class="bi bi-check-circle me-2"></i>${success}
                    <div class="mt-2 text-center">
                        <a href="${resetLink}" class="btn btn-sm btn-success rounded-pill fw-bold">Click để Test Reset Password</a>
                    </div>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/forgot-password" method="POST">
                <div class="mb-4">
                    <label class="form-label fw-bold small text-muted">Địa chỉ Email đã đăng ký</label>
                    <input type="email" name="email" value="${email}" class="form-control" placeholder="Nhập email của bạn" required>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 shadow-sm py-2 fw-bold rounded-3">Gửi yêu cầu</button>
            </form>
        </div>
    </div>

</body>
</html>