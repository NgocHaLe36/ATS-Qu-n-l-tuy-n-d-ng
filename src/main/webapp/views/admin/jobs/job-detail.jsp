

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Tin Tuyển Dụng | ATS Admin</title>

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
        .badge-status { padding: 6px 12px; border-radius: 50px; font-weight: 600; font-size: 0.75rem; }
        
        .job-detail-content h5 { font-weight: 700; margin-top: 1.5rem; margin-bottom: 1rem; color: #2c3e50; }
        .job-detail-content p, .job-detail-content li { color: #555; line-height: 1.6; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center"><i class="bi bi-building-fill text-primary me-2 fs-3"></i><span class="fw-bold fs-4 text-primary">ATS Admin</span></div>
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
            <div>
                <a href="${pageContext.request.contextPath}/admin/jobs" class="btn btn-sm btn-outline-secondary rounded-pill">
                    <i class="bi bi-arrow-left me-1"></i> Quay lại danh sách
                </a>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                        <span class="fw-bold">${admin != null ? admin.fullName : 'Super Admin'}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end border-0 shadow">
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/auth/logout">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4 flex-grow-1">
            
            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-start mb-4">
                            <div>
                                <h3 class="fw-bold text-primary mb-2">${job.title}</h3>
                                <div class="d-flex flex-wrap gap-3 text-muted small">
                                    <span><i class="bi bi-geo-alt-fill text-danger me-1"></i> ${job.location}</span>
                                    <span><i class="bi bi-cash text-success me-1"></i> <fmt:formatNumber value="${job.salary}" type="number"/> VNĐ</span>
                                    <span><i class="bi bi-clock-history text-warning me-1"></i> Hạn nộp: ${job.deadline.toString().split('T')[0]}</span>
                                </div>
                            </div>
                            <c:choose>
                                <c:when test="${job.status == 'OPEN'}"><span class="badge-status bg-success bg-opacity-10 text-success fs-6">Đang mở</span></c:when>
                                <c:when test="${job.status == 'PENDING'}"><span class="badge-status bg-warning bg-opacity-10 text-warning fs-6">Chờ duyệt</span></c:when>
                                <c:otherwise><span class="badge-status bg-secondary bg-opacity-10 text-secondary fs-6">${job.status}</span></c:otherwise>
                            </c:choose>
                        </div>

                        <hr class="text-muted opacity-25">

                        <div class="job-detail-content">
                            <h5>Mô tả công việc</h5>
                            <div>${job.description}</div>
                            
                            <h5>Yêu cầu ứng viên</h5>
                            <div>${job.requirements}</div>
                            
                            <h5>Quyền lợi</h5>
                            <div>${job.benefits}</div>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="admin-card mb-4">
                        <h5 class="fw-bold border-bottom pb-2 mb-3">Thông tin nhà tuyển dụng</h5>
                        <div class="d-flex align-items-center mb-3">
                            <div class="bg-primary bg-opacity-10 text-primary rounded d-flex align-items-center justify-content-center me-3" style="width: 50px; height: 50px; font-size: 1.5rem;">
                                <i class="bi bi-building"></i>
                            </div>
                            <div>
                                <h6 class="fw-bold mb-1">${job.recruiter.fullName}</h6>
                                <p class="text-muted small mb-0">${job.recruiter.email}</p>
                            </div>
                        </div>
                        <ul class="list-unstyled mb-0 small text-muted">
                            <li class="mb-2"><i class="bi bi-telephone me-2"></i> ${job.recruiter.phone}</li>
                            <li><i class="bi bi-calendar-check me-2"></i> Ngày đăng: ${job.createdAt.toString().split('T')[0]}</li>
                        </ul>
                    </div>

                    <c:if test="${job.status == 'PENDING'}">
                        <div class="admin-card bg-light">
                            <h5 class="fw-bold mb-3">Hành động kiểm duyệt</h5>
                            <p class="small text-muted mb-4">Bài đăng này đang chờ bạn phê duyệt để hiển thị cho ứng viên.</p>
                            
                            <form action="${pageContext.request.contextPath}/admin/jobs/approve" method="POST" class="mb-2">
                                <input type="hidden" name="id" value="${job.id}">
                                <button type="submit" class="btn btn-success w-100 fw-bold rounded-pill">
                                    <i class="bi bi-check-circle me-1"></i> Duyệt bài đăng này
                                </button>
                            </form>
                            
                            <form action="${pageContext.request.contextPath}/admin/jobs/reject" method="POST">
                                <input type="hidden" name="id" value="${job.id}">
                                <button type="submit" class="btn btn-outline-danger w-100 fw-bold rounded-pill" onclick="return confirm('Xác nhận từ chối/khóa bài đăng này?');">
                                    <i class="bi bi-x-circle me-1"></i> Từ chối bài đăng
                                </button>
                            </form>
                        </div>
                    </c:if>
                    
                    <c:if test="${job.status == 'OPEN'}">
                         <div class="admin-card bg-light">
                            <form action="${pageContext.request.contextPath}/admin/jobs/reject" method="POST">
                                <input type="hidden" name="id" value="${job.id}">
                                <button type="submit" class="btn btn-outline-danger w-100 fw-bold rounded-pill" onclick="return confirm('Bạn có chắc muốn đóng tin tuyển dụng này?');">
                                    <i class="bi bi-lock-fill me-1"></i> Đóng tin tuyển dụng
                                </button>
                            </form>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>