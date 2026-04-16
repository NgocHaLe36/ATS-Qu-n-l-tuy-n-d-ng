<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Việc làm đã ứng tuyển - ATS</title>
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
        .data-card { border: none; border-radius: 12px; background: #fff; box-shadow: 0 1px 2px rgba(0,0,0,0.1); padding: 25px; }
        
        /* Table Styles */
        .table th { font-weight: 600; color: #6c757d; border-bottom-width: 1px; padding-bottom: 15px; }
        .table td { vertical-align: middle; padding: 15px 10px; border-bottom-color: #f1f5f9; }
        .table tbody tr:hover { background-color: #f8fbff; }
        .table tbody tr:last-child td { border-bottom: none; }
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
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/applied-jobs">
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
            <h5 class="fw-bold mb-0">Lịch sử ứng tuyển</h5>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-medium">${sessionScope.currentUser.fullName}</span>
                <img src="${empty sessionScope.currentUser.avatar ? 'https://ui-avatars.com/api/?name='.concat(sessionScope.currentUser.fullName) : sessionScope.currentUser.avatar}" class="avatar-small">
            </div>
        </div>

        <c:if test="${not empty warningMessage}">
            <div class="alert alert-warning alert-dismissible fade show border-0 shadow-sm mb-4" role="alert">
                <i class="bi bi-exclamation-triangle-fill me-2"></i>${warningMessage}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                <% session.removeAttribute("warningMessage"); %>
            </div>
        </c:if>

        <div class="data-card shadow-sm">
            <div class="table-responsive">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th scope="col">Vị trí ứng tuyển</th>
                            <th scope="col">Ngày nộp</th>
                            <th scope="col">Trạng thái</th>
                            <th scope="col" class="text-end">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="app" items="${applications}">
                            <tr>
                                <td>
                                    <div class="fw-bold text-dark">
                                        <a href="${pageContext.request.contextPath}/candidate/application-detail?id=${app.id}" class="text-dark text-decoration-none">${app.job.title}</a>
                                    </div>
                                    <small class="text-muted"><i class="bi bi-building me-1"></i>${app.job.recruiter.fullName}</small>
                                </td>
                                <td>
                                    <fmt:parseDate value="${app.applyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="appDate"/>
                                    <span class="text-muted small"><fmt:formatDate value="${appDate}" pattern="dd/MM/yyyy HH:mm"/></span>
                                </td>
                                <td>
                                    <%-- Format màu Status đồng bộ với Dashboard --%>
                                    <c:choose>
                                        <c:when test="${app.status == 'APPLIED'}"><span class="badge rounded-pill bg-primary-subtle text-primary px-3 py-2">Đã nộp</span></c:when>
                                        <c:when test="${app.status == 'REVIEWING'}"><span class="badge rounded-pill bg-warning-subtle text-warning px-3 py-2">Đang xét duyệt</span></c:when>
                                        <c:when test="${app.status == 'INTERVIEW'}"><span class="badge rounded-pill bg-info-subtle text-info px-3 py-2">Phỏng vấn</span></c:when>
                                        <c:when test="${app.status == 'ACCEPTED'}"><span class="badge rounded-pill bg-success-subtle text-success px-3 py-2">Trúng tuyển</span></c:when>
                                        <c:when test="${app.status == 'REJECTED'}"><span class="badge rounded-pill bg-danger-subtle text-danger px-3 py-2">Từ chối</span></c:when>
                                        <c:when test="${app.status == 'WITHDRAWN'}"><span class="badge rounded-pill bg-secondary-subtle text-secondary px-3 py-2">Đã rút hồ sơ</span></c:when>
                                        <c:otherwise><span class="badge rounded-pill bg-light text-dark px-3 py-2">${app.status}</span></c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="text-end">
                                    <a href="${pageContext.request.contextPath}/candidate/application-detail?id=${app.id}" class="btn btn-sm btn-outline-primary rounded-pill px-3 fw-bold">Chi tiết</a>
                                </td>
                            </tr>
                        </c:forEach>
                        
                        <%-- Xử lý hiển thị khi chưa nộp đơn nào --%>
                        <c:if test="${empty applications}">
                            <tr>
                                <td colspan="4" class="text-center py-5">
                                    <i class="bi bi-inbox fs-1 text-muted opacity-25"></i>
                                    <p class="text-muted small mt-3 mb-0">Bạn chưa nộp đơn ứng tuyển nào.</p>
                                    <a href="${pageContext.request.contextPath}/jobs" class="btn btn-primary btn-sm rounded-pill px-4 mt-3">Tìm việc ngay</a>
                                </td>
                            </tr>
                        </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>