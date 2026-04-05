<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; color: #1c1e21; margin: 0; }
        
        /* Sidebar Navigation cố định */
        .sidebar { background: #fff; min-height: 100vh; position: fixed; top: 0; left: 0; width: 260px; border-right: 1px solid #e5e5e5; z-index: 1000; }
        .main-content { margin-left: 260px; padding: 20px; min-height: 100vh; }
        
        .nav-link { color: #606770; font-weight: 500; padding: 12px 20px; border-radius: 8px; margin: 4px 15px; transition: 0.2s; text-decoration: none; display: block; }
        .nav-link:hover { background-color: #f2f3f5; color: #007bff; }
        .nav-link.active { background-color: #e7f3ff; color: #007bff; }
        
        /* Top Nav & Form Card */
        .top-nav { background: #fff; padding: 15px 30px; border-bottom: 1px solid #e5e5e5; margin-bottom: 25px; border-radius: 10px; }
        .avatar-small { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; }
        .form-card { max-width: 500px; border: none; border-radius: 12px; background: #fff; box-shadow: 0 1px 2px rgba(0,0,0,0.1); }
    </style>
</head>
<body>

    <div class="sidebar py-3 shadow-sm">
        <div class="px-4 mb-4 d-flex align-items-center">
            <i class="bi bi-building-fill text-primary fs-3 me-2"></i>
            <span class="fw-bold fs-4 text-primary">ATS System</span>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/home">
                <i class="bi bi-house-door-fill me-2"></i> Trang chủ
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/dashboard">
                <i class="bi bi-grid-fill me-2"></i> Dashboard
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/applied-jobs">
                <i class="bi bi-briefcase-fill me-2"></i> Việc làm đã ứng tuyển
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/profile">
                <i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân
            </a>
            <%-- Class active được chuyển xuống mục Đổi mật khẩu --%>
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/change-password">
                <i class="bi bi-shield-lock-fill me-2"></i> Đổi mật khẩu
            </a>
            <hr class="mx-3 my-3">
            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/auth/logout">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </nav>
    </div>

    <div class="main-content">
        <%-- Top-nav đồng bộ với Dashboard --%>
        <div class="top-nav d-flex justify-content-between align-items-center shadow-sm">
            <h5 class="fw-bold mb-0">Đổi mật khẩu</h5>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-medium">${sessionScope.currentUser.fullName}</span>
                <img src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="avatar-small">
            </div>
        </div>

        <%-- Form thay đổi mật khẩu --%>
        <div class="form-card mx-auto p-5 mt-5 shadow-sm">
            <h4 class="fw-bold text-center mb-4">Thay đổi mật khẩu</h4>
            
            <c:if test="${not empty error}"><div class="alert alert-danger py-2 mb-3"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}</div></c:if>
            <c:if test="${not empty success}"><div class="alert alert-success py-2 mb-3"><i class="bi bi-check-circle-fill me-2"></i>${success}</div></c:if>

            <form action="${pageContext.request.contextPath}/candidate/change-password" method="POST">
                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Mật khẩu hiện tại</label>
                    <input type="password" name="oldPassword" class="form-control rounded-3" required>
                </div>
                <div class="mb-3">
                    <label class="form-label small fw-bold text-muted">Mật khẩu mới</label>
                    <input type="password" name="newPassword" class="form-control rounded-3" required>
                </div>
                <div class="mb-4">
                    <label class="form-label small fw-bold text-muted">Xác nhận mật khẩu mới</label>
                    <input type="password" name="confirmPassword" class="form-control rounded-3" required>
                </div>
                <button type="submit" class="btn btn-primary w-100 py-2 rounded-3 fw-bold shadow-sm">Cập nhật mật khẩu</button>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>