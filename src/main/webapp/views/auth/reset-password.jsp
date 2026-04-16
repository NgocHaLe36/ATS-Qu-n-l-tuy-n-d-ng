<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đặt lại mật khẩu | ATS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fbff; color: #333; }
        .auth-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 40px 15px; }
        .auth-card { background: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,123,255,0.08); padding: 40px; width: 100%; max-width: 450px; border: 1px solid #edf2f7; }
        .auth-logo { width: 60px; height: 60px; background: rgba(25, 135, 84, 0.1); color: #198754; border-radius: 16px; display: flex; align-items: center; justify-content: center; font-size: 2rem; margin: 0 auto 20px; }
        .form-control { border-radius: 10px; padding: 12px 15px; border-color: #e2e8f0; font-size: 0.95rem; }
        .form-control:focus { border-color: #198754; box-shadow: 0 0 0 3px rgba(25,135,84,0.15); }
    </style>
</head>
<body>

    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="auth-logo"><i class="bi bi-key-fill"></i></div>
            <h3 class="fw-bold text-center mb-1">Tạo mật khẩu mới</h3>
            <p class="text-center text-muted small mb-4">Vui lòng nhập mật khẩu mới bảo mật cho tài khoản của bạn.</p>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-3 py-2 small"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/reset-password" method="POST">
                <input type="hidden" name="token" value="${token}">

                <div class="mb-3">
                    <label class="form-label fw-bold small text-muted">Mật khẩu mới</label>
                    <input type="password" name="newPassword" class="form-control" placeholder="Tối thiểu 8 ký tự" required>
                </div>
                <div class="mb-4">
                    <label class="form-label fw-bold small text-muted">Xác nhận mật khẩu mới</label>
                    <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu" required>
                </div>
                
                <button type="submit" class="btn btn-success w-100 shadow-sm py-2 fw-bold rounded-3">Cập nhật mật khẩu</button>
            </form>
        </div>
    </div>

</body>
</html>