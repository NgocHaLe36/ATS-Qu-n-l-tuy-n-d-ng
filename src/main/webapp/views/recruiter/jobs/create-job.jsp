<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đăng tin tuyển dụng mới - ATS Recruiter</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar layout đồng nhất Dashboard */
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

        /* Main Content */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        /* Form Styling */
        .form-card { background: #fff; border: 1px solid #edf2f7; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.02); }
        .form-label { font-weight: 700; font-size: 0.75rem; color: #64748b; text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 8px; }
        .form-control, .form-select { border-radius: 10px; padding: 12px 15px; border: 1px solid #e2e8f0; }
        
        .vip-toggle { background: #fffbeb; border: 1px solid #fef3c7; border-radius: 12px; padding: 20px; }
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
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="sidebar-link">
                    <i class="bi bi-grid-1x2-fill"></i> Tổng quan
                </a>
            </li>
            <div class="sidebar-menu-title">Tuyển dụng</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link active"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
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
            <a href="${pageContext.request.contextPath}/auth/logout" class="btn-logout">
                <i class="bi bi-box-arrow-right me-2"></i> <span>Đăng xuất</span>
            </a>
        </div>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <a href="javascript:history.back()" class="btn btn-link text-dark p-0 me-3 shadow-none"><i class="bi bi-arrow-left fs-4"></i></a>
                <h5 class="fw-bold mb-0 text-dark">Đăng tin tuyển dụng mới</h5>
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
            <div class="row justify-content-center">
                <div class="col-lg-10">
                    
                    <c:if test="${not empty error}">
                        <div class="alert alert-danger border-0 rounded-3 shadow-sm mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                        </div>
                    </c:if>

                    <div class="form-card bg-white">
                        <form action="${pageContext.request.contextPath}/recruiter/jobs/store" method="post">
                            
                            <div class="mb-4">
                                <label class="form-label">Tiêu đề công việc <span class="text-danger">*</span></label>
                                <input type="text" name="title" class="form-control fw-bold" placeholder="Ví dụ: Senior Java Developer (Spring Boot)" required>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Địa điểm làm việc <span class="text-danger">*</span></label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0"><i class="bi bi-geo-alt"></i></span>
                                        <input type="text" name="location" class="form-control border-start-0" placeholder="Hà Nội, TP. HCM hoặc Remote" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Mức lương dự kiến (VNĐ)</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-light border-end-0">₫</span>
                                        <input type="number" name="salary" class="form-control border-start-0" placeholder="Để trống nếu thỏa thuận">
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Mô tả công việc <span class="text-danger">*</span></label>
                                <textarea name="description" class="form-control" rows="5" placeholder="Mô tả các trách nhiệm chính..." required></textarea>
                            </div>

                            <div class="mb-4">
                                <label class="form-label">Yêu cầu ứng viên <span class="text-danger">*</span></label>
                                <textarea name="requirement" class="form-control" rows="5" placeholder="Kỹ năng, kinh nghiệm cần thiết..." required></textarea>
                            </div>

                            <div class="row g-4 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label">Hạn chót ứng tuyển <span class="text-danger">*</span></label>
                                    <input type="datetime-local" name="deadline" class="form-control" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Trạng thái tin đăng</label>
                                    <select name="status" class="form-select fw-bold">
                                        <option value="OPEN">Công khai ngay (OPEN)</option>
                                        <option value="HIDDEN">Lưu bản nháp (HIDDEN)</option>
                                    </select>
                                </div>
                            </div>

                            <div class="vip-toggle mb-5">
                                <div class="form-check form-switch d-flex align-items-center mb-0">
                                    <input class="form-check-input me-3" type="checkbox" name="isVip" value="true" id="isVip" 
                                           style="width: 45px; height: 22px;" ${empty activeSubscription ? 'disabled' : ''}>
                                    <div>
                                        <label class="form-check-label fw-bold text-dark" for="isVip">
                                            <i class="bi bi-gem text-warning me-1"></i> Đăng tin ưu tiên (Tin VIP)
                                        </label>
                                        <p class="small text-muted mb-0">Ưu tiên hiển thị tin của bạn ở vị trí đầu danh sách.</p>
                                    </div>
                                </div>
                                <c:if test="${not empty activeSubscription}">
                                    <div class="mt-3 p-2 border-top border-warning border-opacity-25 small text-primary fw-bold">
                                        <i class="bi bi-patch-check-fill me-1"></i> Gói hiện tại: ${activeSubscription.plan.name}
                                    </div>
                                </c:if>
                            </div>

                            <div class="d-flex gap-3 mt-4">
                                <button type="submit" class="btn btn-primary fw-bold px-5 py-3 rounded-pill shadow-sm flex-grow-1 border-0">
                                    <i class="bi bi-rocket-takeoff me-2"></i> Xác nhận đăng tin
                                </button>
                                <a href="${pageContext.request.contextPath}/recruiter/jobs" class="btn btn-white border fw-bold px-4 py-3 rounded-pill shadow-sm">Hủy bỏ</a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>