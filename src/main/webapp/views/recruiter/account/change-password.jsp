<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu - Recruiter ATS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; margin: 0; }
        
        /* Sidebar Styling */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-brand a { text-decoration: none !important; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-item { margin-bottom: 5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: all 0.3s ease; }
        .sidebar-link:hover { background-color: rgba(0, 123, 255, 0.05); color: var(--primary-blue); }
        .sidebar-link.active { background-color: rgba(0, 123, 255, 0.1); color: var(--primary-blue); font-weight: 600; }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }

        /* Main Content Styling */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; display: flex; flex-direction: column; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; }
        
        .admin-card { background: #fff; border: 1px solid #edf2f7; border-radius: 15px; padding: 30px; box-shadow: 0 5px 20px rgba(0,0,0,0.02); }
        .form-label { font-weight: 600; color: #4a5568; font-size: 0.9rem; }
        .form-control { padding: 12px 15px; border-radius: 10px; border: 1px solid #e2e8f0; }
        .form-control:focus { box-shadow: 0 0 0 3px rgba(0, 123, 255, 0.1); border-color: var(--primary-blue); }
        
        .input-group-text { background: transparent; border-right: none; border-radius: 10px 0 0 10px; color: #94a3b8; }
        .input-group .form-control { border-left: none; }
        .btn-submit { padding: 12px 30px; border-radius: 10px; font-weight: 700; transition: 0.3s; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <%-- 1. Thêm link vào Logo để quay về Dashboard --%>
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
            <%-- 2. Cập nhật đường dẫn các nút chức năng --%>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs/create" class="sidebar-link"><i class="bi bi-plus-circle"></i> Đăng tin mới</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/jobs" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin đăng</a></li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/pipeline" class="sidebar-link"><i class="bi bi-people"></i> Danh sách ứng viên</a></li>

            <div class="sidebar-menu-title">Tài khoản & Dịch vụ</div>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/vip/plans" class="sidebar-link"><i class="bi bi-gem"></i> Gói dịch vụ VIP</a></li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/payment/history" class="sidebar-link"><i class="bi bi-credit-card"></i> Lịch sử thanh toán</a>
            </li>
            <li class="sidebar-item"><a href="${pageContext.request.contextPath}/recruiter/account/profile" class="sidebar-link"><i class="bi bi-person-gear"></i> Hồ sơ công ty</a></li>

            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/recruiter/account/change-password" class="sidebar-link active">
                    <i class="bi bi-key"></i> Đổi mật khẩu
                </a>
            </li>
            <li class="sidebar-item mt-3">
                <a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10">
                    <i class="bi bi-box-arrow-right"></i> Đăng xuất
                </a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm d-flex justify-content-between align-items-center">
            <h5 class="fw-bold mb-0 text-muted">Thiết lập tài khoản</h5>
            <div class="d-flex align-items-center">
                <span class="me-3 fw-bold text-dark">${currentUser.fullName}</span>
                <div class="dropdown">
                    <a href="#" data-bs-toggle="dropdown" class="text-decoration-none">
                        <img src="https://ui-avatars.com/api/?name=${currentUser.fullName}&background=007bff&color=fff" class="rounded-circle" width="40" alt="Avatar">
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0">
                        <%-- 3. Cập nhật link hồ sơ trong dropdown --%>
                        <li><a class="dropdown-item" href="${pageContext.request.contextPath}/recruiter/account/profile"><i class="bi bi-person me-2"></i>Hồ sơ</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout"><i class="bi bi-box-arrow-right me-2"></i>Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4">
            <div class="row justify-content-center">
                <div class="col-lg-6">
                    <div class="d-flex align-items-center mb-4">
                        <a href="${pageContext.request.contextPath}/recruiter/dashboard" class="btn btn-white bg-white shadow-sm border rounded-circle me-3 d-flex align-items-center justify-content-center" style="width: 45px; height: 45px; color: inherit; text-decoration: none;">
                            <i class="bi bi-arrow-left fs-5"></i>
                        </a>
                        <div>
                            <h3 class="fw-bold mb-0">Đổi mật khẩu</h3>
                            <p class="text-muted small mb-0">Cập nhật mật khẩu định kỳ để bảo vệ tài khoản</p>
                        </div>
                    </div>

                    <c:if test="${not empty error}">
                        <div class="alert alert-danger border-0 shadow-sm rounded-4 d-flex align-items-center mb-4">
                            <i class="bi bi-exclamation-triangle-fill me-2 fs-5"></i>
                            <div>${error}</div>
                        </div>
                    </c:if>
                    <c:if test="${not empty success}">
                        <div class="alert alert-success border-0 shadow-sm rounded-4 d-flex align-items-center mb-4">
                            <i class="bi bi-check-circle-fill me-2 fs-5"></i>
                            <div>${success}</div>
                        </div>
                    </c:if>

                    <div class="admin-card">
                        <form action="${pageContext.request.contextPath}/recruiter/account/change-password" method="POST">
                            <div class="mb-4">
                                <label class="form-label text-uppercase small letter-spacing-1">Mật khẩu hiện tại</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-shield-lock"></i></span>
                                    <input type="password" name="oldPassword" class="form-control" placeholder="••••••••" required>
                                </div>
                            </div>

                            <hr class="my-4 opacity-25">

                            <div class="mb-4">
                                <label class="form-label text-uppercase small letter-spacing-1">Mật khẩu mới</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-key"></i></span>
                                    <input type="password" name="newPassword" class="form-control" placeholder="Tối thiểu 6 ký tự" required>
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label text-uppercase small letter-spacing-1">Xác nhận mật khẩu mới</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="bi bi-patch-check"></i></span>
                                    <input type="password" name="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu mới" required>
                                </div>
                            </div>

                            <div class="d-grid mt-5">
                                <button type="submit" class="btn btn-primary btn-submit shadow-sm py-3">
                                    Xác nhận thay đổi <i class="bi bi-arrow-right ms-2"></i>
                                </button>
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