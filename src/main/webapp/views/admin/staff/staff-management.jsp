<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý nhân viên - ATS Admin</title>

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
                <a href="${pageContext.request.contextPath}/admin/staff-management" class="sidebar-link active">
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
                <a href="${pageContext.request.contextPath}/admin/recruiters" class="sidebar-link">
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
                <form action="${pageContext.request.contextPath}/admin/staff-management" method="GET" class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" name="keyword" class="border-0 bg-transparent" placeholder="Tìm kiếm nhân viên..." style="outline: none; width: 250px;" value="${param.keyword}">
                </form>
            </div>

            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/admin/create-staff" class="btn btn-outline-primary rounded-pill px-4 fw-bold">
                    <i class="bi bi-person-plus-fill me-2"></i>Tạo tài khoản mới
                </a>
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
            <div class="mb-4">
                <h3 class="fw-bold mb-1">Danh sách nhân viên</h3>
                <p class="text-muted">Quản lý các tài khoản nhân viên vận hành hệ thống.</p>
            </div>

            <div class="admin-card">
                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead>
                            <tr class="text-muted small text-uppercase">
                                <th>Nhân viên</th>
                                <th>Email/SĐT</th>
                                <th>Vai trò</th>
                                <th>Trạng thái</th>
                                <th class="text-center">Thao tác</th>
                            </tr>
                        </thead>
<a href="${pageContext.request.contextPath}/admin/staff/create" class="btn btn-primary rounded-pill px-4 fw-bold shadow-sm">
    <i class="bi bi-person-plus-fill me-2"></i>Thêm nhân sự mới
</a>

<tbody>
    <c:forEach var="s" items="${staffList}">
        <tr>
            <td>
                <div class="d-flex align-items-center">
                    <img src="https://ui-avatars.com/api/?name=${s.fullName}&background=random" class="rounded-circle me-3" width="40">
                    <div class="fw-bold text-dark">${s.fullName}</div>
                </div>
            </td>
            <td>
                <div class="text-dark small">${s.email}</div>
                <div class="text-muted small">${s.phone}</div>
            </td>
            <td><span class="badge bg-primary bg-opacity-10 text-primary">${s.role}</span></td>
            <td>
                <c:choose>
                    <c:when test="${s.status}">
                        <span class="badge bg-success bg-opacity-10 text-success px-3 py-1 rounded-pill">Hoạt động</span>
                    </c:when>
                    <c:otherwise>
                        <span class="badge bg-danger bg-opacity-10 text-danger px-3 py-1 rounded-pill">Đang khóa</span>
                    </c:otherwise>
                </c:choose>
            </td>
            <td class="text-center">
                <a href="${pageContext.request.contextPath}/admin/staff/edit?id=${s.id}" class="btn btn-sm btn-light text-primary rounded-circle">
                    <i class="bi bi-pencil-square"></i>
                </a>

                <c:choose>
                    <c:when test="${s.status}">
                        <form action="${pageContext.request.contextPath}/admin/staff/lock" method="POST" class="d-inline" onsubmit="return confirm('Bạn có chắc muốn khóa nhân viên này?')">
                            <input type="hidden" name="id" value="${s.id}">
                            <button type="submit" class="btn btn-sm btn-light text-warning rounded-circle ms-1"><i class="bi bi-lock-fill"></i></button>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <form action="${pageContext.request.contextPath}/admin/staff/unlock" method="POST" class="d-inline">
                            <input type="hidden" name="id" value="${s.id}">
                            <button type="submit" class="btn btn-sm btn-light text-success rounded-circle ms-1"><i class="bi bi-unlock-fill"></i></button>
                        </form>
                    </c:otherwise>
                </c:choose>

                <form action="${pageContext.request.contextPath}/admin/staff/delete" method="POST" class="d-inline" onsubmit="return confirm('Xóa vĩnh viễn nhân viên này?')">
                    <input type="hidden" name="id" value="${s.id}">
                    <button type="submit" class="btn btn-sm btn-light text-danger rounded-circle ms-1"><i class="bi bi-trash-fill"></i></button>
                </form>
            </td>
        </tr>
    </c:forEach>
</tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>