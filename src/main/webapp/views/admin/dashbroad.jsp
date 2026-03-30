<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - ATS</title>

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

        .text-blue { color: var(--primary-blue); }
        .bg-blue { background-color: var(--primary-blue); }

        .admin-sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            background: #fff;
            border-right: 1px solid #eee;
            overflow-y: auto;
            z-index: 1000;
        }

        .sidebar-brand {
            padding: 20px;
            border-bottom: 1px solid #eee;
        }

        .sidebar-menu {
            padding: 15px 10px;
            list-style: none;
            margin: 0;
        }

        .sidebar-menu-title {
            font-size: 0.75rem;
            text-transform: uppercase;
            font-weight: 700;
            color: #999;
            margin: 20px 0 10px 15px;
            letter-spacing: 0.5px;
        }

        .sidebar-item {
            margin-bottom: 5px;
        }

        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 12px 15px;
            color: #555;
            text-decoration: none;
            font-weight: 500;
            border-radius: 10px;
            transition: all 0.3s ease;
        }

        .sidebar-link:hover,
        .sidebar-link.active {
            background-color: rgba(0, 123, 255, 0.08);
            color: var(--primary-blue);
        }

        .sidebar-link i {
            margin-right: 12px;
            font-size: 1.2rem;
        }

        .admin-main {
            margin-left: var(--sidebar-width);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        .admin-header {
            background: #fff;
            padding: 15px 30px;
            border-bottom: 1px solid #eee;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .admin-card {
            background: #fff;
            border: 1px solid #eee;
            border-radius: 15px;
            padding: 24px;
            transition: all 0.3s ease;
            height: 100%;
            box-shadow: 0 5px 15px rgba(0,0,0,0.02);
        }

        .admin-card:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
        }

        .stat-icon-box {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }

        .badge-status {
            padding: 6px 12px;
            border-radius: 50px;
            font-size: 0.8rem;
            font-weight: 600;
        }
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
                <a href="${pageContext.request.contextPath}/admin/dashboard" class="sidebar-link active">
                    <i class="bi bi-grid-1x2-fill"></i> Tổng quan
                </a>
            </li>

            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/staff-management" class="sidebar-link">
                    <i class="bi bi-person-badge"></i> Quản lý nhân viên
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link">
                    <i class="bi bi-shield-lock"></i> Quản lý tài khoản
                </a>
            </li>

            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/recruiters" class="sidebar-link">
                    <i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/candidates" class="sidebar-link">
                    <i class="bi bi-people"></i> Quản lý ứng viên
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/jobs" class="sidebar-link">
                    <i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/recruitment-results" class="sidebar-link">
                    <i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng
                </a>
            </li>

            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/vip-plans" class="sidebar-link">
                    <i class="bi bi-gem"></i> Quản lý gói VIP
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/transactions" class="sidebar-link">
                    <i class="bi bi-cash-stack"></i> Quản lý giao dịch
                </a>
            </li>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/admin/reports" class="sidebar-link">
                    <i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng
                </a>
            </li>

            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item">
                <a href="${pageContext.request.contextPath}/auth/change-password" class="sidebar-link">
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
            <div class="d-flex align-items-center">
                <div class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" class="border-0 bg-transparent" placeholder="Tìm kiếm nhanh..." style="outline: none; width: 250px;">
                </div>
            </div>

            <div class="d-flex align-items-center gap-3">
                <a href="${pageContext.request.contextPath}/admin/create-staff" class="btn btn-outline-primary rounded-pill px-4 fw-bold">
                    <i class="bi bi-person-plus-fill me-2"></i>Tạo tài khoản mới
                </a>

                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                        <span class="fw-bold">
                            ${admin != null ? admin.fullName : 'Super Admin'}
                        </span>
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

        <div class="container-fluid p-4 flex-grow-1">
            <div class="mb-4">
                <h3 class="fw-bold mb-1">Tổng quan hệ thống</h3>
                <p class="text-muted">Xin chào! Dưới đây là số liệu thống kê mới nhất tính đến hôm nay.</p>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="text-muted fw-bold mb-0">TỔNG ỨNG VIÊN</h6>
                            <div class="stat-icon-box bg-primary bg-opacity-10 text-primary">
                                <i class="bi bi-people-fill"></i>
                            </div>
                        </div>
                        <h2 class="fw-bold mb-2">${totalCandidates != null ? totalCandidates : 0}</h2>
                        <span class="small text-muted">Tổng số ứng viên trong hệ thống</span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="text-muted fw-bold mb-0">NHÀ TUYỂN DỤNG</h6>
                            <div class="stat-icon-box bg-warning bg-opacity-10 text-warning">
                                <i class="bi bi-buildings-fill"></i>
                            </div>
                        </div>
                        <h2 class="fw-bold mb-2">${totalRecruiters != null ? totalRecruiters : 0}</h2>
                        <span class="small text-muted">Tổng số nhà tuyển dụng</span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="text-muted fw-bold mb-0">TIN TUYỂN DỤNG</h6>
                            <div class="stat-icon-box bg-info bg-opacity-10 text-info">
                                <i class="bi bi-file-earmark-text-fill"></i>
                            </div>
                        </div>
                        <h2 class="fw-bold mb-2">${totalJobs != null ? totalJobs : 0}</h2>
                        <span class="small text-muted">Tổng số tin tuyển dụng</span>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h6 class="text-muted fw-bold mb-0">GIAO DỊCH VIP</h6>
                            <div class="stat-icon-box bg-success bg-opacity-10 text-success">
                                <i class="bi bi-cash-stack"></i>
                            </div>
                        </div>
                        <h2 class="fw-bold mb-2">${totalPayments != null ? totalPayments : 0}</h2>
                        <span class="small text-muted">Tổng số giao dịch</span>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-lg-8">
                    <div class="admin-card">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h5 class="fw-bold mb-0">Giao dịch VIP gần đây</h5>
                            <a href="${pageContext.request.contextPath}/admin/transactions" class="btn btn-sm btn-light text-primary fw-medium">
                                Xem tất cả
                            </a>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-hover align-middle">
                                <thead>
                                    <tr class="text-muted small text-uppercase">
                                        <th class="border-0 pb-3">Mã GD</th>
                                        <th class="border-0 pb-3">Người dùng</th>
                                        <th class="border-0 pb-3">Số tiền</th>
                                        <th class="border-0 pb-3">Ngày</th>
                                        <th class="border-0 pb-3">Trạng thái</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td colspan="5" class="text-center text-muted">Dữ liệu giao dịch sẽ hiển thị tại đây</td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="col-lg-4">
                    <div class="admin-card">
                        <h5 class="fw-bold mb-4">Tóm tắt nhanh</h5>

                        <div class="d-flex align-items-start border-bottom pb-3 mb-3">
                            <div class="bg-light rounded p-2 me-3">
                                <i class="bi bi-person-check text-primary fs-5"></i>
                            </div>
                            <div>
                                <div class="fw-bold mb-1">Tổng hồ sơ ứng tuyển</div>
                                <p class="small text-muted mb-0">${totalApplications != null ? totalApplications : 0} hồ sơ</p>
                            </div>
                        </div>

                        <div class="d-flex align-items-start border-bottom pb-3 mb-3">
                            <div class="bg-light rounded p-2 me-3">
                                <i class="bi bi-gem text-warning fs-5"></i>
                            </div>
                            <div>
                                <div class="fw-bold mb-1">Gói VIP đang hoạt động</div>
                                <p class="small text-muted mb-0">${totalSubscriptions != null ? totalSubscriptions : 0} gói/subscription</p>
                            </div>
                        </div>

                        <div class="d-flex align-items-start">
                            <div class="bg-light rounded p-2 me-3">
                                <i class="bi bi-shield-check text-success fs-5"></i>
                            </div>
                            <div>
                                <div class="fw-bold mb-1">Quản trị viên hiện tại</div>
                                <p class="small text-muted mb-0">${admin != null ? admin.fullName : 'Admin'}</p>
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