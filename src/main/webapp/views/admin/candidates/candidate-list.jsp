<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản lý Ứng viên | ATS Admin</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css">
    <style>
        :root { --sidebar-width: 280px; --primary-blue: #007bff; --bg-light: #f8fbff; }
        body { font-family: 'Inter', sans-serif; background-color: var(--bg-light); color: #333; overflow-x: hidden; }
        .text-blue { color: var(--primary-blue); }
        
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
        
        /* Table Styling */
        .admin-card { background: #fff; border: 1px solid #eee; border-radius: 15px; padding: 24px; box-shadow: 0 5px 15px rgba(0,0,0,0.02); }
        .table > :not(caption) > * > * { padding: 16px 12px; border-bottom-color: #f1f5f9; vertical-align: middle; }
        .avatar-sm { width: 40px; height: 40px; border-radius: 50%; object-fit: cover; }
        .badge-subtle { padding: 6px 12px; border-radius: 50px; font-weight: 600; font-size: 0.75rem; }
    </style>
</head>
<body>

    <aside class="admin-sidebar shadow-sm">
        <div class="sidebar-brand d-flex align-items-center">
            <i class="bi bi-building-fill text-primary me-2 fs-3"></i>
            <span class="fw-bold fs-4 text-primary">ATS Admin</span>
        </div>

        <ul class="sidebar-menu">
            <li class="sidebar-item"><a href="../dashboard.jsp" class="sidebar-link"><i class="bi bi-grid-1x2-fill"></i> Tổng quan</a></li>

            <div class="sidebar-menu-title">Quản trị hệ thống</div>
            <li class="sidebar-item"><a href="../staff/staff-management.jsp" class="sidebar-link"><i class="bi bi-person-badge"></i> Quản lý nhân viên</a></li>
            <li class="sidebar-item"><a href="../account/change-password.jsp" class="sidebar-link"><i class="bi bi-shield-lock"></i> Quản lý tài khoản</a></li>

            <div class="sidebar-menu-title">Nghiệp vụ cốt lõi</div>
            <li class="sidebar-item"><a href="../recruiters/recruiter-list.jsp" class="sidebar-link"><i class="bi bi-buildings"></i> Quản lý nhà tuyển dụng</a></li>
            <li class="sidebar-item">
                <a href="candidate-list.jsp" class="sidebar-link active"><i class="bi bi-people"></i> Quản lý ứng viên</a>
            </li>
            <li class="sidebar-item"><a href="../jobs/job-list.jsp" class="sidebar-link"><i class="bi bi-file-earmark-text"></i> Quản lý tin tuyển dụng</a></li>
            <li class="sidebar-item"><a href="../recruitment-results/recruitment-result-list.jsp" class="sidebar-link"><i class="bi bi-clipboard2-check"></i> Quản lý kết quả tuyển dụng</a></li>

            <div class="sidebar-menu-title">Tài chính & Phân tích</div>
            <li class="sidebar-item"><a href="../vip/vip-plan-management.jsp" class="sidebar-link"><i class="bi bi-gem"></i> Quản lý gói VIP</a></li>
            <li class="sidebar-item"><a href="../transactions/transaction-list.jsp" class="sidebar-link"><i class="bi bi-cash-stack"></i> Quản lý giao dịch</a></li>
            <li class="sidebar-item"><a href="../reports/analytics.jsp" class="sidebar-link"><i class="bi bi-bar-chart-line"></i> Báo cáo tuyển dụng</a></li>

            <div class="sidebar-menu-title">Cá nhân</div>
            <li class="sidebar-item"><a href="../account/change-password.jsp" class="sidebar-link"><i class="bi bi-key"></i> Đổi mật khẩu</a></li>
            <li class="sidebar-item mt-3">
                <a href="../../auth/login.jsp" class="sidebar-link text-danger bg-danger bg-opacity-10"><i class="bi bi-box-arrow-right text-danger"></i> Đăng xuất</a>
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
                    <ul class="dropdown-menu dropdown-menu-end border-0 shadow">
                        <li><a class="dropdown-item" href="#">Hồ sơ của tôi</a></li>
                        <li><a class="dropdown-item" href="../account/change-password.jsp">Đổi mật khẩu</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item text-danger" href="../../auth/login.jsp">Đăng xuất</a></li>
                    </ul>
                </div>
            </div>
        </header>

        <div class="container-fluid p-4 flex-grow-1">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <div>
                    <h3 class="fw-bold mb-1">Quản lý Ứng viên</h3>
                    <p class="text-muted small">Xem và quản lý hồ sơ ứng viên trên hệ thống</p>
                </div>
                <div>
                    <button class="btn btn-outline-primary rounded-pill px-4"><i class="bi bi-download me-2"></i>Xuất Excel</button>
                </div>
            </div>

            <div class="admin-card">
                <div class="row mb-4 g-3">
                    <div class="col-md-4">
                        <div class="input-group border rounded-pill overflow-hidden">
                            <span class="input-group-text bg-transparent border-0"><i class="bi bi-search text-muted"></i></span>
                            <input type="text" class="form-control border-0 shadow-none" placeholder="Tìm theo tên, email...">
                        </div>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select rounded-pill border shadow-none text-muted">
                            <option value="">Kinh nghiệm</option>
                            <option value="fresher">Fresher (< 1 năm)</option>
                            <option value="junior">Junior (1-3 năm)</option>
                            <option value="senior">Senior (> 3 năm)</option>
                        </select>
                    </div>
                    <div class="col-md-3">
                        <select class="form-select rounded-pill border shadow-none text-muted">
                            <option value="">Trạng thái</option>
                            <option value="active">Đang hoạt động</option>
                            <option value="locked">Đã khóa</option>
                        </select>
                    </div>
                    <div class="col-md-2 text-end">
                        <button class="btn btn-primary rounded-pill w-100 fw-bold">Lọc dữ liệu</button>
                    </div>
                </div>

                <div class="table-responsive">
                    <table class="table table-hover align-middle">
                        <thead class="bg-light text-muted small text-uppercase">
                            <tr>
                                <th class="border-0 rounded-start">Ứng viên</th>
                                <th class="border-0">Kinh nghiệm</th>
                                <th class="border-0">Kỹ năng chính</th>
                                <th class="border-0">Ngày tạo</th>
                                <th class="border-0">Trạng thái</th>
                                <th class="border-0 rounded-end text-end">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="https://ui-avatars.com/api/?name=Ngoc+Ha&background=007bff&color=fff" class="avatar-sm me-3" alt="Avatar">
                                        <div>
                                            <h6 class="mb-0 fw-bold">Nguyễn Ngọc Hà</h6>
                                            <small class="text-muted">ngocha@gmail.com</small>
                                        </div>
                                    </div>
                                </td>
                                <td>3 năm</td>
                                <td><span class="badge bg-light text-dark border">Java</span> <span class="badge bg-light text-dark border">Spring</span></td>
                                <td class="text-muted small">18/03/2026</td>
                                <td><span class="badge-subtle bg-success bg-opacity-10 text-success">Hoạt động</span></td>
                                <td class="text-end">
                                    <a href="candidate-detail.jsp?id=1" class="btn btn-sm btn-light text-primary rounded-circle" title="Xem chi tiết"><i class="bi bi-eye"></i></a>
                                    <button class="btn btn-sm btn-light text-danger rounded-circle ms-1" title="Khóa tài khoản"><i class="bi bi-lock-fill"></i></button>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div class="d-flex align-items-center">
                                        <img src="https://ui-avatars.com/api/?name=Quoc+Bao&background=random" class="avatar-sm me-3" alt="Avatar">
                                        <div>
                                            <h6 class="mb-0 fw-bold">Quốc Bảo</h6>
                                            <small class="text-muted">baotr@gmail.com</small>
                                        </div>
                                    </div>
                                </td>
                                <td>1 năm</td>
                                <td><span class="badge bg-light text-dark border">Marketing</span></td>
                                <td class="text-muted small">15/03/2026</td>
                                <td><span class="badge-subtle bg-danger bg-opacity-10 text-danger">Bị khóa</span></td>
                                <td class="text-end">
                                    <a href="candidate-detail.jsp?id=2" class="btn btn-sm btn-light text-primary rounded-circle" title="Xem chi tiết"><i class="bi bi-eye"></i></a>
                                    <button class="btn btn-sm btn-light text-success rounded-circle ms-1" title="Mở khóa tài khoản"><i class="bi bi-unlock-fill"></i></button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                
                <nav class="mt-4">
                    <ul class="pagination justify-content-end mb-0">
                        <li class="page-item disabled"><a class="page-link border-0" href="#"><i class="bi bi-chevron-left"></i></a></li>
                        <li class="page-item active"><a class="page-link rounded-circle mx-1" href="#">1</a></li>
                        <li class="page-item"><a class="page-link rounded-circle mx-1 border-0 text-dark" href="#">2</a></li>
                        <li class="page-item"><a class="page-link border-0" href="#"><i class="bi bi-chevron-right"></i></a></li>
                    </ul>
                </nav>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>