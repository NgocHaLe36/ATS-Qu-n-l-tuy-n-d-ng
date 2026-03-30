<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Việc làm đã ứng tuyển - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        body { font-family: 'Inter', sans-serif; background-color: #f0f2f5; margin: 0; }
        .sidebar { background: #fff; min-height: 100vh; position: fixed; width: 260px; border-right: 1px solid #e5e5e5; z-index: 1000; }
        .main-content { margin-left: 260px; padding: 25px; min-height: 100vh; }
        .nav-link { color: #606770; font-weight: 500; padding: 12px 20px; border-radius: 8px; margin: 4px 15px; display: block; text-decoration: none; }
        .nav-link.active { background-color: #e7f3ff; color: #007bff; }
        .nav-link:hover { background-color: #f2f3f5; }
        .data-card { border: none; border-radius: 12px; background: #fff; box-shadow: 0 1px 2px rgba(0,0,0,0.1); padding: 20px; }
        .top-bar { background: #fff; padding: 15px 30px; border-bottom: 1px solid #e5e5e5; margin-bottom: 25px; border-radius: 10px; }
    </style>
</head>
<body>
    <div class="sidebar py-3">
        <div class="px-4 mb-4 d-flex align-items-center"><i class="bi bi-building-fill text-primary fs-3 me-2"></i><span class="fw-bold fs-4 text-primary">ATS System</span></div>
        <nav class="nav flex-column">
            <a class="nav-link" href="${pageContext.request.contextPath}/home"><i class="bi bi-house-door-fill me-2"></i> Trang chủ</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/dashboard"><i class="bi bi-grid-fill me-2"></i> Dashboard</a>
            <a class="nav-link active" href="${pageContext.request.contextPath}/candidate/applied-jobs"><i class="bi bi-briefcase-fill me-2"></i> Việc làm đã ứng tuyển</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/profile"><i class="bi bi-person-fill me-2"></i> Hồ sơ cá nhân</a>
            <a class="nav-link" href="${pageContext.request.contextPath}/candidate/change-password"><i class="bi bi-shield-lock-fill me-2"></i> Đổi mật khẩu</a>
            <hr class="mx-3">
            <a class="nav-link text-danger" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a>
        </nav>
    </div>

    <div class="main-content">
        <div class="top-bar d-flex justify-content-between align-items-center shadow-sm">
            <h5 class="fw-bold mb-0 text-dark">Lịch sử ứng tuyển</h5>
            <div class="fw-medium">${sessionScope.currentUser.fullName} <img src="${sessionScope.currentUser.avatar}" class="rounded-circle ms-2" width="30"></div>
        </div>

        <div class="data-card">
            <table class="table align-middle">
                <thead><tr><th>Vị trí</th><th>Ngày nộp</th><th>Trạng thái</th><th class="text-end">Hành động</th></tr></thead>
                <tbody>
                    <c:forEach var="app" items="${applications}">
                        <tr>
                            <td>
                                <div class="fw-bold">${app.job.title}</div>
                                <small class="text-muted">${app.job.recruiter.fullName}</small>
                            </td>
                            <td><fmt:parseDate value="${app.applyDate}" pattern="yyyy-MM-dd'T'HH:mm" var="d"/><fmt:formatDate value="${d}" pattern="dd/MM/yyyy"/></td>
                            <td><span class="badge rounded-pill bg-primary-subtle text-primary px-3">${app.status}</span></td>
                            <td class="text-end"><a href="${pageContext.request.contextPath}/candidate/application-detail?id=${app.id}" class="btn btn-sm btn-outline-primary rounded-pill">Chi tiết</a></td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>