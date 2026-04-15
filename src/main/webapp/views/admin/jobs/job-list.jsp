<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Tin Tuyển Dụng | ATS Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; overflow-x: hidden; }
        .text-blue { color: var(--primary-blue); }
        .bg-blue { background-color: var(--primary-blue); }
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
        .table > :not(caption) > * > * { padding: 16px 12px; border-bottom-color: #f1f5f9; vertical-align: middle; }
        .badge-status { padding: 6px 12px; border-radius: 50px; font-weight: 600; font-size: 0.75rem; }
        .search-box { width: 300px; }
        .text-nowrap-custom { white-space: nowrap; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Admin</span>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>

            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/staff" class="sidebar-link"><i class="bi bi-person-badge"></i> Quản lý nhân viên</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/accounts" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>

            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruiters" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/candidates" class="sidebar-link"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/jobs" class="sidebar-link active"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruitment-results" class="sidebar-link"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>

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
                <form action="${pageContext.request.contextPath}/admin/jobs" method="GET" class="d-flex gap-2">
                    <div class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border search-box">
                        <i class="bi bi-search text-muted me-2"></i>
                        <input type="text" name="keyword" class="border-0 bg-transparent w-100" placeholder="Tìm tên công việc, địa điểm..." style="outline: none;" value="${keyword}">
                    </div>
                    <select name="status" class="form-select rounded-pill border bg-light" onchange="this.form.submit()" style="width: auto; box-shadow: none;">
                        <option value="">Tất cả trạng thái</option>
                        <option value="OPEN" ${status == 'OPEN' ? 'selected' : ''}>Đang mở</option>
                        <option value="PENDING" ${status == 'PENDING' ? 'selected' : ''}>Chờ duyệt</option>
                        <option value="REJECTED" ${status == 'REJECTED' ? 'selected' : ''}>Từ chối/Đóng</option>
                    </select>
                </form>
            </div>

            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                        <span class="fw-bold">${admin != null ? admin.fullName : 'Super Admin'}</span>
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

        <div class="container-fluid p-4 flex-grow-1">
            <div class="mb-4">
                <h3 class="fw-bold mb-1">Quản lý Tin Tuyển Dụng</h3>
                <p class="text-muted">Xem, duyệt và quản lý các bài đăng tuyển dụng từ doanh nghiệp.</p>
            </div>

            <div class="admin-card">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light">
                            <tr class="text-muted small text-uppercase">
                                <th class="border-0 pb-3">Tin tuyển dụng</th>
                                <th class="border-0 pb-3">Công ty (Recruiter)</th>
                                <th class="border-0 pb-3">Mức lương</th>
                                <th class="border-0 pb-3">Hạn nộp</th>
                                <th class="border-0 pb-3 text-center">Trạng thái</th>
                                <th class="border-0 pb-3 text-end">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="job" items="${jobs}">
                                <tr>
                                    <td>
                                        <div class="fw-bold text-primary mb-1">${job.title}</div>
                                        <div class="small text-muted d-flex align-items-center">
                                            <i class="bi bi-geo-alt me-1"></i> ${job.location}
                                            <c:if test="${job.isVip}">
                                                <span class="badge bg-warning text-dark ms-2" style="font-size: 0.6rem; border-radius: 4px;">VIP</span>
                                            </c:if>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="fw-medium">${job.recruiter.fullName}</div>
                                    </td>
                                    <td class="fw-medium text-success text-nowrap-custom">
                                        <fmt:formatNumber value="${job.salary}" type="number" groupingUsed="true"/> VNĐ
                                    </td>
                                    <td class="text-nowrap-custom">
                                        ${job.deadline.toString().split('T')[0]}
                                    </td>
                                    <td class="text-center text-nowrap-custom">
                                        <c:choose>
                                            <c:when test="${job.status == 'OPEN'}"><span class="badge-status bg-success bg-opacity-10 text-success">Đang mở</span></c:when>
                                            <c:when test="${job.status == 'PENDING'}"><span class="badge-status bg-warning bg-opacity-10 text-warning">Chờ duyệt</span></c:when>
                                            <c:when test="${job.status == 'REJECTED'}"><span class="badge-status bg-danger bg-opacity-10 text-danger">Từ chối</span></c:when>
                                            <c:otherwise><span class="badge-status bg-secondary bg-opacity-10 text-secondary">${job.status}</span></c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end text-nowrap-custom">
                                        <a href="${pageContext.request.contextPath}/admin/jobs/detail?id=${job.id}" class="btn btn-sm btn-light text-primary rounded-circle" title="Xem chi tiết">
                                            <i class="bi bi-eye"></i>
                                        </a>
                                        
                                        <c:if test="${job.status == 'PENDING' || job.status == 'REJECTED'}">
                                            <form action="${pageContext.request.contextPath}/admin/jobs/approve" method="POST" class="d-inline">
                                                <input type="hidden" name="id" value="${job.id}">
                                                <button type="submit" class="btn btn-sm btn-light text-success rounded-circle ms-1" title="Duyệt bài"><i class="bi bi-check-lg"></i></button>
                                            </form>
                                        </c:if>
                                        
                                        <c:if test="${job.status == 'PENDING' || job.status == 'OPEN'}">
                                            <form action="${pageContext.request.contextPath}/admin/jobs/reject" method="POST" class="d-inline">
                                                <input type="hidden" name="id" value="${job.id}">
                                                <button type="submit" class="btn btn-sm btn-light text-danger rounded-circle ms-1" title="Đóng/Từ chối" onclick="return confirm('Bạn có chắc muốn đóng/từ chối tin này?');">
                                                    <i class="bi bi-x-lg"></i>
                                                </button>
                                            </form>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                            
                            <c:if test="${empty jobs}">
                                <tr>
                                    <td colspan="6" class="text-center py-4 text-muted">Không tìm thấy dữ liệu tuyển dụng nào.</td>
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