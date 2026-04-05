<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hồ sơ cá nhân - ATS</title>
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
        
        /* Top Nav & Cards */
        .top-nav { background: #fff; padding: 15px 30px; border-bottom: 1px solid #e5e5e5; margin-bottom: 25px; border-radius: 10px; }
        .avatar-small { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; }
        .profile-card { border: none; border-radius: 12px; background: #fff; box-shadow: 0 1px 2px rgba(0,0,0,0.1); }
        .avatar-lg { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
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
        <%-- Top-nav đồng bộ với Dashboard --%>
        <div class="top-nav d-flex justify-content-between align-items-center shadow-sm">
            <h5 class="fw-bold mb-0">Hồ sơ cá nhân</h5>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-medium">${sessionScope.currentUser.fullName}</span>
                <img src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="avatar-small">
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 mb-4">
                <div class="profile-card text-center p-4 shadow-sm">
                    <div class="position-relative d-inline-block mb-3">
                        <img src="${empty user.avatar ? 'https://ui-avatars.com/api/?name='.concat(user.fullName) : user.avatar}" class="avatar-lg">
                        <a href="${pageContext.request.contextPath}/candidate/upload-avatar" class="btn btn-primary btn-sm position-absolute bottom-0 end-0 rounded-circle shadow-sm" style="width: 35px; height: 35px; display: flex; align-items: center; justify-content: center;">
                            <i class="bi bi-camera"></i>
                        </a>
                    </div>
                    <h4 class="fw-bold mb-1">${user.fullName}</h4>
                    <p class="text-muted small">${user.email}</p>
                    <hr class="my-4">
                    <div class="text-start">
                        <h6 class="fw-bold small text-muted text-uppercase mb-3">Tài liệu hồ sơ</h6>
                        
                        <%-- Xử lý hiển thị CV an toàn hơn --%>
                        <c:choose>
                            <c:when test="${not empty candidate.cvFile}">
                                <div class="p-3 bg-light rounded border d-flex align-items-center justify-content-between mb-3">
                                    <div class="d-flex align-items-center">
                                        <i class="bi bi-file-earmark-pdf-fill text-danger fs-3 me-2"></i>
                                        <span class="small fw-bold">CV hiện tại</span>
                                    </div>
                                    <a href="${pageContext.request.contextPath}/${candidate.cvFile}" class="btn btn-sm btn-outline-primary" target="_blank">Xem</a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="alert alert-warning py-2 small mb-3">Bạn chưa có CV trên hệ thống.</div>
                            </c:otherwise>
                        </c:choose>

                        <a href="${pageContext.request.contextPath}/candidate/upload-cv" class="btn btn-primary w-100 rounded-pill fw-bold shadow-sm">Tải lên CV mới</a>
                    </div>
                </div>
            </div>
            
            <div class="col-lg-8">
                <div class="profile-card p-4 shadow-sm">
                    <div class="d-flex justify-content-between align-items-center mb-4 pb-3 border-bottom">
                        <h5 class="fw-bold mb-0">Thông tin chi tiết</h5>
                        <a href="${pageContext.request.contextPath}/candidate/profile/edit" class="btn btn-outline-primary btn-sm px-4 rounded-pill fw-bold">
                            <i class="bi bi-pencil-square me-1"></i> Chỉnh sửa
                        </a>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <p class="text-muted small mb-1">Số điện thoại</p>
                            <p class="fw-bold mb-0">${empty user.phone ? '<span class="text-secondary fw-normal fst-italic">Chưa cập nhật</span>' : user.phone}</p>
                        </div>
                        <div class="col-md-6">
                            <p class="text-muted small mb-1">Kinh nghiệm</p>
                            <p class="fw-bold mb-0">${empty candidate.experienceYear ? '0' : candidate.experienceYear} Năm</p>
                        </div>
                        <div class="col-12">
                            <p class="text-muted small mb-1">Học vấn</p>
                            <p class="fw-bold mb-0">${empty candidate.education ? '<span class="text-secondary fw-normal fst-italic">Chưa cập nhật</span>' : candidate.education}</p>
                        </div>
                        <div class="col-12">
                            <p class="text-muted small mb-1">Kỹ năng chuyên môn</p>
                            <div class="d-flex flex-wrap gap-2 mt-2">
                                <c:choose>
                                    <c:when test="${not empty candidate.skills}">
                                        <c:forEach var="skill" items="${candidate.skills.split(',')}">
                                            <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill">${skill.trim()}</span>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="text-secondary small fst-italic">Chưa có thông tin kỹ năng</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>