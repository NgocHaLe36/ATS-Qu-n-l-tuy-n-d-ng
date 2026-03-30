<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đăng ký Ứng Viên | ATS System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f8fbff; color: #333; }
        .auth-wrapper { min-height: 100vh; display: flex; align-items: center; justify-content: center; padding: 40px 15px; }
        .auth-card { background: #fff; border-radius: 20px; box-shadow: 0 10px 40px rgba(0,123,255,0.08); padding: 40px; width: 100%; max-width: 700px; border: 1px solid #edf2f7; }
        .form-control { border-radius: 10px; padding: 12px 15px; border-color: #e2e8f0; font-size: 0.95rem; }
        .form-control:focus { border-color: #007bff; box-shadow: 0 0 0 3px rgba(0,123,255,0.15); }
    </style>
</head>
<body>

    <a href="${pageContext.request.contextPath}/auth/register" class="position-absolute top-0 start-0 m-4 text-decoration-none text-muted fw-bold"><i class="bi bi-arrow-left me-2"></i>Quay lại</a>

    <div class="auth-wrapper">
        <div class="auth-card">
            <div class="text-center mb-4">
                <div class="d-inline-flex bg-primary bg-opacity-10 text-primary p-3 rounded-circle mb-3"><i class="bi bi-person-badge fs-2"></i></div>
                <h3 class="fw-bold mb-1">Tạo hồ sơ Ứng viên</h3>
                <p class="text-muted small">Cơ hội việc làm mơ ước đang chờ đón bạn.</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-danger rounded-3 py-2 small"><i class="bi bi-exclamation-circle me-2"></i>${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/auth/register-candidate" method="POST">
                <h6 class="fw-bold border-bottom pb-2 mb-3 text-primary">Thông tin đăng nhập</h6>
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Họ và tên *</label>
                        <input type="text" name="fullName" value="${fullName}" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Email *</label>
                        <input type="email" name="email" value="${email}" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Mật khẩu *</label>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Xác nhận mật khẩu *</label>
                        <input type="password" name="confirmPassword" class="form-control" required>
                    </div>
                </div>

                <h6 class="fw-bold border-bottom pb-2 mb-3 text-primary mt-4">Hồ sơ cá nhân (Tùy chọn)</h6>
                <div class="row g-3 mb-4">
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Số điện thoại</label>
                        <input type="text" name="phone" value="${phone}" class="form-control">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Số năm kinh nghiệm</label>
                        <input type="number" name="experienceYear" value="${experienceYear}" class="form-control" placeholder="VD: 2">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Học vấn</label>
                        <input type="text" name="education" value="${education}" class="form-control" placeholder="Đại học XYZ...">
                    </div>
                    <div class="col-md-6">
                        <label class="form-label fw-bold small text-muted">Kỹ năng chính</label>
                        <input type="text" name="skills" value="${skills}" class="form-control" placeholder="Java, Python, Marketing...">
                    </div>
                </div>
                
                <button type="submit" class="btn btn-primary w-100 rounded-3 py-3 fw-bold shadow-sm mt-2">Hoàn tất đăng ký</button>
            </form>
            
            <div class="text-center mt-4">
                <span class="text-muted small">Đã có tài khoản? </span>
                <a href="${pageContext.request.contextPath}/auth/login" class="fw-bold text-decoration-none text-primary small">Đăng nhập</a>
            </div>
        </div>
    </div>
</body>
</html>