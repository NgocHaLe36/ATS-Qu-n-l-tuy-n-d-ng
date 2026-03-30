<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Ứng tuyển: ${job.title}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; }
        .sidebar { background: #fff; min-height: 100vh; position: fixed; width: 260px; border-right: 1px solid #e5e5e5; }
        .main-content { margin-left: 260px; padding: 25px; }
        .apply-card { background: #fff; border-radius: 15px; padding: 30px; box-shadow: 0 4px 20px rgba(0,0,0,0.05); max-width: 700px; margin: auto; }
        .job-info-box { background: #f8fbff; border: 1px solid #e1efff; border-radius: 10px; padding: 20px; }
    </style>
</head>
<body>
    <div class="sidebar py-3">
        <div class="px-4 mb-4 d-flex align-items-center"><i class="bi bi-building-fill text-primary fs-3 me-2"></i><span class="fw-bold fs-4 text-primary">ATS System</span></div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/dashboard"><i class="bi bi-grid-fill me-2"></i> Dashboard</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/applied-jobs"><i class="bi bi-briefcase-fill me-2"></i> Việc làm đã ứng tuyển</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/profile"><i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="apply-card">
            <h4 class="fw-bold mb-4">Nộp hồ sơ ứng tuyển</h4>
            <div class="job-info-box mb-4">
                <h5 class="fw-bold text-primary mb-1">${job.title}</h5>
                <p class="text-muted small mb-0"><i class="bi bi-building me-1"></i>${job.recruiter.fullName} | ${job.location}</p>
            </div>

            <form action="${pageContext.request.contextPath}/candidate/submit-application" method="POST">
                <input type="hidden" name="jobId" value="${job.id}">
                
                <div class="mb-4">
                    <label class="form-label fw-bold">Chọn CV ứng tuyển</label>
                    <div class="p-3 border rounded-3 bg-light d-flex align-items-center justify-content-between">
                        <div class="d-flex align-items-center">
                            <i class="bi bi-file-earmark-pdf-fill text-danger fs-3 me-3"></i>
                            <div>
                                <span class="d-block small fw-bold">${empty candidateCvFile ? 'Bạn chưa tải CV lên hệ thống' : 'Sử dụng CV mặc định'}</span>
                                <c:if test="${not empty candidateCvFile}"><a href="${candidateCvFile}" target="_blank" class="small text-primary">Xem CV hiện tại</a></c:if>
                            </div>
                        </div>
                        <c:if test="${empty candidateCvFile}"><a href="${pageContext.request.contextPath}/candidate/upload-cv" class="btn btn-sm btn-outline-danger">Tải lên ngay</a></c:if>
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label fw-bold">Thư giới thiệu / Lời nhắn (Ghi chú)</label>
                    <textarea name="note" class="form-control" rows="5" placeholder="Bạn có thể viết lời chào hoặc lý do bạn phù hợp với công việc này..."></textarea>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-primary btn-lg rounded-pill fw-bold" ${empty candidateCvFile ? 'disabled' : ''}>Xác nhận nộp đơn</button>
                    <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="btn btn-link text-muted mt-2">Quay lại</a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>