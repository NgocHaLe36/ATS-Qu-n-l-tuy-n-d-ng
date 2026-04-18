<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Phê duyệt Thư mời (Offer) - ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background: #f0f2f5; }
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; background: #fff; border-right: 1px solid #eee; overflow-y: auto; }
        .admin-main { margin-left: var(--sidebar-width); padding-bottom: 100px; }
        .offer-paper { background: #fff; max-width: 800px; margin: 30px auto; padding: 60px; box-shadow: 0 10px 30px rgba(0,0,0,0.1); border-top: 5px solid #007bff; }
        .sticky-action-bar { position: fixed; bottom: 0; left: var(--sidebar-width); right: 0; background: #fff; padding: 20px 40px; border-top: 1px solid #eee; z-index: 100; }
        /* CSS Sidebar Copy-paste từ bản trên */
    </style>
</head>
<body>
    <main class="admin-main">
        <div class="container py-4">
            <div class="offer-paper">
                <div class="text-center mb-5">
                    <h2 class="fw-bold">THƯ MỜI LÀM VIỆC</h2>
                    <p class="text-muted small">Mã hồ sơ: #APP-${application.id}</p>
                </div>
                
                <p>Thân gửi <strong>${application.candidate.user.fullName}</strong>,</p>
                <p>Chúng tôi rất ấn tượng với kỹ năng và kinh nghiệm của bạn qua các vòng phỏng vấn cho vị trí <strong>${application.job.title}</strong> tại <strong>${application.job.recruiter.fullName}</strong>.</p>
                
                <h5 class="fw-bold mt-4 mb-3 border-bottom pb-2">Chi tiết đề nghị</h5>
                <div class="row g-3 mb-4">
                    <div class="col-6"><p class="text-muted mb-1">Mức lương dự kiến:</p><p class="fw-bold text-success">${application.job.salary}</p></div>
                    <div class="col-6"><p class="text-muted mb-1">Địa điểm làm việc:</p><p class="fw-bold">${application.job.location}</p></div>
                    <div class="col-6"><p class="text-muted mb-1">Trạng thái hiện tại:</p><span class="badge bg-warning">${application.status}</span></div>
                </div>

                <p>Thư này được tạo tự động dựa trên kết quả phỏng vấn. Quản trị viên vui lòng rà soát trước khi phê duyệt gửi cho ứng viên.</p>
                
                <div class="mt-5 pt-5 text-end"><p class="mb-0">Trân trọng,</p><p class="fw-bold">Hệ thống Tuyển dụng ATS</p></div>
            </div>
        </div>

        <div class="sticky-action-bar d-flex justify-content-between align-items-center">
            <a href="${pageContext.request.contextPath}/admin/recruitment-results" class="btn btn-light"><i class="bi bi-arrow-left me-2"></i>Quay lại danh sách</a>
            <div class="d-flex gap-3">
                <form action="${pageContext.request.contextPath}/admin/recruitment-results/offer-approval" method="POST">
                    <input type="hidden" name="applicationId" value="${application.id}">
                    <input type="hidden" name="action" value="reject">
                    <button type="submit" class="btn btn-outline-danger px-4 rounded-pill" onclick="return confirm('Bạn có chắc chắn muốn LOẠI hồ sơ này?')">Từ chối ứng viên</button>
                </form>
                <form action="${pageContext.request.contextPath}/admin/recruitment-results/offer-approval" method="POST">
                    <input type="hidden" name="applicationId" value="${application.id}">
                    <input type="hidden" name="action" value="approve">
                    <button type="submit" class="btn btn-primary px-5 rounded-pill shadow" onclick="return confirm('Phê duyệt và gửi Offer cho ứng viên?')">Phê duyệt & Gửi Offer</button>
                </form>
            </div>
        </div>
    </main>
</body>
</html>