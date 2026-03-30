<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Hồ sơ cá nhân - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; }
        .sidebar { background: #fff; min-height: 100vh; position: fixed; width: 260px; border-right: 1px solid #e5e5e5; }
        .main-content { margin-left: 260px; padding: 30px; }
        .nav-link { color: #606770; padding: 12px 20px; border-radius: 8px; margin: 4px 15px; text-decoration: none; display: block; }
        .nav-link.active { background-color: #e7f3ff; color: #007bff; font-weight: 600; }
        .profile-card { border: none; border-radius: 15px; background: #fff; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .avatar-lg { width: 120px; height: 120px; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 4px 10px rgba(0,0,0,0.1); }
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/profile"><i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/change-password"><i class="bi bi-shield-lock-fill me-2"></i> Đổi mật khẩu</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="row">
            <div class="col-lg-4">
                <div class="profile-card text-center p-4">
                    <div class="position-relative d-inline-block mb-3">
                        <img src="${empty user.avatar ? 'https://ui-avatars.com/api/?name=' + user.fullName : user.avatar}" class="avatar-lg">
                        <a href="${pageContext.request.contextPath}/candidate/upload-avatar" class="btn btn-primary btn-sm position-absolute bottom-0 end-0 rounded-circle shadow-sm">
                            <i class="bi bi-camera"></i>
                        </a>
                    </div>
                    <h4 class="fw-bold mb-1">${user.fullName}</h4>
                    <p class="text-muted small">${user.email}</p>
                    <hr>
                    <div class="text-start">
                        <h6 class="fw-bold small text-muted text-uppercase mb-3">Tài liệu hồ sơ</h6>
                        <div class="p-3 bg-light rounded border d-flex align-items-center justify-content-between mb-3">
                            <div class="d-flex align-items-center">
                                <i class="bi bi-file-earmark-pdf-fill text-danger fs-3 me-2"></i>
                                <span class="small fw-bold">My_CV.pdf</span>
                            </div>
                            <a href="${candidate.cvFile}" class="btn btn-sm btn-outline-primary" target="_blank">Xem</a>
                        </div>
                        <a href="${pageContext.request.contextPath}/candidate/upload-cv" class="btn btn-primary btn-sm w-100 rounded-pill">Tải lên CV mới</a>
                    </div>
                </div>
            </div>
            <div class="col-lg-8">
                <div class="profile-card p-4">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h5 class="fw-bold mb-0">Thông tin chi tiết</h5>
                        <a href="${pageContext.request.contextPath}/candidate/profile/edit" class="btn btn-outline-primary btn-sm px-4 rounded-pill">Chỉnh sửa</a>
                    </div>
                    <div class="row g-4">
                        <div class="col-md-6">
                            <p class="text-muted small mb-1">Số điện thoại</p>
                            <p class="fw-bold">${empty user.phone ? 'Chưa cập nhật' : user.phone}</p>
                        </div>
                        <div class="col-md-6">
                            <p class="text-muted small mb-1">Kinh nghiệm</p>
                            <p class="fw-bold">${candidate.experienceYear} Năm</p>
                        </div>
                        <div class="col-12">
                            <p class="text-muted small mb-1">Học vấn</p>
                            <p class="fw-bold">${empty candidate.education ? 'Chưa cập nhật' : candidate.education}</p>
                        </div>
                        <div class="col-12">
                            <p class="text-muted small mb-1">Kỹ năng chuyên môn</p>
                            <div class="d-flex flex-wrap gap-2 mt-2">
                                <c:forEach var="skill" items="${candidate.skills.split(',')}">
                                    <span class="badge bg-primary-subtle text-primary border border-primary-subtle px-3 py-2 rounded-pill">${skill.trim()}</span>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>