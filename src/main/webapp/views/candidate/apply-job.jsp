<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ứng tuyển: ${job.title}</title>
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
        
        /* Specific UI Elements */
        .apply-card { background: #fff; border-radius: 12px; padding: 30px; border: none; max-width: 750px; margin: auto; }
        .job-info-box { background: #f8fbff; border: 1px solid #e1efff; border-radius: 10px; padding: 20px; }
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
                <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="btn btn-sm btn-light me-3"><i class="bi bi-arrow-left"></i> Quay lại</a>
                <h5 class="fw-bold mb-0">Ứng tuyển công việc</h5>
            </div>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-medium">${sessionScope.currentUser.fullName}</span>
                <img src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="avatar-small">
            </div>
        </div>

        <div class="apply-card shadow-sm mt-3">
            <h4 class="fw-bold mb-4 text-center">Xác nhận nộp hồ sơ</h4>
            
            <%-- Hiển thị thông báo lỗi nếu có --%>
            <c:if test="${not empty error}">
                <div class="alert alert-danger border-0 rounded-3 mb-4 shadow-sm"><i class="bi bi-exclamation-triangle-fill me-2"></i>${error}</div>
            </c:if>

            <div class="job-info-box mb-4 shadow-sm">
                <h5 class="fw-bold text-primary mb-2">${job.title}</h5>
                <p class="text-muted small mb-0"><i class="bi bi-building me-1"></i>${job.recruiter.fullName} &nbsp;|&nbsp; <i class="bi bi-geo-alt me-1"></i>${job.location}</p>
            </div>

            <form action="${pageContext.request.contextPath}/candidate/submit-application" method="POST" enctype="multipart/form-data">
                <input type="hidden" name="jobId" value="${job.id}">
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Chọn CV ứng tuyển</label>
                    
                    <%-- Phần hiển thị CV mặc định --%>
                    <div class="p-3 border rounded-3 bg-light d-flex align-items-center justify-content-between mb-3 shadow-sm">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-file-earmark-check-fill text-success fs-3 me-3"></i>
                            <div>
                                <span class="d-block small fw-bold">${empty candidateCvFile ? 'Bạn chưa có CV mặc định trên hệ thống' : 'Sử dụng CV mặc định trong hồ sơ'}</span>
                                <c:if test="${not empty candidateCvFile}">
                                    <a href="${pageContext.request.contextPath}/${candidateCvFile}" target="_blank" class="small text-primary text-decoration-none"><i class="bi bi-eye me-1"></i>Xem lại CV hiện tại</a>
                                </c:if>
                            </div>
                        </div>
                    </div>

                    <%-- Phần upload CV mới --%>
                    <div class="p-3 border rounded-3 bg-white shadow-sm">
                        <label class="form-label small fw-bold text-dark mb-2">Hoặc tải lên CV mới từ máy tính (Khuyên dùng)</label>
                        <input type="file" name="cvFile" class="form-control" accept=".pdf,.doc,.docx">
                        <small class="text-muted mt-2 d-block"><i class="bi bi-info-circle me-1"></i>Định dạng hỗ trợ: PDF, DOC, DOCX. Tối đa 10MB.</small>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Thư giới thiệu / Lời nhắn (Ghi chú)</label>
                    <textarea name="note" class="form-control bg-light" rows="5" placeholder="Bạn có thể viết lời chào hoặc lý do bạn phù hợp với công việc này để tạo ấn tượng tốt hơn với nhà tuyển dụng..."></textarea>
                </div>

                <div class="d-grid gap-2">
                    <button type="submit" class="btn btn-primary btn-lg rounded-pill fw-bold shadow-sm">Xác nhận nộp đơn ngay</button>
                    <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="btn btn-link text-muted mt-1 text-center text-decoration-none">Hủy bỏ</a>
                </div>
            </form>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>