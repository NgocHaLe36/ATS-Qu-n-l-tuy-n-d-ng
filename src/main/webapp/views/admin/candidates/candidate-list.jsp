

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Ứng viên | ATS Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root {
            --primary-blue: #007bff;
            --bg-light: #f8fbff;
            --sidebar-width: 280px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: #333;
            overflow-x: hidden;
        }

        .text-blue { color: var(--primary-blue); }
        .bg-blue { background-color: var(--primary-blue); }

        .admin-sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background: #fff;
            border-right: 1px solid #eee;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-brand {
            padding: 20px;
            border-bottom: 1px solid #eee;
        }

        .sidebar-menu {
            padding: 15px 10px;
            list-style: none;
            margin: 0;
        }

        .sidebar-menu-title {
            font-size: 0.75rem;
            text-transform: uppercase;
            font-weight: 700;
            color: #999;
            margin: 20px 0 10px 15px;
            letter-spacing: 0.5px;
        }

        .sidebar-item {
            margin-bottom: 5px;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #555;
            text-decoration: none;
            font-weight: 500;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .sidebar-link:hover,
        .sidebar-link.active {
            background-color: rgba(0, 123, 255, 0.08);
            color: var(--primary-blue);
        }

        .sidebar-link i {
            margin-right: 12px;
            font-size: 1.2rem;
        }

        .admin-main {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .admin-header {
            background: #fff;
            padding: 15px 30px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .admin-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 15px;
            padding: 24px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.02);
        }

        /* Tùy chỉnh cho Table để không bị vỡ giao diện */
        .table > :not(caption) > * > * { 
            padding: 16px 12px; 
            border-bottom-color: #f1f5f9; 
            vertical-align: middle; 
        }
        .avatar-sm { 
            width: 42px; 
            height: 42px; 
            border-radius: 50%; 
            object-fit: cover; 
            /* Thêm flex-shrink-0 để ảnh không bị bóp méo khi text dài */
            flex-shrink: 0;
        }
        .badge-subtle { 
            padding: 6px 12px; 
            border-radius: 50px; 
            font-weight: 600; 
            font-size: 0.75rem; 
        }
        /* Class chống xuống dòng cho các cột ngắn */
        .text-nowrap-custom {
            white-space: nowrap;
        }
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
                <a href="${pageContext.request.contextPath}/admin/accounts" class="sidebar-link">
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
                <a href="${pageContext.request.contextPath}/admin/candidates" class="sidebar-link active">
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
                <form action="${pageContext.request.contextPath}/admin/candidates" method="GET" class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" name="keyword" value="${keyword}" class="border-0 bg-transparent shadow-none" placeholder="Tìm kiếm nhanh..." style="outline: none; width: 250px;">
                </form>
            </div>

            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                        <span class="fw-bold">
                            ${admin != null ? admin.fullName : 'Super Admin'}
                        </span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end border-0 shadow">
                        <li><a class="dropdown-item" href="#">Hồ sơ của tôi</a></li>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/change-password">Đổi mật khẩu</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-1">Quản lý Ứng viên</h3>
                    <p class="text-muted small mb-0">Xem và quản lý hồ sơ ứng viên trên hệ thống</p>
                </div>
                <button class="btn btn-outline-primary rounded-pill px-4 fw-medium"><i class="bi bi-download me-2"></i>Xuất Excel</button>
            </div>

            <div class="admin-card">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light text-muted small text-uppercase">
                            <tr>
                                <th class="border-0 rounded-start">Ứng viên</th>
                                <th class="border-0 text-nowrap-custom">Kinh nghiệm</th>
                                <th class="border-0">Kỹ năng chính</th>
                                <th class="border-0 text-nowrap-custom">Ngày tạo</th>
                                <th class="border-0 text-center text-nowrap-custom">Trạng thái</th>
                                <th class="border-0 rounded-end text-end text-nowrap-custom">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="c" items="${candidates}">
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <%-- Xử lý hiển thị Avatar: Sử dụng onerror để tự động thay thế ảnh mặc định nếu URL bị lỗi --%>
                                        <c:choose>
                                            <c:when test="${not empty c.avatar}">
                                                <img src="${c.avatar.startsWith('/') ? c.avatar : pageContext.request.contextPath.concat('/').concat(c.avatar)}" 
                                                     class="avatar-sm me-3" 
                                                     alt="Avatar"
                                                     onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${c.user.fullName}&background=007bff&color=fff';">
                                            </c:when>
                                            <c:otherwise>
                                                <img src="https://ui-avatars.com/api/?name=${c.user.fullName}&background=007bff&color=fff" class="avatar-sm me-3" alt="Avatar">
                                            </c:otherwise>
                                        </c:choose>
                                        
                                        <div>
                                            <h6 class="mb-0 fw-bold text-nowrap-custom">${c.user.fullName}</h6>
                                            <small class="text-muted text-nowrap-custom">${c.user.email}</small>
                                        </div>
                                    </div>
                                </td>
                                
                                <td class="text-nowrap-custom">${c.experienceYear} năm</td>
                                
                                <td>
                                    <%-- Tách kỹ năng bằng dấu phẩy và hiển thị dạng badge. Nếu nhiều quá thì hiển thị dạng chuỗi bình thường để không bị xấu --%>
                                    <div style="max-width: 250px; flex-wrap: wrap; display: flex; gap: 4px;">
                                        <c:forEach var="skill" items="${c.skills.split(',')}">
                                            <span class="badge bg-light text-dark border text-nowrap-custom">${skill.trim()}</span>
                                        </c:forEach>
                                    </div>
                                </td>
                                
                                <td class="text-muted small text-nowrap-custom">
                                    <%-- Cắt bớt đuôi mili-giây dài ngoằng T21:02:50.417 để giao diện sạch hơn --%>
                                    ${c.createdDate.toString().split('T')[0]}
                                </td>
                                
                                <td class="text-center text-nowrap-custom">
                                    <c:choose>
                                        <c:when test="${c.user.status}">
                                            <span class="badge-subtle bg-success bg-opacity-10 text-success">Hoạt động</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge-subtle bg-danger bg-opacity-10 text-danger">Bị khóa</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                
                                <td class="text-end text-nowrap-custom">
                                    <a href="${pageContext.request.contextPath}/admin/candidates/detail?id=${c.id}" class="btn btn-sm btn-light text-primary rounded-circle shadow-sm" title="Xem chi tiết"><i class="bi bi-eye"></i></a>
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