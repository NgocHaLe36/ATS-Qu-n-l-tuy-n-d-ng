<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ATS - Bảng điều khiển ứng viên</title>
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
        /* Stats & Cards */
        .stat-card { border: none; border-radius: 12px; box-shadow: 0 1px 2px rgba(0,0,0,0.1); padding: 20px; background: #fff; }
        .top-nav { background: #fff; padding: 15px 30px; border-bottom: 1px solid #e5e5e5; margin-bottom: 25px; border-radius: 10px; }
        .avatar-small { width: 35px; height: 35px; border-radius: 50%; object-fit: cover; }
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/dashboard">
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
        <div class="top-nav d-flex justify-content-between align-items-center shadow-sm">
            <h5 class="fw-bold mb-0">Bảng điều khiển</h5>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-medium">${sessionScope.currentUser.fullName}</span>
                <img src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="avatar-small">
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h3 class="fw-bold mb-0 text-primary">${totalApplications}</h3>
                            <small class="text-muted">Tổng đơn ứng tuyển</small>
                        </div>
                        <i class="bi bi-file-earmark-text fs-1 text-primary opacity-25"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h3 class="fw-bold mb-0 text-warning">${reviewingCount}</h3>
                            <small class="text-muted">Đang xét duyệt</small>
                        </div>
                        <i class="bi bi-clock-history fs-1 text-warning opacity-25"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h3 class="fw-bold mb-0 text-info">${interviewedCount}</h3>
                            <small class="text-muted">Lịch phỏng vấn</small>
                        </div>
                        <i class="bi bi-calendar-event fs-1 text-info opacity-25"></i>
                    </div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="stat-card">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h3 class="fw-bold mb-0 text-success">${acceptedCount}</h3>
                            <small class="text-muted">Đã trúng tuyển</small>
                        </div>
                        <i class="bi bi-check-circle fs-1 text-success opacity-25"></i>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-md-8">
                <div class="stat-card mb-4 shadow-sm">
                    <h5 class="fw-bold mb-4">Ứng tuyển gần đây</h5>
                    <div class="list-group list-group-flush">
                        <c:forEach var="app" items="${latestApplications}">
                            <div class="list-group-item px-0 py-3 d-flex justify-content-between align-items-center">
                                <div>
                                    <h6 class="fw-bold mb-1">${app.job.title}</h6>
                                    <p class="small text-muted mb-0"><i class="bi bi-building me-1"></i>${app.job.recruiter.fullName}</p>
                                </div>
                                <div class="text-end">
                                    <span class="badge rounded-pill bg-primary-subtle text-primary mb-1">${app.status}</span>
                                    <p class="small text-muted mb-0">
                                        <fmt:parseDate value="${app.applyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="pDate"/>
                                        <fmt:formatDate value="${pDate}" pattern="dd/MM/yyyy"/>
                                    </p>
                                </div>
                            </div>
                        </c:forEach>
                        <c:if test="${empty latestApplications}">
                            <p class="text-muted small text-center py-3">Bạn chưa nộp đơn ứng tuyển nào.</p>
                        </c:if>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="stat-card shadow-sm">
                    <h5 class="fw-bold mb-3">Gợi ý cho bạn</h5>
                    <c:forEach var="job" items="${featuredJobs}">
                        <div class="mb-3 pb-3 border-bottom last-child-border-0">
                            <a href="${pageContext.request.contextPath}/job-detail?id=${job.id}" class="text-decoration-none">
                                <h6 class="text-primary fw-bold mb-1">${job.title}</h6>
                                <small class="text-muted d-block mb-1"><i class="bi bi-geo-alt me-1"></i>${job.location}</small>
                                <strong class="text-danger small"><fmt:formatNumber value="${job.salary}" type="number"/> VNĐ</strong>
                            </a>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>