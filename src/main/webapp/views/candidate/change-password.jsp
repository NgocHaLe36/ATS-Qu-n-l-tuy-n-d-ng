<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Đổi mật khẩu - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; }
        .sidebar { background: #fff; min-height: 100vh; position: fixed; width: 260px; border-right: 1px solid #e5e5e5; }
        .main-content { margin-left: 260px; padding: 30px; }
        .nav-link { color: #606770; padding: 12px 20px; border-radius: 8px; margin: 4px 15px; text-decoration: none; display: block; }
        .nav-link.active { background-color: #e7f3ff; color: #007bff; font-weight: 600; }
        .form-card { max-width: 500px; border: none; border-radius: 15px; background: #fff; box-shadow: 0 4px 15px rgba(0,0,0,0.05); }
    </style>
</head>
<body>
    <div class="sidebar py-3">
        <div class="px-4 mb-4 d-flex align-items-center">
            <i class="bi bi-building-fill text-primary fs-3 me-2"></i>
            <span class="fw-bold fs-4 text-primary">ATS System</span>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/dashboard"><i class="bi bi-grid-fill me-2"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/applied-jobs"><i class="bi bi-briefcase-fill me-2"></i> Việc làm đã ứng tuyển</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/profile"><i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/change-password"><i class="bi bi-shield-lock-fill me-2"></i> Đổi mật khẩu</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="form-card mx-auto p-5 mt-4">
            <h4 class="fw-bold text-center mb-4">Thay đổi mật khẩu</h4>
            
            <c:if test="${not empty error}"><div class="alert alert-danger py-2 mb-3">${error}</div></c:if>
            <c:if test="${not empty success}"><div class="alert alert-success py-2 mb-3">${success}</div></c:if>

            <form action="${pageContext.request.contextPath}/candidate/change-password" method="POST">
                <div class="mb-3">
                    <label class="form-label small fw-bold">Mật khẩu hiện tại</label>
                    <input type="password" name="oldPassword" class="form-control rounded-3" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold">Mật khẩu mới</label>
                    <input type="password" name="newPassword" class="form-control rounded-3" required>
                </div>
                <div class="mb-4">
                    <label class="form-label small fw-bold">Xác nhận mật khẩu mới</label>
                    <input type="password" name="confirmPassword" class="form-control rounded-3" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 fw-bold shadow-sm">Cập nhật mật khẩu</button>
            </form>
        </div>
    </div>
</body>
</html>