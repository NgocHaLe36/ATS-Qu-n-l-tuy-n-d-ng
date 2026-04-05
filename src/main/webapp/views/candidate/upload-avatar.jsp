<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật ảnh đại diện - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; color: #1c1e21; margin: 0; }
        .sidebar { background: #fff; min-height: 100vh; position: fixed; top: 0; left: 0; width: 260px; border-right: 1px solid #e5e5e5; z-index: 1000; }
        .main-content { margin-left: 260px; padding: 20px; min-height: 100vh; }
        .nav-link { color: #606770; font-weight: 500; padding: 12px 20px; border-radius: 8px; margin: 4px 15px; transition: 0.2s; text-decoration: none; display: block; }
        .nav-link:hover { background-color: #f2f3f5; color: #007bff; }
        .nav-link.active { background-color: #e7f3ff; color: #007bff; }
        .top-nav { background: #fff; padding: 15px 30px; border-bottom: 1px solid #e5e5e5; margin-bottom: 25px; border-radius: 10px; }
        .avatar-small { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; }
        
        /* Upload Card */
        .upload-card { background: #fff; border-radius: 15px; padding: 40px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); max-width: 500px; margin: auto; text-align: center; border: none; }
        .preview-circle { width: 160px; height: 160px; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 5px 15px rgba(0,0,0,0.1); margin-bottom: 25px; }
    </style>
</head>
<body>

    <div class="sidebar py-3 shadow-sm">
        <div class="px-4 mb-4 d-flex align-items-center">
            <i class="bi bi-building-fill text-primary fs-3 me-2"></i>
            <span class="fw-bold fs-4 text-primary">ATS System</span>
        </div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door-fill me-2"></i> Trang chủ</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/dashboard"><i class="bi bi-grid-fill me-2"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/applied-jobs"><i class="bi bi-briefcase-fill me-2"></i> Việc làm đã ứng tuyển</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/profile"><i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/change-password"><i class="bi bi-shield-lock-fill me-2"></i> Đổi mật khẩu</a>
            <hr class="mx-3 my-3">
            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="top-nav d-flex justify-content-between align-items-center shadow-sm">
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/candidate/profile" class="btn btn-sm btn-light me-3"><i class="bi bi-arrow-left"></i> Quay lại</a>
                <h5 class="fw-bold mb-0">Cập nhật ảnh đại diện</h5>
            </div>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-medium">${sessionScope.currentUser.fullName}</span>
                <img src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="avatar-small">
            </div>
        </div>

        <div class="upload-card shadow-sm mt-5">
            <form action="${pageContext.request.contextPath}/candidate/save-avatar" method="POST" enctype="multipart/form-data">
                
                <%-- Vùng hiển thị ảnh (Đã sửa lại đường dẫn chuẩn) --%>
                <div class="position-relative d-inline-block">
                    <img id="avatarPreview" src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="preview-circle" alt="Avatar Preview">
                    <div class="position-absolute bottom-0 end-0 bg-primary text-white rounded-circle d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; transform: translate(-10px, -20px); border: 3px solid #fff;">
                        <i class="bi bi-camera-fill"></i>
                    </div>
                </div>

                <h5 class="fw-bold mb-2">Thay ảnh đại diện mới</h5>
                <p class="text-muted small mb-4">Định dạng JPG, PNG. Dung lượng tối đa 5MB.</p>

                <%-- Input file gọi sự kiện onchange để preview ảnh --%>
                <div class="mb-4 text-start">
                    <input type="file" id="avatarInput" name="avatarFile" class="form-control" accept="image/*" required onchange="previewImage(event)">
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg rounded-pill fw-bold shadow-sm">Lưu ảnh đại diện</button>
                    <a href="${pageContext.request.contextPath}/candidate/profile" class="btn btn-light rounded-pill fw-medium text-dark border">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>

    <%-- Script xử lý hiện ảnh thật ngay lập tức khi vừa chọn file --%>
    <script>
        function previewImage(event) {
            const input = event.target;
            if (input.files && input.files[0]) {
                const reader = new FileReader();
                reader.onload = function(e) {
                    document.getElementById('avatarPreview').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>