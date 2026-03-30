<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Quản lý Tin Tuyển Dụng - ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">

    <style>
        :root { --primary-blue: #007bff; --bg-light: #f8fbff; --sidebar-width: 280px; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; overflow-x: hidden; }
        .text-blue { color: var(--primary-blue); }
        .bg-blue { background-color: var(--primary-blue); }

        /* Sidebar Styling */
        .admin-sidebar { width: var(--sidebar-width); height: 100vh; position: fixed; top: 0; left: 0; background: #fff; border-right: 1px solid #eee; overflow-y: auto; z-index: 1000; }
        .sidebar-brand { padding: 20px; border-bottom: 1px solid #eee; }
        .sidebar-menu { padding: 15px 10px; list-style: none; margin: 0; }
        .sidebar-menu-title { font-size: 0.75rem; text-transform: uppercase; font-weight: 700; color: #999; margin: 20px 0 10px 15px; letter-spacing: 0.5px; }
        .sidebar-item { margin-bottom: 5px; }
        .sidebar-link { display: flex; align-items: center; padding: 12px 15px; color: #555; text-decoration: none; font-weight: 500; border-radius: 10px; transition: all 0.3s ease; }
        .sidebar-link:hover, .sidebar-link.active { background-color: rgba(0, 123, 255, 0.08); color: var(--primary-blue); }
        .sidebar-link i { margin-right: 12px; font-size: 1.2rem; }

        /* Main Content Styling */
        .admin-main { margin-left: var(--sidebar-width); min-height: 100vh; display: flex; flex-direction: column; }
        .admin-header { background: #fff; padding: 15px 30px; border-bottom: 1px solid #eee; display: flex; justify-content: space-between; align-items: center; }
        
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; transition: all 0.3s ease; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .table > :not(caption) > * > * { padding: 16px 12px; border-bottom-color: #f1f5f9; vertical-align: middle; }
        .badge-status { padding: 6px 12px; border-radius: 50px; font-size: 0.75rem; font-weight: 600; }
        .btn-action { width: 32px; height: 32px; padding: 0; display: inline-flex; align-items: center; justify-content: center; border-radius: 8px; transition: 0.2s; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Admin</span>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="dashboard.jsp" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>

            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-person-badge"></i> Quản lý nhân viên</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>

            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="recruiter-list.jsp" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-people"></i> Quản lý ứng viên</a></li>
            <li class="sidebar-item">
                <a href="job-list.jsp" class="sidebar-link active"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a>
            </li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>

            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-gem"></i> Quản lý gói VIP</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-cash-stack"></i> Quản lý giao dịch</a></li>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng</a></li>

            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="#" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
            <li class="sidebar-item mt-3">
                <a href="#" class="sidebar-link text-danger bg-danger bg-opacity-10"><i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất</a>
            </li>
        </ul>
    </aside>

    <main class="admin-main">
        <header class="admin-header sticky-top shadow-sm">
            <div class="d-flex align-items-center">
                <div class="bg-light px-3 py-2 rounded-pill d-flex align-items-center border">
                    <i class="bi bi-search text-muted me-2"></i>
                    <input type="text" class="border-0 bg-transparent outline-none" placeholder="Tìm kiếm nhanh..." style="outline: none; width: 250px;">
                </div>
            </div>
            <div class="d-flex align-items-center gap-3">
                <div class="dropdown">
                    <a href="#" class="text-dark text-decoration-none dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
                        <img src="https://ui-avatars.com/api/?name=Admin&background=007bff&color=fff" class="rounded-circle me-2" width="40" alt="Admin">
                        <span class="fw-bold">Super Admin</span>
                    </a>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4 flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-1">Tin Tuyển Dụng</h3>
                    <p class="text-muted small">Quản lý danh sách các công việc đang đăng tải</p>
                </div>
            </div>

            <div class="admin-card">
                <div class="row mb-4 g-3">
                    <div class="col-md-5">
                        <div class="input-group border rounded-pill overflow-hidden bg-white">
                            <span class="input-group-text bg-transparent border-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" class="form-control border-0 shadow-none" placeholder="Tìm tiêu đề công việc...">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select rounded-pill border shadow-none text-muted">
                            <option value="">Tất cả trạng thái</option>
                            <option value="active">Đang hiển thị</option>
                            <option value="hidden">Đã ẩn</option>
                            <option value="expired">Hết hạn</option>
                        </select>
                    </div>
                    <div class="col-md-4 text-end">
                        <button class="btn btn-outline-primary rounded-pill px-4 fw-bold w-100">Lọc dữ liệu</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover">
                        <thead class="bg-light text-muted small text-uppercase">
                            <tr>
                                <th class="border-0 rounded-start">Công ty & Tiêu đề</th>
                                <th class="border-0">Mức lương</th>
                                <th class="border-0">Hạn chót</th>
                                <th class="border-0">Loại tin</th>
                                <th class="border-0">Trạng thái</th>
                                <th class="border-0 rounded-end text-center">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="fw-bold text-dark">Senior Frontend Developer</div>
                                    <small class="text-muted"><i class="bi bi-building me-1"></i> FPT Software</small>
                                </td>
                                <td class="fw-semibold text-success">25M - 40M VNĐ</td>
                                <td class="text-muted">30/06/2026</td>
                                <td><span class="badge bg-warning text-dark"><i class="bi bi-star-fill me-1"></i> VIP</span></td>
                                <td><span class="badge-status bg-success bg-opacity-10 text-success">Đang hiển thị</span></td>
                                <td class="text-center">
                                    <a href="job-detail.jsp" class="btn btn-action btn-light text-primary"><i class="bi bi-eye"></i></a>
                                    <button class="btn btn-action btn-light text-secondary ms-1" title="Ẩn tin"><i class="bi bi-eye-slash"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="fw-bold text-dark">Chuyên viên Marketing</div>
                                    <small class="text-muted"><i class="bi bi-building me-1"></i> Shopee VN</small>
                                </td>
                                <td class="fw-semibold text-success">15M - 20M VNĐ</td>
                                <td class="text-muted">15/05/2026</td>
                                <td><span class="badge bg-secondary bg-opacity-25 text-secondary">Thường</span></td>
                                <td><span class="badge-status bg-secondary bg-opacity-10 text-secondary">Đã ẩn</span></td>
                                <td class="text-center">
                                    <a href="job-detail.jsp" class="btn btn-action btn-light text-primary"><i class="bi bi-eye"></i></a>
                                    <button class="btn btn-action btn-light text-success ms-1" title="Hiển thị lại"><i class="bi bi-eye"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>