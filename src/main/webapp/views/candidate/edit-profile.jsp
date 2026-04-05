<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cập nhật hồ sơ - ATS</title>
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
        .form-card { background: #fff; border-radius: 12px; padding: 35px; box-shadow: 0 1px 2px rgba(0,0,0,0.1); max-width: 800px; margin: auto; border: none; }
        
        /* Custom Inputs */
        .form-control { padding: 10px 15px; border-radius: 8px; border-color: #e2e8f0; }
        .form-control:focus { border-color: #007bff; box-shadow: 0 0 0 0.2rem rgba(0, 123, 255, 0.15); }
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
            <%-- Giữ tab Hồ sơ cá nhân active vì đây là trang con của Hồ sơ --%>
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/profile">
                <i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân
            </a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/change-password">
                <i class="bi bi-shield-lock-fill me-2"></i> Đổi mật khẩu
            </a>
            <hr class="mx-3 my-3">
            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/auth/logout">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </nav>
    </div>

    <div class="main-content">
        <%-- Top-nav đồng bộ --%>
        <div class="top-nav d-flex justify-content-between align-items-center shadow-sm">
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/candidate/profile" class="btn btn-sm btn-light me-3"><i class="bi bi-arrow-left"></i> Quay lại</a>
                <h5 class="fw-bold mb-0">Chỉnh sửa hồ sơ</h5>
            </div>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-medium">${sessionScope.currentUser.fullName}</span>
                <img src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="avatar-small">
            </div>
        </div>

        <div class="form-card shadow-sm mt-4">
            <div class="d-flex align-items-center mb-4 pb-3 border-bottom">
                <i class="bi bi-pencil-square fs-3 text-primary me-3"></i>
                <div>
                    <h4 class="fw-bold mb-1">Cập nhật thông tin chuyên môn</h4>
                    <p class="text-muted small mb-0">Những thông tin này sẽ giúp AI đánh giá mức độ phù hợp của bạn tốt hơn.</p>
                </div>
            </div>
            
            <%-- Hiển thị lỗi nếu có --%>
            <c:if test="${not empty error}">
                <div class="alert alert-danger shadow-sm border-0"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/candidate/profile/update" method="POST">
                <div class="row g-4">
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-muted">Họ và tên <span class="text-danger">*</span></label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-person text-muted"></i></span>
                            <input type="text" name="fullName" class="form-control border-start-0 ps-0 bg-white" value="${user.fullName}" required>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-muted">Số điện thoại</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-telephone text-muted"></i></span>
                            <input type="text" name="phone" class="form-control border-start-0 ps-0 bg-white" value="${user.phone}" placeholder="Ví dụ: 0912345678">
                        </div>
                    </div>
                    
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-muted">Số năm kinh nghiệm</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-briefcase text-muted"></i></span>
                            <input type="number" name="experienceYear" class="form-control border-start-0 ps-0 bg-white" value="${candidate.experienceYear}" min="0" placeholder="0">
                            <span class="input-group-text bg-light">Năm</span>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <label class="form-label small fw-bold text-muted">Trình độ học vấn</label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0"><i class="bi bi-mortarboard text-muted"></i></span>
                            <input type="text" name="education" class="form-control border-start-0 ps-0 bg-white" value="${candidate.education}" placeholder="Ví dụ: Cử nhân CNTT - Đại học FPT">
                        </div>
                    </div>
                    
                    <div class="col-12">
                        <label class="form-label small fw-bold text-muted">Kỹ năng chuyên môn (Phân cách bằng dấu phẩy)</label>
                        <textarea name="skills" class="form-control" rows="3" placeholder="Ví dụ: Java, SQL Server, Spring Boot, ReactJS...">${candidate.skills}</textarea>
                        <small class="text-muted mt-1 d-block"><i class="bi bi-info-circle me-1"></i>Hệ thống AI sẽ dùng các từ khóa này để chấm điểm CV của bạn.</small>
                    </div>
                    
                    <div class="col-12 mt-5 pt-3 border-top d-flex gap-3">
                        <button type="submit" class="btn btn-primary px-5 py-2 rounded-pill fw-bold shadow-sm"><i class="bi bi-check2-circle me-2"></i>Lưu thay đổi</button>
                        <a href="${pageContext.request.contextPath}/candidate/profile" class="btn btn-light px-4 py-2 rounded-pill fw-medium text-dark border">Hủy bỏ</a>
                    </div>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>