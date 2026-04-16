<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý tin tuyển dụng - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar layout */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        
        /* Logout Area */
        .logout-area { padding: 20px; border-top: 1px solid #eee; margin-top: auto; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }

        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        .admin-card { background: #fff; border: 1px solid #edf2f7; border-radius: 15px; padding: 24px; box-shadow: 0 5px 20px rgba(0,0,0,0.02); margin-bottom: 24px; }
        .btn-action { width: 35px; height: 35px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; border: 1px solid #eee; color: #555; transition: 0.2s; text-decoration: none; background: #fff; }
        .btn-action:hover { transform: translateY(-2px); box-shadow: 0 4px 8px rgba(0,0,0,0.1); color: var(--primary-blue); border-color: var(--primary-blue); }
        
        /* Màu sắc nhãn trạng thái đồng bộ */
        .badge-status { padding: 6px 14px; border-radius: 50px; font-weight: 700; font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.5px; }
        .badge-dot { width: 8px; height: 8px; border-radius: 50%; display: inline-block; margin-right: 6px; }
        
        .status-open { background-color: #e8f5e9 !important; color: #2e7d32 !important; }
        .status-closed { background-color: #ffebee !important; color: #c62828 !important; }
        .status-hidden { background-color: #f1f5f9 !important; color: #475569 !important; border: 1px solid #e2e8f0; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand">
            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="d-flex align-items-center">
                <i class="bi bi-rocket-takeoff-fill text-primary me-2 fs-3"></i>
                <span class="fw-bold fs-4 text-primary">ATS Recruiter</span>
            </a>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link active"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link"><i class="bi bi-credit-card"></i> Lịch sử thanh toán</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
        </ul>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout"><i class="bi bi-box-arrow-right me-2"></i> <span>Đăng xuất</span></a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <h5 class="fw-bold mb-0 text-dark">Quản lý tin tuyển dụng</h5>
            <div class="d-flex align-items-center">
                <span class="fw-bold small me-2 text-muted">${currentUser.fullName}</span>
                <div class="bg-primary text-white rounded-circle d-flex align-items-center justify-content-center fw-bold" style="width: 35px; height: 35px; font-size: 0.8rem;">
                    ${currentUser.fullName.substring(0,2).toUpperCase()}
                </div>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="admin-card">
                <form action="${pageContext.request.contextPath}/recruiter/jobs" method="get" class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-muted text-uppercase">Tìm kiếm</label>
                        <input type="text" name="keyword" class="form-control" placeholder="Tiêu đề công việc..." value="${keyword}">
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold text-muted text-uppercase">Trạng thái</label>
                        <select name="status" class="form-select">
                            <option value="all">Tất cả trạng thái</option>
                            <option value="OPEN" ${status == 'OPEN' || status == 'active' ? 'selected' : ''}>Đang mở</option>
                            <option value="CLOSED" ${status == 'CLOSED' || status == 'closed' ? 'selected' : ''}>Đã đóng</option>
                            <option value="HIDDEN" ${status == 'HIDDEN' ? 'selected' : ''}>Đang ẩn</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <label class="form-label small fw-bold text-muted text-uppercase">Loại tin</label>
                        <select name="vip" class="form-select">
                            <option value="all">Tất cả loại tin</option>
                            <option value="true" ${vip == 'true' ? 'selected' : ''}>Tin VIP</option>
                            <option value="false" ${vip == 'false' ? 'selected' : ''}>Tin thường</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100 fw-bold py-2 shadow-sm">Lọc</button>
                    </div>
                </form>
            </div>

            <div class="admin-card p-0 overflow-hidden shadow-sm">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light text-muted small uppercase">
                            <tr>
                                <th class="ps-4">Thông tin tuyển dụng</th>
                                <th>Ngày đăng</th>
                                <th>Hạn chót</th>
                                <th>Trạng thái</th>
                                <th class="text-center">VIP</th>
                                <th class="text-end pe-4">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="j" items="${jobs}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="fw-bold text-dark fs-6">${j.title}</div>
                                        <div class="text-muted small"><i class="bi bi-geo-alt me-1"></i>${j.location}</div>
                                    </td>
                                    <td><span class="small text-muted"><fmt:parseDate value="${j.createdDate}" pattern="yyyy-MM-dd" var="cDate" /><fmt:formatDate value="${cDate}" pattern="dd/MM/yyyy" /></span></td>
                                    <td><span class="small fw-bold"><fmt:parseDate value="${j.deadline}" pattern="yyyy-MM-dd" var="dDate" /><fmt:formatDate value="${dDate}" pattern="dd/MM/yyyy" /></span></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${j.status == 'active' || j.status == 'OPEN'}">
                                                <span class="badge-status status-open"><span class="badge-dot" style="background-color: #10b981;"></span>Đang mở</span>
                                            </c:when>
                                            <c:when test="${j.status == 'HIDDEN'}">
                                                <span class="badge-status status-hidden"><span class="badge-dot" style="background-color: #64748b;"></span>Tạm ẩn</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-status status-closed"><span class="badge-dot" style="background-color: #ef4444;"></span>Đã đóng</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center"><c:if test="${j.isVip}"><i class="bi bi-patch-check-fill text-warning fs-5"></i></c:if></td>
                                    <td class="text-end pe-4">
                                        <div class="d-flex justify-content-end gap-2">
                                            <a href="${pageContext.request.contextPath}/recruiter/jobs/detail?id=${j.id}" class="btn-action" title="Ứng viên"><i class="bi bi-people text-primary"></i></a>
                                            <a href="${pageContext.request.contextPath}/recruiter/jobs/edit?id=${j.id}" class="btn-action" title="Sửa"><i class="bi bi-pencil-square text-warning"></i></a>
                                            <form action="${pageContext.request.contextPath}/recruiter/jobs/delete" method="post" onsubmit="return confirm('Xóa tin tuyển dụng này?')" style="display:inline;">
                                                <input type="hidden" name="id" value="${j.id}">
                                                <button type="submit" class="btn-action border-0 shadow-none"><i class="bi bi-trash text-danger"></i></button>
                                            </form>
                                        </div>
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