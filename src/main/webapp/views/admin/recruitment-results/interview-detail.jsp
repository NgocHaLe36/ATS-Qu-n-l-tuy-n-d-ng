<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Chi tiết Đánh giá Phỏng vấn - ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; overflow-x: hidden; }
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-item { margin-bottom: 5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; display: flex; flex-direction: column; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .info-label { font-size: 0.75rem; font-weight: 700; color: #64748b; text-transform: uppercase; }
    </style>
</head>
<body>
    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center"><i class="bi bi-building-fill text-primary me-2 fs-3"></i><span class="fw-bold fs-4 text-primary">ATS Admin</span></div>
        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/staff" class="sidebar-link"><i class="bi bi-person-badge"></i> Quản lý nhân viên</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>
            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruiters" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/candidates" class="sidebar-link"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruitment-results" class="sidebar-link active"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>
            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/vip-plans" class="sidebar-link"><i class="bi bi-gem"></i> Quản lý gói VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/transactions" class="sidebar-link"><i class="bi bi-cash-stack"></i> Quản lý giao dịch</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link"><i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng</a></li>
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
            <li class="sidebar-item mt-3"><a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10"><i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất</a></li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/admin/recruitment-results" class="btn btn-light rounded-circle me-3"><i class="bi bi-arrow-left"></i></a>
                <h4 class="fw-bold mb-0">Chi tiết Hồ sơ #${application.id}</h4>
            </div>
            <div class="fw-bold">${admin.fullName}</div>
        </header>

        <div class="container-fluid p-4">
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="admin-card mb-4">
                        <h5 class="fw-bold mb-4">Thông tin buổi phỏng vấn</h5>
                        <c:if test="${not empty latestInterview}">
                            <div class="row g-3">
                                <div class="col-md-6"><p class="info-label mb-1">Ngày phỏng vấn</p><p class="fw-bold">${latestInterview.interviewDate}</p></div>
                                <div class="col-md-6"><p class="info-label mb-1">Hình thức</p><p class="fw-bold">${latestInterview.interviewType}</p></div>
                                <div class="col-md-6"><p class="info-label mb-1">Người phỏng vấn</p><p class="fw-bold">${latestInterview.interviewer}</p></div>
                                <div class="col-md-6"><p class="info-label mb-1">Địa điểm/Link</p><p class="fw-bold">${latestInterview.location}</p></div>
                                <div class="col-12"><p class="info-label mb-1">Ghi chú từ HR</p><p class="bg-light p-3 rounded">${latestInterview.note}</p></div>
                            </div>
                        </c:if>
                        <c:if test="${empty latestInterview}">
                            <p class="text-muted text-center py-4">Chưa có thông tin phỏng vấn cho hồ sơ này.</p>
                        </c:if>
                    </div>

                    <div class="admin-card">
                        <h5 class="fw-bold mb-4">Phân tích từ AI</h5>
                        <div class="row text-center g-3">
                            <div class="col-md-4 border-end"><h3>${application.aiScore.skillScore}</h3><p class="small text-muted">Kỹ năng</p></div>
                            <div class="col-md-4 border-end"><h3>${application.aiScore.experienceScore}</h3><p class="small text-muted">Kinh nghiệm</p></div>
                            <div class="col-md-4"><h3>${application.aiScore.totalScore}</h3><p class="small text-muted">Tổng điểm</p></div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="admin-card text-center shadow-sm">
                        <img src="https://ui-avatars.com/api/?name=${application.candidate.user.fullName}&background=007bff&color=fff&size=100" class="rounded-circle mb-3 border p-1">
                        <h5 class="fw-bold">${application.candidate.user.fullName}</h5>
                        <p class="text-muted small">${application.job.title}</p>
                        <hr>
                        <div class="text-start">
                            <p class="mb-2"><i class="bi bi-envelope me-2 text-primary"></i> ${application.candidate.user.email}</p>
                            <p class="mb-3"><i class="bi bi-telephone me-2 text-primary"></i> ${application.candidate.user.phone}</p>
                            <a href="${application.cvFile}" class="btn btn-outline-primary w-100 rounded-pill"><i class="bi bi-file-pdf me-2"></i>Xem CV gốc</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>