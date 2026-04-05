<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Nhà Tuyển Dụng - ATS Admin</title>
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
        
        .table > :not(caption) > * > * { padding: 16px 12px; vertical-align: middle; }
        .avatar-sm { width: 40px; height: 40px; border-radius: 10px; object-fit: cover; }
        .badge-status { padding: 6px 12px; border-radius: 50px; font-size: 0.75rem; font-weight: 600; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Admin</span>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">
                    <i class="bi bi-grid-1x2-fill"></i> Tổng quan
                </a>
            </li>

            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/staff" class="sidebar-link">
                    <i class="bi bi-person-badge"></i> Quản lý nhân viên
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link">
                    <i class="bi bi-shield-lock"></i> Quản lý tài khoản
                </a>
            </li>

            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/recruiters" class="sidebar-link active">
                    <i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/candidates" class="sidebar-link">
                    <i class="bi bi-people"></i> Quản lý ứng viên
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/jobs" class="sidebar-link">
                    <i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/recruitment-results" class="sidebar-link">
                    <i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng
                </a>
            </li>

            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/vip-plans" class="sidebar-link">
                    <i class="bi bi-gem"></i> Quản lý gói VIP
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/transactions" class="sidebar-link">
                    <i class="bi bi-cash-stack"></i> Quản lý giao dịch
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link">
                    <i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng
                </a>
            </li>

            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link">
                    <i class="bi bi-key"></i> Đổi mật khẩu
                </a>
            </li>
            <li class="sidebar-item mt-3">
                <a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10">
                    <i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất
                </a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <form action="${pageContext.request.contextPath}/admin/recruiters" method="GET" class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" name="keyword" class="border-0 bg-transparent outline-none" placeholder="Tìm tên công ty..." style="width: 250px;" value="${param.keyword}">
                </form>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=${admin.fullName}&background=007bff&color=fff" class="rounded-circle me-2" width="40">
                        <span class="fw-bold">${admin.fullName}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end border-0 shadow">
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-1">Nhà Tuyển Dụng</h3>
                    <p class="text-muted small">Quản lý các công ty đang sử dụng hệ thống</p>
                </div>
            </div>

            <div class="admin-card">
                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="bg-light text-muted small text-uppercase">
                            <tr>
                                <th>Nhà Tuyển Dụng</th>
                                <th>Số điện thoại</th>
                                <th>Ngày tham gia</th>
                                <th>Trạng thái</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="r" items="${recruiters}">
                                <tr>
                                    <td>
                                        <div class="d-flex align-items-center">
                                            <img src="https://ui-avatars.com/api/?name=${r.fullName}&background=random" class="avatar-sm me-3" alt="Logo">
                                            <div>
                                                <h6 class="mb-0 fw-bold">${r.fullName}</h6>
                                                <small class="text-muted">${r.email}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>${r.phone != null ? r.phone : 'Chưa cập nhật'}</td>
                                    <td>${r.createdDate.toLocalDate()}</td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${r.status}">
                                                <span class="badge-status bg-success bg-opacity-10 text-success">Hoạt động</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-status bg-danger bg-opacity-10 text-danger">Bị khóa</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center">
                                        <div class="d-flex justify-content-center gap-2">
                                            <a href="${pageContext.request.contextPath}/admin/recruiters/detail?id=${r.id}" class="btn btn-sm btn-light text-primary rounded-circle">
                                                <i class="bi bi-eye"></i>
                                            </a>
                                            <form action="${pageContext.request.contextPath}/admin/recruiters/${r.status ? 'lock' : 'unlock'}" method="POST" class="d-inline">
                                                <input type="hidden" name="id" value="${r.id}">
                                                <button type="submit" class="btn btn-sm btn-light ${r.status ? 'text-danger' : 'text-success'} rounded-circle" 
                                                        onclick="return confirm('Xác nhận thay đổi trạng thái tài khoản?')">
                                                    <i class="bi ${r.status ? 'bi-lock' : 'bi-unlock'}"></i>
                                                </button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty recruiters}">
                                <tr>
                                    <td colspan="5" class="text-center py-4 text-muted">Không tìm thấy dữ liệu nhà tuyển dụng.</td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>