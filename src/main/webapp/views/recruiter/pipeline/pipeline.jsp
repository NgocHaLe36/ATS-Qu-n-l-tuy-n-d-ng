<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý ứng viên - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar Design - Đồng bộ Dashboard */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        
        /* Logout Area - Đồng bộ Dashboard */
        .logout-area { padding: 20px; border-top: 1px solid #eee; margin-top: auto; }
        .btn-logout { display: flex !important; align-items: center; padding: 12px 15px; border-radius: 10px; color: #dc3545 !important; background-color: rgba(220, 53, 69, 0.1); text-decoration: none !important; font-weight: 700; transition: 0.3s; border: none; width: 100%; }
        .btn-logout:hover { background-color: #dc3545; color: #fff !important; }

        /* Main Content Layout */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        .admin-card { background: #fff; border: 1px solid #edf2f7; border-radius: 15px; padding: 24px; box-shadow: 0 5px 20px rgba(0,0,0,0.02); margin-bottom: 24px; }
        
        /* Table Styles */
        .table thead th { font-size: 0.75rem; text-transform: uppercase; letter-spacing: 1px; color: #888; border: none; padding: 15px 10px; }
        .table tbody td { padding: 18px 10px; vertical-align: middle; border-bottom: 1px solid #f8f9fa; }
        
        /* Status Badges - Đồng bộ */
        .badge-status { padding: 6px 14px; border-radius: 50px; font-weight: 700; font-size: 0.7rem; text-transform: uppercase; letter-spacing: 0.5px; }
        .bg-applied { background: #fff8e1; color: #ffa000; }
        .bg-accepted { background: #e8f5e9; color: #2e7d32; }
        .bg-rejected { background: #ffebee; color: #c62828; }
        .bg-interviewing { background: #e3f2fd; color: #1565c0; }
        
        .avatar-circle { width: 38px; height: 38px; background: var(--primary-blue); color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 700; font-size: 0.9rem; }
    </style>
</head>
<body>
    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-rocket-takeoff-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Recruiter</span>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link">
                    <i class="bi bi-grid-1x2-fill"></i> Tổng quan
                </a>
            </li>
            
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link active"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link">
                    <i class="bi bi-credit-card"></i> Lịch sử thanh toán
                </a>
            </li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link">
                    <i class="bi bi-key"></i> Đổi mật khẩu
                </a>
            </li>
        </ul>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right me-2"></i> <span>Đăng xuất</span>
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <h5 class="fw-bold mb-0 text-dark">Ứng viên & Pipeline</h5>
            <div class="dropdown">
                <button class="btn btn-link text-dark text-decoration-none dropdown-toggle d-flex align-items-center p-0 border-0 shadow-none" data-bs-toggle="dropdown">
                    <div class="bg-primary text-white rounded-circle me-2 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px; font-weight: bold;">
                        ${currentUser.fullName.substring(0,2).toUpperCase()}
                    </div>
                    <span class="fw-bold">${currentUser.fullName}</span>
                </button>
                <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-2">
                    <li><a class="dropdown-item py-2" href="${pageContext.request.contextPath}/recruiter/account/profile"><i class="bi bi-person me-2"></i> Hồ sơ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger py-2" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i> Đăng xuất</a></li>
                </ul>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="admin-card mb-4">
                <form action="${pageContext.request.contextPath}/recruiter/pipeline" method="get" class="row g-3">
                    <div class="col-md-4">
                        <label class="form-label small fw-bold text-muted text-uppercase">Trạng thái hồ sơ</label>
                        <select name="status" class="form-select border-0 bg-light rounded-3 shadow-none">
                            <option value="">Tất cả trạng thái</option>
                            <option value="Applied" ${status == 'Applied' ? 'selected' : ''}>Applied (Mới nộp)</option>
                            <option value="Interviewing" ${status == 'Interviewing' ? 'selected' : ''}>Interviewing (Phỏng vấn)</option>
                            <option value="Accepted" ${status == 'Accepted' ? 'selected' : ''}>Accepted (Đã nhận)</option>
                            <option value="Rejected" ${status == 'Rejected' ? 'selected' : ''}>Rejected (Từ chối)</option>
                        </select>
                    </div>
                    <div class="col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-primary w-100 rounded-pill fw-bold shadow-sm py-2">
                            <i class="bi bi-funnel me-1"></i> Lọc hồ sơ
                        </button>
                    </div>
                </form>
            </div>

            <div class="admin-card p-0 overflow-hidden shadow-sm">
                <div class="px-4 pt-4 d-flex justify-content-between align-items-center mb-3">
                    <h5 class="fw-bold mb-0">Danh sách ứng viên</h5>
                    <span class="badge bg-primary bg-opacity-10 text-primary rounded-pill px-3 py-2 fw-bold" style="font-size: 0.75rem;">
                        ${applications.size()} ứng viên
                    </span>
                </div>
                
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead>
                            <tr>
                                <th class="ps-4">Ứng viên</th>
                                <th>Vị trí ứng tuyển</th>
                                <th>Ngày nộp</th>
                                <th>Trạng thái</th>
                                <th class="text-center pe-4">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="app" items="${applications}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="d-flex align-items-center">
                                            <div class="avatar-circle me-3" style="background: rgba(0, 123, 255, 0.1); color: var(--primary-blue); font-weight: 800;">
                                                ${app.candidate.user.fullName.substring(0,1).toUpperCase()}
                                            </div>
                                            <div>
                                                <div class="fw-bold text-dark">${app.candidate.user.fullName}</div>
                                                <small class="text-muted">${app.candidate.user.email}</small>
                                            </div>
                                        </div>
                                    </td>
                                    <td>
                                        <div class="fw-bold text-dark">${app.job.title}</div>
                                        <small class="text-muted small"><i class="bi bi-geo-alt me-1"></i>${app.job.location}</small>
                                    </td>
                                    <td>
                                        <div class="small text-muted">
                                            <fmt:parseDate value="${app.applyDate}" pattern="yyyy-MM-dd" var="parsedDate" type="date" />
                                            <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy" />
                                        </div>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${app.status.equalsIgnoreCase('Interviewing') || app.status.equalsIgnoreCase('INTERVIEW')}">
                                                <span class="badge-status bg-interviewing">INTERVIEWING</span>
                                            </c:when>
                                            <c:when test="${app.status.equalsIgnoreCase('Applied')}">
                                                <span class="badge-status bg-applied">APPLIED</span>
                                            </c:when>
                                            <c:when test="${app.status.equalsIgnoreCase('Accepted')}">
                                                <span class="badge-status bg-accepted">ACCEPTED</span>
                                            </c:when>
                                            <c:when test="${app.status.equalsIgnoreCase('Rejected')}">
                                                <span class="badge-status bg-rejected">REJECTED</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge-status bg-secondary">${app.status}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-center pe-4">
                                        <div class="dropdown">
                                            <button class="btn btn-white btn-sm rounded-pill px-3 fw-bold border shadow-sm" type="button" data-bs-toggle="dropdown">
                                                Hành động <i class="bi bi-chevron-down ms-1"></i>
                                            </button>
                                            <ul class="dropdown-menu dropdown-menu-end shadow border-0 mt-1">
                                                <li>
                                                    <a class="dropdown-item py-2 fw-bold" href="${pageContext.request.contextPath}/recruiter/candidates/detail?applicationId=${app.id}">
                                                        <i class="bi bi-person-badge me-2"></i> Xem hồ sơ
                                                    </a>
                                                </li>
                                                <li><hr class="dropdown-divider"></li>
                                                <li>
                                                    <a class="dropdown-item text-primary py-2 small fw-bold" href="${pageContext.request.contextPath}/recruiter/interviews/schedule?applicationId=${app.id}">
                                                        <i class="bi bi-calendar-event me-2"></i> Đặt lịch phỏng vấn
                                                    </a>
                                                </li>
                                                <form action="${pageContext.request.contextPath}/recruiter/pipeline/update-status" method="post">
                                                    <input type="hidden" name="applicationId" value="${app.id}">
                                                    <li><button type="submit" name="status" value="Accepted" class="dropdown-item text-success py-2 small fw-bold"><i class="bi bi-check-circle me-2"></i> Chấp nhận</button></li>
                                                    <li><button type="submit" name="status" value="Rejected" class="dropdown-item text-danger py-2 small fw-bold"><i class="bi bi-x-circle me-2"></i> Từ chối</button></li>
                                                </form>
                                            </ul>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty applications}">
                                <tr>
                                    <td colspan="5" class="text-center py-5">
                                        <div class="opacity-25 mb-3">
                                            <i class="bi bi-people fs-1 text-muted"></i>
                                        </div>
                                        <p class="text-muted small">Không tìm thấy ứng viên nào phù hợp với bộ lọc.</p>
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