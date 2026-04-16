<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách ứng viên - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; overflow-x: hidden; }
        
        /* Sidebar Styling */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }

        /* Logout Area */
        .logout-area { padding: 20px; border-top: 1px solid #eee; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }
        .btn-logout:hover { background-color: #dc3545; color: #fff !important; }

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; display: flex; flex-direction: column; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; }
        
        .admin-card { background: #fff; border: 1px solid #edf2f7; border-radius: 15px; padding: 24px; box-shadow: 0 5px 20px rgba(0,0,0,0.02); margin-bottom: 24px; }
        .filter-input { border-radius: 10px; border: 1px solid #e2e8f0; padding: 10px 15px; }
        .candidate-avatar { width: 45px; height: 45px; border-radius: 10px; object-fit: cover; }
        
        .table > :not(caption) > * > * { padding: 16px 12px; border-bottom-color: #f1f5f9; vertical-align: middle; }
        .badge-status { padding: 6px 12px; border-radius: 50px; font-weight: 700; font-size: 0.7rem; text-transform: uppercase; display: inline-block; letter-spacing: 0.5px; }
        
        .status-applied { background: #e0f2fe; color: #0369a1; }
        .status-interviewing { background: #fef3c7; color: #92400e; }
        .status-accepted { background: #dcfce7; color: #166534; }
        .status-rejected { background: #fee2e2; color: #991b1b; }

        .btn-action-sm { padding: 5px 12px; font-size: 0.75rem; font-weight: 700; border-radius: 8px; }
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
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link active"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
        </ul>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0 text-dark">Quản lý ứng viên</h5>
            <div class="dropdown">
                <button class="btn btn-link text-dark text-decoration-none dropdown-toggle d-flex align-items-center border-0 p-0 shadow-none" type="button" data-bs-toggle="dropdown">
                    <span class="me-2 fw-bold small text-muted">${currentUser.fullName}</span>
                    <img src="https://ui-avatars.com/api/?name=${currentUser.fullName}&background=007bff&color=fff" class="rounded-circle" width="35">
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/recruiter/account/profile"><i class="bi bi-person me-2"></i>Hồ sơ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger py-2" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                </ul>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="admin-card">
                <form action="${pageContext.request.contextPath}/recruiter/pipeline" method="GET" class="row g-3">
                    <input type="hidden" name="jobId" value="${jobId}">
                    <div class="col-md-5">
                        <label class="form-label small fw-bold text-muted text-uppercase">Tìm kiếm</label>
                        <div class="input-group">
                            <span class="input-group-text bg-transparent border-end-0"><i class="bi bi-search"></i></span>
                            <input type="text" name="keyword" class="form-control border-start-0 filter-input" placeholder="Tên, email hoặc vị trí..." value="${keyword}">
                        </div>
                    </div>
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-muted text-uppercase">Trạng thái hồ sơ</label>
                        <select name="status" class="form-select filter-input">
                            <option value="">Tất cả trạng thái</option>
                            <option value="Applied" ${status == 'Applied' ? 'selected' : ''}>Mới ứng tuyển</option>
                            <option value="Interviewing" ${status == 'Interviewing' ? 'selected' : ''}>Đang phỏng vấn</option>
                            <option value="Accepted" ${status == 'Accepted' ? 'selected' : ''}>Đã chấp nhận</option>
                            <option value="Rejected" ${status == 'Rejected' ? 'selected' : ''}>Đã từ chối</option>
                        </select>
                    </div>
                    <div class="col-md-3 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary fw-bold rounded-pill w-100 py-2 shadow-sm">Lọc kết quả</button>
                    </div>
                </form>
            </div>

            <div class="admin-card p-0 overflow-hidden shadow-sm">
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="bg-light text-muted small text-uppercase">
                            <tr>
                                <th class="ps-4">Ứng viên</th>
                                <th>Vị trí ứng tuyển</th>
                                <th>Ngày nộp</th>
                                <th>Trạng thái</th>
                                <th class="text-end pe-4">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="app" items="${applications}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="d-flex align-items-center">
                                            <img src="https://ui-avatars.com/api/?name=${app.candidate.user.fullName}&background=random" class="candidate-avatar me-3 shadow-sm">
                                            <div>
                                                <div class="fw-bold text-dark">${app.candidate.user.fullName}</div>
                                                <small class="text-muted">${app.candidate.user.email}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark">${not empty app.job ? app.job.title : 'N/A'}</div>
                                        <small class="text-muted"><i class="bi bi-geo-alt me-1"></i>${app.job.location}</small>
                                    </td>
                                    <td class="text-muted small">
                                        <c:choose>
                                            <c:when test="${not empty app.applyDate}">
                                                ${app.applyDate.toLocalDate()}
                                            </c:when>
                                            <c:otherwise>N/A</c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:set var="stClass" value=""/>
                                        <c:choose>
                                            <c:when test="${app.status == 'Applied'}"><c:set var="stClass" value="status-applied"/></c:when>
                                            <c:when test="${app.status == 'Interviewing'}"><c:set var="stClass" value="status-interviewing"/></c:when>
                                            <c:when test="${app.status == 'Accepted'}"><c:set var="stClass" value="status-accepted"/></c:when>
                                            <c:when test="${app.status == 'Rejected'}"><c:set var="stClass" value="status-rejected"/></c:when>
                                        </c:choose>
                                        <span class="badge-status ${stClass}">${app.status}</span>
                                    </td>
                                    <td class="text-end pe-4">
                                        <div class="d-flex justify-content-end gap-2">
                                            <%-- ĐÃ XÓA NÚT CHI TIẾT VÀ NÚT AI ANALYSIS THEO YÊU CẦU --%>
                                            <a href="${pageContext.request.contextPath}/recruiter/candidates/view-cv?applicationId=${app.id}" 
                                               class="btn btn-sm btn-primary btn-action-sm shadow-sm">CV</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty applications}">
                                <tr>
                                    <td colspan="5" class="text-center py-5 text-muted">
                                        <i class="bi bi-inbox fs-1 d-block mb-2 opacity-25"></i>
                                        Hiện chưa có ứng viên nào trong danh sách.
                                    </td>
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