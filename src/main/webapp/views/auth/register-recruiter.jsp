<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký Nhà Tuyển Dụng | ATS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fbff; color: #333; }
        .auth-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 40px 15px; }
        .auth-card { background: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,123,255,0.08); padding: 40px; width: 100%; max-width: 600px; border: 1px solid #edf2f7; }
        .form-control { border-radius: 10px; padding: 12px 15px; border-color: #e2e8f0; font-size: 0.95rem; }
        .form-control:focus { border-color: #007bff; box-shadow: 0 0 0 3px rgba(0,123,255,0.15); }
    </style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/auth/register" class="position-absolute top-0 start-0 m-4 text-decoration-none text-muted fw-bold"><i class="bi bi-arrow-left me-2"></i>Quay lại</a>

    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="text-center mb-4">
                <div class="d-inline-flex bg-warning bg-opacity-10 text-warning p-3 rounded-circle mb-3"><i class="bi bi-buildings fs-2"></i></div>
                <h3 class="fw-bold mb-1">Tài khoản Doanh nghiệp</h3>
                <p class="text-muted small">Bắt đầu tìm kiếm nhân tài và ứng dụng AI ngay hôm nay.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-3 py-2 small"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/register-recruiter" method="POST">
                <div class="mb-3">
                    <label class="form-label fw-bold small text-muted">Tên công ty / Người đại diện <span class="text-danger">*</span></label>
                    <input type="text" name="fullName" value="${fullName}" class="form-control" placeholder="Công ty CP ATS..." required>
                </div>
                
                <div class="row g-3 mb-3">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Email liên hệ <span class="text-danger">*</span></label>
                        <input type="email" name="email" value="${email}" class="form-control" placeholder="hr@congty.com" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Hotline công ty</label>
                        <input type="text" name="phone" value="${phone}" class="form-control" placeholder="028 xxx xxxx">
                    </div>
                </div>

                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Xác nhận mật khẩu <span class="text-danger">*</span></label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>
                </div>
                
                <div class="mb-4 form-check">
                    <input type="checkbox" class="form-check-input" id="terms" required>
                    <label class="form-check-label small text-muted" for="terms">Tôi đồng ý với <a href="#">Điều khoản sử dụng</a> và <a href="#">Bảo mật thông tin</a>.</label>
                </div>

                <button type="submit" class="btn btn-primary w-100 rounded-3 py-3 fw-bold shadow-sm">Đăng ký doanh nghiệp</button>
            </form>
            
            <div class="text-center mt-4">
                <span class="text-muted small">Đã có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/auth/login" class="fw-bold text-decoration-none text-primary small">Đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>