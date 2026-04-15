<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi tiết Ứng viên | ATS Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root {
            --primary-blue: #007bff;
            --bg-light: #f8fbff;
            --sidebar-width: 280px;
        }

        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; overflow-x: hidden; }
        
        /* Sidebar & Header Styles */
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
        
        /* Candidate Detail Styles */
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; box-shadow: 0 5px 15px rgba(0,0,0,0.02); margin-bottom: 20px; }
        .avatar-lg { width: 130px; height: 130px; border-radius: 50%; object-fit: cover; border: 4px solid #fff; box-shadow: 0 5px 15px rgba(0,0,0,0.1); flex-shrink: 0; }
        
        .nav-tabs .nav-link { border: none; color: #666; font-weight: 500; padding: 12px 24px; border-bottom: 2px solid transparent; }
        .nav-tabs .nav-link.active { color: var(--primary-blue); border-bottom-color: var(--primary-blue); background: transparent; font-weight: 600; }
        
        .info-label { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #888; margin-bottom: 6px; display: block; letter-spacing: 0.5px; }
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
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/candidates" class="sidebar-link active"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/recruitment-results" class="sidebar-link"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>

            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/vip-plans" class="sidebar-link"><i class="bi bi-gem"></i> Quản lý gói VIP</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/transactions" class="sidebar-link"><i class="bi bi-cash-stack"></i> Quản lý giao dịch</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link"><i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng</a></li>

            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
            <li class="sidebar-item mt-3">
                <a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10"><i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất</a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <form action="${pageContext.request.contextPath}/admin/candidates" method="GET" class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" name="keyword" class="border-0 bg-transparent shadow-none" placeholder="Tìm kiếm nhanh..." style="outline: none; width: 250px;">
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

        <div class="container-fluid p-4">
            <div class="mb-4 d-flex align-items-center">
                <a href="${pageContext.request.contextPath}/admin/candidates" class="btn btn-white border shadow-sm rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 40px; height: 40px;">
                    <i class="bi bi-arrow-left"></i>
                </a>
                <div>
                    <h4 class="fw-bold mb-1">Hồ sơ ứng viên</h4>
                    <p class="text-muted small mb-0">Quản lý thông tin chi tiết và lịch sử ứng tuyển</p>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-4">
                    <div class="admin-card text-center position-relative overflow-hidden">
                        <div class="bg-primary bg-opacity-10 position-absolute top-0 start-0 w-100" style="height: 100px;"></div>
                        
                        <div class="position-relative mt-4 mb-3">
                            <c:choose>
                                <c:when test="${not empty candidate.avatar}">
                                    <img src="${candidate.avatar.startsWith('/') ? candidate.avatar : pageContext.request.contextPath.concat('/').concat(candidate.avatar)}" 
                                         class="avatar-lg bg-white" alt="Avatar"
                                         onerror="this.onerror=null; this.src='https://ui-avatars.com/api/?name=${candidate.user.fullName}&background=007bff&color=fff';">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://ui-avatars.com/api/?name=${candidate.user.fullName}&background=007bff&color=fff" class="avatar-lg bg-white" alt="Avatar">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <h5 class="fw-bold mb-1">${candidate.user.fullName}</h5>
                        <p class="text-muted mb-3">${candidate.user.email}</p>
                        
                        <div class="d-flex justify-content-center gap-2 mb-4">
                            <c:choose>
                                <c:when test="${candidate.user.status}">
                                    <span class="badge bg-success bg-opacity-10 text-success rounded-pill px-3 py-2 border border-success border-opacity-25">Tài khoản Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger bg-opacity-10 text-danger rounded-pill px-3 py-2 border border-danger border-opacity-25">Tài khoản Bị khóa</span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        
                        <hr class="opacity-10 my-4">
        
                        <div class="text-start">
                            <div class="mb-4">
                                <span class="info-label">Thông tin cơ bản</span>
                                <div class="d-flex align-items-center mb-2 mt-2">
                                    <div class="bg-light rounded p-2 me-3 text-primary"><i class="bi bi-briefcase"></i></div>
                                    <div>
                                        <small class="text-muted d-block">Kinh nghiệm</small>
                                        <span class="fw-medium">${candidate.experienceYear} năm</span>
                                    </div>
                                </div>
                                <div class="d-flex align-items-center mb-2">
                                    <div class="bg-light rounded p-2 me-3 text-primary"><i class="bi bi-mortarboard"></i></div>
                                    <div>
                                        <small class="text-muted d-block">Học vấn</small>
                                        <span class="fw-medium">${not empty candidate.education ? candidate.education : 'Chưa cập nhật'}</span>
                                    </div>
                                </div>
                            </div>

                            <div>
                                <span class="info-label mb-2">Kỹ năng chuyên môn</span>
                                <div class="d-flex flex-wrap gap-2">
                                    <c:choose>
                                        <c:when test="${not empty candidate.skills}">
                                            <c:forEach var="skill" items="${candidate.skills.split(',')}">
                                                <span class="badge bg-light text-dark border px-2 py-1">${skill.trim()}</span>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="text-muted small">Chưa cập nhật kỹ năng</span>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-8">
                    <div class="admin-card p-0 overflow-hidden h-100">
                        <ul class="nav nav-tabs px-4 pt-3 bg-light border-bottom" id="candidateTabs">
                            <li class="nav-item">
                                <a class="nav-link active" data-bs-toggle="tab" href="#overview">
                                    <i class="bi bi-file-earmark-person me-1"></i> CV Đính kèm
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" data-bs-toggle="tab" href="#history">
                                    <i class="bi bi-clock-history me-1"></i> Lịch sử ứng tuyển
                                </a>
                            </li>
                        </ul>

                        <div class="tab-content p-4">
                            <div class="tab-pane fade show active" id="overview">
                                <div class="bg-light bg-opacity-50 rounded-4 p-5 text-center border border-dashed mb-4">
                                    <c:choose>
                                        <c:when test="${not empty candidate.cvFile}">
                                            <div class="mb-3">
                                                <i class="bi bi-file-earmark-pdf-fill text-danger" style="font-size: 4rem;"></i>
                                            </div>
                                            <h5 class="fw-bold text-dark mb-1">Hồ sơ xin việc</h5>
                                            <p class="text-muted small mb-4">Nhấn vào nút bên dưới để xem chi tiết hoặc tải xuống tài liệu</p>
                                            
                                            <a href="${candidate.cvFile.startsWith('/') ? candidate.cvFile : pageContext.request.contextPath.concat('/').concat(candidate.cvFile)}" 
                                               target="_blank" 
                                               class="btn btn-primary btn-lg rounded-pill px-4 shadow-sm fw-medium">
                                                <i class="bi bi-eye me-2"></i> Xem & Tải CV
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <div class="mb-3">
                                                <i class="bi bi-file-earmark-x text-muted" style="font-size: 4rem; opacity: 0.5;"></i>
                                            </div>
                                            <h6 class="text-muted">Ứng viên chưa tải lên CV nào</h6>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="history">
                                <div class="table-responsive">
                                    <table class="table table-hover align-middle">
                                        <thead class="bg-light small text-muted text-uppercase">
                                            <tr>
                                                <th class="border-0 rounded-start">Công việc ứng tuyển</th>
                                                <th class="border-0">Trạng thái</th>
                                                <th class="border-0 rounded-end">Ngày nộp</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="app" items="${applications}">
                                                <tr>
                                                    <td>
                                                        <div class="fw-bold text-dark">${app.job.title}</div>
                                                        <small class="text-muted">Mã đơn: #${app.id}</small>
                                                    </td>
                                                    <td>
                                                        <span class="badge bg-light text-dark border">${app.status}</span>
                                                    </td>
                                                    <td class="text-muted small">
                                                        <%-- Fix lỗi applyDate và bỏ đuôi milisecond --%>
                                                        ${app.applyDate.toString().split('T')[0]}
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty applications}">
                                                <tr>
                                                    <td colspan="3" class="text-center text-muted py-4">Chưa có lịch sử ứng tuyển nào.</td>
                                                </tr>
                                            </c:if>
                                        </tbody>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>