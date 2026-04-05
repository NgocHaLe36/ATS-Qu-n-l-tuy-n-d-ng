<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard Nhà Tuyển Dụng - ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar layout */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; display: flex; flex-direction: column; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; flex-grow: 1; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: 0.3s; margin-bottom: 5px; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); font-weight: 700; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }
        
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        .admin-card { background: #fff; border: 1px solid #edf2f7; border-radius: 15px; padding: 24px; box-shadow: 0 5px 20px rgba(0,0,0,0.02); margin-bottom: 24px; }
        .stat-card { transition: 0.3s; text-decoration: none; display: block; color: inherit; }
        .stat-card:hover { transform: translateY(-5px); }
        .vip-card-gradient { background: linear-gradient(135deg, #e0eaff 0%, #f8fbff 100%); border: 1px solid #c2d6ff; }
        
        /* Màu trạng thái: CLOSED Đỏ, HIDDEN Xám */
        .badge-job { padding: 5px 12px; border-radius: 6px; font-weight: 700; font-size: 0.65rem; text-transform: uppercase; letter-spacing: 0.5px; display: inline-block; }
        .bg-open { background-color: #e8f5e9 !important; color: #2e7d32 !important; }
        .bg-closed { background-color: #ffebee !important; color: #c62828 !important; }
        .bg-hidden { background-color: #f1f5f9 !important; color: #475569 !important; border: 1px solid #e2e8f0; }

        .btn-action { width: 32px; height: 32px; display: inline-flex; align-items: center; justify-content: center; border-radius: 50%; border: 1px solid #eee; color: #555; transition: 0.2s; text-decoration: none; }
        .btn-action:hover { background: #f8fbff; color: var(--primary-blue); border-color: var(--primary-blue); }
        .logout-area { padding: 20px; border-top: 1px solid #eee; margin-top: auto; }
    </style>
</head>
<body>
    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-rocket-takeoff-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Recruiter</span>
        </div>
        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link active"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>
            
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>
            
            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link"><i class="bi bi-credit-card"></i> Lịch sử thanh toán</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>
            
            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link">
                    <i class="bi bi-key"></i> Đổi mật khẩu
                </a>
            </li>
        </ul>
        <div class="logout-area">
            <a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10 py-2">
                <i class="bi bi-box-arrow-right me-2"></i> Đăng xuất
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <h5 class="fw-bold mb-0 text-dark">Chào mừng trở lại, ${currentUser.fullName}!</h5>
            <div class="dropdown">
                <button class="btn btn-link text-dark text-decoration-none dropdown-toggle d-flex align-items-center p-0 border-0 shadow-none" data-bs-toggle="dropdown">
                    <div class="bg-primary text-white rounded-circle me-2 d-flex align-items-center justify-content-center fw-bold" style="width: 40px; height: 40px;">
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
            <div class="row g-4 mb-4">
                <a href="${pageContext.request.contextPath}/recruiter/jobs" class="col-md-3 stat-card">
                    <div class="admin-card mb-0 h-100 d-flex align-items-center justify-content-between">
                        <div><p class="text-muted small fw-bold text-uppercase mb-1">Tin tuyển dụng</p><h2 class="fw-bold mb-0">${jobs.size()}</h2></div>
                        <div class="bg-primary bg-opacity-10 p-3 rounded-circle text-primary"><i class="bi bi-briefcase fs-3"></i></div>
                    </div>
                </a>
                <a href="${pageContext.request.contextPath}/recruiter/pipeline" class="col-md-3 stat-card">
                    <div class="admin-card mb-0 h-100 d-flex align-items-center justify-content-between">
                        <div><p class="text-muted small fw-bold text-uppercase mb-1">Tổng hồ sơ</p><h2 class="fw-bold mb-0">${totalApps}</h2></div>
                        <div class="bg-success bg-opacity-10 p-3 rounded-circle text-success"><i class="bi bi-file-earmark-person fs-3"></i></div>
                    </div>
                </a>
                <div class="col-md-3">
                    <div class="admin-card mb-0 h-100 d-flex align-items-center justify-content-between">
                        <div><p class="text-muted small fw-bold text-uppercase mb-1">Chờ phỏng vấn</p><h2 class="fw-bold mb-0">${pendingInterviews}</h2></div>
                        <div class="bg-warning bg-opacity-10 p-3 rounded-circle text-warning"><i class="bi bi-calendar-event fs-3"></i></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="admin-card mb-0 h-100 d-flex align-items-center justify-content-between">
                        <div><p class="text-muted small fw-bold text-uppercase mb-1">Đã tuyển</p><h2 class="fw-bold mb-0">${hiredCount}</h2></div>
                        <div class="bg-info bg-opacity-10 p-3 rounded-circle text-info"><i class="bi bi-check-circle fs-3"></i></div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="admin-card h-100">
                        <h5 class="fw-bold mb-4">Dịch vụ hiện tại</h5>
                        <div class="vip-card-gradient rounded-4 p-4 mb-3 text-center">
                            <h4 class="fw-bold text-primary mb-1"><c:out value="${activeSubscription.plan.name}" default="Basic Member"/></h4>
                            <p class="small text-muted mb-0">Hạng: VIP</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="btn btn-outline-primary w-100 rounded-pill fw-bold btn-sm">Nâng cấp ngay</a>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="admin-card p-0 overflow-hidden h-100">
                        <div class="px-4 pt-4 d-flex justify-content-between align-items-center mb-3">
                            <h5 class="fw-bold mb-0">Tin tuyển dụng mới nhất</h5>
                            <a href="${pageContext.request.contextPath}/recruiter/jobs" class="btn btn-sm btn-link text-decoration-none fw-bold">Quản lý tất cả</a>
                        </div>
                        <div class="table-responsive">
                            <table class="table table-hover align-middle mb-0">
                                <thead class="text-muted small">
                                    <tr>
                                        <th class="ps-4">VỊ TRÍ</th>
                                        <th>TRẠNG THÁI</th>
                                        <th class="text-center">THAO TÁC</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="job" items="${jobs}" varStatus="loop">
                                        <c:if test="${loop.index < 5}">
                                            <tr>
                                                <td class="ps-4">
                                                    <div class="fw-bold text-dark">${job.title}</div>
                                                    <small class="text-muted">${job.location}</small>
                                                </td>
                                                <td>
                                                    <c:choose>
                                                        <c:when test="${job.status == 'OPEN' || job.status == 'active'}">
                                                            <span class="badge-job bg-open">OPEN</span>
                                                        </c:when>
                                                        <c:when test="${job.status == 'CLOSED' || job.status == 'expired'}">
                                                            <span class="badge-job bg-closed">CLOSED</span>
                                                        </c:when>
                                                        <c:when test="${job.status == 'HIDDEN'}">
                                                            <span class="badge-job bg-hidden">HIDDEN</span>
                                                        </c:when>
                                                        <c:otherwise>
                                                            <span class="badge-job bg-secondary text-white">${job.status}</span>
                                                        </c:otherwise>
                                                    </c:choose>
                                                </td>
                                                <td class="text-center">
                                                    <a href="${pageContext.request.contextPath}/recruiter/jobs/detail?id=${job.id}" class="btn-action me-1" title="Ứng viên"><i class="bi bi-people"></i></a>
                                                    <a href="${pageContext.request.contextPath}/recruiter/jobs/edit?id=${job.id}" class="btn-action" title="Sửa"><i class="bi bi-pencil"></i></a>
                                                </td>
                                            </tr>
                                        </c:if>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>