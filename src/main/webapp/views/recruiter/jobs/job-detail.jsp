<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết công việc: ${job.title} - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #1e293b; margin: 0; }
        
        /* Sidebar Styling - Đồng bộ Dashboard */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        
        .logout-area { padding: 20px; border-top: 1px solid #eee; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }
        .btn-logout:hover { background-color: #dc3545; color: #fff !important; }

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        .job-header-card { background: #fff; border: 1px solid #edf2f7; border-radius: 16px; }
        .info-card { border-radius: 15px; border: 1px solid #edf2f7; background: #fff; box-shadow: 0 5px 20px rgba(0,0,0,0.02); }
        .section-title { font-weight: 700; font-size: 0.85rem; color: #64748b; text-transform: uppercase; letter-spacing: 0.05rem; }
        .status-badge { padding: 6px 12px; border-radius: 50px; font-weight: 700; font-size: 0.75rem; }
        .candidate-table thead { background: #f8fbff; }
        .candidate-table th { font-weight: 700; font-size: 0.75rem; color: #94a3b8; text-transform: uppercase; border: none; }
        .sticky-sidebar { position: sticky; top: 100px; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <%-- 1. Link Logo quay về Dashboard --%>
        <div class="sidebar-brand">
            <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="d-flex align-items-center">
                <i class="bi bi-rocket-takeoff-fill text-primary me-2 fs-3"></i>
                <span class="fw-bold fs-4 text-primary">ATS Recruiter</span>
            </a>
        </div>
        
        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <%-- 2. Cập nhật link Sidebar đầy đủ --%>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link active"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            <div class="sidebar-menu-title">Tài khoản</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
        </ul>
        
        <%-- 3. Đồng bộ nút Đăng xuất Sidebar --%>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right me-2"></i> <span>Đăng xuất</span>
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/recruiter/jobs" class="btn btn-link text-dark p-0 me-3 shadow-none">
                    <i class="bi bi-arrow-left fs-4"></i>
                </a>
                <h5 class="fw-bold mb-0 text-dark">Chi tiết tin đăng</h5>
            </div>
            <div class="dropdown">
                <button class="btn btn-link text-dark text-decoration-none dropdown-toggle d-flex align-items-center p-0 border-0" data-bs-toggle="dropdown">
                    <div class="bg-primary text-white rounded-circle me-2 d-flex align-items-center justify-content-center" style="width: 35px; height: 35px; font-weight: bold; font-size: 0.8rem;">
                        ${currentUser.fullName.substring(0,2).toUpperCase()}
                    </div>
                    <span class="fw-bold small">${currentUser.fullName}</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/recruiter/account/profile"><i class="bi bi-person me-2"></i> Hồ sơ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger py-2" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                </ul>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="job-header-card p-4 mb-4 shadow-sm bg-white">
                <div class="d-flex justify-content-between align-items-start flex-wrap gap-3">
                    <div class="d-flex align-items-center">
                        <div class="bg-primary bg-opacity-10 p-3 rounded-4 me-3 text-primary">
                            <i class="bi bi-briefcase-fill fs-3"></i>
                        </div>
                        <div>
                            <h2 class="fw-bold mb-1">${job.title}</h2>
                            <div class="d-flex align-items-center gap-3">
                                <span class="text-muted small"><i class="bi bi-geo-alt me-1"></i>${job.location}</span>
                                <span class="text-muted small"><i class="bi bi-cash-stack me-1"></i>
                                    <c:choose>
                                        <c:when test="${job.salary > 0}"><fmt:formatNumber value="${job.salary}" type="number"/> VNĐ</c:when>
                                        <c:otherwise>Thỏa thuận</c:otherwise>
                                    </c:choose>
                                </span>
                                <c:choose>
                                    <c:when test="${job.status == 'OPEN' || job.status == 'active'}"><span class="status-badge bg-success bg-opacity-10 text-success px-3">ĐANG TUYỂN</span></c:when>
                                    <c:when test="${job.status == 'HIDDEN'}"><span class="status-badge bg-secondary bg-opacity-10 text-secondary px-3">ĐANG ẨN</span></c:when>
                                    <c:otherwise><span class="status-badge bg-danger bg-opacity-10 text-danger px-3">${job.status}</span></c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                    <div class="d-flex gap-2">
                        <a href="${pageContext.request.contextPath}/recruiter/jobs/edit?id=${job.id}" class="btn btn-warning fw-bold px-4 rounded-pill shadow-sm text-dark border-0">
                            <i class="bi bi-pencil-square me-2"></i> Chỉnh sửa tin
                        </a>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="info-card p-4 mb-4">
                        <div class="mb-4">
                            <h6 class="section-title mb-3"><i class="bi bi-file-earmark-text me-2 text-primary"></i>Mô tả công việc</h6>
                            <div class="text-dark lh-lg" style="white-space: pre-line;">${job.description}</div>
                        </div>
                        <hr class="my-4 opacity-10">
                        <div class="mb-2">
                            <h6 class="section-title mb-3"><i class="bi bi-person-check me-2 text-primary"></i>Yêu cầu ứng viên</h6>
                            <div class="text-dark lh-lg" style="white-space: pre-line;">${job.requirement}</div>
                        </div>
                    </div>

                    <div class="info-card p-0 overflow-hidden mb-4">
                        <div class="p-4 border-bottom d-flex justify-content-between align-items-center">
                            <h6 class="section-title mb-0"><i class="bi bi-people me-2 text-primary"></i>Danh sách ứng tuyển (${applications.size()})</h6>
                            <a href="${pageContext.request.contextPath}/recruiter/pipeline?jobId=${job.id}" class="btn btn-sm btn-link text-decoration-none fw-bold">Xem tất cả</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table candidate-table align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th class="ps-4">Ứng viên</th>
                                        <th>Ngày nộp</th>
                                        <th class="text-center">Trạng thái</th>
                                        <th class="text-end pe-4">Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="app" items="${applications}">
                                        <tr>
                                            <td class="ps-4 py-3">
                                                <div class="d-flex align-items-center">
                                                    <div class="bg-primary text-white rounded-circle me-3 fw-bold d-flex align-items-center justify-content-center" style="width:35px; height:35px; font-size: 0.8rem;">
                                                        ${app.candidate.user.fullName.substring(0,1).toUpperCase()}
                                                    </div>
                                                    <div>
                                                        <span class="fw-bold d-block text-dark">${app.candidate.user.fullName}</span>
                                                        <small class="text-muted">${app.candidate.user.email}</small>
                                                    </div>
                                                </div>
                                            </td>
                                            <td class="text-muted small">
                                                ${app.applyDate.dayOfMonth}/${app.applyDate.monthValue}/${app.applyDate.year}
                                            </td>
                                            <td class="text-center">
                                                <span class="badge rounded-pill bg-light text-dark border px-3 fw-bold">${app.status}</span>
                                            </td>
                                            <td class="text-end pe-4">
                                                <%-- 4. Cập nhật link dẫn đến trang chi tiết ứng viên --%>
                                                <a href="${pageContext.request.contextPath}/recruiter/candidates/detail?id=${app.id}" class="btn btn-sm btn-outline-primary px-3 rounded-pill fw-bold">
                                                    Xem hồ sơ
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                    <c:if test="${empty applications}">
                                        <tr><td colspan="4" class="text-center py-5 text-muted fst-italic">Hiện tại chưa có hồ sơ nào nộp vào vị trí này.</td></tr>
                                    </c:if>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="sticky-sidebar">
                        <div class="info-card p-4 mb-4 border-primary border-opacity-10 text-center bg-white">
                            <h6 class="section-title mb-3">Hiệu quả tuyển dụng</h6>
                            <div class="display-4 fw-bold text-primary mb-1">${applications.size()}</div>
                            <p class="text-muted small mb-3 fw-medium">Tổng số hồ sơ đã nhận</p>
                            <div class="progress mb-3 shadow-sm" style="height: 8px; border-radius: 10px;">
                                <div class="progress-bar progress-bar-striped progress-bar-animated" style="width: 100%"></div>
                            </div>
                            <div class="d-flex justify-content-between align-items-center p-3 bg-light rounded-3">
                                <span class="text-muted fw-bold small uppercase">Hạn chót:</span>
                                <span class="fw-bold text-danger">
                                    ${job.deadline.dayOfMonth}/${job.deadline.monthValue}/${job.deadline.year}
                                </span>
                            </div>
                        </div>
                        
                        <div class="info-card p-4 bg-primary bg-opacity-10 border-0">
                            <h6 class="section-title mb-3 text-primary">Thông tin hiển thị</h6>
                            <ul class="small text-dark ps-3 mb-0 lh-lg">
                                <li>Trạng thái <strong>OPEN</strong>: Công khai và cho phép ứng tuyển.</li>
                                <li>Trạng thái <strong>HIDDEN</strong>: Chỉ nhà tuyển dụng mới thấy tin.</li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>