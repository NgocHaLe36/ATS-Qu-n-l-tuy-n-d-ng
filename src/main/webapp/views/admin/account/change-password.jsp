<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Đổi mật khẩu | ATS Admin</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root {
            --primary-blue: #007bff;
            --bg-light: #f8fbff;
            --sidebar-width: 280px;
        }

        body {
            font-family: 'Inter', sans-serif;
            background-color: var(--bg-light);
            color: #333;
            overflow-x: hidden;
        }

        /* Sidebar & Layout Styles từ Dashboard */
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
        
        /* Card Styles */
        .admin-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 15px;
            padding: 35px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.02);
            max-width: 500px;
            width: 100%;
        }

        .input-group-text { background: #f8f9fa; border-right: none; color: #6c757d; }
        .form-control { border-left: none; }
        .form-control:focus { box-shadow: none; border-color: #dee2e6; }
        .input-group:focus-within { box-shadow: 0 0 0 0.25rem rgba(0, 123, 255, 0.1); border-radius: 0.375rem; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Admin</span>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link">
                    <i class="bi bi-grid-1x2-fill"></i> Tổng quan
                </a>
            </li>

            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/staff-management" class="sidebar-link">
                    <i class="bi bi-person-badge"></i> Quản lý nhân viên
                </a>
            </li>

            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/account/change-password" class="sidebar-link active">
                    <i class="bi bi-key"></i> Đổi mật khẩu
                </a>
            </li>
            <li class="sidebar-item mt-3">
                <a href="${pageContext.request.contextPath}/auth/logout" class="sidebar-link text-danger bg-danger bg-opacity-10">
                    <i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất
                </a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="fw-bold fs-5">Tài khoản</div>
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=${currentUser.fullName}&background=007bff&color=fff" class="rounded-circle me-2" width="35" alt="Admin">
                        <span class="fw-bold">${currentUser.fullName}</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end border-0 shadow">
                        <li><a class="dropdown-item text-danger" href="${pageContext.request.contextPath}/auth/logout">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4 d-flex justify-content-center align-items-center flex-grow-1">
            <div class="admin-card">
                <div class="text-center mb-4">
                    <div class="bg-primary bg-opacity-10 text-primary d-inline-block p-3 rounded-circle mb-3">
                        <i class="bi bi-shield-lock fs-2"></i>
                    </div>
                    <h4 class="fw-bold">Đổi Mật Khẩu</h4>
                    <p class="text-muted small">Cập nhật mật khẩu định kỳ để bảo vệ hệ thống</p>
                </div>

                <c:if test="${not empty error}">
                    <div class="alert alert-danger border-0 small shadow-sm" role="alert">
                        <i class="bi bi-exclamation-triangle-fill me-2"></i> ${error}
                    </div>
                </c:if>
                <c:if test="${not empty success}">
                    <div class="alert alert-success border-0 small shadow-sm" role="alert">
                        <i class="bi bi-check-circle-fill me-2"></i> ${success}
                    </div>
                </c:if>

                <form action="${pageContext.request.contextPath}/admin/account/change-password" method="POST">
                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Mật khẩu hiện tại</label>
                        <div class="input-group border rounded-3">
                            <span class="input-group-text"><i class="bi bi-key"></i></span>
                            <input type="password" name="oldPassword" class="form-control border-0" placeholder="Nhập mật khẩu hiện tại" required>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label fw-semibold small">Mật khẩu mới</label>
                        <div class="input-group border rounded-3">
                            <span class="input-group-text"><i class="bi bi-lock"></i></span>
                            <input type="password" name="newPassword" class="form-control border-0" placeholder="Tối thiểu 8 ký tự" required>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label fw-semibold small">Xác nhận mật khẩu mới</label>
                        <div class="input-group border rounded-3">
                            <span class="input-group-text"><i class="bi bi-lock-fill"></i></span>
                            <input type="password" name="confirmPassword" class="form-control border-0" placeholder="Nhập lại mật khẩu mới" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-primary w-100 rounded-pill py-2 fw-bold shadow-sm">
                        Cập nhật mật khẩu
                    </button>
                    
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-link w-100 mt-2 text-decoration-none text-muted small">
                        Quay lại Dashboard
                    </a>
                </form>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>